#include <iostream>
#include <cstdlib>

__global__ void vectorAdd(int *a, int *b, int *c, int n){
    int tid = blockIdx.x * blockDim.x + threadIdx.x;

    if (tid < n){
        c[tid] = a[tid] + b[tid];
    }
}

int main(){
    int n = 1 << 20;

    size_t size = n * sizeof(int);

    int *a = (int*)malloc(size);
    int *b = (int*)malloc(size);
    int *c = (int*)malloc(size);

    for(int i = 0; i < n; i++){
        a[i] = 1;
        b[i] = 2;
    }

    int *d_a;
    int *d_b;
    int *d_c;

    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    int threads = 256;

    int blocks = (n + threads - 1) / threads;

    vectorAdd<<<blocks, threads>>>(d_a, d_b, d_c, n);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    for (int i = 0; i < n; i++){
        std::cout << a[i] << " + " << b[i] << " = " << c[i] << std::endl;
    }

    for (int i = 0; i < n; i++){
        if(c[i] != 3){
            std::cout << "Error at index " << i << std::endl;
            break;
        }
    }

    std::cout << "Done" << std::endl;

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    free(a);
    free(b);
    free(c);

    return 0;
}