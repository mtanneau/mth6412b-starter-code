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
    graphe = construct_graph(file_name, "test")

    #on construit l'arbre de recouvrement minimal grâce à l'algo de Kruskal
    arbre = algoKruskal(graphe)

end

main()
