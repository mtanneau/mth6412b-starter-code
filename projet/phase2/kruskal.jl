import Base.show
include(joinpath(@__DIR__,"node.jl"))
include(joinpath(@__DIR__,"edge.jl"))
include(joinpath(@__DIR__,"graph.jl"))
include(joinpath(@__DIR__,"arbreRecouvrement.jl"))

"""fonction retournant un arbre de recouvrement minimal pour un graphe non orienté connexe"""
function algoKruskal(graph::AbstractGraph)
  # on crée un objet de type Arbre pour le graphe
  foret = initArbre(graph)

  # on crée un tableau avec toutes les arêtes du graphe triées par poids
  aretes = edges(graph)
  sort!(aretes, by = x -> x.weight)

  # pour chaque arête, on regarde si elle coupe un ensemble connexe cad si ses deux noeuds ont une racine différente
  for arete in aretes
    # si oui, on relie les deux ensembles connexes par leurs racines
    if getRacine(foret, getNode1(arete)) != getRacine(foret, getNode2(arete))
      changeParent!(foret, getRacine(foret, getNode1(arete)), getRacine(foret, getNode2(arete)))
      # On ajoute l'arête à l'arbre
      add_edge!(foret, arete)
    end
    #  sinon on passe à l'arête suivante
  end
  return foret

end
