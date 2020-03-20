using HomotopyContinuation, LinearAlgebra, Plots

@polyvar x t
γ = rand(ComplexF64)

f = x^3 - 7x^2 + 17x - 15 # first example
#f = x^3 - 5x^2 - 7x + 51 # second example
g = x^3 - 1
h = (1-t)f + γ*t*g

startsolz = [-0.5 + 0.866im; -0.5 - 0.866im; 1.0 + 0.0im]

M = 100
endparameters = [1.0 - Δt/M for Δt in 1:M]

solutionpoints = zeros(2,length(startsolz))
for i in 1:length(startsolz)
    solutionpoints[:,i] = [real(startsolz[i]); imag(startsolz[i])]
end
plt = scatter(solutionpoints[1,:], solutionpoints[2,:],
        aspect_ratio = :equal,
        color = :black,
        legend = false,
        size=(500,500))

function evolve(plt)
    for (count,startsol) in enumerate(startsolz)
        clr = :lightblue
        if count==2
            clr = :indianred
        end
        if count==3
            clr = :seagreen
        end
        for endparam in endparameters
            result = solve([h], [startsol]; parameters=[t],
                            start_parameters = [1.0],
                            target_parameters = [endparam])
            sols = solutions(result)
            points = map(x->vec([real(x); imag(x)]), sols)
            pointz = zeros(2,length(points))
            for (i,point) in enumerate(points)
                pointz[:,i] = point
            end
            plt = Plots.scatter!(pointz[1,:], pointz[2,:],
                aspect_ratio = :equal,
                color = clr,
                legend = false,
                size=(500,500),
                tickfont = font(10, "Courier"))
        end
    end
    return plt
end

pltfinal = evolve(plt)

savefig(pltfinal, "planets-moving.png")
