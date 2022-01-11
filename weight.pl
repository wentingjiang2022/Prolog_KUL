% part one
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

% need to remove duplicates
solve(OriginalList,SumWeight,SumValue,List):-
    append(List0, List1, OriginalList),
    (List = List0; List = List1),
    List \= [],
    sumWeight(List, W),
    W < SumWeight,
    sumValue(List, V),
    V < SumValue. 


% OriginalList --> [item(ax,50,40), item(book,50,50),item(cookie,10,5),item(laptop,99,60)]


% part two
find_highest(Bag,List):-
    find_highest_acc(Bag,[],0,List).

find_highest_acc([],List,_,List).
find_highest_acc(Bag,Acc,HighestValue,List):-
    Bag = [H|T],
    sumValue(H,V),
    V > HighestValue,
    Acc is H,
    find_highest_acc(T,Acc,V,List).
    
    
% find highest

solve_two(OriginalList,SumWeight,SumValue,Highest):-
    findall(List,solve(OriginalList,SumWeight,SumValue,List),Bag),
    remove_duplicates(Bag,Bag2),
    find_highest(Bag2,Highest).

remove_duplicates([],[]).
remove_duplicates([H | T], List) :-    
     member(H, T),
     remove_duplicates( T, List).
remove_duplicates([H | T], [H|T1]) :- 
      \+member(H, T),
      remove_duplicates( T, T1).
%[item(ax,50,40), item(book,50,50),item(cookie,10,5),item(laptop,99,60)]

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

% query: solve_two([item(ax,50,40), item(book,50,50),item(cookie,10,5),item(laptop,99,60)], 300,200, Highest).
