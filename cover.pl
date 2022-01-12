% exact cover problem
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


% my solution, unfinished

isCovered(I,[H|_],O):-
    member(I,H),
    O = H.
isCovered(I,[_|T],O):-
    isCovered(I,T,O).

residual(Is,Os,I,O,Res):-
    delete(I,O,I_free),
    delete(I,Is,I_remaining),
    subtract(I_remaining, I_free, Res).

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([H|T],R) :-
    my_flatten(H,HFlat),
    my_flatten(T,TFlat),
    append(HFlat,TFlat,R).

delete(A, [A|B], B).
delete(A, [B, C|D], [B|E]) :-
	    delete(A, [C|D], E).
