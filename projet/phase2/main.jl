import Base.show

include(joinpath(@__DIR__,"read_stsp.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "graphConstruction.jl"))

function main(graphe::AbstractGraph)

    arbre = algoKruskal(graphe)

end
