class Truss:

    def __init__(self, nodes, edges, node_coordinates={}, dim=3, orthonormal=False):
        self.tolerance = 1e-30
        self.orthonormal = orthonormal
        self.ring_choice = AA # could try RR or RealField(400) or AA or QQbar or CC or ComplexField(400) or RDF or CDF or SR or QQ
        self.dim = dim
        self.nodes = nodes # should be [1,2,3,4,5] etc. not anything crazy like [0,1,2,3,4] or [1,2,5,19,12]
        self.edges = edges # should be [(1,2),(1,4),...] etc.
        self.X = matrix(len(self.nodes),dim,[var('x%s%s'%(node,j)) for node in nodes for j in range(1,dim+1)]) # one row for each node
        self.node_coordinates = node_coordinates # dictionary, the user needs to fill this with initial configuration "p" coordinates
        self.node_indices = self.create_node_indices() # key:val is "1:[0,1,2], 2:[3,4,5],..." giving the column indices of "A0" matrix
        self.edge_indices = self.create_edge_indices() # key:val is "(1,2):0, (1,3):1, ..." giving row indices in "A0" matrix
        self.p0 = self.vector_from_node_coordinates()
        self.edge_lengths_squared = {} # fill this dictionary during "create_bar_constraints"
        self.potential = 0
        self.bar_constraints = self.create_bar_constraints()
        self.rigidity_matrix = self.create_rigidity_matrix()
        self.rigidity_matrix_at_p = self.create_rigidity_matrix_at_p()
        self.leftnullspace = self.create_leftnullspace()
        self.right_nullspace = self.create_right_nullspace()
        self.stress_matrices = self.create_stress_matrices()
        self.fixed_nodes = []
        self.unfixed_node_indices = self.create_node_indices() # If fix node 2, update key:val is "1:[0,1,2], 2:[], 3:[3,4,5], ..." gives column indices
        self.A0created = False
        self.A0 = [] # need to wait and create this after "node_coordinates" has been filled
        self.A = [] # need to wait and create this once we "fix_nodes"
        self.before = self.plot() # this is just the framework alone. No mechanisms etc.
        self.mechanism_plot = Graphics()
        self.flexes_plot = Graphics()
        self.rigid_motions_plot = Graphics()
        self.number_mechanisms = 0
        #self.mechanisms = {} # the keys will be 0,1,2... depending on how many linearly independent mechanisms we have
        self.translations = self.create_translations()
        self.rotations = self.create_rotations()
        self.rigid_motions = self.translations + self.rotations
        self.flexes = self.create_flexes()
        self.mechanisms = self.rigid_motions + self.flexes
        self.translation_sections = self.create_translation_sections()
        self.rotation_sections = self.create_rotation_sections()
        self.flex_sections = self.create_flex_sections()
        self.plot_arrow_scale = 1/3 # default setting, feel free to change this.
        self.barycentric_node_coordinates = self.create_barycentric_node_coordinates()
        self.barycentric_rotations = self.create_barycentric_rotations() # ask for it if you need it.
        self.barycentric_flexes = self.create_barycentric_flexes() # ask for it if you need it.

    def create_node_indices(self):
        # OUTPUT: a dictionary
        # key:val is "1:[0,1,2], 2:[3,4,5],..." giving the column indices of "A0" matrix
        node_indices = {}
        for i,node in enumerate(self.nodes): # in case they do something silly like nodes=[1,5,6,19], this still works
            node_indices[node] = [self.dim*i + j for j in range(self.dim)]
        return node_indices

    def create_edge_indices(self):
        # OUTPUT: a dictionary
        # key:val is "(1,2):0, (1,3):1, ..." giving row indices in "A0" matrix
        edge_indices = {}
        for i,edge in enumerate(self.edges):
            edge_indices[edge] = i
        return edge_indices

    def vector_from_node_coordinates(self):
        # OUTPUT: a vector of length n*d, contains all coordinates of all nodes
        n = len(self.nodes)
        d = self.dim
        p0 = vector(self.ring_choice,[0]*(n*d))
        for node in self.nodes:
            indices = self.node_indices[node]
            for i,ind in enumerate(indices):
                p0[ind] = self.node_coordinates[node][i]
        return p0

    def create_bar_constraints(self):
        # OUTPUT: a dictionary
        # key:val example is "(1,2):symbolic expression giving the squared edge length equation"
        bar_constraints = {}
        potential = 0 # also creates the potential energy function Q_w
        for edge in self.edges:
            n1,n2 = edge
            final_minus_initial = vector(self.node_coordinates[n1]) - vector(self.node_coordinates[n2])
            squared_distance = final_minus_initial*final_minus_initial
            self.edge_lengths_squared[edge] = squared_distance
            constraint = SR(0) - squared_distance # initialize
            squared_length = SR(0) # initialize
            for i in range(dim):
                constraint += (self.X[n1-1,i] - self.X[n2-1,i])^2
                squared_length += (self.X[n1-1,i] - self.X[n2-1,i])^2
            bar_constraints[edge] = constraint
            #squared_length = sqrt(squared_length)
            squared_length -= squared_distance
            squared_length = var('w%s%s'%edge) * squared_length
            potential += squared_length
        self.potential = potential
        return bar_constraints

    def create_rigidity_matrix(self):
        # OUTPUT: 1/2 the Jacobian of the bar constraint equations. This is equivalent to Gilbert's incidence matrix A with denominators cleared.
        #         This matrix has entries which are symbolic expressions
        #         For the matrix with scalars, use self.rigidity_matrix_at_p
        eqns = []
        for edge in self.edges:
            eqn = self.bar_constraints[edge]
            eqns.append(eqn)
        J = jacobian(eqns, self.X.list()) # if we start fixing nodes, this becomes wrong
        J = 1/2*J
        return J
    
    def create_rigidity_matrix_at_p(self):
        subz = {var('x%s%s'%(i,k)):self.node_coordinates[i][k-1] for i in range(1,len(self.nodes)+1) for k in range(1,self.dim+1)}
        return (self.rigidity_matrix).subs(subz)

    def create_translations(self):
        # OUTPUT: a list of vectors. Each vector has length n*d in the right nullspace of A, a translation.
        translations = []
        for i in range(self.dim): # one translation vector for every dimension
            u = [0]*(self.dim*len(self.nodes)) # initialize
            for node in self.nodes: # each node gets translated
                indices = self.node_indices[node]
                one_index = indices[i]
                u[one_index] = 1 # only one "1" for each node
            u = vector(self.ring_choice,u)
            if self.orthonormal:
                u = u / u.norm()
            translations.append(u)
        return translations

    def create_rotations(self):
        # OUTPUT: a list of vectors. Each vector has length n*d, in right nullspace of A, a rotation.
        rotations = []
        for i in range(self.dim):
            for j in range(self.dim):
                if j>i: # one rotation for each upper triangular entry, skew-symm matrix(3,3,[0,1,0, -1,0,0, 0,0,0])
                    u = [0]*(len(self.nodes)*self.dim)
                    for node in self.nodes:
                        indices = self.node_indices[node]
                        # extract the jth coordinate, and put it in the ith coordinate
                        u[indices[i]] = self.node_coordinates[node][j]
                        # extract the ith coordinate, and put -it in the jth coordinate
                        u[indices[j]] = -(self.node_coordinates[node][i])
                    u = vector(self.ring_choice,u)
                    if self.orthonormal:
                        u = u / u.norm()
                    rotations.append(u)
        return rotations

    def create_flexes(self):
        # OUTPUT: a list of vectors. Each vector has length n*d, in the right nullspace of A, not a translation nor a rotation.
        if not self.A0created:
            self.create_A0() # also creates self.A
        flexes = []
        nullspace = (self.A).right_kernel_matrix()
        rigid_motions = matrix(self.ring_choice,self.rigid_motions)
        rigid_motions = rigid_motions.gram_schmidt()[0]
        for v in nullspace:
            v = vector(self.ring_choice,v)
            for b in rigid_motions:
                b = vector(self.ring_choice,b)
                v -= b.dot_product(v)*b / b.dot_product(b)
            for b in flexes:
                b = vector(self.ring_choice,b)
                v -= b.dot_product(v)*b / b.dot_product(b)
            if v.norm() > self.tolerance:
                flexes.append(v)
        return flexes

    def create_A0(self):
        if len(self.node_coordinates.keys()) != len(nodes):
            raise NameError('...you need to give node coordinates before we can compute the A0 matrix.')
        A0 = matrix.zero(len(edges),self.dim*len(nodes)) # matrix full of zeros, correct size
        A0 = A0.change_ring(self.ring_choice)
        for edge in self.edges:
            node0 = edge[0] # initial
            node1 = edge[1] # final
            finalminusinitial = vector(self.node_coordinates[node1]) - vector(self.node_coordinates[node0])
            finalminusinitial = finalminusinitial.normalized() # unit vector
            i = self.edge_indices[edge]
            # node0 initial
            js = self.node_indices[node0]
            for d,j in enumerate(js):
                A0[i,j] = list(finalminusinitial)[d]
            # node1 final
            js = self.node_indices[node1]
            for d,j in enumerate(js):
                A0[i,j] = list(-finalminusinitial)[d]
        self.A0 = A0
        self.A0created = True
        self.A = A0 # until we fix nodes, we might as well have this matrix available

    def gs(self,A,orthonormal=False):
        # my own version of gram schmidt
        # OUTPUT: a list of vectors, orthogonal or orthonormal basis for the row space of A
        # INPUT: a matrix "A" whose row space we will compute
        basis = [] # fill this list with orthogonal or orthonormal vectors
        rows = A.rows()
        for row in rows:
            row = vector(self.ring_choice,row)
            for b in basis:
                row = row - b.dot_product(row)*b / (b.dot_product(b))
            if row.norm() > self.tolerance:
                if orthonormal:
                    row = row / row.norm()
                if self.orthonormal:
                    row = row / row.norm()
                basis.append(row)
        return basis

    def create_translation_sections(self):
        # OUTPUT: a list of dictionaries, keys are nodes, vals are tuples, vectors attached at that node
        translation_sections = []
        for u in self.translations:
            section = {}
            for node in self.nodes:
                indices = self.node_indices[node]
                v = [u[i] for i in indices]
                section[node] = vector(self.ring_choice, v)
            translation_sections.append(section)
        return translation_sections

    def create_flex_sections(self):
        # OUTPUT: a list of dictionaries, keys are nodes, vals are tuples, vectors attached at that node
        flex_sections = []
        for u in self.flexes:
            section = {}
            for node in self.nodes:
                indices = self.node_indices[node]
                v = [u[i] for i in indices]
                section[node] = vector(self.ring_choice,v)
            flex_sections.append(section)
        return flex_sections

    def create_rotation_sections(self):
        # OUTPUT: a list of dictionaries, keys are nodes, vals are tuples, vectors attached at that node
        rotation_sections = []
        for u in self.rotations:
            section = {}
            for node in self.nodes:
                indices = self.node_indices[node]
                v = [u[i] for i in indices]
                section[node] = vector(self.ring_choice, v)
            rotation_sections.append(section)
        return rotation_sections
    
    def get_incidence_matrix(self):
        # OUTPUT: the m \times n incidence matrix of the graph structure alone
        n = len(self.nodes)
        m = len(self.edges)
        d = self.dim
        A = matrix.zero(m,n)
        for (i,j) in self.edges:
            row_ind = self.edge_indices[(i,j)]
            A[row_ind, i-1] = 1
            A[row_ind, j-1] = -1 # choice of 1 or -1 doesn't matter because we do A^T A
        return A
    
    def get_weighted_graph_laplacian(self):
        A = self.get_incidence_matrix()
        wvarz = [var('w%s%s'%e) for e in self.edges]
        C = matrix.diagonal(wvarz)
        wgl = A.T * C * A # weighted graph laplacian
        return wgl
    
    def get_stress_matrix(self):
        wgl = self.get_weighted_graph_laplacian()
        wglKRON = wgl.tensor_product(matrix.identity(self.dim), subdivide=False)
        # another option:
        #        1/2*jacobian(jacobian(self.potential, self.X.list()), self.X.list())
        return wglKRON
    
    def create_barycentric_node_coordinates(self):
        barycenter = vector([0]*self.dim)
        for node in self.nodes:
            vnode = vector(self.node_coordinates[node])
            barycenter += vnode
        barycenter = barycenter / len(self.nodes)
        barycentric_node_coordinates = {}
        for node in self.nodes:
            vnode = vector(self.node_coordinates[node])
            vnode = vnode - barycenter
            barycentric_node_coordinates[node] = tuple(vnode)
        return barycentric_node_coordinates

    def create_barycentric_rotations(self):
        # OUTPUT: a list of vectors. Each vector has length n*d
        #         infinitesimal rotations in the right nullspace of self.rigidity_matrix_at_p
        rotations = []
        for i in range(self.dim):
            for j in range(self.dim):
                if j>i: # one rotation for each upper triangular entry, skew-symm matrix(3,3,[0,1,0, -1,0,0, 0,0,0])
                    u = [0]*(len(self.nodes)*self.dim)
                    for node in self.nodes:
                        indices = self.node_indices[node]
                        # extract the jth coordinate, and put it in the ith coordinate
                        u[indices[i]] = self.barycentric_node_coordinates[node][j]
                        # extract the ith coordinate, and put -it in the jth coordinate
                        u[indices[j]] = -(self.barycentric_node_coordinates[node][i])
                    u = vector(self.ring_choice,u)
                    if self.orthonormal:
                        u = u / u.norm()
                    rotations.append(u)
        return rotations
    
    def create_right_nullspace(self):
        ans = (self.rigidity_matrix_at_p).change_ring(self.ring_choice).right_kernel_matrix()
        return ans
    
    def create_barycentric_flexes(self):
        # OUTPUT: a list of vectors. Each vector has length n*d,
        #         in the right nullspace of self.rigidity_matrix_at_p, not a translation nor a rotation.
        if not self.A0created:
            self.create_A0() # also creates self.A
        flexes = []
        nullspace = self.right_nullspace
        self.barycentric_rotations = self.create_barycentric_rotations()
        rigid_motions = matrix(self.ring_choice,self.barycentric_rotations + self.translations)
        rigid_motions = self.gs(rigid_motions) # my own version of gram schmidt
        for v in nullspace:
            v = vector(self.ring_choice,v)
            for b in rigid_motions:
                b = vector(self.ring_choice,b)
                v -= b.dot_product(v)*b / b.dot_product(b)
            for b in flexes:
                b = vector(self.ring_choice,b)
                v -= b.dot_product(v)*b / b.dot_product(b)
            if v.norm() > self.tolerance:
                flexes.append(v)
        self.barycentric_flexes = flexes
        return flexes
    
    def create_leftnullspace(self):
        leftnull = (((self.rigidity_matrix_at_p).T).change_ring(self.ring_choice).right_kernel_matrix()).rows()
        return leftnull
    
    def create_stress_matrices(self):
        omega = self.get_stress_matrix()
        stress_matrices = []
        for w in self.leftnullspace:
            subz = {}
            for e in self.edges:
                ind = self.edge_indices[e]
                subz[var('w%s%s'%e)] = w[ind] # in general we will need a linear combination, or -1 times this if 1-dimensional leftnull
            mat = omega.subs(subz)
            stress_matrices.append(mat)
        return stress_matrices
    
    
    
    
    
    
    
    
#### OLDER CODE BELOW
    
    def get_new_node_coordinates(self,pnew):
        # OUTPUT a dictionary of node coordinates like self.node_coordinates, but for "pnew"
        pnew_node_coordinates = {}
        for node in self.nodes:
            indices = self.node_indices[node]
            coords = []
            for ind in indices:
                coords.append( pnew[ind] )
            pnew_node_coordinates[node] = tuple(coords)
        return pnew_node_coordinates

    def satisfies_constraints(self,pnew,tolerance):
        # OUTPUT: True or False, depending on if pnew satifies the constraints
        # ASSUME: for now that we just have rigid bars, no cables or struts
        okay = True
        subz = self.create_subz(pnew)
        # now subz is created
        for edge in self.edges:
            eqn = self.bar_constraints[edge]
            eqn = eqn.subs(subz)
            ans = abs(eqn)
            #print ans
            if ans > tolerance:
                okay = False
        return okay
    
    def create_subz(self,pnew):
        subz = {}
        for node in self.nodes:
            indices = self.node_indices[node]
            for k,ind in enumerate(indices):
                subz[var('x%s%s'%(node,k+1))] = pnew[ind] # needed a k+1 here
        return subz

    # The user can "set_location" on each node separately, or import coordinates from some VarTruss whose locations have been fixed.
    def set_location(self, node, coords): # coords = (2,3,-0.3) of the correct dimension
        if len(coords) != self.dim:
            raise NameError('...your dimensions are off.')
        if node not in self.nodes:
            raise NameError('...that node does not exist')
        for i in range(self.dim):
            #self.A0 = self.A0( { var('x%s%s'%(node,i+1)) :coords[i]} ) # variables x11,x12,x13 and onwards
            #self.A = self.A( { var('x%s%s'%(node,i+1)) :coords[i]} )
            self.node_coordinates[node] = coords
    def import_coordinates(self, node_coord_dictionary):
        # "node_coord_dictionary" should literally be from VarTruss
        self.node_coordinates = node_coord_dictionary

    def fix_nodes(self, fixed_nodes):
        # "fixed_nodes" should be [1,3,4] a list of the nodes to be fixed
        # then we delete columns from "self.A0" to create "self.A"
        #     and also we give the "self.unfixed_node_indices" for indices of "self.A"
        # LATER: should allow fixing the node in each coordinate separately, and...
        #            what about allowing motion only in some fixed plane? and along some fixed line in space?
        for node in fixed_nodes:
            if node not in self.fixed_nodes:
                self.fixed_nodes.append(node)
        if not self.A0created:
            self.create_A0()
        index = 0 # keeps track of how many nodes are leftover, so we can label column indices in "unfixed_node_indices"
        cols = []
        for node in nodes:
            if node not in fixed_nodes:
                cols += self.node_indices[node]
                self.unfixed_node_indices[node] = [self.dim*index + j for j in range(self.dim)]
                index += 1
            else:
                self.unfixed_node_indices[node] = [] # this is a fixed node!
        self.A = self.A0.matrix_from_columns(cols)

    def compute_mechanisms(self, orthonormal=False):
        if not self.A0created:
            self.create_A0()
        # compute the right nullspace of "self.A"
        RK = self.A.right_kernel_matrix()
        mechanisms = RK.rows() # should be a list of tuples, each tuple is the entire row
        self.number_mechanisms = len(mechanisms)
        for i,mechanism in enumerate(mechanisms):
            self.mechanisms[i] = {}
            for node in nodes:
                if node in self.fixed_nodes:
                    self.mechanisms[i][node] = self.dim*[0]
                else:
                    indices = self.unfixed_node_indices[node]
                    force = [mechanism[j] for j in indices]
                    self.mechanisms[i][node] = force
        self.plot_mechanisms()

    def plot(self, before=True, origin=True):
        plt = Graphics()
        if self.dim==2:
            plt.set_aspect_ratio(1)
        if origin:
            plt += point(self.dim*[0],size=1)
        if before:
            edgecolor = 'darkblue'
            nodecolor = 'grey'
        else:
            edgecolor = 'darkblue'
            nodecolor = 'black'
        for edge in self.edges:
            coords0 = self.node_coordinates[edge[0]]
            coords1 = self.node_coordinates[edge[1]]
            plt += line([coords0,coords1], color=edgecolor, thickness=5, alpha=0.4)
        for node in self.nodes:
            coords = self.node_coordinates[node]
            if self.dim==2:
                #plt += point(coords, size=30, color=nodecolor)
                if node in self.fixed_nodes:
                    plt += text(str(node), coords, fontsize=20, color='red')
                else:
                    plt += text(str(node), coords, fontsize=20, color='black')
            if self.dim==3:
                #plt += point(coords, size=5, color=nodecolor)
                if node in self.fixed_nodes:
                    plt += text3d(str(node), coords, fontsize=20, color='red')
                else:
                    plt += text3d(str(node), coords, fontsize=20)
        return plt #self.before = plt
    
    def plot_rigid_motions(self):
        if not self.A0created:
            self.create_A0()
        self.plot()
        plt = self.before
        arrowwidth = 0.8
        if self.dim==2:
            plt.set_aspect_ratio(1)
            arrowwidth = 2
        total_colors = len(self.rigid_motions)
        color_count = 0
        for u in self.translation_sections: # add an arrow
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors+1)[color_count])
            color_count += 1
        for u in self.rotation_sections: # add an arrow
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors+1)[color_count])
            color_count += 1
        self.rigid_motions_plot = plt
    
    def plot_flexes(self):
        if not self.A0created:
            self.create_A0()
        self.plot()
        plt = self.before
        arrowwidth = 0.8
        if self.dim==2:
            plt.set_aspect_ratio(1)
            arrowwidth = 2
        total_colors = len(self.flexes)
        color_count = 0
        for u in self.flex_sections:
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors)[color_count])
            color_count += 1
        self.flexes_plot = plt

    def plot_mechanisms(self):
        if not self.A0created:
            self.create_A0()
        self.plot()
        plt = self.before
        arrowwidth = 0.8
        if self.dim==2:
            plt.set_aspect_ratio(1)
            arrowwidth = 2
        total_colors = len(self.flexes) + len(self.rigid_motions)
        color_count = 0
        for u in self.flex_sections:
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors)[color_count])
            color_count += 1
        for u in self.translation_sections: # add an arrow
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors+1)[color_count])
            color_count += 1
        for u in self.rotation_sections: # add an arrow
            for node in self.nodes:
                coords = self.node_coordinates[node]
                motion = vector(u[node])
                if motion.norm()!=0:
                    end_coords = list( vector(coords) + self.plot_arrow_scale*motion )
                    plt += arrow(coords, end_coords, width=arrowwidth, color=rainbow(total_colors+1)[color_count])
            color_count += 1
        self.mechanism_plot = plt






