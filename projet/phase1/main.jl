import Base.show
include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"read_stsp.jl"))

function main()
    noeud1 = Node("James", [π, exp(1)])
    noeud2 = Node("Kirk", "guitar")
    noeud3 = Node("Lars", 2)

    edge1 = Edge("1", noeud1, noeud2, 3);
    edge2 = Edge("2", noeud2, noeud3, 4);
    read_stsp(joinpath(@__DIR__,"..","..","instances","stsp","bayg29.tsp"))


end

main();
