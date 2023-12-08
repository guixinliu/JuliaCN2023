## @time
using LinearAlgebra
a = rand(2^22);
@time sum(a);
@time norm(a);
@time norm(a);
@time norm(a);


## @btime & @benchmark in BenchmarkTools
using BenchmarkTools
a = rand(2^22);
@btime sum(a);
@benchmark sum(a);


# @timeit in TimerOutputs
using TimerOutputs

const to = TimerOutput();

function time_test()
    @timeit to "nest 1" begin
        sleep(0.1)
        # 3 calls to the same label
        @timeit to "level 2.1" sleep(0.03)
        @timeit to "level 2.1" sleep(0.03)
        @timeit to "level 2.1" sleep(0.03)
        @timeit to "level 2.2" sleep(0.2)
    end
    @timeit to "nest 2" begin
        @timeit to "level 2.1" sleep(0.3)
        @timeit to "level 2.2" sleep(0.4)
    end
end

time_test()
show(to)
