import Base.show

"""Type abstrait dont d'autres types d'arêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arêtes d'un graphe.

Exemple:


"""
mutable struct Edge{T} <: AbstractEdge{T}
  name::String
  node1::AbstractNode
  node2::AbstractNode
  data::T
end

# on présume que tous les noeuds dérivant d'AbstractEdge
# posséderont des champs `name`,  'node1', 'node2' et `data`.

"""Renvoie le nom de l'arête."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les deux noeuds de l'arête."""
node1Edge(edge::AbstractEdge) = edge.node1;
node2Edge(edge::AbstractEdge) = edge.node2;

"""Renvoie les données contenues dans le noeud."""
data(edge::AbstractEdge) = edge.data

"""Affiche un noeud."""
function show(edge::AbstractEdge)
  print("Edge ", name(edge), ", data: ", data(edge), ", noeud 1 : ");
  show(edge.node1);
  print(" ,noeud 2 : ");
  show(edge.node2);
end
