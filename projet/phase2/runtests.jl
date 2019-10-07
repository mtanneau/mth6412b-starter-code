using Test

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))

"""Graphe à 4 noeuds"""
graph1 = Graph{Int64}("graph1", [Node{Int64}("1", 1), Node{Int64}("2", 2), Node{Int64}("3", 3), Node{Int64}("4", 4)],
[Edge{Int64}("1", Node{Int64}("1", 1), Node{Int64}("2", 2), 1),
Edge{Int64}("2", Node{Int64}("1", 1), Node{Int64}("3", 3), 2),
Edge{Int64}("3", Node{Int64}("1", 1), Node{Int64}("4", 4), 3),
Edge{Int64}("4", Node{Int64}("2", 2), Node{Int64}("3", 3), 4),
Edge{Int64}("5", Node{Int64}("2", 2), Node{Int64}("4", 4), 5),
Edge{Int64}("6", Node{Int64}("3", 3), Node{Int64}("4", 4), 6)])

min_tree1 = main2(graph1)

@test length(edges(min_tree1)) == length(nodes(graph1)) - 1


"""Graphe à 6 noeuds"""
graph2 = Graph{Int64}("graph1", [Node{Int64}("1", 1), Node{Int64}("2", 2), Node{Int64}("3", 3), Node{Int64}("4", 4), Node{Int64}("5", 5), Node{Int64}("6", 6)],
[Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("2", 2), 1),
Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("3", 3), 2),
Edge{Int64}("", Node{Int64}("1", 1), Node{Int64}("4", 4), 3),
Edge{Int64}("", Node{Int64}("2", 2), Node{Int64}("3", 3), 4),
Edge{Int64}("", Node{Int64}("3", 3), Node{Int64}("4", 4), 5),
Edge{Int64}("", Node{Int64}("4", 4), Node{Int64}("5", 5), 6),
Edge{Int64}("", Node{Int64}("2", 2), Node{Int64}("5", 5), 6),
Edge{Int64}("", Node{Int64}("3", 3), Node{Int64}("6", 6), 6)])

min_tree2 = main2(graph2)

@test length(edges(min_tree2)) == length(nodes(graph2)) - 1


"""Graphe à 10 noeuds"""
graph2 = Graph{Int64}("graph1", [], [])
for i = 1 : 10
    add_node!(graph2, Node{Int64}(string(i), i))
end
for e = 1 : 9
    add_edge!(graph2, Edge{Int64}("", nodes(graph2)[e], nodes(graph2)[e+1], rand(range(1, stop=10))))
end
min_tree2 = main2(graph2)

@test length(edges(min_tree2)) == length(nodes(graph2)) - 1


"""Graphe à n noeuds"""
graph3 = main1("C:/Users/arthg/github/mth6412b-starter-code/instances/stsp/bays29.tsp")
min_tree3 = main2(graph3)

@test length(edges(min_tree3)) == length(nodes(graph3)) - 1
