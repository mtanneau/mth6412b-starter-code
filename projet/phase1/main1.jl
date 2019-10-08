include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")
using Plots

""" Analyse une instance de TSP symétrique dont les poids sont donnés au format
 EXPLICIT et construit un objet de type Graph.

"""
function main1(filename::String)
  header = read_header(filename)
  graph_edges = read_edges(header, filename)
  graph_nodes = read_nodes(header, filename)
  nodes_empty = Vector{Node}()
  edges_empty = Vector{Edge}()
  graph = Graph{Int64}("graph", nodes_empty, edges_empty)
  for (i, node) in enumerate(graph_nodes)
    new_node = Node{Int64}(string(collect(keys(graph_nodes))[i]), collect(keys(graph_nodes))[i])
    add_node!(graph, new_node)
  end
  for edge in graph_edges
      new_edge = Edge{Int64}("", Node{Int64}(string(edge[1]), edge[1]), Node{Int64}(string(edge[2]), edge[2]), parse(Int, edge[3]))
      add_edge!(graph, new_edge)
  end
  # show(graph)
  graph
end
