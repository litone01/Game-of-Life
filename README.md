# Game Of Life on CUDA
Simplified implementation of the [Conway’s game](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) of life on CUDA. This used to be part of a project for the [Parallel Computing](https://nusmods.com/modules/CS3210/parallel-computing) at NUS where I learned about GPU computations.

## How to run
`make example`
`./export_example.out`

A file `export.out` should be generated in the same directory as the executable.
This file can be used as input into the GOI visualizer.

## NOTE: EXPORTER ONLY WORKS ON HOST
The `exporter` module can only be used by calls from the host. It is outputting to a file
after all.

It will not work on the GPU just by adding `__device__` in front of each function. If you
wish to export from the GPU, you will need to write code to copy the world state from the
device to the host and then output to a file from the host. Note that `printf` when called
from the device basically does this behind the scenes.

See https://stackoverflow.com/questions/21303713/writing-output-files-from-cuda-devices
