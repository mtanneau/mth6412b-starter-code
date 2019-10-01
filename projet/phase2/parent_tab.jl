

import Base.show

here = "C://Users//arthg//github//mth6412b-starter-code//projet//"
include(joinpath(here, "phase1//node.jl"))
include(joinpath(here, "phase1//edge.jl"))
include(joinpath(here, "phase1//graph.jl"))
include(joinpath(here, "phase1//main.jl"))


abstract type AbstractParent_table{T} end

mutable struct Parent_table{T} <: AbstractParent_table{T}
    nodes::Vector{Node{T}}
    parents::Vector{Node{T}}
end

nodes(Parent_table::AbstractParent_table) = Parent_table.nodes

parents(Parent_table::AbstractParent_table) = Parent_table.parents

function get_parent(Parent_table::AbstractParent_table, node::AbstractNode)
    nodes = nodes(Parent_table)
    for i in range(length(nodes))
        if nodes[i] == node
            return parents(Parent_table)[i]
        end
    end
end

function get_root(Parent_table::AbstractParent_table, node::AbstractNode)
    root = node
    while root != get_parent(root)
        root = get_parent(root)
    end
    return root
end

function build_Parent_table(graph::Graph)

end
