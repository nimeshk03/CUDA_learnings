# CUDA Learnings

My CUDA programming practice repository.

## Workflow

Code is written locally and executed on Google Colab using a GPU runtime.

Local workflow:

    git add .
    git commit -m "practice"
    git push

Colab workflow:

    %cd /content/CUDA_learnings
    !git pull
    !./run_cuda.sh 01_vector_addition/main.cu

## Topics

- Vector addition
- Matrix multiplication
- Reductions
- Shared memory
- Atomic operations
- CUDA memory management
- Kernel optimization
