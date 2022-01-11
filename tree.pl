% part one
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).

% preorder((nil-[f(a,b)]+(nil-[21,22,23]+nil))-[root,1,2]+((nil-[a]+nil)-[child,4]+nil),L).


% part two: try to understand why this works, make a drawing.

preorder(Left-SomeList+Right, ValueList):-
    preorder_diff(Left-SomeList+Right, ValueList - []).

preorder_diff(Left-SomeList+Right, A - D):-
    preorder_diff(Left,A-B),
    preorder_diff(Right,C-D),
    B=[SomeList|C].
preorder_diff(nil,L-L).
