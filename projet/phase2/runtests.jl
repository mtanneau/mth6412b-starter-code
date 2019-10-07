using Test

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))

using Test

"""Construction des graphes"""

# "Graphe à 3 noeuds"
node1 = Node{Int64}("1", 1)
node2 = Node{Int64}("2", 2)
node3 = Node{Int64}("3", 3)
edge1 = Edge{Int64}("", node1, node2, 1)
edge2 = Edge{Int64}("", node1, node3, 2)
edge3 = Edge{Int64}("", node2, node3, 3)
graph_3n = Graph{Int64}("graph_3n",[],[])
add_edge!(graph_3n, edge1)
add_edge!(graph_3n, edge2)
add_edge!(graph_3n, edge3)
add_node!(graph_3n, node1)
add_node!(graph_3n, node2)
add_node!(graph_3n, node3)
parent_table_3n = init_parent_table(graph_3n)


# "Graphe à 4 noeuds"
graph_4n = Graph{Int64}("graph_4n", [Node{Int64}("1", 1), Node{Int64}("2", 2), Node{Int64}("3", 3), Node{Int64}("4", 4)],
[Edge{Int64}("1", Node{Int64}("1", 1), Node{Int64}("2", 2), 6),
Edge{Int64}("2", Node{Int64}("1", 1), Node{Int64}("3", 3), 5),
Edge{Int64}("3", Node{Int64}("1", 1), Node{Int64}("4", 4), 4),
Edge{Int64}("4", Node{Int64}("2", 2), Node{Int64}("3", 3), 3),
Edge{Int64}("5", Node{Int64}("2", 2), Node{Int64}("4", 4), 2),
Edge{Int64}("6", Node{Int64}("3", 3), Node{Int64}("4", 4), 1)])
parent_table_4n = init_parent_table(graph_4n)


# "Graphe à 6 noeuds"
graph_6n = Graph{Int64}("graph_6n", [Node{Int64}("1", 1), Node{Int64}("2", 2), Node{Int64}("3", 3), Node{Int64}("4", 4), Node{Int64}("5", 5), Node{Int64}("6", 6)],
[Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("2", 2), 10),
Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("3", 3), 9),
Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("4", 4), 8),
Edge{Int64}("", Node{Int64}("2", 2), Node{Int64}("3", 3), 7),
Edge{Int64}("", Node{Int64}("3", 3), Node{Int64}("4", 4), 6),
Edge{Int64}("", Node{Int64}("4", 4), Node{Int64}("5", 5), 5),
Edge{Int64}("", Node{Int64}("2", 2), Node{Int64}("5", 5), 4),
Edge{Int64}("", Node{Int64}("3", 3), Node{Int64}("6", 6), 3)])
parent_table_6n = init_parent_table(graph_6n)


# "Graphe à 10 noeuds"
graph_10n = Graph{Int64}("graph10n", [], [])
for i = 1 : 10
    add_node!(graph_10n, Node{Int64}(string(i), i))
end
for e = 1 : 9
    add_edge!(graph_10n, Edge{Int64}("", nodes(graph_10n)[e], nodes(graph_10n)[e + 1], 100 - e))
end
parent_table_10n = init_parent_table(graph_10n)


# "Graphe à n noeuds"
graph_Nn = main1("C:/Users/arthg/github/mth6412b-starter-code/instances/stsp/bayg29.tsp")
parent_table_Nn = init_parent_table(graph_Nn)


"""Fonctions"""

function is_parent_ok(parent_table::AbstractParentTable)
    parent_ok = true
    for i = 1 : length(parents(parent_table))
        if parents(parent_table)[i] != parent(parent_table, enfants(parent_table)[i])
            parent_ok = false
        end
    end
    parent_ok
end

function is_root_unique(graph::AbstractGraph)
    root_unique = true
    for i = 1 : length(nodes(graph_3n))
        for j = 1 : i
            if root(nodes(graph_3n)[i]) != root(nodes(graph_3n)[j])
                root_unique = false
            end
        end
    end
    root_unique
end


"""Tests"""

# "Au départ, chaque noeud est son propre parent"
@test enfants(parent_table_3n) == parents(parent_table_3n)
@test enfants(parent_table_4n) == parents(parent_table_4n)
@test enfants(parent_table_6n) == parents(parent_table_6n)
@test enfants(parent_table_10n) == parents(parent_table_10n)
@test enfants(parent_table_Nn) == parents(parent_table_Nn)

# "Test de la méthode parent()"
@test is_parent_ok(parent_table_3n)
@test is_parent_ok(parent_table_4n)
@test is_parent_ok(parent_table_6n)
@test is_parent_ok(parent_table_10n)
@test is_parent_ok(parent_table_Nn)

# "Test de 'parent()', 'set_parent!()' et 'root()' pour le graphe à 3 noeuds."
# "Changeons le parent de node1 dans graph_3n :"
set_parent!(parent_table_3n, node1, node2)
# "Est ce que parent de node 1 est changé ?"
@test parent(parent_table_3n, node1) == node2
# "Ajoutons node 3 comme parent de 2 dans graph_3n :"
set_parent!(parent_table_3n, node2, node3)
# "Est ce que parent de node 2 est changé ?"
@test parent(parent_table_3n, node2) == node3
# "Nous avons maintenant le graphe de cout minimal, tous les noeuds devraient avoir la meme racine :"
@test root(parent_table_3n, node1) == root(parent_table_3n, node2) == root(parent_table_3n, node3)


# "Appliquons l'algorithme de Kruskal aux graphes"
min_tree_3n = main2(graph_3n)
min_tree_4n = main2(graph_4n)
min_tree_6n = main2(graph_6n)
min_tree_10n = main2(graph_10n)
min_tree_Nn = main2(graph_Nn)

# "L'arbre de recouvrement minimal devrait avoir exactmeent une arête de moins que de sommets"
@test length(edges(min_tree_3n)) == length(nodes(min_tree_3n)) - 1
@test length(edges(min_tree_4n)) == length(nodes(min_tree_4n)) - 1
@test length(edges(min_tree_6n)) == length(nodes(min_tree_6n)) - 1
@test length(edges(min_tree_10n)) == length(nodes(min_tree_10n)) - 1
@test length(edges(min_tree_Nn)) == length(nodes(min_tree_Nn)) - 1

# "La racine de chaque noeud devrait être la même"

@test is_root_unique(min_tree_3n)
@test is_root_unique(min_tree_4n)
@test is_root_unique(min_tree_6n)
@test is_root_unique(min_tree_10n)
@test is_root_unique(min_tree_Nn)
