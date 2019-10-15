here = @__DIR__
include(joinpath(here, "..", "phase1", "node.jl"))
include(joinpath(here, "..", "phase1", "node.jl"))
include(joinpath(here, "..", "phase1", "edge.jl"))
include(joinpath(here, "..", "phase1", "graph.jl"))

#import Base.union!
"""Renvoie la racine du  noeud `node`
Calcule recursivement la racine de `node, selon la relation de parents donnée
par le dictionnaire `dict`.
"""
function root(node::Node{T},dict::Dict{String,String}) where T
    p = name(node)
    #Tant que le parent du noeud p est différent de lui-même,
    #on remplace ce noeud par son parent
    while p != dict[p]
        p = dict[p]
    end
    return(p)
end

"""Renvoie un booléen true si les deux noeuds de l'arête
 edge sont dans le même ensemble connexe et false autrement
"""
function connex(node1::Node{T}, node2::Node{T},dict::Dict{String,String}) where T
     #Si ces deux noeuds ont la même racine, ils sont dans le
        #même ensemble connexe, sinon non
    return(root(node1,dict) == root(node2,dict))
end

"""
Fonction réalisant l'union de deux arborescences, par l'arête edge,
 et dans la forêt représentée par le dictionaire dict
 """
function union_1!(edge::Edge{T},dict::Dict{String,String}) where T
    #On récupère dans node1 et node2 les deux noeuds contenus dans l'arête edge
    node1 = name(data(edge)[1])
    node2 = name(data(edge)[2])
    #p1 et p2 permettent de garder en mémoire l'arc reliant node2 et son parent
    p1 = node2
    p2 = dict[node2]
    #On remplace le parent de node2 par node1, c'est-à-dire qu'on
    #supprime l'arc allant de p1 vers p2 et on le remplace vers
    #un arc allant de p1 vers node1
    dict[node2] = node1
    #Tant que le parent de p1 est différent de lui même (c'est-à-dire
    #tant que l'on n'a pas atteint la racine de la deuxième arborescence)
    while p1 != p2
        #avant d'appliquer des changements au dictionaire,
        #on mémorise le parent de p2
        p3 = dict[p2]
        #on peut alors appliquer les changements au dictionaire:
        #l'arc reliant p1 et p2 change de sens, et l'arc reliant
        #p2 et son ancient parent p3 disparait
        dict[p2] = p1
        #on s'intéresse maintenant à l'arc que l'on vient d'effacer
        p1 = p2
        p2 = p3
    end
        #A la dernière itération, on aura effacé l'arc reliant
        #l'ancienne racine de l'arborescence 2 à elle-même
end


"""Renvoie un arbre de recouvrement de coût minimal associé au
 graphe G, en utilisant l'algorithme de Kruskal
"""
function kruskal(G::Graph{T}) where T
    #copie des arêtes du graphe
     E = copy(edges(G))
     #Tri des arêtes par poids
     sort!(E, by = x -> weight(x))
     parents = Dict(name(node) => name(node) for node in nodes(G))

     #Graphe contenant les noeuds de G, initialement sans arêtes
     G_construction = Graph("Arbre", nodes(G), Edge{T}[])
     for e in E
         #Si les deux noeuds de l'arête e ne sont pas dans le même ensemble connexe
        if connex(e,parents) == false
            #On ajoute cette arête au graphe de construction
            add_edge!(G_construction,e)
            #On ajoute cette arête à la forêt d'arborescence
            union_1!(e,parents)
        end
    end
    #Le graphe de construction obtenu est un arbre de recouvrement de G
    return G_construction
end
