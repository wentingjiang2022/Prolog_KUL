%someone else's answer

%Exercise 4 
% (nil-[f(a,b)]+(nil-[21,22,23]+nil))-[root,1,2]+((nil-[a]+nil)-[child,4]+nil)
% No difference lists
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).

%With difference lists NOT DONE BECAUSE I DO NOT UNDERSTAND THEM
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).