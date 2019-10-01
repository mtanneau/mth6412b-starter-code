include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

filename = "instances\\stsp\\bayg29.tsp"
header = read_header(filename)
nom = header["NAME"]
graph_edges = read_edges(header,filename)
graph_nodes = read_nodes(header,filename)
G = Graph(nom, Node{Vector{Float64}}[], Edge{Vector{Float64}}[])
# On ajoute les noueds un par un au graphe G
for i in keys(graph_nodes)
    add_node!(G, Node(string(i), graph_nodes[i]))
end
# On ajoute les arêtes au graphe G
for e in graph_edges
    add_edge!(G, Edge(string(e[1],"-",e[2]),[Node(string(e[1]), graph_nodes[e[1]]), Node(string(e[2]), graph_nodes[e[2]])], e[3]))
end
show(G)
