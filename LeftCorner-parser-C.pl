% --left-corner parser with extended grammar and result tree

parse(Constituent, [Cuvant|SirRamas], S, ArboreR) :- 
	cuvant(W, Cuvant),
	completeaza(W, Constituent, SirRamas, S, [W, [Cuvant]], ArboreR).
	
completeaza(W, W, S, S, Arb, Arb).
completeaza(W, Constituent, SirRamas, S, Arbore, ArboreR) :-
	regula(Parinte, [W | Rest]),
	parse_lista(Rest, SirRamas, S1, Arbore1),
	completeaza(Parinte, Constituent, S1, S, [Parinte, [Arbore | Arbore1]], ArboreR).

parse_lista([C|Constituenti], S1, S, [Arbore1 | Arbore2]) :-
	parse(C, S1, S2, Arbore1),
	parse_lista(Constituenti, S2, S, Arbore2).
parse_lista([], S, S, []).

regula(s, [np, vp]).
regula(np, [det, n]).
regula(np, [np, conj, np]).
regula(vp, [v, np]).
regula(vp, [v, np, pp]).
regula(pp, [p, np]).

cuvant(det, the).
cuvant(det, all).
cuvant(det, every).
cuvant(p, near).
cuvant(conj, and).
cuvant(n, dog).
cuvant(n, dogs).
cuvant(n, cat).
cuvant(n, cats).
cuvant(n, elephant).
cuvant(n, elephants).
cuvant(v, chase).
cuvant(v, chases).
cuvant(v, see).
cuvant(v, sees).
cuvant(v, amuse).
cuvant(v, amuses).

parse_s(X, Arbore) :- parse(s, X, [], Arbore).
