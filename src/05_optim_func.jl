using Optim

rosenbrock(x) =  (1.0 - x[1])^2 + 10.0 * (x[2] - x[1]^2)^2
result = optimize(rosenbrock, zeros(2), BFGS())
x, y = Optim.minimizer(result)
fmin = minimum(result)
println("x = $x, y = $y")
println("fmin = $fmin")