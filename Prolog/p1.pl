% (dificultad 1) Escribe un predicado Prolog prod(L,P) que signifique “P es el
% sproducto de los elementos de la lista de enteros dada L”. Debe poder generar la
% P y también comprobar una P dada.

prod([L],L).
prod([X|L],P):-prod(L,P2),P is P2*X.

%  (dificultad 1) Escribe un predicado Prolog pescalar(L1,L2,P) que signifique
% “P es el producto escalar de los dos vectores L1 y L2”. Los dos vectores vienen
% dados por las dos listas de enteros L1 y L2. El predicado debe fallar si los dos
%  vectores tienen una longitud distinta.


pescalar([L1],[L2],L1*L2).
pescalar([X1|L1],[X2|L2],P):- pescalar(L1,L2,P2), Aux is X1 * X2, P is P2 + Aux. 

% (dificultad 2) Representando conjuntos con listas sin repeticiones, escribe predi-
% cados para las operaciones de intersección y unión de conjuntos dados.

% Funcio auxiliar que utilitzarem
pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).


my_interseccion([],_,[]).
my_interseccion([X|L1],L2,[X|R]):-
    pert(X,L2),!, my_interseccion(L1,L2,R).
    
% X no pertany a L2, per tant la saltem, no ens importa el seu valor.
my_interseccion([_|L1],L2,R):- my_interseccion(L1,L2,R).


my_union([],L2,L2).
my_union([X|L1],L2,[X|R]):- not(pert(X,L2)),!,my_union(L1,L2,R).

my_union([_|L1],L2,R):- my_union(L1,L2,R).


% (dificultad 2) Usando el concat, escribe predicados para el último de una lista
% dada, y para el inverso de una lista dada.

my_reverse([L],L).
my_reverse([X|L1],LR):- my_reverse(L1,LR1),concat(LR1,X,LR).

%(dificultad 3) Escribe un predicado Prolog fib(N,F) que signifique “F es el N-
% ésimo número de Fibonacci para la N dada”. Estos números se definen como:
% fib(1) = 1, fib(2) = 1, y, si N > 2, como: fib(N) = fib(N − 1) + fib(N − 2).

fib(1,1).
fib(2,1).
fib(N,F):- N1 is N -1, N2 is N -2,fib(N1,F1),fib(N2,F2), F is F1 + F2.


% (dificultad 3) Escribe un predicado Prolog dados(P,N,L) que signifique “la lista
% L expresa una manera de sumar P puntos lanzando N dados”. Por ejemplo: si P es
% 5, y N es 2, una solución serı́a [1,4]. (Nótese que la longitud de L es N). Tanto
% P como N vienen instanciados. El predicado debe ser capaz de generar todas las
% soluciones posibles.

dados(0,0,[]).
dados(P,N,[X|LR]):-
    N > 0, pert(X,[1,2,3,4,5,6]),
    Px is P-X, Nx is N-1,
    dados(Px,Nx,LR).
