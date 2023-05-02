#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <errno.h>
#include "exporter.h"
#include "settings.h"

// including the "dead faction": 0
#define MAX_FACTIONS 10

// this macro is here to make the code slightly more readable, not because it can be safely changed to
// any integer value; changing this to a non-zero value may break the code
#define DEAD_FACTION 0

// death toll due to fighting
__device__ __managed__ int deathToll;


void check_cuda_errors()
{
    cudaError_t rc;
    rc = cudaGetLastError();
    if (rc != cudaSuccess)
    {
        printf("Last CUDA error %s\n", cudaGetErrorString(rc));
    }

}

/**
 * Specifies the number(s) of live neighbors of the same faction required for a dead cell to become alive.
 */
__device__ bool isBirthable(int n)
{
    return n == 3;
}

/**
 * Specifies the number(s) of live neighbors of the same faction required for a live cell to remain alive.
 */
__device__ bool isSurvivable(int n)
{
    return n == 2 || n == 3;
}

/**
 * Specifies the number of live neighbors of a different faction required for a live cell to die due to fighting.
 */
__device__ bool willFight(int n) {
    return n > 0;
}

/**
 * returns the value at the input row and col of the input grid, if valid.
 * 
 * -1 is returned if row or col is out of bounds (as specified by nRows and nCols).
 */
__device__ int getValueAtCuda(const int *grid, int nRows, int nCols, int row, int col)
{
    if (row < 0 || row >= nRows || col < 0 || col >= nCols)
    {
        return -1;
    }

    return *(grid + (row * nCols) + col);
}

/**
 * sets the value at the input row and col of the input grid to val.
 * 
 * Does nothing if row or col is out of bounds (as specified by nRows and nCols).
 */
__device__ void setValueAtCuda(int *grid, int nRows, int nCols, int row, int col, int val)
{
    if (row < 0 || row >= nRows || col < 0 || col >= nCols)
    {
        return;
    }

    *(grid + (row * nCols) + col) = val;
}


/**
 * returns the value at the input row and col of the input grid, if valid.
 * 
 * -1 is returned if row or col is out of bounds (as specified by nRows and nCols).
 */
int getValueAt(const int *grid, int nRows, int nCols, int row, int col)
{
    if (row < 0 || row >= nRows || col < 0 || col >= nCols)
    {
        return -1;
    }

    return *(grid + (row * nCols) + col);
}

/**
 * sets the value at the input row and col of the input grid to val.
 * 
 * Does nothing if row or col is out of bounds (as specified by nRows and nCols).
 */
void setValueAt(int *grid, int nRows, int nCols, int row, int col, int val)
{
    if (row < 0 || row >= nRows || col < 0 || col >= nCols)
    {
        return;
    }

    *(grid + (row * nCols) + col) = val;
}

/**
 * Writes the input world to stdout.
 */
void printWorld(const int *world, int nRows, int nCols)
{
    for (int row = 0; row < nRows; row++)
    {
        for (int col = 0; col < nCols; col++)
        {
            printf("%d ", *(world + (row * nCols) + col));
        }
        printf("\n");
    }
}


/**
 * Computes and returns the next state of the cell specified by row and col based on currWorld and invaders. Sets *diedDueToFighting to
 * true if this cell should count towards the death toll due to fighting.
 * 
 * invaders can be NULL if there are no invaders.
 */
__device__ int getNextState(const int *currWorld, const int *invaders, int nRows, int nCols, int row, int col, bool *diedDueToFighting)
{
    // we'll explicitly set if it was death due to fighting
    *diedDueToFighting = false;

    // faction of this cell
    int cellFaction = getValueAtCuda(currWorld, nRows, nCols, row, col);

    // did someone just get landed on?
    if (invaders != NULL && getValueAtCuda(invaders, nRows, nCols, row, col) != DEAD_FACTION)
    {
        *diedDueToFighting = cellFaction != DEAD_FACTION;
        return getValueAtCuda(invaders, nRows, nCols, row, col);
    }

    // tracks count of each faction adjacent to this cell
    int neighborCounts[MAX_FACTIONS];
    memset(neighborCounts, 0, MAX_FACTIONS * sizeof(int));

    // count neighbors (and self)
    for (int dy = -1; dy <= 1; dy++)
    {
        for (int dx = -1; dx <= 1; dx++)
        {
            int faction = getValueAtCuda(currWorld, nRows, nCols, row + dy, col + dx);
            if (faction >= DEAD_FACTION)
            {
                neighborCounts[faction]++;
            }
        }
    }

    // we counted this cell as its "neighbor"; adjust for this
    neighborCounts[cellFaction]--;

    if (cellFaction == DEAD_FACTION)
    {
        // this is a dead cell; we need to see if a birth is possible:
        // need exactly 3 of a single faction; we don't care about other factions

        // by default, no birth
        int newFaction = DEAD_FACTION;

        // start at 1 because we ignore dead neighbors
        for (int faction = DEAD_FACTION + 1; faction < MAX_FACTIONS; faction++)
        {
            int count = neighborCounts[faction];
            if (isBirthable(count))
            {
                newFaction = faction;
            }
        }

        return newFaction;
    }
    else
    {
        /** 
         * this is a live cell; we follow the usual rules:
         * Death (fighting): > 0 hostile neighbor
         * Death (underpopulation): < 2 friendly neighbors and 0 hostile neighbors
         * Death (overpopulation): > 3 friendly neighbors and 0 hostile neighbors
         * Survival: 2 or 3 friendly neighbors and 0 hostile neighbors
         */

        int hostileCount = 0;
        for (int faction = DEAD_FACTION + 1; faction < MAX_FACTIONS; faction++)
        {
            if (faction == cellFaction)
            {
                continue;
            }
            hostileCount += neighborCounts[faction];
        }

        if (willFight(hostileCount))
        {
            *diedDueToFighting = true;
            return DEAD_FACTION;
        }

        int friendlyCount = neighborCounts[cellFaction];
        if (!isSurvivable(friendlyCount))
        {
            return DEAD_FACTION;
        }

        return cellFaction;
    }
}


__global__ void simulate(int *wholeNewWorld, const int *world, const int * inv, int nRows, int nCols, int elementPerThread)
{
    // printf("Currently on block %d %d %d, thread %d %d %d\n", blockIdx.x, blockIdx.y, blockIdx.z, threadIdx.x, threadIdx.y, threadIdx.z);

    int blockId = blockIdx.x + blockIdx.y * gridDim.x + gridDim.x * gridDim.y * blockIdx.z;
    int threadId = blockId * (blockDim.x * blockDim.y * blockDim.z) + (threadIdx.z * (blockDim.x * blockDim.y)) + (threadIdx.y * blockDim.x) + threadIdx.x;
    
    // calculate the starting and ending position of the world to be computed by the current thread
    int firstElement = threadId * elementPerThread;
    int lastElement = ((threadId + 1) * elementPerThread) - 1;
    // handle cases where nRows * nCols are not divisible by nThreads.
    int max = nRows * nCols - 1;
    if (lastElement > max) {
        lastElement = max;
    }

    int currentElement = firstElement;
    int row, col;
    while (currentElement <= lastElement) {
        row = currentElement / nCols;
        col = currentElement % nCols;
        // printf("[thread %d] row:%d, col:%d\n", threadId, row, col);
        bool diedDueToFighting;
        int nextState = getNextState(world, inv, nRows, nCols, row, col, &diedDueToFighting);
        setValueAtCuda(wholeNewWorld, nRows, nCols, row, col, nextState);
        if (diedDueToFighting) {
            // critical region
            atomicAdd(&deathToll, 1);
        }
        currentElement++;
    }
}



/**
 * The main simulation logic.
 * 
 * goi does not own startWorld, invasionTimes or invasionPlans and should not modify or attempt to free them.
 * nThreads is the number of threads to simulate with. It is ignored by the sequential implementation.
 */
int goi(int nGenerations, const int *startWorld, int nRows, int nCols, int nInvasions, const int *invasionTimes, int **invasionPlans,
        int gridX, int gridY, int gridZ, int blockX, int blockY, int blockZ)
{
    cudaError_t rc;
    size_t worldSizeInBytes = nRows * nCols * sizeof(int);

    // grid and block dimensions
    dim3 gridDim(gridX, gridY, gridZ);
    dim3 blockDim(blockX, blockY, blockZ);
    int nThreads = blockX * blockY * blockZ * gridX * gridY * gridZ;
    // rounding up the division to the nearest integer
    // further assume that nRows * nCols >= nThreads
    int elementPerThread = 1 +((nRows * nCols - 1) / nThreads);

    // init deathtoll
    deathToll = 0;
    // rc = cudaMemcpyToSymbol(deathToll, res, sizeof(res));
    // if (rc != cudaSuccess)
    // {
    //     printf("Could not copy to device. Reason: %s\n", cudaGetErrorString(rc));
    // }

    // init the world!
    // we make a copy because we do not own startWorld (and will perform free() on hostWorld)
    int* world = (int*) malloc(worldSizeInBytes);
    if (world == NULL)
    {
        return -1;
    }

    // set value of the host world
    // TODO (maybe can just use the startWorld since we are not modifying)
    for (int row = 0; row < nRows; row++)
    {
        for (int col = 0; col < nCols; col++)
        {
            setValueAt(world, nRows, nCols, row, col, getValueAt(startWorld, nRows, nCols, row, col));
        }
    }

    // Copy world to CUDA
    int* world_cuda;
    cudaMalloc((void **)&world_cuda, sizeof(int) * nRows * nCols);
    rc = cudaMemcpy(world_cuda, world, sizeof(int) * nRows * nCols, cudaMemcpyHostToDevice);
    if (rc != cudaSuccess)
    {
        printf("Could not copy world_cuda to device. Reason: %s\n", cudaGetErrorString(rc));
    }

#if PRINT_GENERATIONS
    printf("\n=== WORLD 0 ===\n");
    printWorld(world, nRows, nCols);
#endif

#if EXPORT_GENERATIONS
    exportWorld(world, nRows, nCols);
#endif

    // Begin simulating
    int invasionIndex = 0;
    for (int i = 1; i <= nGenerations; i++)
    {
        // is there an invasion this generation?
        int *inv = NULL;
        int *inv_cuda = NULL;
        if (invasionIndex < nInvasions && i == invasionTimes[invasionIndex])
        {
            // we make a copy because we do not own invasionPlans
            inv = (int*) malloc(worldSizeInBytes);
            if (inv == NULL)
            {
                free(world);
                cudaFree(world_cuda);
                return -1;
            }
            rc = cudaMalloc((void**) &inv_cuda, worldSizeInBytes);
            if (rc != cudaSuccess) {
                free(world);
                cudaFree(world_cuda);
                free(inv);
                return -1;
            }

            for (int row = 0; row < nRows; row++)
            {
                for (int col = 0; col < nCols; col++)
                {
                    setValueAt(inv, nRows, nCols, row, col, getValueAt(invasionPlans[invasionIndex], nRows, nCols, row, col));
                }
            }
            invasionIndex++;
            cudaMemcpy(inv_cuda, inv, worldSizeInBytes, cudaMemcpyHostToDevice);
        }

        // create newWorld state for cuda
        int *wholeNewWorld_cuda;
        rc = cudaMalloc((void **)&wholeNewWorld_cuda, sizeof(int) * nRows * nCols);
        if (rc != cudaSuccess) {
                free(world);
                cudaFree(world_cuda);
                free(inv);
                cudaFree(inv_cuda);
                return -1;
        }

        // Simulate next state
        simulate<<<gridDim, blockDim>>>(wholeNewWorld_cuda, world_cuda, inv_cuda, nRows, nCols, elementPerThread);
        check_cuda_errors();
        cudaError_t cudaerr = cudaDeviceSynchronize();
        if (cudaerr != cudaSuccess) {
            printf("kernel launch failed with error \"%s\".\n", cudaGetErrorString(cudaerr));
        }

        // free inv and inv_cuda if needed
        if (inv != NULL)
        {
            free(inv);
            cudaFree(inv_cuda);
        }

        // swap worlds
        cudaFree(world_cuda);
        world_cuda = wholeNewWorld_cuda;


#if PRINT_GENERATIONS
        cudaMemcpy(world, world_cuda, worldSizeInBytes, cudaMemcpyDeviceToHost);
        printf("\n=== WORLD %d ===\n", i);
        printWorld(world, nRows, nCols);
#endif

#if EXPORT_GENERATIONS
        cudaMemcpy(world, world_cuda, worldSizeInBytes, cudaMemcpyDeviceToHost);
        exportWorld(world, nRows, nCols);
#endif
    }

    free(world);
    cudaFree(world_cuda);

    return deathToll;
}


