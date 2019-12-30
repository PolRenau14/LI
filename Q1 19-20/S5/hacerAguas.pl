main:- retractall(bestMovements(_,_)),  assertz(bestMovements(100,[])),  % "infinite" movements
       hAguas(0,0,0,[(0,0)]).

main:- bestMovements(BestMov,ReverseMovements), reverse( ReverseMovements, Movements ), nl,
       write('Optimal movements: '), write(Movements), write('. '), write(BestMov), write(' moves.'), nl, nl, halt.

%% El objetivo es tener 4 litros de agua en el cubo de 8L con el minimo numero de movimientos possibles.

%% Fer moviments d'aigues'
%%% Mover de C5 a C8
moverAguas(C5A,C8A,C5D,C8D):-
  C5D is max(C8A+C5A - 8, 0), C8D is min(C8A + C5A, 8), C5A \= C5D. %% para evitar hacer movimientos inutiles como no verter porque el C8 estaba lleno

%%% Mover de C8 a C5
moverAguas(C5A,C8A,C5D,C8D):-
  C8D is max(C8A + C5A - 5, 0), C5D is min(C8A + C5A, 5), C8A \= C8D.

%% LLenar Cubos
% Llenar C5
moverAguas(C5,C8,5,C8):- C5 \= 5.
% Llenar C8
moverAguas(C5,C8,C5,8):- C8 \= 8.

%% Vaciar Cubos
% Vaciar C5
moverAguas(C5,C8,0,C8):- C5 \= 0.
% Vaciar C8
moverAguas(C5,C8,C5,0):- C8 \= 0.


% Solució
hAguas(_,4,AcumulatedMovements,Movements):- storeMovementsIfBetter(AcumulatedMovements,Movements),fail.

% Fer poda, si la solució parcial actual ja no es millor que la anterior la descartem.
hAguas(_,_,AcumulatedMovements,_):- bestMovements(BestMov,_), AcumulatedMovements >= BestMov,!,fail.

% Fer una passa

hAguas(C5,C8,AcumulatedMovements,Movements):-
  moverAguas(C5,C8,R5,R8), Nextval is AcumulatedMovements +1, hAguas(R5,R8,Nextval,[(R5,R8)|Movements]), fail.

storeMovementsIfBetter( AcumulatedMovements, Movements ):-  bestMovements( BestMov, _ ), AcumulatedMovements < BestMov,
    write('Improved solution. New best movements are '), write(AcumulatedMovements), write(' moves.'),nl,
    retractall(bestMovements(_,_)), assertz(bestMovements(AcumulatedMovements,Movements)),!.
