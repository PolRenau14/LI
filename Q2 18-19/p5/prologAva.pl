mainAguas:- retractall(bestMoves(_,_)),  assertz(bestMoves(100,[])), haguas(0,0,0,[(0,0)]).

mainAguas:- bestMoves(NumMoves,ReverseMoves), reverse( ReverseMoves, Moves ), nl,
       write('Pasos optimos: '), write(Moves), write('. '), write(NumMoves), write(' pasos.'), nl, nl, halt.

cubos(P,G,5,G):- P \= 5.
cubos(P,G,0,G):- P \= 0.
cubos(P,G,P,8):- G \= 8.
cubos(P,G,P,0):- G \= 0.

%Vertir pequeño en grande
cubos(Pini,Gini,Pfin,Gfin):- Cantidad is Pini+Gini, Pfin is max(Cantidad-8,0), Gfin is min(8,Cantidad), Pini \= Pfin.
%Vertir grande en pequeño
cubos(Pini,Gini,Pfin,Gfin):- Cantidad is Pini+Gini, Gfin is max(Cantidad-5,0), Pini is min(5,Cantidad), Pini \= Pfin.

%Tenemos 4 litros en el grande, donete
haguas(_,4,NumMoves,Moves):- storeRouteIfBetter(NumMoves,Moves), fail.
haguas(_,_,NumMoves,_):- bestMoves(M,_), NumMoves >= M, !, fail.
haguas(P,G,NumMoves,Moves):- cubos(P,G,Pfin,Gfin), NumMoves2 is NumMoves+1, haguas(Pfin,Gfin,NumMoves2,[(Pfin,Gfin)|Moves]). 


storeRouteIfBetter( NumMoves, Moves ):-  bestMoves( BestMove, _ ), NumMoves < BestMove,
    write('Solucion encontrada. La nueva solucion es -> '), write(NumMoves), write(' pasos.'),nl,
    retractall(bestMoves(_,_)), assertz(bestMoves(NumMoves,Moves)),!.
    
    
mainMisionero:- retractall(bestMoves(_,_)),  assertz(bestMoves(100,[])), solucionOptima.

mainMisionero:- bestMoves(NumMoves,ReverseMoves), reverse( ReverseMoves, Moves ), nl,
       write('Pasos optimos: '), write(Moves), write('. '), write(NumMoves), write(' pasos.'), nl, nl, halt.
       
camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

    
solucionOptima:-
    nat(N),
    camino((3,3,0,0,0),(0,0,3,3,1),[(3,3,0,0,0)],Camino), length(Camino,N),
    reverse(Camino,C),
    write(N), nl,
    write(C).


unPaso((M11,C11,M12,C12,0),(M21,C21,M22,C22,1)):- 
    between(0,2,MM), 
    Aux is 2-MM,
    between(0,Aux,MC),
    Suma is MM+MC,
    Suma \= 0,
    M11 >= MM,
    C11 >= MC,
    M21 is M11-MM,
    C21 is C11-MC,
    M22 is M12+MM,
    C22 is C12+MC,
    comp(M21,C21,M22,C22).
    
    
unPaso((M11,C11,M12,C12,1),(M21,C21,M22,C22,0)):-
    between(0,2,MM), 
    Aux is 2-MM,
    between(0,Aux,MC),
    Suma is MM+MC,
    Suma \= 0,
    M12 >= MM,
    C12 >= MC,
    M21 is M11+MM,
    C21 is C11+MC,
    M22 is M12-MM,
    C22 is C12-MC,
    comp(M21,C21,M22,C22).
   
comp(A,A,B,B).
comp(0,_,_,_).
comp(_,_,0,_).



nat(N):- between(1,1000,N).
