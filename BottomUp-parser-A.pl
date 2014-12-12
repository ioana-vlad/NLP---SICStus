% --bottom-up parser with features and result tree

parse(Sir, Rezultat, Nr, Arbore) :- 
	depl_red(Sir, [], Rezultat, Nr, [], Arbore).
	
depl_red([], Rezultat, Rezultat, _, Arbore, Arbore).
depl_red(Sir, Stiva, Rezultat, Nr, Arbore, ArboreR) :-
	deplasare(Stiva, Sir, StivaNoua, SirRedus),
	reducere(StivaNoua, StivaRedusa, Nr, NrRedus, Arbore, Arbore1),
	depl_red(SirRedus, StivaRedusa, Rezultat, NrRedus, Arbore1, ArboreR).

deplasare(Stiva, [Cuvant | SirRamas], [Cuvant | Stiva], SirRamas).

reducere(Stiva, Stiva, Nr, Nr, Arbore, Arbore).
reducere(Stiva, StivaRedusa, Nr, NrRedus, Arbore, ArboreR) :-
	iregula(Stiva, Stiva1, Nr, Nr1, Arbore, Arbore1),
	reducere(Stiva1, StivaRedusa, Nr1, NrRedus, Arbore1, ArboreR).

iregula([vp, np | X], [s | X], [Nr, Nr | Numere], [_ | Numere], [A2, A1 | Arb] , [[s, A1, A2] | Arb]).
iregula([n | X], [np | X], [Nr | Numere], [Nr | Numere], [A | Arb] , [[np, A] | Arb]).
iregula([np, v | X], [vp | X], [_, Nr | Numere], [Nr | Numere], [A2, A1 | Arb] , [[vp, A1, A2] | Arb]).
iregula([v | X], [vp | X], [Nr | Numere], [Nr | Numere], [A | Arb] , [[vp, A] | Arb]).

iregula([Cuvant | X], [Categorie | X], Numere, [Nr | Numere], Arbore, [[Categorie, [Cuvant]] | Arbore]) :- 
	cuvant(Categorie, Nr, Cuvant).

cuvant(n, sing, omul).
cuvant(n, plur, hainele).
cuvant(v, sing, face).
cuvant(v, plur, fac).

parse_s(X, Arbore) :- parse(X, [s], [], Arbore).
