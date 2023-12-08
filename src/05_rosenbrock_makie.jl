using CairoMakie

# shift for log axis
rosenbrock_shift(xi, yi) =  (1 - xi)^2 + 10 * (yi - xi^2)^2 + 0.0001

x = -2:0.01:2
y = -1:0.01:3
z = [rosenbrock_shift(xi, yi) for xi in x, yi in y]

fig = Figure(fontsize=22)
axs = [Axis(fig[1, 1]; aspect=1, xlabel="x", ylabel="y")]
p1 = heatmap!(axs[1], x, y, z; colormap=:plasma, colorscale=log10)
Colorbar(fig[1, 2], p1)
fig