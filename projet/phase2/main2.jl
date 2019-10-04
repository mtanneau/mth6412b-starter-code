
import Base.show

here = "C://Users//arthg//github//mth6412b-starter-code//projet//"
include(joinpath(here, "phase1//graph.jl"))
include("parent_table.jl")

"""Renvoie un arbre de recouvrement minimal du graphe symétrique en entrée en
utilisant l'algorithme de Kruskal. La méthode renvoie un objet de type Graph.
"""
function main2(graph::AbstractGraph)
    println(graph)
    parent_table = init_parent_table(graph)
    nodes = deepcopy(graph.nodes)
    edges = deepcopy(graph.edges)
    # nodes = nodes(graph) # la méthode nodes({Graph}) renvoie une erreur "ERROR: UndefVarError: nodes not defined"
    # edges = edges(graph) # la méthode edges({Graph}) renvoie une erreur "ERROR: UndefVarError: edges not defined"
    # On trie les arêtes par poids croissant :
    edges_order = sortperm(weight.(edges))
    edges = edges[edges_order]
    min_tree = Graph{Int64}("min_tree", nodes, [])
    for edge in edges
        # On récupère les extrémités de l'arête
        sd_nodes = get_sd_nodes(nodes, edge)
        node1 = sd_nodes[1]
        node2 = sd_nodes[2]
        println(node1, ", ", node2)
        # Si les deux noeuds ont des racines différentes, on ajoute l'arête à
        # l'arbre de recouvrement minimum
        println("\navant : ", name.(nodes))
        println(typeof(node1))
        # le type de node1 est bien Node{Int64}. Pourtant, la méthode main2.jl
        # renvoie l'erreur suivante à la ligne 37:
        # ERROR: MethodError: no method matching parent(::ParentTable{Int64}, ::Nothing)
        # Closest candidates are :
        # parent(::AbstractParentTable, ::AbstractNode)
        if root(parent_table, node1) != root(parent_table, node2)
            add_edge!(min_tree, edge)
            set_parent!(parent_table, node2, node1)
        end
        println("\naprès : ", name.(nodes))
    end
    min_tree
end
