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
