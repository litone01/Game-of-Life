build:
	nvcc -arch sm_70 sb/sb.cu exporter.cu goi_cuda.cu main.cu -o goi_cuda

baseline:
	nvcc -arch sm_70 sb/sb.cu exporter.cu goi_cuda_baseline.cu main.cu -o goi_cuda_baseline
	
example:
	nvcc -o export_example.out sb/sb.cu exporter.cu export_example.cu
