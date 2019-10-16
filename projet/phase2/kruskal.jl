include(joinpath(@__DIR__, "..", "phase1", "node.jl"))
include(joinpath(@__DIR__, "..", "phase1", "edge.jl"))
include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "arbreRecouvrement.jl"))

"""Retourne un arbre de recouvrement minimal pour un graphe non orienté connexe"""
function algoKruskal(graph::AbstractGraph)
  # on crée un objet de type Arbre pour le graphe
  foret = initArbre(graph)

  # on crée un tableau avec toutes les arêtes du graphe triées par poids
  aretes = copy(edges(graph))
  sort!(aretes, by = x -> x.weight)

  # pour chaque arête, on regarde si elle coupe un ensemble connexe cad si ses deux noeuds ont une racine différente
  for arete in aretes
    racine1 = getRacine(foret, getNode1(arete))
    racine2 = getRacine(foret, getNode2(arete))
    # si oui, on relie les deux ensembles connexes par leurs racines
    if racine1 != racine2
      changeParent!(foret, racine1, racine2)
      # On ajoute l'arête à l'arbre
      add_edge!(foret, arete)
    end
    #  sinon on passe à l'arête suivante
  end
  return foret

end
