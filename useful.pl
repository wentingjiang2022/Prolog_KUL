% find highest value

% remove duplicate

% reverse

% select

% member

% sort

% nth element

% length

% append

% prefix

% odd,even

% find subset of list
% implemented by someone last year
/* Without control on order */
sublist1([],_).
sublist1([H|T],List):-
    member1(H, List),
    sublist1(T, List).

member1(_, []) :- fail.
member1(X, [H|T]) :-
    H = X;
    H \= X,
    member1(X, T).

/* With control on order */
sublist2(S,L) :- 
    append1(_,L2,L),
    append1(S,_,L2).

append1([],X,X).
append1([H|T1], X, [H|T2]  ) :- append1(T1,X,T2).
