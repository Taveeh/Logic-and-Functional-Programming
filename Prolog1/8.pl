
% Problem 8
% a. Write a predicate to determine if a list has even numbers of elements without counting the elements from the list.

% evenList(l1...ln) = 
%	true, n = 0
%	false, n = 1
%	evenList(l3...ln), otherwise

evenList([]).
evenList([_, _|T]) :- evenList(T).

% b. Write a predicate to delete first occurrence of the minimum number from a list.
%

% minNumbers(a, b) = 
% 	a, a <= b
% 	b, a > b

% minNumbers(A: number, B: number, R: number)
% minNumbers(i, i, o)

minNumbers(A, B, A) :- A =< B.
minNumbers(A, B, B) :- A > B.

% minList(l1...ln) = 
% 	l1, n = 1
% 	minNumbers(l1, minList(l2...ln)), otherwise

% minList(L: list, R: number)
% minList(i, o)

minList([H], H):- !.
minList([H|T], R) :-
	minList(T, R1),
	minNumbers(H, R1, R).

% deleteFirstOccurence(l1...ln, m) =
%	[], n = 0
% 	l2...ln, l1 = m
% 	l1 + deleteFirstOccurence(l2...ln, m), otherwise

% deleteFirstOccurence(L: list, M: number, R: list)
% deleteFirstOccurence(i, i, o)

deleteFirstOccurence([], _, []) :- !.
deleteFirstOccurence([H|T], H, T) :- !.
deleteFirstOccurence([H|T], M, [H|R]) :- deleteFirstOccurence(T, M, R).

% deleteFirstMin(L: list, R: list)
% deleteFirstMin(i, o)


deleteFirstMin(L, R) :-
	minList(L, RM),
	deleteFirstOccurence(L, RM, R).

