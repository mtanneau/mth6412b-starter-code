
import Base.show

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))

"""Renvoie un arbre de recouvrement minimal du graphe symétrique en entrée en
utilisant l'algorithme de Kruskal. La méthode renvoie un objet de type Graph.
"""
function main2(graph::AbstractGraph)
    # println(graph)
    parent_table = init_parent_table(graph)
    edges_copy = copy(edges(graph))
    # On trie les arêtes par poids croissant :
    edges_order = sortperm(weight.(edges_copy))
    edges_copy = edges_copy[edges_order]
    # println("début : ", name.(enfants(parent_table)), "\n")
    min_tree = Graph{Int64}("min_tree", nodes(graph), [])
    i = 0
    for edge in edges_copy
        # On récupère les extrémités de l'arête
        node1 = s_node(edge)
        node2 = d_node(edge)
        # Si les deux noeuds ont des racines différentes, on ajoute l'arête à
        # l'arbre de recouvrement minimum et on met à jour les composantes connexes.
        if root(parent_table, node1) != root(parent_table, node2)
            i += 1
            add_edge!(min_tree, edge)
            set_parent!(parent_table, node2, node1)
        end
    end
    println("Nombre d'arêtes : ", i)
    # show(min_tree)
    min_tree
end
