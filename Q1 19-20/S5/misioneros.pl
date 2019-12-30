

%definimos Estado (MinionerosOrilla1,CanivalesOrilla1,MissionerosOrilla2,CanivalesOrilla2,Orilla)

comp(0,_,3,_).
comp(3,_,0,_).
comp(A,A,B,B).

%unPaso(0,0,3,3,2). % es solucio final.
unPaso((M1,C1,M2,C2,1),(RM1,RC1,RM2,RC2,2)):-
	between(0,2,NM), New is 2-NM,between(0,New,NC),
	Comp is NM + NC , Comp \= 0,
	M1 >= NM, C1 >= NC,
	RM1 is M1 - NM, RC1 is C1 - NC,
	RM2 is M2 + NM, RC2 is C2 + NC,
	comp(RM1,RC1,RM2,RC2).

unPaso((M1,C1,M2,C2,2),(RM1,RC1,RM2,RC2,1)):-
	between(0,2,NM), New is 2-NM,between(0,New,NC),
	Comp is NM + NC , Comp \= 0,
	M2 >= NM, C2 >= NC,
	RM2 is M2 - NM, RC2 is C2 - NC,
	RM1 is M1 + NM, RC1 is C1 + NC,
	comp(RM1,RC1,RM2,RC2).

camino(E,E,C,C).
camino(EstadoActual, EstadoFinal, CaminoHastaAhora,CaminoTotal):- unPaso(EstadoActual,EstadoSiguiente),
	\+member(EstadoSiguiente,CaminoHastaAhora),camino(EstadoSiguiente,EstadoFinal,[EstadoSiguiente|CaminoHastaAhora],CaminoTotal).

solucionOptima:-
	between(1,1000,N),
	camino((3,3,0,0,1),(0,0,3,3,2),[(3,3,0,0,1)],C),
	length(C,N),
	reverse(C,C1),
	write(C1), nl, write(N).
