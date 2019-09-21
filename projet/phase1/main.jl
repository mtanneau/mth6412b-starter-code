import Base.show
include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"read_stsp.jl"))

function main()
    noeud1 = Node("James", [π, exp(1)])
    noeud2 = Node("Kirk", "guitar")
    noeud3 = Node("Lars", 2)

    edge1 = Edge(noeud1, noeud2, 3)
    edge2 = Edge(noeud2, noeud3, 4)
    graphToConstruct = read_stsp(joinpath(@__DIR__,"..","..","instances","stsp","bayg29.tsp"))
    println(typeof(graphToConstruct))
    println(graphToConstruct[2])
    """construct_graph(graphToConstruct[1])"""

end


"""fonction qui va créer un tableau de type noeuds"""
function construct_graph(nodes_dic::Dict)
    """création du graphe vide """
    t = eltype(collect(nodes));
    nodesgraph = Vector{Node{t}}();
    edgesgraph = Vector{Edge{t}}();
    println("t ", typeof(t));
    println(typeof(nodesgraph))
    println(edgesgraph)
    Graph_stsp = Graph("stsp",nodesgraph ,edgesgraph)

    """Pour tous les noeuds du graphe, on crée un objet de type noeud et on l'ajoute au tableau"""
    for k = 1 : length(nodes)
        println(nodes[k])
        node = Node(nodes[k][1],nodes[k][2])
        add_node!(Graph_stsp,node)
    end
    return Graph_stsp

end

main()
