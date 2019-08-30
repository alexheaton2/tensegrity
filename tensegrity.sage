class Truss:
    
    def __init__(self, dim=3):
        self.dim = dim
        self.nodes = []
        self.bars = []
        self.forces = []
        self.fixed_nodes = []
        self.fixed_columns = []
        self.C = []
        self.A0 = []
        self.A = []
        self.f0 = []
        self.f = []
        self.b0 = []
        self.b = []
        self.K = []
        self.before = Graphics()
        self.after = Graphics()

    # Add bar by specifying two end points and the material constant
    def add_bar(self, pt1, pt2, mat_const):
        if pt1 not in self.nodes:
            self.nodes.append(pt1)
        if pt2 not in self.nodes:
            self.nodes.append(pt2)
        bar = {'nd1':self.nodes.index(pt1), 'nd2':self.nodes.index(pt2), 'mat_const':mat_const}
        self.bars.append(bar)

    # Add force by specifying pt at which force acts and tuple force
    def add_force(self, pt, force):
        if pt in self.nodes:
            self.forces.append({'nd':self.nodes.index(pt), 'force':force})

    # Fix an end point of a bar by specifying point pt and tuple of dimensions to fix - fixed_dims
    def fix_node(self, pt, fixed_dims):
        if len(fixed_dims) != self.dim:
            raise NameError('fixed_dims tuple length not equal to dimension of space')
        if pt in self.nodes:
            self.fixed_nodes.append({'nd':self.nodes.index(pt), 'fixed_dims':fixed_dims})

    # Creates a graphics object for the Truss. Red nodes fixed in all directions. Yellow fixed in one direction. White free.
    def graphic(self, before=True, show=False):
        plt = Graphics()
        # different colors before and after
        if before==True:
            color = 'lightblue'
        else:
            color = 'darkblue'
        # ensure the origin is in the picture, looks better usually
        plt += point(self.dim*[0], size=1)
        # plot the fixed nodes in RED
        for node in self.fixed_nodes:
            plt += point(self.nodes[node['nd']], color='red', size=25)
        # plot the bars in 'color'
        for bar in self.bars:
            nd1, nd2 = self.nodes[bar['nd1']], self.nodes[bar['nd2']]
            plt += line([nd1, nd2], color=color)
        # plot the force vector and its point BLUE
        if before==True:
            for force in self.forces:
                 nd, frc = self.nodes[force['nd']], force['force']
                 end = vector(nd)+ vector(frc)
                 plt += arrow(nd, end)
                 plt += point(nd, color='blue', size=25)
        return plt
    
    # create all the matrices and vectors, but DO NOT ATTEMPT SOLVING
    def compute(self, show=False):
        self.A0 = self.create_A0()
        self.f0 = self.create_f0()
        self.fixed_columns = self.fixed_matrix_columns()
        self.A = (self.A0).matrix_from_columns([i for i in range(self.A0.ncols()) if i not in self.fixed_columns])
        self.f = vector(RR, [self.f0[i] for i in range(len(self.f0)) if i not in self.fixed_columns])
        self.C = self.create_C()
        self.K = self.A.transpose()*self.C*self.A
        self.before = t.graphic()
        if show:
            print 'A0 is rank {} with {} rows and {} cols.'.format(self.A0.rank(), self.A0.nrows(), self.A0.ncols())
            print 'A is rank {} with {} rows and {} cols.'.format(self.A.rank(), self.A.nrows(), self.A.ncols())
            print 'K is rank {} with {} rows and {} cols.'.format(self.K.rank(), self.K.nrows(), self.K.ncols())
        
    # Given list of node displacement vectors "node_displacements", updates Truss node positions.
    def displace_nodes(self, node_displacements):
        n = len(self.nodes)
        for i in range(n):
            nd = self.nodes[i]
            nd = tuple(vector(nd) + node_displacements[i])
            self.nodes[i] = nd
    
    # HELPER FUNCTIONS for truss.compute()
    def create_A0(self):
        N = self.dim*len(self.nodes)
        rows = []
        for bar in self.bars:

            # Initialize bar variables
            nd1_index, nd2_index = bar['nd1'], bar['nd2']
            nd1, nd2 = vector(self.nodes[nd1_index]), vector(self.nodes[nd2_index])
            row = vector(RR, {N-1:0})

            # Calculate unit vector pointing from node 1 to node 2.
            X = (nd2 - nd1)/(nd2-nd1).norm()

            for i in range(self.dim):
                row[self.dim*nd1_index + i] = X[i]
                row[self.dim*nd2_index + i] = -X[i]

            rows.append(row)
        return matrix(rows)
    
    def fixed_matrix_columns(self):
        indexes = []
        for node in self.fixed_nodes:
            nd_index = node['nd']
            fixed_dims = node['fixed_dims']
            for i in range(self.dim):
                if fixed_dims[i]:
                    indexes.append(self.dim*nd_index + i)
        return indexes

    def create_C(self):
        m = len(self.bars)
        rows = []
        for i in range(m):
            row = vector(RR, {m-1:0})
            row[i] = self.bars[i]['mat_const']
            rows.append(row)
        return matrix(rows)

    def create_f0(self):
        N = self.dim*len(self.nodes)
        f0 = vector(RR, {N-1:0})
        for force in self.forces:
            nd_index = force['nd']
            frc = force['force']
            for i in range(self.dim):
                f0[self.dim*nd_index+i] = frc[i]
        return f0

    def create_x0(self, x, fixed_columns):
        N = self.dim*len(self.nodes)
        x0 = vector(RR, {N-1:0})
        j = 0
        for i in range(N):
            if i not in fixed_columns:
                x0[i] = x[j]
                j += 1
        return x0

    def solve_truss(self):
        x = self.K.solve_right(self.f)
        y = self.C*self.A*x
        return self.create_x0(x, self.fixed_columns), y
    
    def solve(self):
        x0, y = self.solve_truss()
        self.displace_nodes(self.create_displ_vectors(x0))
        self.after = self.graphic(before=False)

    def create_displ_vectors(self, x0):
        n = len(self.nodes)
        nds_disp = []
        for nd_index in range(n):
            node_displ = vector(RR, {self.dim-1:0})
            for i in range(self.dim):
                node_displ[i] = x0[self.dim*nd_index + i]
            nds_disp.append(node_displ)
        return nds_disp

class VarTruss:

    def __init__(self, nodes, edges, dim=3):
        self.dim = dim
        self.nodes = nodes # should be [0,1,2,...] starting from 0
        self.edges = edges # should be [(1,3),(0,4),...] tuples of endpoints
        self.X = matrix(len(nodes),dim,[var('x%s%s'%(i,j)) for i in range(1,len(nodes)+1) for j in range(1,dim+1)])
        self.A0 = self.create_A0()
        self.A = []

    def create_A0(self):
        rows = []
        for edge in self.edges:
            row = []
            for i in self.nodes:
                if i == edge[0]:
                    row += list(self.X[edge[0]-1] - self.X[edge[1]-1]) # minus 1 because indices start 0,1,2... but we use 1,2,3...
                elif i == edge[1]:
                    row += list(self.X[edge[1]-1] - self.X[edge[0]-1]) # minus 1 because indices start 0,1,2... but we use 1,2,3...
                else:
                    row += self.dim*[0]
            rows.append(row)
        return matrix(rows)

    def set_location(self, spot, loc): # loc = (2,3,-0.3) of the correct dimension
        if len(loc) != self.dim:
            raise NameError('...your dimensions are off.')
        for i in range(self.dim):
            self.A0 = self.A0( {self.X[spot-1,i]:loc[i]} ) # indices off by 1 since 0,1,2,... not 1,2,3,...

    def fix_nodes(self, fixed_nodes): # fixed_nodes should be a list like [0,2,4] which would leave nodes 1 and 3 free
        cols = []
        for node in self.nodes:
            if node not in fixed_nodes:
                cols += [3*(node-1), 3*(node-1) + 1, 3*(node-1) + 2]
        self.A = self.A0.matrix_from_columns(cols)
        
def left_nullspace_ideal(M):
    eqns = []
    if M.nrows() > M.ncols():
        print 'This matrix has a left nullspace since it has more rows than columns. But we will find maximal minors anyway, because perhaps you see zero rows that you are ignoring for some reason.'
    k = min(M.nrows(), M.ncols())
    eqns = M.minors(k)
    return eqns

def associated_primes(M, xvars, minimal=True):
    R = PolynomialRing(QQ, xvars)
    eqns = left_nullspace_ideal(M)
    eqns = [R(f) for f in eqns if f!=0]
    print 'There are %s nonzero equations to start with.'%(len(eqns))
    print ''
    I = R.ideal(eqns)
    if minimal:
        MAP = I.minimal_associated_primes()
        for p in MAP:
            print p.ngens(), p.gens()
            print ''
        return MAP
    else:
        AP = I.associated_primes()
        for p in AP:
            print p.ngens(), p.gens()
        return AP