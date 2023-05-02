# run on test3.in and test5.in

# 32768
nvprof --log-file results_xgpc/32768_32x1024_test3_1 ../goi_cuda test3.in out 2 4 4 16 8 8
nvprof --log-file results_xgpc/32768_32x1024_test5_1 ../goi_cuda test5.in out 2 4 4 16 8 8

nvprof --log-file results_xgpc/32768_64x512_test3_1 ../goi_cuda test3.in out 4 4 4 8 8 8
nvprof --log-file results_xgpc/32768_64x512_test5_1 ../goi_cuda test5.in out 4 4 4 8 8 8

nvprof --log-file results_xgpc/32768_128x256_test3_1 ../goi_cuda test3.in out 8 4 4 4 8 8
nvprof --log-file results_xgpc/32768_128x256_test5_1 ../goi_cuda test5.in out 8 4 4 4 8 8

nvprof --log-file results_xgpc/32768_256x128_test3_1 ../goi_cuda test3.in out 16 4 4 2 8 8
nvprof --log-file results_xgpc/32768_256x128_test5_1 ../goi_cuda test5.in out 16 4 4 2 8 8

nvprof --log-file results_xgpc/32768_512x64_test3_1 ../goi_cuda test3.in out 32 4 4 1 8 8
nvprof --log-file results_xgpc/32768_512x64_test5_1 ../goi_cuda test5.in out 32 4 4 1 8 8

# 65536
nvprof --log-file results_xgpc/65536_64x1024_test3_1 ../goi_cuda test3.in out 4 4 4 16 8 8
nvprof --log-file results_xgpc/65536_64x1024_test5_1 ../goi_cuda test5.in out 4 4 4 16 8 8

nvprof --log-file results_xgpc/65536_128x512_test3_1 ../goi_cuda test3.in out 8 4 4 8 8 8
nvprof --log-file results_xgpc/65536_128x512_test5_1 ../goi_cuda test5.in out 8 4 4 8 8 8

nvprof --log-file results_xgpc/65536_256x256_test3_1 ../goi_cuda test3.in out 16 4 4 4 8 8
nvprof --log-file results_xgpc/65536_256x256_test5_1 ../goi_cuda test5.in out 16 4 4 4 8 8

nvprof --log-file results_xgpc/65536_512x128_test3_1 ../goi_cuda test3.in out 32 4 4 2 8 8
nvprof --log-file results_xgpc/65536_512x128_test5_1 ../goi_cuda test5.in out 32 4 4 2 8 8

nvprof --log-file results_xgpc/65536_1024x64_test3_1 ../goi_cuda test3.in out 64 4 4 1 8 8
nvprof --log-file results_xgpc/65536_1024x64_test5_1 ../goi_cuda test5.in out 64 4 4 1 8 8

# 131072
nvprof --log-file results_xgpc/131072_64x2048_test3_1 ../goi_cuda test3.in out 4 4 4 32 8 8
nvprof --log-file results_xgpc/131072_64x2048_test5_1 ../goi_cuda test5.in out 4 4 4 32 8 8

nvprof --log-file results_xgpc/131072_128x1024_test3_1 ../goi_cuda test3.in out 8 4 4 16 8 8
nvprof --log-file results_xgpc/131072_128x1024_test5_1 ../goi_cuda test5.in out 8 4 4 16 8 8

nvprof --log-file results_xgpc/131072_256x512_test3_1 ../goi_cuda test3.in out 16 4 4 8 8 8
nvprof --log-file results_xgpc/131072_256x512_test5_1 ../goi_cuda test5.in out 16 4 4 8 8 8

nvprof --log-file results_xgpc/131072_512x256_test3_1 ../goi_cuda test3.in out 32 4 4 4 8 8
nvprof --log-file results_xgpc/131072_512x256_test5_1 ../goi_cuda test5.in out 32 4 4 4 8 8

nvprof --log-file results_xgpc/131072_1024x128_test3_1 ../goi_cuda test3.in out 64 4 4 2 8 8
nvprof --log-file results_xgpc/131072_1024x128_test5_1 ../goi_cuda test5.in out 64 4 4 2 8 8

# 262144
nvprof --log-file results_xgpc/262144_128x2048_test3_1 ../goi_cuda test3.in out 8 4 4 32 8 8
nvprof --log-file results_xgpc/262144_128x2048_test5_1 ../goi_cuda test5.in out 8 4 4 32 8 8

nvprof --log-file results_xgpc/262144_256x1024_test3_1 ../goi_cuda test3.in out 16 4 4 16 8 8
nvprof --log-file results_xgpc/262144_256x1024_test5_1 ../goi_cuda test5.in out 16 4 4 16 8 8

nvprof --log-file results_xgpc/262144_512x512_test3_1 ../goi_cuda test3.in out 32 4 4 8 8 8
nvprof --log-file results_xgpc/262144_512x512_test5_1 ../goi_cuda test5.in out 32 4 4 8 8 8

nvprof --log-file results_xgpc/262144_1024x256_test3_1 ../goi_cuda test3.in out 64 4 4 4 8 8
nvprof --log-file results_xgpc/262144_1024x256_test5_1 ../goi_cuda test5.in out 64 4 4 4 8 8

nvprof --log-file results_xgpc/262144_2048x128_test3_1 ../goi_cuda test3.in out 128 4 4 2 8 8
nvprof --log-file results_xgpc/262144_2048x128_test5_1 ../goi_cuda test5.in out 128 4 4 2 8 8

# Repeat - remember different output file
# 32768
nvprof --log-file results_xgpc/32768_32x1024_test3_2 ../goi_cuda test3.in out 2 4 4 16 8 8
nvprof --log-file results_xgpc/32768_32x1024_test5_2 ../goi_cuda test5.in out 2 4 4 16 8 8

nvprof --log-file results_xgpc/32768_64x512_test3_2 ../goi_cuda test3.in out 4 4 4 8 8 8
nvprof --log-file results_xgpc/32768_64x512_test5_2 ../goi_cuda test5.in out 4 4 4 8 8 8

nvprof --log-file results_xgpc/32768_128x256_test3_2 ../goi_cuda test3.in out 8 4 4 4 8 8
nvprof --log-file results_xgpc/32768_128x256_test5_2 ../goi_cuda test5.in out 8 4 4 4 8 8

nvprof --log-file results_xgpc/32768_256x128_test3_2 ../goi_cuda test3.in out 16 4 4 2 8 8
nvprof --log-file results_xgpc/32768_256x128_test5_2 ../goi_cuda test5.in out 16 4 4 2 8 8

nvprof --log-file results_xgpc/32768_512x64_test3_2 ../goi_cuda test3.in out 32 4 4 1 8 8
nvprof --log-file results_xgpc/32768_512x64_test5_2 ../goi_cuda test5.in out 32 4 4 1 8 8

# 65536
nvprof --log-file results_xgpc/65536_64x1024_test3_2 ../goi_cuda test3.in out 4 4 4 16 8 8
nvprof --log-file results_xgpc/65536_64x1024_test5_2 ../goi_cuda test5.in out 4 4 4 16 8 8

nvprof --log-file results_xgpc/65536_128x512_test3_2 ../goi_cuda test3.in out 8 4 4 8 8 8
nvprof --log-file results_xgpc/65536_128x512_test5_2 ../goi_cuda test5.in out 8 4 4 8 8 8

nvprof --log-file results_xgpc/65536_256x256_test3_2 ../goi_cuda test3.in out 16 4 4 4 8 8
nvprof --log-file results_xgpc/65536_256x256_test5_2 ../goi_cuda test5.in out 16 4 4 4 8 8

nvprof --log-file results_xgpc/65536_512x128_test3_2 ../goi_cuda test3.in out 32 4 4 2 8 8
nvprof --log-file results_xgpc/65536_512x128_test5_2 ../goi_cuda test5.in out 32 4 4 2 8 8

nvprof --log-file results_xgpc/65536_1024x64_test3_2 ../goi_cuda test3.in out 64 4 4 1 8 8
nvprof --log-file results_xgpc/65536_1024x64_test5_2 ../goi_cuda test5.in out 64 4 4 1 8 8

# 131072
nvprof --log-file results_xgpc/131072_64x2048_test3_2 ../goi_cuda test3.in out 4 4 4 32 8 8
nvprof --log-file results_xgpc/131072_64x2048_test5_2 ../goi_cuda test5.in out 4 4 4 32 8 8

nvprof --log-file results_xgpc/131072_128x1024_test3_2 ../goi_cuda test3.in out 8 4 4 16 8 8
nvprof --log-file results_xgpc/131072_128x1024_test5_2 ../goi_cuda test5.in out 8 4 4 16 8 8

nvprof --log-file results_xgpc/131072_256x512_test3_2 ../goi_cuda test3.in out 16 4 4 8 8 8
nvprof --log-file results_xgpc/131072_256x512_test5_2 ../goi_cuda test5.in out 16 4 4 8 8 8

nvprof --log-file results_xgpc/131072_512x256_test3_2 ../goi_cuda test3.in out 32 4 4 4 8 8
nvprof --log-file results_xgpc/131072_512x256_test5_2 ../goi_cuda test5.in out 32 4 4 4 8 8

nvprof --log-file results_xgpc/131072_1024x128_test3_2 ../goi_cuda test3.in out 64 4 4 2 8 8
nvprof --log-file results_xgpc/131072_1024x128_test5_2 ../goi_cuda test5.in out 64 4 4 2 8 8

# 262144
nvprof --log-file results_xgpc/262144_128x2048_test3_2 ../goi_cuda test3.in out 8 4 4 32 8 8
nvprof --log-file results_xgpc/262144_128x2048_test5_2 ../goi_cuda test5.in out 8 4 4 32 8 8

nvprof --log-file results_xgpc/262144_256x1024_test3_2 ../goi_cuda test3.in out 16 4 4 16 8 8
nvprof --log-file results_xgpc/262144_256x1024_test5_2 ../goi_cuda test5.in out 16 4 4 16 8 8

nvprof --log-file results_xgpc/262144_512x512_test3_2 ../goi_cuda test3.in out 32 4 4 8 8 8
nvprof --log-file results_xgpc/262144_512x512_test5_2 ../goi_cuda test5.in out 32 4 4 8 8 8

nvprof --log-file results_xgpc/262144_1024x256_test3_2 ../goi_cuda test3.in out 64 4 4 4 8 8
nvprof --log-file results_xgpc/262144_1024x256_test5_2 ../goi_cuda test5.in out 64 4 4 4 8 8

nvprof --log-file results_xgpc/262144_2048x128_test3_2 ../goi_cuda test3.in out 128 4 4 2 8 8
nvprof --log-file results_xgpc/262144_2048x128_test5_2 ../goi_cuda test5.in out 128 4 4 2 8 8
