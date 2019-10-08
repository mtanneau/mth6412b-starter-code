
import Base.show

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))

"""Renvoie un arbre de recouvrement minimal du graphe symétrique en entrée en
utilisant l'algorithme de Kruskal. La méthode renvoie un objet de type Graph.
"""
function main2(graph::AbstractGraph)
    parent_table = init_parent_table(graph)
    edges_copy = copy(edges(graph))
    # On trie les arêtes par poids croissant.
    edges_order = sortperm(weight.(edges_copy))
    edges_copy = edges_copy[edges_order]
    min_tree = Graph{Int64}("min_tree", [], [])
    # On parcourt les arêtes du graphe.
    for edge in edges_copy
        # On récupère les extrémités de l'arête.
        node1 = s_node(edge)
        node2 = d_node(edge)
        # Si les deux noeuds ont des racines différentes, on ajoute
        # l'arête à l'arbre de recouvrement minimum.
        if root(parent_table, node1) != root(parent_table, node2)
            add_edge!(min_tree, edge)
            # On veut ensuite savoir quel(s) noeud(s) ajouter à l'arbre.
            # Si une des extrémités de l'arête appartient déjà à l'arbre, on ne l'ajoute pas.
            node1_added = true
            node2_added = true
            parent_node = node1
            child_node = node2
            for node in nodes(min_tree)
                if name(node) == name(node1)
                    node1_added = false
                end
                if name(node) == name(node2)
                    node2_added = false
                end
            end
            # On ajoute le(s) noeud(s) et on définit lequel sera parent de l'autre.
            if node1_added
                add_node!(min_tree, node1)
                parent_node = node2
                child_node = node1
            end
            if node2_added
                add_node!(min_tree, node2)
                parent_node = node1
                child_node = node2
            end
            # On met finalement à jour la table des parents.
            set_parent!(parent_table, child_node, parent_node)
        end
    end
    min_tree
end
