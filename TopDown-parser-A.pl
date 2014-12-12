% --top-down parser with features and result tree

parse(Constituent, Numar, [Cuvant|S], S, [Constituent,[Cuvant]]) :- 
	cuvant(Constituent, Numar, Cuvant).
parse(Constituent, Numar, S1, S, [Constituent, Arbore]) :- 
	regula(Constituent, Numar, NumereFii, Fii),
	parse_lista(Fii, NumereFii, S1, S, Arbore).

parse_lista([C|Constituenti], [N|Numere], S1, S, [A|Arbore]) :-
	parse(C, N, S1, S2, A),
	parse_lista(Constituenti, Numere, S2, S, Arbore).
parse_lista([], [], S, S, []).

regula(s, _, [Nr, Nr], [np, vp]).
regula(np, Nr, [Nr], [n]).
regula(vp, Nr, [Nr, _], [v, np]).
regula(vp, Nr, [Nr], [v]).

cuvant(n, sing, omul).
cuvant(n, plur, hainele).
cuvant(v, sing, face).
cuvant(v, plur, fac).

parse_s(X, Arbore) :- parse(s, _, X, [], Arbore).
generate_all(L) :- findall(X, parse_s(X, _), L).
