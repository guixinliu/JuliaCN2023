using CUDA
using cuTENSOR
using OMEinsum
using TensorOperations
using TimerOutputs


# Create a TimerOutput, this is the main type that keeps track of everything.
const to = TimerOutput();

dims = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

for dim in dims
    println("[-] dim = $dim test start:")
    a_cpu = randn(Float64, (4, dim, dim))
    b_cpu = randn(Float64, (4, dim, dim))
    block_cpu = Array{Float64}(undef, (4, 4, dim, dim))

    a_gpu = CuArray(a_cpu)
    b_gpu = CuArray(b_cpu)
    block_gpu = CuArray{Float64}(undef, (4, 4, dim, dim))

    @timeit to "einsum_cpu_$dim" @ein block_cpu[p, b, n, m] := a_cpu[p, n, o] * b_cpu[b, o, m]
    @timeit to "tensor_cpu_$dim" @tensor block_cpu[p, b, n, m]:= a_cpu[p, n, o] * b_cpu[b, o, m]

    print("einsum_gpu_$dim: ")
    CUDA.@time CUDA.@sync @ein block_gpu[p, b, n, m] := a_gpu[p, n, o] * b_gpu[b, o, m]
    
    print("tensor_gpu_$dim: ")
    CUDA.@time CUDA.@sync @cutensor block_gpu[p, b, n, m] := a_gpu[p, n, o] * b_gpu[b, o, m]

    modesA = ['p', 'b', 'n', 'm']
    modesU = ['p', 'n', 'o']
    modesV = ['b', 'o', 'm']

    At = CuTensor(block_gpu, modesA)
    Vt = CuTensor(b_gpu, modesV)

    print("cuTENSOR einsum: ")
    CUDA.@time CUDA.@sync At = Ut * Vt

    println("[-] dim = $dim test end")
end

show(to)