% question 1

matching, 
domain of finite 

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
    
% question 4 (rotate a list such that there is only one node path which is larger, the others are smaller)

% quesiton 5, couple problem


