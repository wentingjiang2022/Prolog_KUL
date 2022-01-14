% someone's answer

beats(1, [2, 3, 4, 5, 6]).
beats(7, [1]).
beats(8, [1]).

all_different([]).
all_different([X | Rest]):-
    not((member(Y, Rest), X=Y)),
    all_different(Rest).

range(1, [1]).
range(N, [N | Rest]):-
    N > 0,
    N1 is N-1,
    range(N1, Rest).

all_members([], _).
all_members([X | Rest], Domain):-
    member(X, Domain),
    all_members(Rest, Domain).

player_sequence(N, Sequence):-
    length(Sequence, N),
    range(N, Domain),
    all_members(Sequence, Domain),
    all_different(Sequence).

onematch([], []).
onematch([X, Y | Rest], [Winner | Winners]):-
    singlematch([X, Y], Winner),
    onematch(Rest, Winners).

singlematch([X, Y], X):-
    beats(X, Losers),
    member(Y, Losers),
    !.
singlematch([X, Y], Y):-
    beats(Y, Losers),
    member(X, Losers),
    !.
singlematch([X, _], X).  % If no info provided first one wins

tournament([Winner], Winner).
tournament(Round, Winner):-
    onematch(Round, NextRound),
    tournament(NextRound,Winner).

numberwins(N, PlayerNumber, NumWins):-
    findall(Seq, (player_sequence(N, Seq), tournament(Seq, PlayerNumber)), Tournaments),
    length(Tournaments, NumWins).

% Faster version
good_tournament([Winner], Winner).
good_tournament(Round, Winner):-
    member(Winner, Round),
    onematch(Round, NextRound),
    good_tournament(NextRound,Winner).

numberwins_fast(N, PlayerNumber, NumWins):-
    findall(Seq, (player_sequence(N, Seq), good_tournament(Seq, PlayerNumber)), Tournaments),
    length(Tournaments, NumWins).
    


% someone's code from last year

/* Question1 
win(1,2).
win(1,3).
win(1,4).
win(1,5).
win(1,6).
win(7,1).
win(8,1). */

/* Question2 -> A list of length N */

/* Question3 */
wins(2,1).
wins(1,3).
wins(1,4).
wins(3,2).
wins(2,4).
wins(3,4).

onematch([],[]).
onematch([A,B|T],[A|Winner]):-
    wins(A,B),
    onematch(T,Winner).
onematch([A,B|T],[B|Winner]):-
    wins(B,A),
    onematch(T,Winner).

/* Question 4 */

tournament([X],X):-!.
tournament(Players,Winner):-
    onematch(Players,Winners),
    tournament(Winners,Winner).
