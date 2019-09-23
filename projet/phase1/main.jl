
using Plots

""" Analyse une instance de TSP symétrique dont les poids sont donnés au format
 EXPLICIT et construit un objet de type Graph.

 La méthode renvoie aussi un tableau répertoriant les poids des arcs au départ de chaque noeud.
 --> graph_edges_weights[i][j] est donc le poids de l'arc reliant le noeud i au noeud j.

 Pour finir, la méthode main génère un fichier pdf contenant le graphique produit.

"""

function main(filename::String, pdf="y")
  graph_nodes, graph_edges, graph_edges_weights = read_stsp(filename)
  println("\nGraph weights :")
  Base.show(graph_edges_weights)
  if(pdf == "y")
    savefig(split(filename, ".")[1] * ".pdf")
  end
  plot_graph(graph_nodes, graph_edges)
end
