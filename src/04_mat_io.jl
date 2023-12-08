using DelimitedFiles

a = 1:10
b = a.^2 + a

open("result1.dat", "w") do io
    println(io, "a   b")
    writedlm(io, [a b])
end 


using Printf

x = randn()
y = x.^2 + x

open("result2.dat", "w") do io
    println(io, "x          y")
    for (ix, iy) in zip(x, y)
        @printf(io, "%.4f    %.4f \n", ix, iy)
    end
end 
