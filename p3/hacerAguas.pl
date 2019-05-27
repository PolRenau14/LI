main:- retractall(bestMovements(_,_)),  assertz(bestMovements(100,[])),  % "infinite" movements
       hAguas(0,0,0,[(0,0)]).

main:- bestMovements(BestMov,ReverseMovements), reverse( ReverseMovements, Movements ), nl,
       write('Optimal movements: '), write(Movements), write('. '), write(BestMov), write(' moves.'), nl, nl, halt.


%Variable que sigui lo que tinc en el cubo de 8L
%Variable 
%% Operaciones


% Molt mes rapid si estan aquests operadors primers (son els que usarem mes cops per logica)
moverAguas(C1,C2,R1,R2):- R1 is max(C1-8+C2,0), R2 is min(C1+C2,8),R1 \= C1. %% verter el de 5 en el de 8
moverAguas(C1,C2,R1,R2):- R1 is min(C1+C2,5), R2 is max(C2 - 5 + C1,0), R1 \= C1. %% verter el de 8 en el de 5

moverAguas(C1,C2,5,C2):- C1 \=5. %% llenamos el cubo de 5
moverAguas(C1,C2,C1,8):- C2 \=8. %% llenamos el cubo de 8
moverAguas(C1,C2,0,C2):- C1 \=0. %% vaciamos el cubo de 5
moverAguas(C1,C2,C1,0):- C2 \=0. %% vaciamos el de 8

% hAguas(cantidadCubo5, cantidad cubo8,acumulatedMovements,movements)

hAguas(_,4,AcumulatedMovements,Movements):- storeMovementsIfBetter(AcumulatedMovements,Movements),fail.

hAguas(_,_,AcumulatedMovements,_) :- bestMovements(BestMov,_), AcumulatedMovements >= BestMov,!,fail. % fem poda

hAguas(C5,C8,AcumulatedMovements,Movements):-
	moverAguas(C5,C8,R5,R8),Nextval is AcumulatedMovements+1,hAguas(R5,R8,Nextval,[(R5,R8)|Movements]),fail.

storeMovementsIfBetter( AcumulatedMovements, Movements ):-  bestMovements( BestMov, _ ), AcumulatedMovements < BestMov,
    write('Improved solution. New best movements are '), write(AcumulatedMovements), write(' moves.'),nl,
    retractall(bestMovements(_,_)), assertz(bestMovements(AcumulatedMovements,Movements)),!.
