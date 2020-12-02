% Problem 5
% 5. Two integers, n and m are given. 
% Write a predicate to determine all possible sequences of numbers from 1 to n, 
% such that between any two numbers from consecutive positions, the absolute difference to be >= m.


% getSequences(n, i) = {
%   [], i = n + 1,
%   1. i + getSequences(n, i + 1), i <= n
%   2. getSequences(n, i + 1), i <= n
% }

% getSequences(N: number, I: number, R: list)
% getSequences(i, i, o) - non deterministic

getSequences(N, I, []) :- I =:= N + 1, !.
getSequences(N, I, [I|R]) :- 
    I =< N,
    NI is I + 1,
    getSequences(N, NI, R).
getSequences(N, I, R) :-
    I =< N,
    NI is I + 1,
    getSequences(N, NI, R).


% difference(a, b) = {
%   a - b, a > b,
%   b - a, otherwise
%}

% difference(A: Number, B: Number, C: Number)
% difference(i, i, o)

difference(A, B, C) :-
    A > B,
    C is A - B.
difference(A, B, C) :-
    A < B,
    C is B - A.


% check(l1...ln, m) = {
%   true, difference(l1, l2) >= m and n = 2
%   check(l2...ln, m), difference(l1, l2) >= m and n > 2
%   false, otherwise
% }

% check(L: List, M: Number)
% check(i, i)

check([H1, H2], M) :-
    difference(H1, H2, R),
    R >= M,
    !.

check([H1, H2 | T], M) :-
    difference(H1, H2, R),
    R >= M,
    check([H2 | T], M).

% solution(N: Number, M: Number, R: List)
% solution(i, i , o)

solution(N, M, R) :-
    getSequences(N, 1, R),
    check(R, M).

% allSolutions(N: Number, M: Number, R: List)
% allSolutions(i, i, o)

allSolutions(N, M, R) :-
    findall(R2, solution(N, M, R2), R),
    write(R).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% isIn(e, l1...ln) = {
%   true, e = l1,
%   false, n = 0,
%   isIn(e, l2...ln), otherwise
% }

% isIn(E: Number, L: List)
% isIn(i, i)
isIn(H, [H|T]) :- !.
isIn(E, [H|T]) :- 
    E =\= H,
    isIn(E, T).

% candidate(n) = 
%   1. n
%   2. candidate(n - 1), n > 1
% 

% candidate(N: Number, I: Number)
% candidate(i, o) - non deterministic

candidate(N, N).
candidate(N, I) :-
    N > 1,
    N1 is N - 1,
    candidate(N1, I).

% permutationAux(n, m, len, l1...ln) = {
%   l1...ln, len = n
%   permutationAux(n, m, len + 1, candidate(n) U l1...ln), abs(l1 - candidate(n)) >= m, candidate(n) not in l1...ln
%}

% permutationAux(N: Number, M: Number, Len: Number, L: List, R: List)
% permutationAux(i, i, i, i, o)

permutationAux(N, _, N, L, L) :- !.
permutationAux(N, M, Len, [H|T], L) :-
    candidate(N, I),
    abs(H - I) >= M,
    \+ isIn(I, [H|T]),
    Len1 is Len + 1,
    permutationAux(N, M, Len1, [I|[H|T]], L).

% permutation(n, m) = 
%   permutationAux(n, m, 1, [candidate(n)])
% 
% permutation(N: Number, M: Number, L: List)
% permutation(i, i, o)
permutation(N, M, L) :-
    candidate(N, I),
    permutationAux(N, M, 1, [I], L).


% allPermutations(n, m) = U permutation(n, m)
% allPermutations(N: Number, M: Number, R: List)
% allPermutations(i, i, o)
allPermutations(N, M, R) :-
    findall(R2, permutation(N, M, R2), R),
    write(R).



