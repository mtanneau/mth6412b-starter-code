import Base.show

include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"read_stsp.jl"))
include(joinpath(@__DIR__, "arbreRecouvrement.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "graphConstruction.jl"))

function main()
    file_name = "gr21.tsp"
    #on construit le graphe à partir d'une instance TSP
    graphe1 = construct_graph(file_name, "test")

    #on construit l'arbre de recouvrement minimal grâce à l'algo de Kruskal
    arbre1 = algoKruskal(graphe1)
    println(arbre1.link)

    #test 2
    graphe2 = construct_graph("bayg29.tsp", "test2")
    arbre2 = algoKruskal(graphe2)
    println(arbre2.link)

    #test3
    graphe3 = construct_graph("hk48.tsp", "test3")
    arbre3 = algoKruskal(graphe3)
    println(arbre3.link)

    #test4
    graphe4 = construct_graph("swiss42.tsp", "test4")
    arbre4 = algoKruskal(graphe4)
    println(arbre4.link)



end

main()
