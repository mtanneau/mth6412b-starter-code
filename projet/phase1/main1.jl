include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")
using Plots

""" Analyse une instance de TSP symétrique dont les poids sont donnés au format
 EXPLICIT et construit un objet de type Graph.

"""

# function main1(filename::String)
#   graph_nodes, graph_edges = read_stsp(filename)
#   nodes = Vector{Node}()
#   edges = Vector{Edge}()
#   graph = Graph{Int64}("graph", nodes, edges)
#   for raw_node in raw_nodes
#     node = Node{Int64}(string(raw_node), 0)
#     add_node!(graph, node)
#   end
#   for n = 1 : length(raw_edges)
#     for e = 1 : length(raw_edges[n])
#       edge = Edge{Int64}(string(n, "-", raw_edges[n][e]), n, raw_edges[n][e], raw_edges_weights[n][e])
#       add_edge!(graph, edge)
#     end
#   end
#   show(graph)
#   return graph
# end


function main1(filename::String)
  header = read_header(filename)
  graph_edges = read_edges(header, filename)
  graph_nodes = read_nodes(header, filename)
  nodes_empty = Vector{Node}()
  edges_empty = Vector{Edge}()
  graph = Graph{Int64}("graph", nodes_empty, edges_empty)
  print(graph_nodes)
  for (i,node) in enumerate(graph_nodes)
    AjoutNode = Node{Int64}(string(collect(keys(graph_nodes))[i]), collect(keys(graph_nodes))[i])
    add_node!(graph, AjoutNode)
  end
  for edge in graph_edges
      #println(edge)
      #println(typeof(edge[3]))
      AjoutEdge = Edge{Int64}("", Node{Int64}(string(edge[1]),edge[1]), Node{Int64}(string(edge[2]),edge[2]), parse(Int,edge[3]))#string(edge[1], "-", edge[2])
      add_edge!(graph, AjoutEdge)
  end
  # show(graph)
  return graph
end




# function main1(filename::String)
#   graph_nodes, graph_edges = read_stsp(filename)
#   header = read_header(filename)
#   graph_edges = read_edges(header, filename)
#   nodes_empty = Vector{Node}()
#   edges_empty = Vector{Edge}()
#   graph = Graph{Int64}("graph", nodes_empty, edges_empty)
#   for node in graph_nodes
#     println(node)
#     println("NODE!!!")
#     println(node[0])
#     AjoutNode = Node{Int64}(string(node), 0)
#     add_node!(graph, AjoutNode)
#   end
#   for edge in graph_edges
#       #println(edge)
#       #println(typeof(edge[3]))
#       AjoutEdge = Edge{Int64}("", Node{Int64}(string(edge[1]),edge[1]), Node{Int64}(string(edge[2]),edge[2]), parse(Int,edge[3]))#string(edge[1], "-", edge[2])
#       add_edge!(graph, AjoutEdge)
#   end
#   show(graph)
#   return graph
# end
