include("projet\\phase1\\node.jl")
include("projet\\phase1\\edge.jl")
include("projet\\phase1\\graph.jl")
include("projet\\phase1\\read_stsp.jl")

filename="instances\\stsp\\bayg29.tsp"
nom=read_header(filename)["NAME"]
graph_edges=read_edges(read_header(filename),filename)
Node_Vector=[Node("",Float64[])]
for i in keys(graph_nodes)
    push!(Node_Vector,Node(string(i),graph_nodes[i]))
end
popfirst!(Node_Vector)
println(Node_Vector)

Edge_Vector=[Edge("",[Node_Vector[1]],0)]
coord1=[]
coord2=[]
for e in graph_edges
    for j in Node_Vector
        if j.name==string(e[1])
            coord1=j.data
        end
        if j.name==string(e[2])
            coord2=j.data
        end
    end
    push!(Edge_Vector,Edge(string(e[1],"-",e[2]),[Node(string(e[1]),[parse(Float64,coord1[1]),parse(Float64,coord1[2])]),Node(string(e[2]),[parse(Float64,coord2[1]),parse(Float64,coord2[2])])],e[3]))
end


G=Graph(nom,Node_Vector,Edge_Vector)
