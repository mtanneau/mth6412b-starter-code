import Base.show

include(joinpath(@__DIR__, "..", "phase1", "read_stsp.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "..", "phase1", "graphConstruction.jl"))

function main(graphe::AbstractGraph)

    arbre = algoKruskal(graphe)

end
