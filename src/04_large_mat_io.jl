using JLD2
using Printf
using BenchmarkTools

n = 10
a = rand(n, n)

function largeio(a)
    jldopen("example.jld2", "w") do file
        file["bigdata"] = a
    end
end

function largeio2(a)
    open("example2.dat", "w") do io
        for ix in eachindex(a)
            @printf(io, "%.4f\n", a[ix])
        end
    end 
end


