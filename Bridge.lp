persona(hijo;padre;madre;abuelo).
lado(lado_a;lado_b).
velocidad(hijo,1;padre,2;madre,3;abuelo,5).

fluent(antorcha_en(Lado)) :- lado(Lado).
fluent(en(P,Lado)) :- persona(P), lado(Lado).

init(en(P,lado_a)) :- persona(P).
init(antorcha_en(lado_a)).

goal(en(P,lado_b)) :- persona(P).

action(cruzar_solo(P, Desde, Hacia)) :- persona(P), 
					lado(Desde), 
					lado(Hacia), 
					Desde != Hacia.

action(cruzar_juntos(X,Y,Desde,Hacia)) :-	lado(Desde), 
							lado(Hacia), 
							Desde != Hacia, 
							velocidad(X,T1),
							velocidad(Y,T2),
							T2 < T1.

cost(cruzar_solo(P,Desde,Hacia),Costo) :- action(cruzar_solo(P,Desde,Hacia)),
					  velocidad(P,Costo).
cost(cruzar_juntos(X,Y,Desde,Hacia),Costo) :- action(cruzar_juntos(X,Y,Desde,Hacia)),
							   velocidad(X,Costo).

#show cost/2.
#maximize{Costo : cost(_,Costo)}.