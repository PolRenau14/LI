:-use_module(library(clpfd)).

main:- Coins = [1,2,5,13,17,35,157], Amount = 361,
    length(Coins,N),
    length(Vars,N),
    Vars ins 0..Amount,
    expresionAmount(Vars,Coins,E), E #= Amount,
    expresionSuma(Vars,Es),
    labeling([min(Es)],Vars), write(Vars), nl.
    
    
    
    
expresionAmount([V],[C],V*C).
expresionAmount([V|Vars],[C|Coins],V*C+E):- expresionAmount(Vars,Coins,E).

expresionSuma([V],V).
expresionSuma([V|Vars], V+E):- expresionSuma(Vars,E).
