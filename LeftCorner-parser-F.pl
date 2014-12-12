% --left-corner parser with extended grammar, result tree and generated links

parse(Constituent, [Cuvant|SirRamas], S, ArboreR) :- 
	cuvant(W, Cuvant),
	legatura(W, Constituent),
	completeaza(W, Constituent, SirRamas, S, [W, [Cuvant]], ArboreR).
	
parse(Constituent, Sir, S, Arbore) :-
    regula(W, []),
    legatura(W, Constituent),
    completeaza(W, Constituent, Sir, S, [W, []], Arbore).
	
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
regula(det, []).

:-dynamic legatura/2.
generate_links(X) :-
	\+legatura(X,X), assert(legatura(X, X)),
	print(X), print(' '), print(X), nl,
    regula(X, [Y | _]),!, X\=Y,
	\+legatura(Y,X), assert(legatura(Y,X)),
    print(Y), print(' '), print(X), nl,
	generate_links(Y),
	legatura(X,Z),!, \+legatura(Y,Z), assert(legatura(Y,Z)),
	print(Y), print(' '), print(Z), nl.
generate_links(_).		


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
