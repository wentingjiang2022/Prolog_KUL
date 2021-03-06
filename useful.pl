# Prolog_KUL

% all different

checkalldiff([_]).
checkalldiff([H|T]):-
    not(member(H, T)),
    checkalldiff(T).

% not 

not(P) :- P, !, fail ; true.

% permutation

permutation([],[]).

permutation(L, [X|T]):-
   select(X, L, L1),
   permutation(L1, T)

% iterative deepening

% to-do: element E occurs M times in List
exactly(_, [], 0).
exactly(E, [E|T], N):-
    exactly(E, T, N1),
    N is N1 + 1.

exactly(E, [H|T], N):-
    E \= H,
    exactly(E, T, N).


% find highest value

get_highest(L,Result):-
    get_highest_acc(L,0,Result).
    
get_highest_acc([],Result,Result).
get_highest_acc([H|T],Acc,Result):-
    H >= Acc,
    get_highest_acc(T,H,Result).

get_highest_acc([H|T],Acc,Result):-
    H < Acc,
    get_highest_acc(T,Acc,Result).

% prefix: excluding the situation where prefix is []

prefix([E],[E|_]).
prefix([H1|T1],[H1|T2]):-
    prefix(T1,T2).

% flatten a list
myflatten([],[]).
myflatten(X,[X]):-
    atomic(X), 
    X\= [].

myflatten([H1|T1], L):-
    myflatten(H1, New),
    myflatten(T1, New2),
    append(New, New2, L).

% odd,even

% swap the element
%Gets the value in specified index
get([H|_],1,H).
get([_|T],N,Result):-
    Temp is N-1,
    get(T,Temp,Result).
%Sets the specified value on specified index
set([_|T],1,Element,[Element|T]).
set([H|T],N,Element,Result):-
    Temp is N-1,
    set(T,Temp,Element,TempList),
    Result = [H|TempList].
swap(List,I,J,Result):-
    get(List,I,IElement),
    get(List,J,JElement),
    set(List,I,JElement,Temp),
    set(Temp,J,IElement,Result).

% subtract a list from another list

my_subtract(L, [], L).
my_subtract(L2, [H|T], L3):-
    select(H, L2, L4),
    my_subtract(L4, T, L3).

% generate a random sequence based on a list
generate([],0,_).
generate([H|T],N,L):- % L here has to be e.g. [1,2,3,4,5]
    select(H, L, L1),
    N1 is N-1,
    generate(T, N1,L1).
    
% sort

gt(X,Y):- X > Y.

merge([],L,L).
merge(L,[],L).
merge([H1|T1],[H2|T2],[H1|Res]):-
        gt(H2,H1), !,
        merge(T1,[H2|T2],Res).
merge([H1|T1],[H2|T2],[H2|Res]):-
        merge([H1|T1],T2,Res).
split([],[],[]).
split([A],[A],[]).
split([A,B|T],[A|S1],[B|S2]):-
        split(T,S1,S2).
mergesort([],[]).
mergesort([X],[X]).
mergesort([X,Y|T],S):-
        split([X,Y|T],L1,L2),
        mergesort(L1,S1),
        mergesort(L2,S2),
        merge(S1,S2,S).

% find sublist (not preserving the order). This one is quite tricky...
sublist( [X], XS ):-
    member(X, XS).
sublist( [X|XS], [X|XSS] ) :- sublist( XS, XSS ).
sublist( [X|XS], [_|XSS] ) :- sublist( [X|XS], XSS ).


% find sublist (preserving the order)

sublist(L1,L2):-
    prefix(L1,L2).
sublist(L1,[_|T]):-
    sublist(L1,T).

% remove duplicate (using accumulator)

remove_duplicate(L,L1):-
    remove_duplicate_acc(L,[],L1).
remove_duplicate_acc([],Result,Result).
remove_duplicate_acc([H|T],Acc,L1):-
    not(member(H,Acc)),
    remove_duplicate_acc(T,[H|Acc],L1).
remove_duplicate_acc([H|T],Acc,L1):-
    member(H,Acc),
    remove_duplicate_acc(T,Acc,L1).
    
% reverse (this one is a bit challenging to think through)

reverse(List, Reversed):-
        reverse_acc(List, Reversed, []). % the accumulater is initial empty
reverse_acc([], Result, Result). % Return the result (=the accumulated data)
reverse_acc([Head|Tail], Result, Acc):-
        reverse_acc(Tail, Result, [Head|Acc]).


% select

my_select(E,[E|T],T).
my_select(E,[H|T],[H|E3]):-
    my_select(E,T,E3).

% create integer list from 1 to N

create_integer_list(1,[1]):-!.
create_integer_list(N,L):-
    N1 is N-1,
    create_integer_list(N1,L1),
    append(L1,[N],L).

% member
my_member(H, [H|_]).
my_member(E,[_|T]):-
    my_member(E, T).

% nth element

nth_element(1,[H|_],H).
nth_element(N,[_|T],E):-
    N1 is N - 1,
    nth_element(N1,T,E).

% length
mylength([],0).
mylength([_|T],N):-
    mylength(T,N1),
    N is N1 + 1.

% append
my_append([],L,L).
my_append([H|T],L,[H|L2]):-
    my_append(T,L,L2).

% template for the search
solve(InitialState,Trace) :- 
        search(InitialState,[InitialState],Trace).

search(CurrentState,Trace,Trace):-
        is_solution(CurrentState).

search(CurrentState,AccTrace,Trace):-
        try_action(CurrentState,NewState),
        validate_state(NewState),
        no_loop(NewState,AccTrace),
        search(NewState,[NewState|AccTrace],Trace).

no_loop(NewState,AccTrace) :-
        not(member(NewState,AccTrace)).

is_solution(t(0,0,1)). % define a value solution

try_action(CurrentState,NewState):- 

validate_state(NewState):-


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
#=< less or equal
= match
<==> assign a function to a variable

