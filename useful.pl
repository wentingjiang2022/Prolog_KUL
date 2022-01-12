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


% operations

1). =:=.   arithmetically identical
1+3 =:= 2+2, true,
3 =:= 3, true (but does not make sense to use this one)

2). == identical
3 == 3, true
a == a, true
1+3 == 2+2, false

3). =\=. arithmetically not identical
1+3 =\= 2+2, false

4). \== not identical
a \== b, true

5). @< alphabetically or arithmetically smaller
a @< b, true
a @=< a, true

6). atom: constant, not including numbers
atom(a), true
atom(1), false

7). atomic: constant, including numbers and []
atomic(1), true
atomic(a), true
atomic([]), true

8). CLP
#= arithmetically equal
#\= arithemticlaly not equal
= match
<==> assign a function to a variable


