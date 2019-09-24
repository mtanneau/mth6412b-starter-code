
using Plots

""" Analyse une instance de TSP symétrique dont les poids sont donnés au format
 EXPLICIT et construit un objet de type Graph.

 La méthode renvoie aussi un tableau répertoriant les poids des arcs au départ de chaque noeud.
 --> graph_edges_weights[i][j] est donc le poids de l'arc reliant le noeud i au noeud j.

 Pour finir, la méthode main génère un fichier pdf contenant le graphique produit.

"""

function main(filename::String)
  raw_nodes, raw_edges, raw_edges_weights = read_stsp(filename)
  nodes = Vector{Node}()
  edges = Vector{Edge}()
  graph = Graph{Int64}("graph", nodes, edges)
  for raw_node in raw_nodes
    node = Node{Int64}(string(raw_node), 0)
    add_node!(graph, node)
  end
  for n = 1 : length(raw_edges)
    for e = 1 : length(raw_edges[n])
      edge = Edge{Int64}(string(n, "-", raw_edges[n][e]), n, raw_edges[n][e], raw_edges_weights[n][e])
      add_edge!(graph, edge)
    end
  end
  show(graph)
end
