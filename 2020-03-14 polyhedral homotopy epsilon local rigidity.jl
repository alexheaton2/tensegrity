using HomotopyContinuation, LinearAlgebra

#=
Here we change coordinates to the moving frame
=#
function set_locations(p0)
    # p0 should be an n by d array, p0[1,:] gives the coords of node 1
    # returns a new configuration \widehat{p0}
    # which has been translated and rotated
    # ASSUME nodes 1,2,3 CONNECTED and NON-COLLINEAR
    # here we change coordinates so that
    # node 1 has coordinates 0,0,0
    # node 2 has coordinates *,0,0
    # node 3 has coordinates *,*,0
    p1 = translate_coordinates(p0)
    p2 = rotate_coordinates(p1)
    return p2
end

function rotate_coordinates(p0)
    # p0 should be an n by d array, p0[1,:] gives the coords of node 1
    # ASSUME node 1 has coordinates 0,0,0 (already TRANSLATED)
    # ASSUME nodes 1,2,3 CONNECTED and NON-COLLINEAR
    # here we change coordinates so that
    # node 1 has coordinates 0,0,0
    # node 2 has coordinates *,0,0
    # node 3 has coordinates *,*,0
    n,d = size(p0)
    if d==3
        v2 = p0[2,:] #p0[2]
        v3 = p0[3,:]  #p0[3]
        V = hcat(v2,v3)
        Q,R = qr(V)
        p1 = p0*Q # equivalently applies Q' to every column vector p0[i,:]
    elseif d==2
        Q,R = qr(p0[2,:])
        p1 = p0*Q # equivalently applies Q' to every column vector p0[i,:]
    end
    return p1
end

function translate_coordinates(p0)
    # p0 should be an n by d array, p0[1,:] gives the coords of node 1
    # ASSUME nodes 1,2,3 CONNECTED and NON-COLLINEAR
    # here we change coordinates so that
    # node 1 has coordinates 0,0,0
    n,d = size(p0)
    p1 = zeros(n,d)
    for i in 2:n
        p1[i,:] = p0[i,:] - p0[1,:]
    end
    return p1
end

function get_equation(p0, x, edge)
    i,j = edge
    v = x[j,:] - x[i,:]
    w = p0[j,:] - p0[i,:]
    gij = sum([vi^2 for vi in v]) - sum(wi^2 for wi in w)
    return gij
end




#=
Here is the "epsilon local rigidity" test.
This code was needing 67 million paths for total degree homotopy.
=#
ht = 3
p0 = [1 0 0; -1/2 sqrt(3)/2 0; -1/2 -sqrt(3)/2 0;
        -sqrt(3)/2 -1/2 ht; sqrt(3)/2 -1/2 ht; 0 1 ht]
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),
        (2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]

m = length(edges)
n,d = size(p0)
N = n*d - binomial(d+1,2)
@polyvar x[1:n,1:d]
p0 = set_locations(p0)

g = [get_equation(p0,x,edge) for edge in edges]
subz = Dict(x[i,k] => 0 for i in 1:n for k in 1:d if k >= i)
g = [subs(gij, subz...) for gij in g]
# "g" contains the squared edge length equations

# the ε-sphere equation
ε = 0.1 # you could change this
s = sum([ (x[i,k]-p0[i,k])^2 for i in 1:n for k in 1:d ]) - ε^2
s = subs(s, subz...)

# our one polynomial
G = sum([gi^2 for gi in g]) + s^2
# add Gaussian noise
y0 = p0 + randn(Float64,n,d)
# only the lower number of variables
Nvarz = [x[i,k] for i in 1:n for k in 1:d if k < i]
∇G = differentiate(G, Nvarz)
xminusy = [x[i,k] - y0[i,k] for i in 1:n for k in 1:d if k < i]
# affine chart of projective space
@polyvar λ[1:2]
a = rand(Float64, 2,1) # random affine chart of projective space
lagrange = λ[1]*∇G + λ[2]*xminusy
chart = sum(λ.*a) - 1

# "G" is one polynomial, the sum of squares of all the
# squared edge length equations, one for each edge,
# and the sphere equation too.
# "lagrange" and "chart" are the equations for Euclidean distance minimization
F = vcat(G,lagrange,chart)
display(bezout_number(F))

# multi-homogeneous Bezout number is only 8 million or so
vars = variables(F)
display(bezout_number(F; variable_groups=[vars[1:12],vars[13:14]]))

# even better is the mixed volume, which gives about 1 million paths!
display(mixed_volume(F))

# random seed was 525849.
resultpolyhedral = solve(F; start_system = :polyhedral)
# zero real solutions.
rs = real_solutions(resultpolyhedral)
display(resultpolyhedral)