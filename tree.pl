preorder(nil, []).
preorder(L - M + R, L3):-
    preorder(L,L1),
    preorder(R,R1),
    append(L1,M,L2),
    append(L2,R1,L3).

%With difference lists NOT DONE BECAUSE I DO NOT UNDERSTAND THEM
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).
