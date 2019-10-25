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

%(dificultad 2) Escribe un predicado suma demas(L) que, dada una lista de enteros L, se satisface si existe algun elemento en ´ L que es igual a la suma de los
% demas elementos de ´ L, y falla en caso contrario.

suma_lista([],0).
suma_lista([X|L],R):- suma_lista(L,RX), R is RX + X.

suma_demas([]).
suma_demas(L):- append(L1,[X|L2],L),append(L1,L2,LS), suma_lista(LS,SX),X == SX.

% (dificultad 2) Escribe un predicado suma ants(L) que, dada una lista de enteros L, se satisface si existe algun elemento en ´ L que es igual a la suma de los
% elementos anteriores a el en ´ L, y falla en caso contrario.

suma_ants([]).
suma_ants([X,Y|_]):- X==Y.
suma_ants([X,Y|L]):- X1 is X+Y, suma_ants([X1|L]).


% (dificultad 2) Escribe un predicado card(L) que, dada una lista de enteros L,
% escriba la lista que, para cada elemento de L, dice cuantas veces aparece este ´
% elemento en L. Por ejemplo, card( [1,2,1,5,1,3,3,7] ) escribira´
% [[1,3],[2,1],[5,1],[3,2],[7,1]].


count_elem_remove(_,[],0,[]).
count_elem_remove(X,[X|L],C,LR):- count_elem_remove(X,L,C1,LR), C is C1 + 1 .
count_elem_remove(X,[Y|L],C,[Y|LR]):- count_elem_remove(X,L,C,LR).

card([],[]).
card([X|L],LR):-count_elem_remove(X,[X|L],C,L1), card(L1,LR2), append([[X,C]],LR2,LR).

card(L):- card(L,LR),write(LR).

% (dificultad 2) Escribe un predicado Prolog est´a ordenada(L) que signifique
% “la lista L de numeros enteros est ´ a ordenada de menor a mayor”. Por ejemplo, ´
% con ?-est´a ordenada([3,45,67,83]). dice yes
% Con ?-est´a ordenada([3,67,45]). dice no

ordenada([]).
ordenada([_]).
ordenada([X,Y|L]):- X =< Y, ordenada([Y|L]).

% (dificultad 2) Escribe un predicado Prolog ordenaci´on(L1,L2) que signifique
% “L2 es la lista de enteros L1 ordenada de menor a mayor”. Por ejemplo: si L1 es
% [8,4,5,3,3,2], L2 sera´ [2,3,3,4,5,8]. Hazlo en una l´ınea, utilizando solo ´
% los predicados permutaci´on y est´a ordenada.

pert_con_resto(X,L,R):- append(L1,[X|L2],L), append(L1,L2,R).

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

ordenacion(L1,L2):- permutacion(L1,L2),ordenada(L2).

% (dificultad 3) Escribe un predicado Prolog ordenaci´on(L1,L2) basado en el
% metodo de la inserci ´ on, usando un predicado ´ insercion(X,L1,L2) que signifique: “L2 es la lista obtenida al insertar X en su sitio en la lista de enteros L1 que
% esta ordenada de menor a mayor”.


insercion(X,[],[X]).
insercion(X,[Y|L1],[X,Y|L1]) :- X=<Y.
insercion(X,[Y|L1],[Y|L2]) :- X>Y, insercion(X,L1,L2).

ordenacion2([],[]).
ordenacion2([X|L1],L2) :- ordenacion2(L1,L3), insercion(X,L3,L2).


% (dificultad 3) Escribe un predicado Prolog ordenación(L1,L2) basado en el
% método de la fusión (merge sort): si la lista tiene longitud mayor que 1, con
% concat divide la lista en dos mitades, ordena cada una de ellas (llamada recur-
% siva) y después fusiona las dos partes ordenadas en una sola (como una “crema-
% llera”). Nota: este algoritmo puede llegar a hacer como mucho n log n compa-
% raciones (donde n es el tamaño de la lista), lo cual es demostrablemente óptimo.

fusiona([],L2,L2).
fusiona(L1,[],L1).
fusiona([X|L1],[Y|L2],[X|LR]):-
  X < Y,!, fusiona(L1,[Y|L2],LR).
fusiona([X|L1],[Y|L2],[Y|LR]):-
  fusiona([X|L1],L2,LR).

divide([],[],[]).
divide([X],[X],[]).
divide([X,Y|L],[X|L1],[Y|L2]):- divide(L,L1,L2).

ordenacion3([],[]):- !.
ordenacion3([X],[X]):- !.
ordenacion3(L1,L2):- divide(L1,LP1,LP2), ordenacion3(LP1,LR1),ordenacion3(LP2,LR2),fusiona(LR1,LR2,L2).




% (dificultad 4) Escribe un predicado diccionario(A,N) que, dado un alfabe-
% to A de sı́mbolos y un natural N, escriba todas las palabras de N sı́mbolos, por
% orden alfabético (el orden alfabético es según el alfabeto A dado). Ejemplo:
% diccionario( [ga,chu,le],2) escribirá:
% %%%% === >gaga gachu gale chuga chuchu chule lega lechu lele.

nmembers(_,0,[]):- !.
nmembers(A,N,[X|L]):- pert(X,A),N1 is N -1, nmembers(A,N1,L).

escribir([]):- write(' '),nl,!.
escribir([X|L]):- write(X),escribir(L).

diccionario(A,N):- nmembers(A,N,L),escribir(L),fail.
diccionario(_,_).




% dificultad 3) Escribe un predicado palı́ndromos(L) que, dada una lista de le-
% tras L, escriba todas las permutaciones de sus elementos que sean palı́ndromos
% (capicúas).
% Ejemplo: palindromos([a,a,c,c]) escribe [a,c,c,a] y [c,a,a,c].




es_palindromo([]).
es_palindromo([_]):- !.
es_palindromo([X|L]):- append(L1,[X],L),es_palindromo(L1).

% La funció set of la fem servir  per no tenir repetits.

palindromos(L):- setof(P,(permutacion(L,P), es_palindromo(P)),S), write(S).
palindromos(_).
