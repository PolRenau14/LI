main:- retractall(bestMovements(_,_)),  assertz(bestMovements(100,[])),  % "infinite" movements
       hAguas(0,0,0,[(0,0)]).

main:- bestMovements(BestMov,ReverseMovements), reverse( ReverseMovements, Movements ), nl,
       write('Optimal movements: '), write(Movements), write('. '), write(BestMov), write(' moves.'), nl, nl, halt.


%% Operaciones
camino(E,E,C,C).
camino(EstActual,EstFinal,CaminoHastaAhora,CaminoTotal):-
	unPaso(EstActual,EstSiguiente),
	\+member(EstSiguiente,CaminoHastaAhora),
	camino(EstSiguiente,EstFinal,[EstSiguiente|CaminoHastaAhora],CaminoTotal).

nat(N):- between(1,30,N).

solucionOptima:-
	nat(N),
	camino([0,0],[0,4],[[0,0]],C),
	lenght(C,N),
	write(C).
