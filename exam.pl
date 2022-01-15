% question 1

matching of lists,
finite domain

% question 2
does the predicate succeed, if yes, provide all the bindings

% question 3

left([H|_], H).
left([E|T], H):-
    E < H, 
    left(T, H).

count(L, N):-
    count_acc(L, L, 0, N).

count_acc([], _, N, N).
count_acc([H|T], L, Acc, N):-
    left(L, H),
    Acc1 is Acc + 1,
    count_acc(T, L, Acc1, N).
count_acc([H|T], L, Acc, N):-
    not(left(L, H)),
    count_acc(T, L, Acc, N).
    
% question 4 (question about a cycle of nodes)

:-use_module(library(clpfd)).

cycle(L):-
    length(L, N), 
    N #>= 3,
    check(L).

check(L):-
    last(L, E),
    append(L1, [E], L),
    all_different(L1),
    rotate(L1, L2),
    subtract(L1, L2, L3), 
    count(L3, 1).

rotate([],[]).
rotate([H|T], L):-
    append(T, [H], L).
        
subtract([], [], []).
subtract([H1|T1], [H2|T2], [H3|L1]):-
    H3 is H1 - H2,
    subtract(T1, T2, L1).

count([], 0).
count([H|T], N):-
    H > 0,
    count(T, N1),
    N is N1 + 1.

count([H|T], N):-
    H < 0,
    count(T, N).
    
% quesiton 5, couple problem


