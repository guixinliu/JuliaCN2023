using JuMP
import Ipopt
using Test

# https://jump.dev/JuMP.jl/stable/tutorials/nonlinear/simple_examples/#The-Rosenbrock-function
function example_rosenbrock()
    model = Model(Ipopt.Optimizer)
    set_silent(model)
    @variable(model, x)
    @variable(model, y)
    @objective(model, Min, (1 - x)^2 + 10 * (y - x^2)^2)
    optimize!(model)
    Test.@test termination_status(model) == LOCALLY_SOLVED
    Test.@test primal_status(model) == FEASIBLE_POINT
    Test.@test objective_value(model) ≈ 0.0 atol = 1e-10
    Test.@test value(x) ≈ 1.0
    Test.@test value(y) ≈ 1.0
    println("x = $(value(x)), y = $(value(y))") 
end

example_rosenbrock()