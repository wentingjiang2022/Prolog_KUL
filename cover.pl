% exact cover problem

% my answer
% is covered predicate

iscovered(I, Os, O):-
    member(O, Os),
    member(I, O).

% the residual predicate
% need to define subtract a list from another list

residual(A,O,L,Os,R,RO):-
    select(A, O, R1),
    select(A, L, R2),
    subtract(R2, R1, R),
    filter(Os, O, RO).

filter([], _, []).
filter([H|T], O, [H|L1]):-
    not(intersect(H,O)),
    filter(T, O, L1).

filter([H|T], O, L1):-
    intersect(H,O),
    filter(T, O, L1).

intersect(L1,L2):-
    member(H,L1),
    member(H,L2).

my_subtract(L, [], L).
my_subtract(L2, [H|T], L3):-
    select(H, L2, L4),
    my_subtract(L4, T, L3).

% search
findexactcovering(L, Os, Result):-
    search_acc(L, Os, [], Result),!. % need to add cut here, if no duplicated solution

search_acc([H|T], Os, Acc, Result):-
    		iscovered(H, Os, O),
           residual(H, O, [H|T], Os, R, RO),
           search_acc(R, RO, [O|Acc], Result).
           
search_acc([], _, Result, Result).

% check result: findexactcovering([1,2,3,4,5],[[1,2],[3,4],[5,6],[1,5]], Result).





% someone's answer


%exercise 5 [[c,e],[a,d,g],[b,c,f],[a,d,f],[b,g],[d,e,g]]
isCovered(I,[H|_],O):-
    m(I,H),
    O = H.
isCovered(I,[_|T],O):-
    isCovered(I,T,O).

residual(Is,Os,O,NIs,NOs):-
    removeItems(Is,O,NIs),
    removeOptions(Os,O,NOs).

removeOption([H|T],I,R):-
    m(I,H),
    removeOption(T,I,R).
removeOption([H|T],I,R):-
    not(m(I,H)),
    removeOption(T,I,Temp),
    R = [H|Temp].
removeOption([],_,[]).

removeOptions(Os,[H|T],R):-
    removeOption(Os,H,Temp),
    removeOptions(Temp,T,R).
removeOptions(Os,[],Os).

removeItems(Is,[],Is).
removeItems(Is,[H|T],R):-
    remove(H,Is,Temp),
    removeItems(Temp,T,R).

remove(I,[I|T],T).
remove(I,[H|T],R):-
    I \= H,
    remove(I,T,Temp),
    R = [H|Temp].

m(H,[H|_]).
m(E,[_|T]):-
    member(E,T).

findexactcovering([H|T],Os,Acc,Result):-
    isCovered(H,Os,O),
    residual([H|T],Os,O,NIs,NOs),
    findexactcovering(NIs,NOs,[O|Acc],Result).
findexactcovering([],_,Acc,Acc).

