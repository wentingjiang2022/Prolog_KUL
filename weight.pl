% a more understandable solution by me


   
% part one

item(ax,50,40).
item(book,50,50).
item(cookie,10,5).
item(laptop,99,60).

% [item(ax,50,40), item(book,50,50), item(cookie,10,5), item(laptop,99,60)]

find(Bag, W, V, Result):-
    findall(Subsets,sublist(Subsets,Bag), All),
    filter([], All, Result, W, V).

filter(Result, [], Result, _, _).
filter(Acc, All, Result, W, V):-
    All = [H|T],
    get_total_weight(H,W1),
    get_total_value(H,V1),
    W1 < W,
    V1 > V,
    filter([H|Acc], T, Result, W, V).

filter(Acc, All, Result, W, V):-
    All = [H|T],
    get_total_weight(H,W1),
    get_total_value(H,_),
    W1 >= W,
    filter(Acc, T, Result, W, V).

filter(Acc, All, Result, W, V):-
    All = [H|T],
    get_total_weight(H,_),
    get_total_value(H,V1),
    V1 =< V,
    filter(Acc, T, Result, W, V).
    
get_total_weight([],0).
get_total_weight(Bag,W):-
    Bag = [item(_,W1,_)|T],
    get_total_weight(T, W2),
    W is W1 + W2.

get_total_value([],0).
get_total_value(Bag,V):-
    Bag = [item(_,_,V1)|T],
    get_total_weight(T, V2),
    V is V1 + V2.

sublist( [X], XS ):-
    member(X, XS).
sublist( [X|XS], [X|XSS] ) :- sublist( XS, XSS ).
sublist( [X|XS], [_|XSS] ) :- sublist( [X|XS], XSS ).



% other's idea
% part one

item(ax,50,40).
item(book,50,50).
item(cookie,10,5).
item(laptop,99,60).

find_set(Acc,AccW,AccV,W,V,Result):-
    AccW < W,
    AccV > V,
    Result = Acc.
find_set(Acc,AccW,AccV,W,V,Result):-
    item(Name,ItemW,ItemV),
    NewW is AccW + ItemW,
    NewV is AccV + ItemV,
    not(member(Name,Acc)),
    find_set([Name|Acc],NewW,NewV,W,V,Result).

% part two

highest(Result):-
    findall(L,find_set([],0,0,90,40,L),R),
    find_highest(R,Result).

sumValue([],0).
sumValue([H|T],V3):-
    item(H,_,V),
    sumValue(T,V2),
    V3 is V + V2.

find_highest(L,List):-
    find_highest_acc(L,[],0,List).
find_highest_acc([],List,_,List).
find_highest_acc([H|T],_,HighestValue,List):-
    sumValue(H,V),
    V > HighestValue,
    find_highest_acc(T,H,V,List).

find_highest_acc([H|T],Acc,HighestValue,List):-
    sumValue(H,V),
    V =< HighestValue,
    find_highest_acc(T,Acc,HighestValue,List).
