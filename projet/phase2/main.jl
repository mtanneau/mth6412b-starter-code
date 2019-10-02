import Base.show

include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"read_stsp.jl"))
include(joinpath(@__DIR__, "arbreRecouvrement.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "graphConstruction.jl"))

function main()

    # Test sur l'arbre vu en cours
    # Construction des noeuds
    node1 = Node(1, "a")
    node2 = Node(2, "b")
    node3 = Node(3, "C")
    node4 = Node(4, "d")
    node5 = Node(5, "e")
    node6 = Node(6, "f")
    node7 = Node(7, "g")
    node8 = Node(8, "h")
    node9 = Node(9, "i")
    nodes = [node1, node2, node3, node4, node5, node6, node7, node8, node9]

    # Construction des arêtes
    edge1 = Edge(node1, node2, 4)
    edge2 = Edge(node1, node8, 8)
    edge3 = Edge(node2, node3, 8)
    edge4 = Edge(node2, node8, 11)
    edge5 = Edge(node3, node9, 2)
    edge6 = Edge(node3, node6, 4)
    edge7 = Edge(node3, node4, 7)
    edge8 = Edge(node4, node5, 9)
    edge9 = Edge(node4, node6, 14)
    edge10 = Edge(node5, node6, 10)
    edge11 = Edge(node7, node9, 6)
    edge12 = Edge(node7, node8, 1)
    edge13 = Edge(node8, node9, 7)
    edge14 = Edge(node6, node7, 2)
    edges = [edge1, edge2, edge3, edge4, edge5, edge6, edge7, edge8, edge9, edge10, edge11, edge12, edge13, edge14]

    grapheCours = Graph("cours", nodes, edges)
    arbreCours = algoKruskal(grapheCours)
    # vérification sur les arêtes de l'arbre de recouvrement minimal
    show(arbreCours.edges)


    file_name = "hk48.tsp"
    # on construit le graphe à partir d'une instance TSP
    graphe1 = construct_graph(file_name, "test")

    # on construit l'arbre de recouvrement minimal grâce à l'algo de Kruskal
    arbre1 = algoKruskal(graphe1)
    # show(arbre1.edges)

    # test 2
    graphe2 = construct_graph("bayg29.tsp", "test2")
    arbre2 = algoKruskal(graphe2)
    # show(arbre2.edges)

    # test3
    graphe3 = construct_graph("swiss42.tsp", "test4")
    arbre3 = algoKruskal(graphe3)
    # show(arbre3.edges)
end

main()
