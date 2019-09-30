import Base.show

"""Type abstrait dont d'autres types d'arêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arêtes d'un graphe.

Exemple:

        arete = (Node1, Node2, 4)
        arete = (Node2, Node3, 1)

"""

mutable struct Edge{T} <: AbstractEdge{T}
  node1::AbstractNode{T}
  node2::AbstractNode{T}
  weight::Int
end

# on présume que tous les noeuds dérivant d'AbstractEdge
# posséderont des champs 'node1', 'node2' et 'data'.

"""Renvoie les deux noeuds de l'arête."""
node1Edge(edge::AbstractEdge) = edge.node1
node2Edge(edge::AbstractEdge) = edge.node2

"""Renvoie les données contenues dans l'arête."""
weight(edge::AbstractEdge) = edge.weight

"""Affiche une arête."""
function show(edge::AbstractEdge)
  println("Edge from ", name(node1Edge(edge)), " to ", name(node2Edge(edge)), ", weighting ", weightOnEdge(edge), ".")
end
