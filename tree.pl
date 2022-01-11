% part one
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).

% preorder((nil-[f(a,b)]+(nil-[21,22,23]+nil))-[root,1,2]+((nil-[a]+nil)-[child,4]+nil),L).


% part two
% not sure why it does not work 


preorder(Left-[SomeList]+Right, ValueList):-
    preorder_diff(Left-[SomeList]+Right, ValueList - []).

preorder_diff(Left-[SomeList]+Right, [SomeList|A-C]-[]):-
    preorder_diff(Left,A-B),
    preorder_diff(Right,B-C).
preorder_diff(nil,L-L).

