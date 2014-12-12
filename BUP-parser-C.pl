% --BUP parser with extended grammar, features, result tree and links

parse(C, [Cuv | S1], S, Nr, Arbore) :-
    cuvant(W, [Cuv | S1], S2, Nr),
	legatura(W, C),
	P =..[W, C, S2, S, Nr, [W, [Cuv]], Arbore],
    call(P).

s(s, S, S, _, Arb, Arb).
vp(vp, S, S, _, Arb, Arb).
n(n, S, S,  _, Arb, Arb).
pp(pp, S, S,  _, Arb, Arb).
conj(conj, S, S,  _, Arb, Arb).

% -- S -> NP VP
np(C, S1, S, Nr, A1, A) :-
    parse(vp, S1, S2, Nr, A2),
    s(C, S2, S, Nr, [s,  A1, A2], A).
	
% -- NP -> NP Conj NP
np(C, S1, S, Nr, A1, A) :-
    parse(conj, S1, S2, Nr, A2),
    parse(np, S2, S3, Nr, A3),
    np(C, S3, S, plur, [np, A1, A2, A3], A).
np(np, S, S,  _, Arb, Arb).
	
% -- NP -> Det N
det(C, S1, S, Nr, A1, A) :-
    parse(n, S1, S2, Nr, A2),
    np(C, S2, S, Nr, [np, A1, A2], A).
det(det, S, S,  _, Arb, Arb).

% -- VP -> V NP
v(C, S1, S, Nr, A1, A) :-
    parse(np, S1, S2, _, A2),
    vp(C, S2, S, Nr, [vp, A1, A2], A).
	
% -- VP -> V NP PP
v(C, S1, S, Nr, A1, A) :-
    parse(np, S1, S2, _, A2),
    parse(pp, S2, S3, _, A3),
    vp(C, S3, S, Nr, [vp, A1, A2, A3], A).
v(v, S, S,  _, Arb, Arb).

% -- PP -> P NP
p(C, S1, S, _, A1, A) :-
    parse(np, S1, S2, Nr, A2),
    pp(C, S2, S, Nr, [pp, A1, A2], A).
p(p, S, S,  _, Arb, Arb).

legatura(np, s).
legatura(det, np).
legatura(det, s).
legatura(v, vp).
legatura(p, pp).
legatura(X, X).

cuvant(det, [the | X], X, _).
cuvant(det, [all | X], X, plur).
cuvant(det, [every | X], X, sing).
cuvant(p, [near | X], X, _).
cuvant(conj, [and | X], X, _).
cuvant(n, [dog | X], X, sing).
cuvant(n, [dogs | X], X, plur).
cuvant(n, [cat | X], X, sing).
cuvant(n, [cats | X], X, plur).
cuvant(n, [elephant | X], X, sing).
cuvant(n, [elephants | X], X, plur).
cuvant(v, [chase | X], X, plur).
cuvant(v, [chases | X], X, sing).
cuvant(v, [see | X], X, plur).
cuvant(v, [sees | X], X, sing).
cuvant(v, [amuse | X], X, plur).
cuvant(v, [amuses | X], X, sing).

parse_s(S, Arbore) :- parse(s, S, [], _, Arbore).
