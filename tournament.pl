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
