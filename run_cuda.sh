#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./run_cuda.sh path/to/file.cu"
  exit 1
fi

CUDA_FILE="$1"
OUT="build/$(basename "$CUDA_FILE" .cu)"

mkdir -p build

echo "[1] Checking CUDA compiler..."
nvcc --version

echo
echo "[2] Compiling $CUDA_FILE..."
nvcc -O2 "$CUDA_FILE" -o "$OUT"

echo
echo "[3] Running $OUT..."
"$OUT"
