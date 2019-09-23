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
    nodes, edges = read_stsp(joinpath(@__DIR__,"..","..","instances","stsp","bayg29.tsp"))
    construct_graph(joinpath(@__DIR__,"..","..","instances","stsp","bayg29.tsp"))

end


"""fonction qui va créer un graphe à partir d'un fichier"""
function construct_graph(filename::String)
    """Récupérer les données du fichier """
    brut_nodes, edges = read_stsp(joinpath(@__DIR__,"..","..","instances","stsp","bayg29.tsp"))
    nodes = []
    nb_nodes = length(length.(collect(keys(brut_nodes))))

    """Pour tous les noeuds du graphe, on crée un objet de type noeud et on l'ajoute au graphe"""
    #On implémente un tableau vide si il n'y a pas de noeud dans le fichier
    if (length(brut_nodes)==0)
    nodes = AbstractNode{Array{Float64,1}}[]
        for i in 1:nb_nodes
          push!(nodes,Node(i,[0.0,0.0]))
        end
    else
        T = valtype(brut_nodes)
        nodes = AbstractNode{T}[]
        for node_id in keys(brut_nodes)
          node = Node(string(node_id), brut_nodes[node_id])
          push!(nodes, node)
        end
    end

    """Pour toutes les arêtes, on ajoute l'arête avec son poids au tableau d'arêtes"""
    #on implémente un tableau d'arêtes si il n'y a pas d'arêtes dans le fichier

end

main()
