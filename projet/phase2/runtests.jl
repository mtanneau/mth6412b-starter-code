import Base.show
using Test
include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"read_stsp.jl"))
include(joinpath(@__DIR__, "arbreRecouvrement.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "graphConstruction.jl"))

# test node.jl
node1 = Node(1,2)
@test name(node1) == 1
@test data(node1) == 2
node2 = Node(2,1)
node3 = Node(3,1)

# test edge.jl
edge1 = Edge(node1, node2, 4)
@test getNode1(edge1) == node1
@test getNode2(edge1) == node2
@test weight(edge1) == 4
edge2 = Edge(node2, node3, 2)

# test graph.jl
graphe = Graph("test", [node1, node2],[edge1] )
@test name(graphe) == "test"
@test nb_nodes(graphe) == 2
@test nb_edges(graphe) == 1
@test typeNode(graphe) == Int64
@test nodes(graphe) == [node1, node2]
@test edges(graphe) == [edge1]
add_node!(graphe,  node3)
@test nodes(graphe) == [node1, node2, node3]
add_edge!(graphe, edge2)
@test edges(graphe) == [edge1, edge2]


# test recouvrement.jl
foret = initArbre(graphe)
@test getName(foret) == name(graphe)
@test getParents(foret) == Dict(node3 => node3, node1 => node1, node2 => node2)
@test getEdges(foret) == Edge{Int64}[]
@test getParent(foret, node1) == node1
@test getRacine(foret, node1) == node1
changeParent!(foret, node1, node2)
@test getParent(foret, node1) == node2
changeParent!(foret, node2, node3)
@test getRacine(foret, node1) == node3

# test algoKruskal
edge3 = Edge(node1, node3, 1)
add_edge!(graphe, edge3)
# test du bon fonctionnement de l'algo
arbre = algoKruskal(graphe)
@test getRacine(arbre, node3) == node3
@test getRacine(arbre, node2) == node3
@test getRacine(arbre, node1) == node3
@test getEdges(arbre) == [edge3, edge2]
