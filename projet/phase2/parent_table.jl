import Base.show

here = "C://Users//arthg//github//mth6412b-starter-code//projet//"
include(joinpath(here, "phase1//graph.jl"))

"""Un type abstrait dont dériveront d'autres types de ParentTable."""
abstract type AbstractParentTable{T} end

"""Structure de données associant à chaque noeud d'un graphe son noeud parent."""
mutable struct ParentTable{T} <: AbstractParentTable{T}
    nodes::Vector{Node{T}}
    parents::Vector{Node{T}}
end

ParentTable{T}() where T = ParentTable{T[]}

"""Renvoie la liste des noeuds."""
nodes(parent_table::AbstractParentTable) = parent_table.nodes

"""Renvoie la liste des parents de chaque noeud."""
parents(parent_table::AbstractParentTable) = parent_table.parents

"""Renvoie le parent d'un noeud donné selon la table parent_table."""
function parent(parent_table::AbstractParentTable, node::AbstractNode)
    nodes = deepcopy(parent_table.nodes)
    # nodes = nodes(parent_table) # la méthode nodes({ParentTable}) renvoie une erreur "ERROR: UndefVarError: nodes not defined"
    for i in range(1, stop = length(nodes))
        if nodes[i] == node
            return parents(parent_table)[i]
        end
    end
end

"""Attribue un noeud parent au noeud d'indice node_index."""
function set_parent!(parent_table::AbstractParentTable, node::AbstractNode, parent::AbstractNode)
    index = findfirst(x -> x==name(node), name.(nodes(parent_table)))
    parents(parent_table)[index] = parent
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
    parent_table = ParentTable{Int64}(nodes(graph), nodes(graph))
end
