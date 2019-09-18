import Base.show

function main()
    noeud1 = Node("James", [π, exp(1)])
    noeud2 = Node("Kirk", "guitar")
    noeud3 = Node("Lars", 2)

    edge1 = Edge("1", noeud1, noeud2, 3);
    edge2 = Edge("2", noeud2, noeud3, 4);

    show(noeud1);
    show(edge1);

end

main();
