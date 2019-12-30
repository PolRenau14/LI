
variable(x).
variable(y).
variable(z).

instruccion([A,=,B,+,C]):-
    variable(A),
    variable(B),
    variable(C).

instruccion([if,A,=,B,then|L]):-
    variable(A), variable(B),
    append(Ins1,[else|Aux],L),
    append(Ins2,[endif],Aux),
    instrucciones(Ins1),
    instrucciones(Ins2).

instrucciones(In):- instruccion(In).

instrucciones(L):-
    append(In,[;|Ins],L),
    instruccion(In),
    instrucciones(Ins).

programa([begin|L]):-
    append(Ins,[end],L),
    instrucciones(Ins).
