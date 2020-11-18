% a. Given a linear numerical list write a predicate to remove all sequences of consecutive values.
% Eg.: removeConsecutive([1, 2, 4, 6, 7, 8, 10], L) will produce L=[4, 10].

% Mathematical Model:
% removeConsecutive(l1...ln) = {
%           [], n = 1
%           [l1], n = 1
%           [], n = 2 and l2 = l1 + 1
%           l1 U removeConsecutive(l2...ln), l2 != l1 + 1
%           removeConsecutive(l3...ln), l2 = l1 + 1 and l3 != l2 + 1
%           removeConsecutive(l2...ln), l2 = l1 + 1 and l3 = l2 + 1
%}
% removeConsecutive(L:list, R:List)
% Flow model:
%   removeConsecutive(i, o)

removeConsecutive([], []).
removeConsecutive([H], [H]).
removeConsecutive([H1, H2], []) :- H2 =:= H1 + 1.
removeConsecutive([H, H2|T], [H|R]):-
    H2 =\= H + 1,
    removeConsecutive([H2|T], R).
removeConsecutive([H1, H2, H3|T], R):-
    H2 =:= H1 + 1,
    H3 =:= H2 + 1,
    removeConsecutive([H2, H3 |T], R).
removeConsecutive([H1, H2, H3|T], R):-
    H2 =:= H1 + 1,
    H3 =\= H2 + 1,
    removeConsecutive([H3|T], R).

% b. For a heterogeneous list, formed from integer numbers and list of numbers; write a predicate to delete from every sublist all sequences of consecutive values.
% Eg.: [1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7] =>
% [1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7]

% Mathematical model
% removeConsecutiveHeterogeneous(l1...ln) = {
%                   [], n = 0
%                   removeConsecutive(l1) U removeConsecutiveHeterogeneous(l2...ln), is_list(l1) = True
%                   l1 U removeConsecutiveHeterogeneous(l2...ln), otherwise
% }

% removeConsecutiveHeterogeneous(L:List, R:List)
% Flow model:
%   removeConsecutiveHeterogeneous(i, o).

removeConsecutiveHeterogeneous([], []).
removeConsecutiveHeterogeneous([H|T], [RRC|R]) :-
    is_list(H), !,
    removeConsecutive(H, RRC),
    removeConsecutiveHeterogeneous(T, R).
removeConsecutiveHeterogeneous([H|T], [H|R]):-
    removeConsecutiveHeterogeneous(T, R).


