:- use_module(library(clpfd)).

rotate_once([H|T], L):-
    append(T,[H],L).

rotate_twice(L, L2):-
    rotate_once(L,L1),
    rotate_once(L1,L2).

check_all([],[],[],_).
check_all([H1|T1],[H2|T2],[H3|T3],Sum):-
    Check #= H1 + H2 + H3,
    Check #=< Sum,
    check_all(T1,T2,T3,Sum).

clock_round(N,Sum,Xs):-
    length(Xs,N),
    Xs = [H|T],
    H #= 1, % constrain the first number being one will give unique solutions
    T ins 2..N,
    all_different(Xs),
    rotate_once(Xs,Xs2),
    rotate_twice(Xs, Xs3),
    check_all(Xs,Xs2, Xs3, Sum),
    labeling([],Xs).
