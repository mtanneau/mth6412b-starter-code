import Base.show

"""Type abstrait dont d'autres types d'arêtes dériveront."""
abstract type AbstractEdge{T} end

mutable struct Edge{T} <: AbstractEdge{T}
  node1::AbstractNode
  node2::AbstractNode
  weight::T
end

# on présume que tous les noeuds dérivant d'AbstractEdge
# posséderont des champs `name`,  'node1', 'node2' et `data`.

"""Renvoie les deux noeuds de l'arête."""
node1Edge(edge::AbstractEdge) = edge.node1;
node2Edge(edge::AbstractEdge) = edge.node2;

"""Renvoie les données contenues dans l'arête."""
weightOnEdge(edge::AbstractEdge) = edge.weight

"""Affiche une arête."""
function show(edge::AbstractEdge)
  messageToPrint = string("Edge from ", name(node1Edge(edge)), " to ", name(node2Edge(edge)), ", weighting ", weightOnEdge(edge), ".")
  println(messageToPrint)
end
