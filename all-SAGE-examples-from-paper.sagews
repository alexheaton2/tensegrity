︠30948442-739d-44a9-b0d1-eb2f6001b63es︠
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
h = 3
# Equation (1) in the paper:
node_coordinates = {1:(1,0,0), 2:(-1/2, sqrt(3)/2, 0), 3:(-1/2, -sqrt(3)/2, 0), 4:(-sqrt(3)/2, -1/2, h), 5:(sqrt(3)/2, -1/2, h), 6:(0,1,h)}
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),(2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim)
show(truss.before, frame=False)
︡be47dc0a-6336-4351-afc6-1dad4e02a3ad︡{"file":{"filename":"f3cecdae-496f-4e8d-8176-05db55797996.sage3d","uuid":"f3cecdae-496f-4e8d-8176-05db55797996"}}︡{"done":true}
︠75e00900-e338-4eb9-82b3-e978188a30ccs︠
# Equation (2) in the paper
BCs = truss.bar_constraints
g = []
for e in truss.edges:
    g.append(BCs[e])
for gij in g:
    show(gij)
︡4d1ffa64-50f1-48e7-9de5-46e30c221899︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{11} - x_{21}\\right)}^{2} + {\\left(x_{12} - x_{22}\\right)}^{2} + {\\left(x_{13} - x_{23}\\right)}^{2} - 3$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{11} - x_{31}\\right)}^{2} + {\\left(x_{12} - x_{32}\\right)}^{2} + {\\left(x_{13} - x_{33}\\right)}^{2} - 3$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{11} - x_{41}\\right)}^{2} + {\\left(x_{12} - x_{42}\\right)}^{2} + {\\left(x_{13} - x_{43}\\right)}^{2} - \\frac{1}{4} \\, {\\left(\\sqrt{3} + 2\\right)}^{2} - \\frac{37}{4}$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{11} - x_{51}\\right)}^{2} + {\\left(x_{12} - x_{52}\\right)}^{2} + {\\left(x_{13} - x_{53}\\right)}^{2} - \\frac{1}{4} \\, {\\left(\\sqrt{3} - 2\\right)}^{2} - \\frac{37}{4}$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{21} - x_{31}\\right)}^{2} + {\\left(x_{22} - x_{32}\\right)}^{2} + {\\left(x_{23} - x_{33}\\right)}^{2} - 3$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{21} - x_{51}\\right)}^{2} + {\\left(x_{22} - x_{52}\\right)}^{2} + {\\left(x_{23} - x_{53}\\right)}^{2} - \\frac{1}{2} \\, {\\left(\\sqrt{3} + 1\\right)}^{2} - 9$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{21} - x_{61}\\right)}^{2} + {\\left(x_{22} - x_{62}\\right)}^{2} + {\\left(x_{23} - x_{63}\\right)}^{2} - \\frac{1}{4} \\, {\\left(\\sqrt{3} - 2\\right)}^{2} - \\frac{37}{4}$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{31} - x_{41}\\right)}^{2} + {\\left(x_{32} - x_{42}\\right)}^{2} + {\\left(x_{33} - x_{43}\\right)}^{2} - \\frac{1}{2} \\, {\\left(\\sqrt{3} - 1\\right)}^{2} - 9$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{31} - x_{61}\\right)}^{2} + {\\left(x_{32} - x_{62}\\right)}^{2} + {\\left(x_{33} - x_{63}\\right)}^{2} - \\frac{1}{4} \\, {\\left(\\sqrt{3} + 2\\right)}^{2} - \\frac{37}{4}$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{41} - x_{51}\\right)}^{2} + {\\left(x_{42} - x_{52}\\right)}^{2} + {\\left(x_{43} - x_{53}\\right)}^{2} - 3$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{41} - x_{61}\\right)}^{2} + {\\left(x_{42} - x_{62}\\right)}^{2} + {\\left(x_{43} - x_{63}\\right)}^{2} - 3$</div>"}︡{"html":"<div align='center'>$\\displaystyle {\\left(x_{51} - x_{61}\\right)}^{2} + {\\left(x_{52} - x_{62}\\right)}^{2} + {\\left(x_{53} - x_{63}\\right)}^{2} - 3$</div>"}︡{"done":true}
︠bd2ae675-48b1-4ac3-bbcb-77b713aa6d6fs︠
# Equation (3) in the paper
dg = jacobian(g,truss.X.list())/2
show(dg); print; # show(truss.rigidity_matrix)
show(truss.rigidity_matrix_at_p)
︡cb2a5153-a520-4949-a37b-23fc6650e8fe︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\nx_{11} - x_{21} &amp; x_{12} - x_{22} &amp; x_{13} - x_{23} &amp; -x_{11} + x_{21} &amp; -x_{12} + x_{22} &amp; -x_{13} + x_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{31} &amp; x_{12} - x_{32} &amp; x_{13} - x_{33} &amp; 0 &amp; 0 &amp; 0 &amp; -x_{11} + x_{31} &amp; -x_{12} + x_{32} &amp; -x_{13} + x_{33} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{41} &amp; x_{12} - x_{42} &amp; x_{13} - x_{43} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{11} + x_{41} &amp; -x_{12} + x_{42} &amp; -x_{13} + x_{43} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{51} &amp; x_{12} - x_{52} &amp; x_{13} - x_{53} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{11} + x_{51} &amp; -x_{12} + x_{52} &amp; -x_{13} + x_{53} &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; x_{21} - x_{31} &amp; x_{22} - x_{32} &amp; x_{23} - x_{33} &amp; -x_{21} + x_{31} &amp; -x_{22} + x_{32} &amp; -x_{23} + x_{33} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; x_{21} - x_{51} &amp; x_{22} - x_{52} &amp; x_{23} - x_{53} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{21} + x_{51} &amp; -x_{22} + x_{52} &amp; -x_{23} + x_{53} &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; x_{21} - x_{61} &amp; x_{22} - x_{62} &amp; x_{23} - x_{63} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{21} + x_{61} &amp; -x_{22} + x_{62} &amp; -x_{23} + x_{63} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{31} - x_{41} &amp; x_{32} - x_{42} &amp; x_{33} - x_{43} &amp; -x_{31} + x_{41} &amp; -x_{32} + x_{42} &amp; -x_{33} + x_{43} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{31} - x_{61} &amp; x_{32} - x_{62} &amp; x_{33} - x_{63} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{31} + x_{61} &amp; -x_{32} + x_{62} &amp; -x_{33} + x_{63} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{41} - x_{51} &amp; x_{42} - x_{52} &amp; x_{43} - x_{53} &amp; -x_{41} + x_{51} &amp; -x_{42} + x_{52} &amp; -x_{43} + x_{53} &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{41} - x_{61} &amp; x_{42} - x_{62} &amp; x_{43} - x_{63} &amp; 0 &amp; 0 &amp; 0 &amp; -x_{41} + x_{61} &amp; -x_{42} + x_{62} &amp; -x_{43} + x_{63} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{51} - x_{61} &amp; x_{52} - x_{62} &amp; x_{53} - x_{63} &amp; -x_{51} + x_{61} &amp; -x_{52} + x_{62} &amp; -x_{53} + x_{63}\n\\end{array}\\right)$</div>"}︡{"stdout":"\n"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\n\\frac{3}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} &amp; 0 &amp; -\\frac{3}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n\\frac{3}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\frac{3}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n\\frac{1}{2} \\, \\sqrt{3} + 1 &amp; \\frac{1}{2} &amp; -3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\frac{1}{2} \\, \\sqrt{3} - 1 &amp; -\\frac{1}{2} &amp; 3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n-\\frac{1}{2} \\, \\sqrt{3} + 1 &amp; \\frac{1}{2} &amp; -3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} \\, \\sqrt{3} - 1 &amp; -\\frac{1}{2} &amp; 3 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; \\sqrt{3} &amp; 0 &amp; 0 &amp; -\\sqrt{3} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; -\\frac{1}{2} \\, \\sqrt{3} - \\frac{1}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} + \\frac{1}{2} &amp; -3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} \\, \\sqrt{3} + \\frac{1}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} - \\frac{1}{2} &amp; 3 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; -\\frac{1}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} - 1 &amp; -3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} + 1 &amp; 3 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} \\, \\sqrt{3} - \\frac{1}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} + \\frac{1}{2} &amp; -3 &amp; -\\frac{1}{2} \\, \\sqrt{3} + \\frac{1}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} - \\frac{1}{2} &amp; 3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\frac{1}{2} &amp; -\\frac{1}{2} \\, \\sqrt{3} - 1 &amp; -3 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} &amp; \\frac{1}{2} \\, \\sqrt{3} + 1 &amp; 3 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\sqrt{3} &amp; 0 &amp; 0 &amp; \\sqrt{3} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\frac{1}{2} \\, \\sqrt{3} &amp; -\\frac{3}{2} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} \\, \\sqrt{3} &amp; \\frac{3}{2} &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{1}{2} \\, \\sqrt{3} &amp; -\\frac{3}{2} &amp; 0 &amp; -\\frac{1}{2} \\, \\sqrt{3} &amp; \\frac{3}{2} &amp; 0\n\\end{array}\\right)$</div>"}︡{"done":true}
︠8036cdc4-7a54-4481-a966-46ca5b6d2437s︠
# Figure 5 in the paper
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
h = 1
node_coordinates = {1:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50)),
                    2:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50)),
                    3:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50)),
                    4:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50)),
                    5:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50)),
                    6:(QQ.random_element(50,50), QQ.random_element(50,50), QQ.random_element(50,50))}
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),(2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim)
truss.plot_flexes()
show(truss.flexes_plot, frame=False)
print;
rank(truss.A); rank(truss.rigidity_matrix_at_p)
︡132200f4-68ef-4e54-bf22-d2d75d87e223︡{"file":{"filename":"93f11fe0-44de-442d-a18c-a3a23f2dd27c.sage3d","uuid":"93f11fe0-44de-442d-a18c-a3a23f2dd27c"}}︡{"stdout":"\n"}︡{"stdout":"12\n12\n"}︡{"done":true}
︠376bc2ea-f8db-4d6f-bc4a-1032d662b8fcs︠
# Figure 6 electrical network
load("tensegrity.sage")

nodes = [1,2,3,4]
node_coordinates = {1:(1/2,1), 2:(5/2, 1), 3:(0, 0), 4:(3,0)}
edges = [(1,2),(1,3),(2,3),(2,4),(3,4)]
dim = 2

truss = Truss(nodes,edges,node_coordinates,dim)
show(truss.before, frame=False)
-truss.get_incidence_matrix() # notice the minus sign convention is different. But A^T C A remains the same.
︡e5aabf5d-a6eb-4fbd-aade-48bc182306b1︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_TlTbQG.svg","show":true,"text":null,"uuid":"c1a776a7-7a24-485d-815e-08ca936d4e19"},"once":false}︡{"stdout":"[-1  1  0  0]\n[-1  0  1  0]\n[ 0 -1  1  0]\n[ 0 -1  0  1]\n[ 0  0 -1  1]\n"}︡{"done":true}
︠eeb4c2f0-8415-40ba-abe3-183af8b345bbs︠
# Figure 8 shows the second row corresponding to edge (1,3).
show(truss.rigidity_matrix)
︡106e9efe-ca64-4587-8eed-01b771fea720︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrr}\nx_{11} - x_{21} &amp; x_{12} - x_{22} &amp; -x_{11} + x_{21} &amp; -x_{12} + x_{22} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{31} &amp; x_{12} - x_{32} &amp; 0 &amp; 0 &amp; -x_{11} + x_{31} &amp; -x_{12} + x_{32} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{31} &amp; x_{22} - x_{32} &amp; -x_{21} + x_{31} &amp; -x_{22} + x_{32} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{41} &amp; x_{22} - x_{42} &amp; 0 &amp; 0 &amp; -x_{21} + x_{41} &amp; -x_{22} + x_{42} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{31} - x_{41} &amp; x_{32} - x_{42} &amp; -x_{31} + x_{41} &amp; -x_{32} + x_{42}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠143473cc-bf1b-44cd-b166-e82f4593adc5s︠
load("tensegrity.sage")
nodes = range(1,12+1) # 12 vertices of icosahedron
u = 1
v = 1/2*(sqrt(5)+1) - 1 # since we use EXACT computation, this takes a bit of time...
node_coordinates = {1:(v,0,u), 2:(-v,0,u), 3:(0,u,v), 4:(u,v,0),
              5:(u,-v,0), 6:(0,-u,v), 7:(-u,v,0), 8:(0,u,-v),
              9:(v,0,-u), 10:(0,-u,-v), 11:(-u,-v,0), 12:(-v,0,-u)}
edges = [(1,2),(1,3),(1,4),(1,5),(1,6),(2,3),(2,6),(2,7),(2,11),(3,4),
        (3,7),(3,8),(4,5),(4,8),(4,9),(5,6),(5,9),(5,10),(6,10),(6,11),
        (7,8),(7,11),(7,12),(8,9),(8,12),(9,12),(10,11),(10,12),(11,12)] # remove (9,10)
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim,orthonormal=True)

truss.plot_arrow_scale = 0.07
truss.plot_flexes()

show(truss.flexes_plot, frame=False)
︡c9bd40c0-fbab-4e34-b011-124afd46b5ce︡{"file":{"filename":"94e15c86-06d5-4fb9-9eee-ce16d01daeb0.sage3d","uuid":"94e15c86-06d5-4fb9-9eee-ce16d01daeb0"}}︡{"done":true}
︠5fe706b3-9d01-4da2-8cc1-2f1cf2a58c0b︠
load("tensegrity.sage")

nodes = range(1,6+1) # 6 nodes in the plane
node_coordinates = {1:(0,0),2:(4,0),3:(0,3),4:(4,3),5:(4/3,3/2), 6:(8/3,3/2)}
edges = [(1,2),(1,3),(1,5),(2,6),(2,4),(3,4),(3,5),(4,6),(5,6)]
dim = 2

truss = Truss(nodes,edges,node_coordinates,dim,orthonormal=True)

truss.plot_arrow_scale = 2.0
truss.plot_mechanisms()
show(truss.mechanism_plot, frame=False)
︡e6f07a8a-4ef1-4ca8-a9ec-1a6ed8e2c6bb︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_nj2RJR.svg","show":true,"text":null,"uuid":"1bb32c1c-652b-42a3-b139-a25eecc9c70f"},"once":false}︡{"done":true}
︠315e6e74-cd7c-4d67-b036-ed2ee51fec32︠
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
node_coordinates = {1:(0,0), 2:(0,2), 3:(1,2), 4:(0,1), 5:(1,1), 6:(1,0)} # The nodes are labelled as in Problem 1, Section 2.7.
edges = [(2,3),(2,4),(3,5),(4,5),(4,6),(1,5)] # indices of the correct node in "nodes"
dim = 2

truss = Truss(nodes,edges,node_coordinates,dim,orthonormal=True) #T.fix_nodes([1,6])

truss.plot_arrow_scale = 1.0
truss.plot_mechanisms()

show(truss.mechanism_plot, frame=False)
︡8700d887-bab0-48a6-968a-8b39bbb271e9︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_XUNGvV.svg","show":true,"text":null,"uuid":"acb66e17-20ff-4b67-be55-2139c61172a2"},"once":false}︡{"done":true}
︠15c8ad84-fb8f-47d0-b1af-652cf1b6d0bes︠
# Figure 12
x,y = var('x y')
f = y - x^2
r = 3.5
plt = implicit_plot(f, (x,-r,r), (y,-1,3*r), aspect_ratio=1, linestyle='--', color='black')

df = jacobian(f,[x,y])
df; print;
dfatp = df({x:2,y:4})
print dfatp; print;
null = dfatp.right_kernel().basis_matrix()
v = vector(null) + vector([2,4])
v = arrow(vector([2,4]),v, color='blue')
plt += plot(v)
show(plt)
︡d8e923ec-14dd-4cf6-90bc-fe6c8a16f3b2︡{"stdout":"[-2*x    1]\n\n"}︡{"stdout":"[-4  1]\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_0EIQxN.svg","show":true,"text":null,"uuid":"de775fef-c0d0-44db-8e4d-ca12efc2e9d2"},"once":false}︡{"done":true}
︠70f3babc-4ff3-474e-a6cd-9e058d9d80c1s︠
# Figure 13
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
h = 3
node_coordinates = {1:(1,0,0), 2:(-1/2, sqrt(3)/2, 0), 3:(-1/2, -sqrt(3)/2, 0), 4:(-sqrt(3)/2, -1/2, h), 5:(sqrt(3)/2, -1/2, h), 6:(0,1,h)}
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),(2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim)
truss.plot_flexes()
show(truss.flexes_plot, frame=False)
︡3bd9a26b-4950-423c-ab6a-5acaaec9457a︡{"file":{"filename":"3ac7e878-dc91-46c1-8ae6-76aaca5d9b32.sage3d","uuid":"3ac7e878-dc91-46c1-8ae6-76aaca5d9b32"}}︡{"done":true}
︠79598473-339e-4d2b-b0bd-c38b6d33a581s︠
# Figure 14
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
h = 3
node_coordinates = {1:(1,0,0), 2:(-1/2, sqrt(3)/2, 0), 3:(-1/2, -sqrt(3)/2, 0), 4:(-sqrt(3)/2, -1/2, h), 5:(sqrt(3)/2, -1/2, h), 6:(0,1,h)}
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),(2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim)
truss.plot_rigid_motions()
show(truss.rigid_motions_plot, frame=False)
︡e4484e0a-ddd3-49fe-85dd-629d2c748317︡{"file":{"filename":"749e75ba-c084-4c2d-81be-98e5f2f05d20.sage3d","uuid":"749e75ba-c084-4c2d-81be-98e5f2f05d20"}}︡{"done":true}
︠27e4cf6b-de1f-4db8-bbab-4ed4de1244a7︠
# Figure 15 and 16
R.<x,y,z> = PolynomialRing(QQ,3,order='degrevlex')
eqns = [x*y-x^3, x*z-x^4, x^2*y*z-x^4*z-x^5*y + x^7]
I = R.ideal( eqns )
AP = I.associated_primes()
for p in AP:
    print  p.gens()
︡619a6d98-8a19-482a-ba11-e3534418c522︡{"stdout":"[x]\n[y^2 - x*z, x*y - z, x^2 - y]\n"}︡{"done":true}
︠b79dbef9-3e06-40ee-b173-f3fd5cc98cdds︠
df = jacobian(eqns,[x,y,z])
show(df)
print df((0,0,0)); print;
print df((0,5,3)); print;
print df((1,1,1)); print;
︡32f162bb-e618-4019-8a9a-b8b64b4bdaf0︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n-3 x^{2} + y &amp; x &amp; 0 \\\\\n-4 x^{3} + z &amp; 0 &amp; x \\\\\n7 x^{6} - 5 x^{4} y - 4 x^{3} z + 2 x y z &amp; -x^{5} + x^{2} z &amp; -x^{4} + x^{2} y\n\\end{array}\\right)$</div>"}︡{"stdout":"[0 0 0]\n[0 0 0]\n[0 0 0]\n\n"}︡{"stdout":"[5 0 0]\n[3 0 0]\n[0 0 0]\n\n"}︡{"stdout":"[-2  1  0]\n[-3  0  1]\n[ 0  0  0]\n\n"}︡{"done":true}
︠2f282a63-1ac2-42bf-b134-3ffd86a286b1s︠
# Figure 17.
load("tensegrity.sage")

nodes = range(1,3+1) # 6 nodes in the plane
node_coordinates = {1:(0,0),2:(2,0),3:(4,0)}
edges = [(1,2),(2,3)]
dim = 2

truss = Truss(nodes,edges,node_coordinates,dim,orthonormal=True)
show(truss.before, axes=False)
A = truss.get_incidence_matrix()
K = A.T * A; show(K); print;
K.eigenspaces_right() # Equation (6)
︡d2681331-0650-4a8b-ba2d-786f00014b08︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_kb48no.svg","show":true,"text":null,"uuid":"bc8f0b85-0b88-40f2-b911-e294a3e0a4a1"},"once":false}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; -1 &amp; 0 \\\\\n-1 &amp; 2 &amp; -1 \\\\\n0 &amp; -1 &amp; 1\n\\end{array}\\right)$</div>"}︡{"stdout":"\n"}︡{"stdout":"[\n(3, Vector space of degree 3 and dimension 1 over Rational Field\nUser basis matrix:\n[ 1 -2  1]),\n(1, Vector space of degree 3 and dimension 1 over Rational Field\nUser basis matrix:\n[ 1  0 -1]),\n(0, Vector space of degree 3 and dimension 1 over Rational Field\nUser basis matrix:\n[1 1 1])\n]\n"}︡{"done":true}
︠bd07dafa-29d1-42f3-898d-b0e309537001s︠
# for fun
G = SymmetricGroup(3)
show([g.matrix() for g in G])
Q = matrix(AA,3,3,[1,1,1, 1,0,-1, -1,2,-1]).T; show(Q)
L = matrix.diagonal([1/sqrt(3), 1/sqrt(2), 1/sqrt(6)]); show(L)
C = Q*L; show(C)
newG = [C.T*g.matrix()*C for g in G]
show(newG)
︡29269f54-e3ce-4ca5-be23-53c308bf494c︡{"html":"<div align='center'>[$\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; 1 &amp; 0 \\\\\n0 &amp; 0 &amp; 1\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n0 &amp; 0 &amp; 1 \\\\\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; 1 &amp; 0\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n0 &amp; 1 &amp; 0 \\\\\n0 &amp; 0 &amp; 1 \\\\\n1 &amp; 0 &amp; 0\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 1 \\\\\n0 &amp; 1 &amp; 0\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n0 &amp; 0 &amp; 1 \\\\\n0 &amp; 1 &amp; 0 \\\\\n1 &amp; 0 &amp; 0\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n0 &amp; 1 &amp; 0 \\\\\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 1\n\\end{array}\\right)$]</div>"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 1 &amp; -1 \\\\\n1 &amp; 0 &amp; 2 \\\\\n1 &amp; -1 &amp; -1\n\\end{array}\\right)$</div>"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n\\frac{1}{3} \\, \\sqrt{3} &amp; 0 &amp; 0 \\\\\n0 &amp; \\frac{1}{2} \\, \\sqrt{2} &amp; 0 \\\\\n0 &amp; 0 &amp; \\frac{1}{6} \\, \\sqrt{6}\n\\end{array}\\right)$</div>"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n\\frac{1}{3} \\, \\sqrt{3} &amp; \\frac{1}{2} \\, \\sqrt{2} &amp; -\\frac{1}{6} \\, \\sqrt{6} \\\\\n\\frac{1}{3} \\, \\sqrt{3} &amp; 0 &amp; \\frac{1}{3} \\, \\sqrt{6} \\\\\n\\frac{1}{3} \\, \\sqrt{3} &amp; -\\frac{1}{2} \\, \\sqrt{2} &amp; -\\frac{1}{6} \\, \\sqrt{6}\n\\end{array}\\right)$</div>"}︡{"html":"<div align='center'>[$\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; 1 &amp; 0 \\\\\n0 &amp; 0 &amp; 1\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; -\\frac{1}{2} &amp; -\\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} \\\\\n0 &amp; \\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} &amp; -\\frac{1}{2}\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; -\\frac{1}{2} &amp; \\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} \\\\\n0 &amp; -\\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} &amp; -\\frac{1}{2}\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; \\frac{1}{2} &amp; -\\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} \\\\\n0 &amp; -\\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} &amp; -\\frac{1}{2}\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; -1 &amp; 0 \\\\\n0 &amp; 0 &amp; 1\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rrr}\n1 &amp; 0 &amp; 0 \\\\\n0 &amp; \\frac{1}{2} &amp; \\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} \\\\\n0 &amp; \\frac{1}{4} \\, \\sqrt{6} \\sqrt{2} &amp; -\\frac{1}{2}\n\\end{array}\\right)$]</div>"}︡{"done":true}
︠fd1a2912-b024-4b43-855f-a73e709e0296s︠
# Equation (7)
load("tensegrity.sage")

nodes = [1,2,3,4,5,6]
h = 3
node_coordinates = {1:(1,0,0), 2:(-1/2, sqrt(3)/2, 0), 3:(-1/2, -sqrt(3)/2, 0), 4:(-sqrt(3)/2, -1/2, h), 5:(sqrt(3)/2, -1/2, h), 6:(0,1,h)}
edges = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,5),(2,6),(3,4),(3,6),(4,5),(4,6),(5,6)]
dim = 3

truss = Truss(nodes,edges,node_coordinates,dim)
truss.flexes
︡e69027fa-1afe-41e1-a436-96d4aff1337f︡{"stdout":"[(0, 1.577350269189626?, 0.2628917115316043?, -1.366025403784439?, -0.7886751345948129?, 0.2628917115316043?, 1.366025403784439?, -0.7886751345948129?, 0.2628917115316043?, -0.7886751345948129?, 1.366025403784439?, -0.2628917115316043?, -0.7886751345948129?, -1.366025403784439?, -0.2628917115316043?, 1.577350269189626?, 0, -0.2628917115316043?)]\n"}︡{"done":true}
︠be5916c2-0093-4dbd-b1dd-a7794dc0e4aas︠
# Equation (8)
Q1 = sum([truss.bar_constraints[e] for e in truss.edges])
1/2 * jacobian(jacobian(Q1,truss.X.list()), truss.X.list())
︡c2ba8c76-02ab-41e2-9043-af71d1284e0f︡{"stdout":"[ 4  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  0  0  0]\n[ 0  4  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  0  0]\n[ 0  0  4  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  0]\n[-1  0  0  4  0  0 -1  0  0  0  0  0 -1  0  0 -1  0  0]\n[ 0 -1  0  0  4  0  0 -1  0  0  0  0  0 -1  0  0 -1  0]\n[ 0  0 -1  0  0  4  0  0 -1  0  0  0  0  0 -1  0  0 -1]\n[-1  0  0 -1  0  0  4  0  0 -1  0  0  0  0  0 -1  0  0]\n[ 0 -1  0  0 -1  0  0  4  0  0 -1  0  0  0  0  0 -1  0]\n[ 0  0 -1  0  0 -1  0  0  4  0  0 -1  0  0  0  0  0 -1]\n[-1  0  0  0  0  0 -1  0  0  4  0  0 -1  0  0 -1  0  0]\n[ 0 -1  0  0  0  0  0 -1  0  0  4  0  0 -1  0  0 -1  0]\n[ 0  0 -1  0  0  0  0  0 -1  0  0  4  0  0 -1  0  0 -1]\n[-1  0  0 -1  0  0  0  0  0 -1  0  0  4  0  0 -1  0  0]\n[ 0 -1  0  0 -1  0  0  0  0  0 -1  0  0  4  0  0 -1  0]\n[ 0  0 -1  0  0 -1  0  0  0  0  0 -1  0  0  4  0  0 -1]\n[ 0  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  4  0  0]\n[ 0  0  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  4  0]\n[ 0  0  0  0  0 -1  0  0 -1  0  0 -1  0  0 -1  0  0  4]\n"}︡{"done":true}
︠6d871280-581f-4b8e-ae30-0bac5c35f615s︠
# Equation (8)
Qw = truss.potential; show(Qw)
show(1/2 * jacobian(jacobian(Qw,truss.X.list()), truss.X.list()))
︡6db64672-0fc0-41a0-8085-cb7abb788869︡{"html":"<div align='center'>$\\displaystyle {\\left({\\left(x_{11} - x_{21}\\right)}^{2} + {\\left(x_{12} - x_{22}\\right)}^{2} + {\\left(x_{13} - x_{23}\\right)}^{2} - 3\\right)} w_{12} + {\\left({\\left(x_{11} - x_{31}\\right)}^{2} + {\\left(x_{12} - x_{32}\\right)}^{2} + {\\left(x_{13} - x_{33}\\right)}^{2} - 3\\right)} w_{13} + \\frac{1}{4} \\, {\\left(4 \\, {\\left(x_{11} - x_{41}\\right)}^{2} + 4 \\, {\\left(x_{12} - x_{42}\\right)}^{2} + 4 \\, {\\left(x_{13} - x_{43}\\right)}^{2} - {\\left(\\sqrt{3} + 2\\right)}^{2} - 37\\right)} w_{14} + \\frac{1}{4} \\, {\\left(4 \\, {\\left(x_{11} - x_{51}\\right)}^{2} + 4 \\, {\\left(x_{12} - x_{52}\\right)}^{2} + 4 \\, {\\left(x_{13} - x_{53}\\right)}^{2} - {\\left(\\sqrt{3} - 2\\right)}^{2} - 37\\right)} w_{15} + {\\left({\\left(x_{21} - x_{31}\\right)}^{2} + {\\left(x_{22} - x_{32}\\right)}^{2} + {\\left(x_{23} - x_{33}\\right)}^{2} - 3\\right)} w_{23} + \\frac{1}{2} \\, {\\left(2 \\, {\\left(x_{21} - x_{51}\\right)}^{2} + 2 \\, {\\left(x_{22} - x_{52}\\right)}^{2} + 2 \\, {\\left(x_{23} - x_{53}\\right)}^{2} - {\\left(\\sqrt{3} + 1\\right)}^{2} - 18\\right)} w_{25} + \\frac{1}{4} \\, {\\left(4 \\, {\\left(x_{21} - x_{61}\\right)}^{2} + 4 \\, {\\left(x_{22} - x_{62}\\right)}^{2} + 4 \\, {\\left(x_{23} - x_{63}\\right)}^{2} - {\\left(\\sqrt{3} - 2\\right)}^{2} - 37\\right)} w_{26} + \\frac{1}{2} \\, {\\left(2 \\, {\\left(x_{31} - x_{41}\\right)}^{2} + 2 \\, {\\left(x_{32} - x_{42}\\right)}^{2} + 2 \\, {\\left(x_{33} - x_{43}\\right)}^{2} - {\\left(\\sqrt{3} - 1\\right)}^{2} - 18\\right)} w_{34} + \\frac{1}{4} \\, {\\left(4 \\, {\\left(x_{31} - x_{61}\\right)}^{2} + 4 \\, {\\left(x_{32} - x_{62}\\right)}^{2} + 4 \\, {\\left(x_{33} - x_{63}\\right)}^{2} - {\\left(\\sqrt{3} + 2\\right)}^{2} - 37\\right)} w_{36} + {\\left({\\left(x_{41} - x_{51}\\right)}^{2} + {\\left(x_{42} - x_{52}\\right)}^{2} + {\\left(x_{43} - x_{53}\\right)}^{2} - 3\\right)} w_{45} + {\\left({\\left(x_{41} - x_{61}\\right)}^{2} + {\\left(x_{42} - x_{62}\\right)}^{2} + {\\left(x_{43} - x_{63}\\right)}^{2} - 3\\right)} w_{46} + {\\left({\\left(x_{51} - x_{61}\\right)}^{2} + {\\left(x_{52} - x_{62}\\right)}^{2} + {\\left(x_{53} - x_{63}\\right)}^{2} - 3\\right)} w_{56}$</div>"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\nw_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 \\\\\n-w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} \\\\\n-w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} \\\\\n-w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} \\\\\n-w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} \\\\\n0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠14a4f851-bad0-46da-92dd-2f99c99ad855s︠
show(truss.get_stress_matrix())
︡83bbbffe-a979-4bd1-939c-884330ac020a︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\nw_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 \\\\\n-w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} \\\\\n-w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} \\\\\n-w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} \\\\\n-w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} \\\\\n0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠0d18221b-38a3-4752-b452-613273a27d13s︠
# Equation (11)
truss.leftnullspace
︡5abe69f7-1f2f-47b1-85ff-438be539726f︡{"stdout":"[(1, 1, -1.732050807568878?, 1.732050807568878?, 1, -1.732050807568878?, 1.732050807568878?, 1.732050807568878?, -1.732050807568878?, 1, 1, 1)]\n"}︡{"done":true}
︠56e34956-a75b-48d0-b608-19913d6bbe97s︠
v = truss.flexes[0] # pick the first and only flex vector dg v = 0
w = truss.leftnullspace[0] # pick the first and only self stress w^T dg = 0
show(v,w)

omegaw = truss.stress_matrices[0] # pick the first and only stress matrix computed from "w" above.
show(omegaw)

print v*omegaw*v # a very small semidefinite program
︡2a227e87-456c-434b-8327-d98fa5241cb4︡{"html":"<div align='center'>$\\displaystyle \\left(0,\\,1.577350269189626?,\\,0.2628917115316043?,\\,-1.366025403784439?,\\,-0.7886751345948129?,\\,0.2628917115316043?,\\,1.366025403784439?,\\,-0.7886751345948129?,\\,0.2628917115316043?,\\,-0.7886751345948129?,\\,1.366025403784439?,\\,-0.2628917115316043?,\\,-0.7886751345948129?,\\,-1.366025403784439?,\\,-0.2628917115316043?,\\,1.577350269189626?,\\,0,\\,-0.2628917115316043?\\right)$ $\\displaystyle \\left(1,\\,1,\\,-1.732050807568878?,\\,1.732050807568878?,\\,1,\\,-1.732050807568878?,\\,1.732050807568878?,\\,1.732050807568878?,\\,-1.732050807568878?,\\,1,\\,1,\\,1\\right)$</div>"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\n2.000000000000000? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 \\\\\n-1 &amp; 0 &amp; 0 &amp; 2.000000000000000? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 \\\\\n0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 \\\\\n0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1.732050807568878? \\\\\n-1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 \\\\\n0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 \\\\\n0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 1.732050807568878? \\\\\n1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 2.000000000000000? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 \\\\\n0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 \\\\\n0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 \\\\\n-1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2.000000000000000? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 \\\\\n0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 &amp; 0 \\\\\n0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 &amp; -1 \\\\\n0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -1.732050807568878? &amp; 0 &amp; 0 &amp; 1.732050807568878? &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; -1 &amp; 0 &amp; 0 &amp; 2\n\\end{array}\\right)$</div>"}︡{"stdout":"89.56921938165305?\n"}︡{"done":true}
︠806bfdb7-1377-4039-a21c-7cccc1cf8514s︠
wgl = truss.get_weighted_graph_laplacian(); show(wgl)
︡a577d962-5884-4918-a148-11307e45115f︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrr}\nw_{12} + w_{13} + w_{14} + w_{15} &amp; -w_{12} &amp; -w_{13} &amp; -w_{14} &amp; -w_{15} &amp; 0 \\\\\n-w_{12} &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; -w_{23} &amp; 0 &amp; -w_{25} &amp; -w_{26} \\\\\n-w_{13} &amp; -w_{23} &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; -w_{34} &amp; 0 &amp; -w_{36} \\\\\n-w_{14} &amp; 0 &amp; -w_{34} &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; -w_{45} &amp; -w_{46} \\\\\n-w_{15} &amp; -w_{25} &amp; 0 &amp; -w_{45} &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; -w_{56} \\\\\n0 &amp; -w_{26} &amp; -w_{36} &amp; -w_{46} &amp; -w_{56} &amp; w_{26} + w_{36} + w_{46} + w_{56}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠1538fa2c-3969-4b8f-bf41-4a26b4c26c4fs︠
wgl = truss.get_weighted_graph_laplacian()
show(wgl.tensor_product(matrix.identity(3))); print;
show(wgl.tensor_product(matrix.identity(3), subdivide=False))
︡ea79232a-75fb-4d00-ba04-8709881a1f7c︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr|rrr|rrr|rrr|rrr|rrr}\nw_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 \\\\\n\\hline\n -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} \\\\\n\\hline\n -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} \\\\\n\\hline\n -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} \\\\\n\\hline\n -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} \\\\\n\\hline\n 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56}\n\\end{array}\\right)$</div>"}︡{"stdout":"\n"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrrrrrrrrrr}\nw_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; w_{12} + w_{13} + w_{14} + w_{15} &amp; 0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; 0 \\\\\n-w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{12} &amp; 0 &amp; 0 &amp; w_{12} + w_{23} + w_{25} + w_{26} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; -w_{26} \\\\\n-w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{13} &amp; 0 &amp; 0 &amp; -w_{23} &amp; 0 &amp; 0 &amp; w_{13} + w_{23} + w_{34} + w_{36} &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{36} \\\\\n-w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{14} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{34} &amp; 0 &amp; 0 &amp; w_{14} + w_{34} + w_{45} + w_{46} &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; -w_{46} \\\\\n-w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; -w_{15} &amp; 0 &amp; 0 &amp; -w_{25} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{45} &amp; 0 &amp; 0 &amp; w_{15} + w_{25} + w_{45} + w_{56} &amp; 0 &amp; 0 &amp; -w_{56} \\\\\n0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56} &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -w_{26} &amp; 0 &amp; 0 &amp; -w_{36} &amp; 0 &amp; 0 &amp; -w_{46} &amp; 0 &amp; 0 &amp; -w_{56} &amp; 0 &amp; 0 &amp; w_{26} + w_{36} + w_{46} + w_{56}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠95b5f31c-14d9-464b-9d31-f0bb5b27074e︠
xvarz = [var('x%s%s'%(i,j)) for i in range(1,2+1) for j in range(1,5+1)]
adjacentminorz = [x11*x22 - x12*x21, x12*x23 - x13*x22, x13*x24 - x14*x23, x14*x25 - x15*x24]
R = PolynomialRing(QQ,xvarz)
I = R.ideal(adjacentminorz)
for P in I.associated_primes():
    print P; print;
︡33955931-2eee-4b6b-a6b3-a20921c03bca︡{"stdout":"Ideal (x23, x13, x15*x24 - x14*x25, x12*x21 - x11*x22) of Multivariate Polynomial Ring in x11, x12, x13, x14, x15, x21, x22, x23, x24, x25 over Rational Field"}︡{"stdout":"\n\nIdeal (x24, x14, x13*x22 - x12*x23, x13*x21 - x11*x23, x12*x21 - x11*x22) of Multivariate Polynomial Ring in x11, x12, x13, x14, x15, x21, x22, x23, x24, x25 over Rational Field\n\nIdeal (x24, x22, x14, x12) of Multivariate Polynomial Ring in x11, x12, x13, x14, x15, x21, x22, x23, x24, x25 over Rational Field\n\nIdeal (x22, x12, x15*x24 - x14*x25, x15*x23 - x13*x25, x14*x23 - x13*x24) of Multivariate Polynomial Ring in x11, x12, x13, x14, x15, x21, x22, x23, x24, x25 over Rational Field\n\nIdeal (x15*x24 - x14*x25, x15*x23 - x13*x25, x14*x23 - x13*x24, x15*x22 - x12*x25, x14*x22 - x12*x24, x13*x22 - x12*x23, x15*x21 - x11*x25, x14*x21 - x11*x24, x13*x21 - x11*x23, x12*x21 - x11*x22) of Multivariate Polynomial Ring in x11, x12, x13, x14, x15, x21, x22, x23, x24, x25 over Rational Field\n\n"}︡{"done":true}
︠9b557c37-d231-4332-88ac-01cd0801b9c1s︠
load("tensegrity.sage")

nodes = range(1,5+1) # 5 nodes in the plane
node_coordinates = {1:(0,0),2:(1,0),3:(2,-1),4:(2,1),5:(2,0)}
edges = [(1,2),(1,3),(1,4),(2,3),(2,4),(3,5),(4,5)]
dim = 2

truss = Truss(nodes,edges,node_coordinates,dim,orthonormal=True)

truss.plot_arrow_scale = 2.0
truss.plot_mechanisms()
show(truss.before, frame=False)
︡07902dcd-e887-4f50-83eb-e1c6b3fdd61f︡{"file":{"filename":"/home/user/.sage/temp/project-e3d8858f-633e-4199-98c4-2459b1781fb3/85594/tmp_05VsYw.svg","show":true,"text":null,"uuid":"00a7d709-3092-453b-9a38-0a8153d0727e"},"once":false}︡{"done":true}
︠e046fb4a-8e7b-491d-bd88-d109dce16423s︠
A = truss.rigidity_matrix; show(A)
︡e828772f-3983-4084-b383-af945321e47e︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrr}\nx_{11} - x_{21} &amp; x_{12} - x_{22} &amp; -x_{11} + x_{21} &amp; -x_{12} + x_{22} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{31} &amp; x_{12} - x_{32} &amp; 0 &amp; 0 &amp; -x_{11} + x_{31} &amp; -x_{12} + x_{32} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\nx_{11} - x_{41} &amp; x_{12} - x_{42} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -x_{11} + x_{41} &amp; -x_{12} + x_{42} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{31} &amp; x_{22} - x_{32} &amp; -x_{21} + x_{31} &amp; -x_{22} + x_{32} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{41} &amp; x_{22} - x_{42} &amp; 0 &amp; 0 &amp; -x_{21} + x_{41} &amp; -x_{22} + x_{42} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{31} - x_{51} &amp; x_{32} - x_{52} &amp; 0 &amp; 0 &amp; -x_{31} + x_{51} &amp; -x_{32} + x_{52} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{41} - x_{51} &amp; x_{42} - x_{52} &amp; -x_{41} + x_{51} &amp; -x_{42} + x_{52}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠f6fc803f-63dd-4051-86cf-ac495ac46935s︠
subz = {var('x%s%s'%(i,k)):QQ.random_element(50,50) for i in range(1,6+1) for k in range(1,2+1)}; subz
B = A.subs(subz); show(B)
rank(B) # generic rank
︡32cd1e9f-45c8-4de6-929a-1d0674c0123d︡{"stdout":"{x12: -31/48, x61: -13/23, x22: 15/19, x11: -45/46, x32: -37/24, x21: 47/44, x42: 46/47, x31: 25/24, x52: 7/5, x41: -13/17, x62: -35/8, x51: 1/27}\n"}︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrr}\n-\\frac{2071}{1012} &amp; -\\frac{1309}{912} &amp; \\frac{2071}{1012} &amp; \\frac{1309}{912} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n-\\frac{1115}{552} &amp; \\frac{43}{48} &amp; 0 &amp; 0 &amp; \\frac{1115}{552} &amp; -\\frac{43}{48} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n-\\frac{167}{782} &amp; -\\frac{3665}{2256} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{167}{782} &amp; \\frac{3665}{2256} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; \\frac{7}{264} &amp; \\frac{1063}{456} &amp; -\\frac{7}{264} &amp; -\\frac{1063}{456} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; \\frac{1371}{748} &amp; -\\frac{169}{893} &amp; 0 &amp; 0 &amp; -\\frac{1371}{748} &amp; \\frac{169}{893} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; \\frac{217}{216} &amp; -\\frac{353}{120} &amp; 0 &amp; 0 &amp; -\\frac{217}{216} &amp; \\frac{353}{120} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; -\\frac{368}{459} &amp; -\\frac{99}{235} &amp; \\frac{368}{459} &amp; \\frac{99}{235}\n\\end{array}\\right)$</div>"}︡{"stdout":"7\n"}︡{"done":true}
︠a0febff3-d74f-477b-b541-cb3071afd1e0s︠
subz = {var('x11'):0, var('x12'):0, var('x22'):0} # moving frame
B = A.subs(subz)
show(B)
︡4ce43634-4543-46e4-b237-058b460cb41a︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrrrrrrrrr}\n-x_{21} &amp; 0 &amp; x_{21} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n-x_{31} &amp; -x_{32} &amp; 0 &amp; 0 &amp; x_{31} &amp; x_{32} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n-x_{41} &amp; -x_{42} &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{41} &amp; x_{42} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{31} &amp; -x_{32} &amp; -x_{21} + x_{31} &amp; x_{32} &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; x_{21} - x_{41} &amp; -x_{42} &amp; 0 &amp; 0 &amp; -x_{21} + x_{41} &amp; x_{42} &amp; 0 &amp; 0 \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{31} - x_{51} &amp; x_{32} - x_{52} &amp; 0 &amp; 0 &amp; -x_{31} + x_{51} &amp; -x_{32} + x_{52} \\\\\n0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; 0 &amp; x_{41} - x_{51} &amp; x_{42} - x_{52} &amp; -x_{41} + x_{51} &amp; -x_{42} + x_{52}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠02dede80-c08d-4534-8b99-e1e6c58bd8b7s︠
minorz = B.minors(7) # generic rank 7
minorz = [minor for minor in minorz if minor!=0]
print len(minorz), binomial(10,7)
︡0caa6976-3662-402b-a90c-2fe8c04c34da︡{"stdout":"95 120\n"}︡{"done":true}
︠333db155-2b9b-4a7d-8ad7-8b60cff1b4b2s︠
subz = {var('x11'):0, var('x12'):0, var('x22'):0} # moving frame
eqns = [truss.bar_constraints[e].subs(subz) for e in truss.edges]
for eqn in eqns:
    print eqn
︡2c26bcf0-6d0d-4b7f-bd36-90450d99508d︡{"stdout":"x21^2 - 1\nx31^2 + x32^2 - 5\nx41^2 + x42^2 - 5\n(x21 - x31)^2 + x32^2 - 2\n(x21 - x41)^2 + x42^2 - 2\n(x31 - x51)^2 + (x32 - x52)^2 - 1\n(x41 - x51)^2 + (x42 - x52)^2 - 1\n"}︡{"done":true}
︠d29c2650-926a-4321-bc31-de8dc9a40c23s︠
subz = {var('x11'):0, var('x12'):0, var('x22'):0} # moving frame
eqns = [truss.bar_constraints[e].subs(subz) for e in truss.edges]
eqnz = eqns + minorz

xvarz = [var('x%s%s'%(i,k)) for i in range(1,6+1) for k in range(1,2+1) if i > k]
R = PolynomialRing(QQ,xvarz)
eqnz = [R(eqn) for eqn in eqnz]

I = R.ideal(eqnz)
AP = I.associated_primes()
︡abbb5b89-2fc1-436c-8821-eb99cf200ee5︡{"done":true}
︠c40b8391-1f9b-4d09-ade6-a9ee33c5c072s︠
for P in AP:
    print P.gens()
︡ad1d14db-c4dc-4747-a901-823d377e6481︡{"stdout":"[x52, x51 + 2, x42 - 1, x41 + 2, x32 + 1, x31 + 2, x21 + 1]\n[x52, x51 + 2, x42 + 1, x41 + 2, x32 - 1, x31 + 2, x21 + 1]\n[x42 + 1, x41 + 2, x32 + 1, x31 + 2, x21 + 1, x51^2 + x52^2 + 4*x51 + 2*x52 + 4]\n[x42 - 1, x41 + 2, x32 - 1, x31 + 2, x21 + 1, x51^2 + x52^2 + 4*x51 - 2*x52 + 4]\n[x52, x51 - 2, x42 - 1, x41 - 2, x32 + 1, x31 - 2, x21 - 1]\n[x52, x51 - 2, x42 + 1, x41 - 2, x32 - 1, x31 - 2, x21 - 1]\n[x42 + 1, x41 - 2, x32 + 1, x31 - 2, x21 - 1, x51^2 + x52^2 - 4*x51 + 2*x52 + 4]\n[x42 - 1, x41 - 2, x32 - 1, x31 - 2, x21 - 1, x51^2 + x52^2 - 4*x51 - 2*x52 + 4]\n"}︡{"done":true}
︠90f863f9-ca56-4ca3-a5d7-1c4c4c508181︠









