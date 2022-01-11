% unfinished

item(ax,50,40).
item(book,50,50).
item(cookie,10,5).
item(laptop,99,60).

sumWeight([],0).
sumWeight([item(_,W1,_)|T],W):-
    sumWeight(T,W2),
    W is W2 + W1.

sumValue([],0).
sumValue([item(_,_,V1)|T],V):-
    sumValue(T,V2),
    V is V2 + V1.

solve(OriginalList,SumWeight,SumValue,List):-
    append(List0, List1, OriginalList),
    (List = List0; List = List1),
    List \= [],
    sumWeight(List, W),
    W < SumWeight,
    sumValue(List, V),
    V < SumValue. % need to remove duplicates
