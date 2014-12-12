% --top-down parser without features, with result tree

parse(Constituent, [Cuvant|S], S, [Constituent,[Cuvant]]) :- 
	cuvant(Constituent, Cuvant).
parse(Constituent, S1, S, [Constituent, Arbore]) :- 
	regula(Constituent, Fii),
	parse_lista(Fii, S1, S, Arbore).

parse_lista([C|Constituenti], S1, S, [A|Arbore]) :-
	parse(C, S1, S2, A),
	parse_lista(Constituenti, S2, S, Arbore).
parse_lista([], S, S, []).

regula(s, [np, vp]).
regula(np, [n]).
regula(vp, [v, np]).
regula(vp, [v]).

cuvant(n, omul).
cuvant(n, hainele).
cuvant(v, face).
cuvant(v, fac).

parse_s(X, Arbore) :- parse(s, X, [], Arbore).
generate_all(L) :- findall(X, parse_s(X, _), L).
