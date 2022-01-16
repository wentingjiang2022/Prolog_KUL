% question 1 
matching in list, and a question about domain

% question 2 
does the predicate succeed, if yes, provide all the bindings

% question 3: a special property is defined for a kind of element in a list, that every elements before this one is smaller. Count such number of elements in list.
(don't remember the exact questions)

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
    
% question 4: question about a cycle of nodes, for a list of nodes [A,B,D,...A] which always ends with the same node and the rest of nodes being all different,
the pattern should hold that for every subsequent pair, the former node is smaller than than latter, except for one pair.

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
    
% quesiton 5, couple problem, a group of people going from down to top via elevators. need to satisfy the constraint that the couple has to be together if there is a another man. 
elevator always has to have a person inside, max number is 2.

%THE FOLLOWING ANSWER IS INCOMPLETE/INCORRECT

couple(j, m).
couple(x, y).
couple(d,z).
male(j).
male(x).
male(d).
female(m).
female(y).
female(z).

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

not_jealousy([_]).
not_jealousy(L):-
    all_female(L);
    all_male(L).

not_jealousy(L):-
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

transition(S1, S2, Move):-
    action(S1, S2, Move),
    valid_state(S2), valid_state(S1),
    valid_state(Move).

valid_state(S):-
    not(not_jealousy(S)).

action(S1,S2, Move):-
    go_up(S1, S2,Move);
    go_down(S1,S2,Move).

go_up((down, L1, L2), (top, L3,L4), Move):-
    length(Move, N),
    N >= 1, 
    N =< 2, 
    append(L3, Move, L1),
    append(L2, Move, L4), 
    append(L1, L2, [j, m,x, y, d,z]),
    append(L3, L4, [j, m,x, y, d,z]).

go_down((top, L1, L2), (down, L3,L4), Move):-
    length(Move, N),
    N >= 1, 
    N =< 2, 
    append(L1, Move, L3),
    append(L4, Move, L2),
    append(L1, L2, [j, m,x, y, d,z]),
    append(L3, L4, [j, m,x, y, d,z]).

solve((down,[j, m,x, y, d,z],[]), S2, Moves):-
    search((down,[j, m,x, y, d,z],[]), S2, [], Moves, []).

search(S1, S2, Acc, Moves, Old_states):-
    transition(S1, Temp, Move),
    not(member(Temp, Old_states)),
    search(Temp, S2, [Move|Acc], Moves, [Temp|Old_states]).    
    
search(S1, _, Moves, Moves,_):-
    S1 = (top,[],[j, m,x, y, d,z]).
