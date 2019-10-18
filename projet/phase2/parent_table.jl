import Base.show

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))

abstract type AbstractParentTable{T} end

"""Structure de données associant à chaque noeud d'un graphe son noeud parent."""
mutable struct ParentTable{T} <: AbstractParentTable{T}
    enfants::Vector{Node{T}}
    parents::Vector{Node{T}}
end

"""Renvoie la liste des noeuds."""
enfants(parent_table::AbstractParentTable) = parent_table.enfants

"""Renvoie la liste des parents de chaque noeud."""
parents(parent_table::AbstractParentTable) = parent_table.parents

"""Renvoie le parent d'un noeud donné selon la table parent_table."""
function parent(parent_table::AbstractParentTable, node::AbstractNode)
    for (i, enfant) in enumerate(enfants(parent_table))
        if name(enfant) == name(node)
            parent = parents(parent_table)[i]
            return parent
        end
    end
    error("Aucun parent n'a été trouvé pour ce noeud.")
end

"""Attribue un noeud parent au noeud d'indice node_index."""
function set_parent!(parent_table::AbstractParentTable, node::AbstractNode, parent::AbstractNode)
    for (i, enfant) in enumerate(enfants(parent_table))
        if name(enfant) == name(node)
            parents(parent_table)[i] = parent
            return parent_table
        end
    end
    error("Ce noeud n'existe pas.")
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

"""Réunit deux composantes connexes en joignant leurs deux racines si elles sont distinctes."""
function unite!(parent_table::AbstractParentTable, node1::AbstractNode, node2::AbstractNode)
    root1 = root(parent_table, node1)
    root2 = root(parent_table, node2)
    parent(parent_table, root2) = root1
end

"""Construit un objet ParentTable aux dimensions d'un graphe donné.
Chaque noeud est son propre parent.
"""
function init_parent_table(graph::Graph{T}) where T
    graph_nodes_copy = copy(nodes(graph))
    parent_table = ParentTable{T}(nodes(graph), graph_nodes_copy)
end
