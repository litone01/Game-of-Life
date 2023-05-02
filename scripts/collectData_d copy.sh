#!/bin/bash
# grid=( 
#     4
#     8
#     16
#     32
#     64
#     8
#     16
#     32
#     64
#     128
#     16
#     32
#     64
#     128
#     256
#     32
#     64
#     128
#     256
#     512
# )
# blk=(
#     512
#     256
#     128
#     64
#     32
#     512
#     256
#     128
#     64
#     32
#     512
#     256
#     128
#     64
#     32
#     512
#     256
#     128
#     64
#     32
# )

# for j in 0 1 2
# do
#     for i in "${!grid[@]}"; do {
#         gridSize=${grid[$i]}
#         blkSize=${blk[$i]}
#         nvprof --log-file log_xgpd.log ../goi_cuda test3.in out_xgpd.out $gridSize 1 1 $blkSize 1 1 >> results_test3_xgpd.out
#         cat log_xgpd.log >> results_test3_xgpd.out
#         echo "----------------------------end of prev---------------------------------------" >> results_test3_xgpd.out
#         cat out_xgpd.out >> out_test3_xgpd.out
#         echo "" >> out_test3_xgpd.out
#     } done
# done

# for j in 0 1 2
# do
#     for i in "${!grid[@]}"; do {
#         gridSize=${grid[$i]}
#         blkSize=${blk[$i]}
#         nvprof --log-file log_xgpd.log ../goi_cuda test5.in out_xgpd.out $gridSize 1 1 $blkSize 1 1 >> results_test5_xgpd.out
#         cat log_xgpd.log >> results_test5_xgpd.out
#         echo "----------------------------end of prev---------------------------------------" >> results_test5_xgpd.out
#         cat out_xgpd.out >> out_test5_xgpd.out
#         echo "" >> out_test5_xgpd.out
#     } done
# done

grid=( 
    4
    8
    16
    32
    64
    8
    16
    32
    64
    128
    16
    32
    64
    128
    256
    32
    64
    128
    256
    512
    32
    64
    128
    256
    512
    64
    128
    256
    512
    1024
    128
    256
    512
    1024
    2048
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
    512
    256
    128
    64
    32
    512
    256
    128
    64
    32
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
        nvprof --log-file log_xgpd.log ../goi_cuda test6.in out_xgpd.out $gridSize 1 1 $blkSize 1 1 >> results_test6_xgpd.out
        cat log_xgpd.log >> results_test6_xgpd.out
        echo "----------------------------end of prev---------------------------------------" >> results_test6_xgpd.out
        cat out_xgpd.out >> out_test6_xgpd.out
        echo "" >> out_test6_xgpd.out
    } done
done

cat results_test6_xgpd.out | grep "GPU activities" > test6_xgpd.txt


for j in 0 1 2
do
    for i in "${!grid[@]}"; do {
        gridSize=${grid[$i]}
        blkSize=${blk[$i]}
        nvprof --log-file log_xgpd.log ../goi_cuda test4.in out_xgpd.out $gridSize 1 1 $blkSize 1 1 >> results_test4_xgpd.out
        cat log_xgpd.log >> results_test4_xgpd.out
        echo "----------------------------end of prev---------------------------------------" >> results_test4_xgpd.out
        cat out_xgpd.out >> out_test4_xgpd.out
        echo "" >> out_test4_xgpd.out
    } done
done

cat results_test4_xgpd.out | grep "GPU activities" > test4_xgpd.txt