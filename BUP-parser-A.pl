% --BUP parser with extended grammar

parse(C, S1, S) :-
    cuvant(W, S1, S2),
	P =..[W, C, S2, S],
    call(P).

s(s, S, S).
vp(vp, S, S).
n(n, S, S).
pp(pp, S, S).
conj(conj, S, S).

% -- S -> NP VP
np(C, S1, S) :-
    parse(vp, S1, S2),
    s(C, S2, S).
	
% -- NP -> NP Conj NP
np(C, S1, S) :-
    parse(conj, S1, S2),
    parse(np, S2, S3),
    np(C, S3, S).
np(np, S, S).
	
% -- NP -> Det N
det(C, S1, S) :-
    parse(n, S1, S2),
    np(C, S2, S).
det(det, S, S).

% -- VP -> V NP
v(C, S1, S) :-
    parse(np, S1, S2),
    vp(C, S2, S).
	
% -- VP -> V NP PP
v(C, S1, S) :-
    parse(np, S1, S2),
    parse(pp, S2, S3),
    vp(C, S3, S).
v(v, S, S).

% -- PP -> P NP
p(C, S1, S) :-
    parse(np, S1, S2),
    pp(C, S2, S).
p(p, S, S).

cuvant(det, [the | X], X).
cuvant(det, [all | X], X).
cuvant(det, [every | X], X).
cuvant(p, [near | X], X).
cuvant(conj, [and | X], X).
cuvant(n, [dog | X], X).
cuvant(n, [dogs | X], X).
cuvant(n, [cat | X], X).
cuvant(n, [cats | X], X).
cuvant(n, [elephant | X], X).
cuvant(n, [elephants | X], X).
cuvant(v, [chase | X], X).
cuvant(v, [chases | X], X).
cuvant(v, [see | X], X).
cuvant(v, [sees | X], X).
cuvant(v, [amuse | X], X).
cuvant(v, [amuses | X], X).

parse_s(S) :- parse(s, S, []).
