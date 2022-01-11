% generate possible config

:-use_module(library(clpfd)).

search(L):-
    L = [D1,D2,D3,D4],
    D1 = [X1,X2], % #= means equal, not assign value!
    D2 = [X3,X4],
    D3 = [X5,X6],
    D4 = [X7,X8],
    D1 ins 0..6,
    D2 ins 0..6,
    D3 ins 0..6,
    D4 ins 0..6,
    sort_list_of_list(L, L_sorted),
    sort(L_sorted, L_unique),
    length(L_sorted, N1),
    length(L_unique, N2),
    N1 #= N2,
    X1 + X2 + X3 #= 3,
    X3 + X4 + X5 #= 3,
    X5 + X6 + X7 #= 3,
    X7 + X8 + X1 #= 3,
    % need to label each one separately.
    labeling([],D1), labeling([],D2), labeling([],D3), labeling([],D4).

sort_list_of_list([],[]).
sort_list_of_list([H|T],[H1|L3]):-
    sort(H,H1),
    sort_list_of_list(T,L3).


rotate_list([],[]).
rotate_list([H|T], L):-
    append(T,[H],L).
    
check_variant(L1,L2):-
    rotate_list(L1,L2).
check_variant(L1,L2):-
    rotate_list(L1,L3),
    check_variant(L3,L2).
    
 % does not work yet, find better way to remove the variants?
remove_variant(L, L3):-
    member(H1,L),
    member(H2,L),
    check_variant(H1,H2),
    delete(H2,L,L2),
    remove_variant(L2, L3).

delete(A, [A|B], B).
delete(A, [B, C|D], [B|E]) :-
    delete(A, [C|D], E).
    

get_all(Result):-
    findall(L, search(L), Bag),
    remove_variant(Bag, Result).
    
