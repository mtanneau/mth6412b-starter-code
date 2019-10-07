import Base.show

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))

"""Un type abstrait dont dériveront d'autres types de ParentTable."""
abstract type AbstractParentTable{T} end

"""Structure de données associant à chaque noeud d'un graphe son noeud parent."""
mutable struct ParentTable{T} <: AbstractParentTable{T}
    enfants::Vector{Node{T}}
    parents::Vector{Node{T}}
end

ParentTable{T}() where T = ParentTable{T[]}

"""Renvoie la liste des noeuds."""
enfants(parent_table::AbstractParentTable) = parent_table.enfants

"""Renvoie la liste des parents de chaque noeud."""
parents(parent_table::AbstractParentTable) = parent_table.parents

"""Renvoie le parent d'un noeud donné selon la table parent_table."""
function parent(parent_table::AbstractParentTable, node::AbstractNode)
    parent = node
    for (i, enfant) in enumerate(enfants(parent_table))
        if name(enfant) == name(node)
            parent = parents(parent_table)[i]
            return parent
        end
    end
    parent
end

"""Attribue un noeud parent au noeud d'indice node_index."""
function set_parent!(parent_table::AbstractParentTable, node::AbstractNode, parent::AbstractNode)
    for (i, enfant) in enumerate(enfants(parent_table))
        if name(enfant) == name(node)
            parents(parent_table)[i] = parent
            return parent_table
        end
    end
    parent_table
end

"""Renvoie la racine d'un noeud donné selon la table parent_table, c'est-à-dire
le plus ancien parent de ce noeud.
"""
function root(parent_table::AbstractParentTable, node::AbstractNode)
    root = node
    while root != parent(parent_table, root)
        root = parent(parent_table, root)
    end
    root
end

"""Construit un objet ParentTable aux dimensions d'un graphe donné.
Chaque noeud est son propre parent.
"""
function init_parent_table(graph::Graph)
    graph_nodes_copy = copy(nodes(graph))
    parent_table = ParentTable{Int64}(nodes(graph), graph_nodes_copy)
end
