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

couple(J, M).
couple(X, Y).
couple(D,Z).

male(J).
male(X).
male(D).

female(M).
female(Y).
female(Z).

same_state(S1, S2):-
    S1 = (E1, E2, E3),
    S2 = (E4, E5, E6),
    E1 = E4,
    permutation(E2,E5),
    permutation(E3,E6).

permutation([],[]).

permutation(L, [X|T]):-
   select(X, L, L1),
   permutation(L1, T).

jealousy([E]).
jealousy(L):-
    all_female(L);
    all_male(L).

jealousy(L):-
    member(F, L),
    couple(M, F),
    member(M, L).

all_female([E]):-
    female(E).
all_female([H|T]):-
    female(H),
    all_female(T).

all_male([E]):-
    male(E).
all_male([H|T]):-
    male(H),
    all_male(T).

solve(S1, S2, Moves):-
    search(S1, 
           
search(S1, S2, Moves, Moves):-
    S = (   )
