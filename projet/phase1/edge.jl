import Base.show

"""Type abstrait dont d'autres types d'arcs dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arcs d'un graphe.

Exemple:

        arc = Edge("James", [π, exp(1)])
        arc = Edge("Kirk", "guitar")
        arc = Edge("Lars", 2)

"""
mutable struct Edge{T} <: AbstractEdge{T}
  name::String
  data::T
end

# on présume que tous les arcs dérivant d'AbstracEdge
# posséderont des champs `name` et `data`.

"""Renvoie le nom de l'arc."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les données contenues dans l'arc."""
data(edge::AbstractEdge) = edge.data

"""Affiche un arc."""
function show(edge::AbstractEdge)
  println("Edge ", name(edge), ", data: ", data(edge))
end
