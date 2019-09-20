import Base.show
# ajout d'une ligne
"""Type abstrait dont d'autres types d'arete' dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les noeuds d'un graphe.

Exemple:

        arete1 = Edge("James", [node1, node2], 12)
        arete2 = Edge("Kirk", [node1, node3], 24)
        arete3 = Edge("Lars", [node2, node3], 3)

"""
mutable struct Edge{T} <: AbstractEdge{T}
  name::String
  data::Vector{Node{T}}
  weigth::Int
end


 #on présume que tous les noeuds dérivant d'AbstractNode
 # posséderont des champs `name` et `data`.

"""Renvoie le nom de l'arête."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les sommets reliés par l'arête."""
data(edge::AbstractEdge) = edge.data


"""Renvoie le poids de l'arête."""
weigth(edge::AbstractEdge) = edge.weigth

"""Affiche une arête."""
function show(edge::AbstractEdge)
  println("Edge", name(edge), ", data: ", data(edge)[1].name, " et ",data(edge)[2].name , ", weigth", weigth(edge))
end
