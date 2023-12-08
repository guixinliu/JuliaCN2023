using CUDA
using cuTENSOR
using cuTensorNet
using TimerOutputs
using LinearAlgebra
using TensorKit


const to = TimerOutput();

alldim = [50, 100, 200, 300, 400, 500]

for dim_i in alldim
    u_cpu = Tensor(zeros, ℝ^4 ⊗ ℝ^dim_i ⊗ ℝ^dim_i)
    vd_cpu = Tensor(zeros, ℝ^4 ⊗ ℝ^dim_i ⊗ ℝ^dim_i)
    s_cpu = Tensor(zeros, ℝ^dim_i)
    block_cpu = Tensor(randn, ℝ^4 ⊗ ℝ^4 ⊗ ℝ^dim_i ⊗ ℝ^dim_i)

    println("svd_gpu_$dim_i: ")
    @timeit to "svd_cpu$dim_i" u_cpu, s_cpu, vd_cpu = tsvd(block_cpu, (1, 3), (2, 4))

block_gpu = CuArray(convert(Array, block_cpu))
u_gpu =CuArray{Float64}(undef, (4, dim_i, dim_i))
s_gpu =CuVector{Float64}(undef, (dim_i,))
v_gpu =CuArray{Float64}(undef, (4, dim_i, dim_i))

modesA = ['p', 'b', 'n', 'm']
modesU = ['p', 'n', 'o']
modesV = ['b', 'o', 'm']

print("svd_gpu_$dim_i: ")
CUDA.@time CUDA.@sync cuTensorNet.svd!(block_gpu, modesA, u_gpu, modesU, s_gpu, v_gpu, modesV)
end

show(to)


