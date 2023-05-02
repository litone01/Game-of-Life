#!/bin/bash
grid=( 
    8
    16
    32
    64
    128
    32
    64
    128
    256
    512
    256
    512
    1024
    2048
    4096
)
blk=(   
    512
    256
    128
    64
    32
    1024
    512
    256
    128
    64
    1024
    512
    256
    128
    64
)


for j in 0 1 2
do
    for i in "${!grid[@]}"; do {
        gridSize=${grid[$i]}
        blkSize=${blk[$i]}
        nvprof --log-file log_xgpc2_baseline.log ../goi_cuda_baseline test4.in out_xgpc2_baseline.out $gridSize 1 1 $blkSize 1 1 >> results_test4_xgpc2_baseline.out
        cat log_xgpc2_baseline.log >> results_test4_xgpc2_baseline.out
        echo "----------------------------end of prev---------------------------------------" >> results_test4_xgpc2_baseline.out
        cat out_xgpc2_baseline.out >> out_test4_xgpc2_baseline.out
        echo "" >> out_test4_xgpc2_baseline.out
    } done
done

