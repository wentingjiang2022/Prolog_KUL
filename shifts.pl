repeated([X, X | _]):-!.
repeated([_, Y | Rest]):-
    repeated([Y | Rest]).

count_shifts(X, L, Count):-
    count_shifts(X, L, 0, Count).
count_shifts(_, [], Count, Count).
count_shifts(X, [X | L], Accum, Count):-
    Accum1 is Accum + 1,
    count_shifts(X, L, Accum1, Count).
count_shifts(X, [Y | L], Accum, Count):-
    X \= Y,
    count_shifts(X, L, Accum, Count).

generate(0, _, []).
generate(N, Workers, [First | Rest]):-
    N > 0,
    member(First, Workers),
    N1 is N-1,
    generate(N1, Workers, Rest).


% Prolog facts
worker(danny, 3, 7).
worker(jef, 2, 2).
worker(ann, 2, 4).

possible(0, _, []).
possible(N, Workers, Shifts):-
    generate(N, Workers, Shifts),
    \+ repeated(Shifts),
    all_valid(Workers, Shifts).

all_valid([], _).
all_valid([First | Rest], Shifts):-
    valid_worker(First, Shifts),
    all_valid(Rest, Shifts).

valid_worker(Name, Shifts):-
    worker(Name, Min, Max),
    count_shifts(Name, Shifts, Count),
    Count =< Max,
    Count >= Min.

%Prolog terms
worker_terms(WorkerList):-
    WorkerList = [
        w(danny, 3, 7),
        w(jef, 2, 2),
        w(ann, 2, 4)
    ].

possible(_, 0, _, []).
possible(WorkerList, N, Workers, Shifts):-
    generate(N, Workers, Shifts),
    \+ repeated(Shifts),
    all_valid(WorkerList, Workers, Shifts).

all_valid(_, [], _).
all_valid(WorkerList, [First | Rest], Shifts):-
    valid_worker(WorkerList, First, Shifts),
    all_valid(WorkerList, Rest, Shifts).

valid_worker(WorkerList, Name, Shifts):-
    member(w(Name, Min, Max), WorkerList),
    count_shifts(Name, Shifts, Count),
    Count =< Max,
    Count >= Min.
