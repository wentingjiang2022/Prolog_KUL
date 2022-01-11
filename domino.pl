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
