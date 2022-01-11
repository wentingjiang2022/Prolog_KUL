
%Exercise 5 I think this exercise is not complete another page migth be missing
% Use a list for the tour
distance(heverlee,leuven-city-center,10).
distance(leuven-station,leuven-city-center,8).
distance(a,b,2).
distance(c,b,4).

stop(heverlee,4).
stop(leuven-station,10).
stop(leuven-city-center,10).
stop(a,1).
stop(c,1).

% [leuven-station,leuven-city-center,heverlee]
costBus(Tour,Result):-
    costBusAcc(Tour,0,Result).

costBusAcc([_],Acc,Acc).
costBusAcc([S1,S2|T],Acc,Result):-
    distance(S1,S2,Dist),
    Temp is Acc + Dist,
    costBusAcc([S2|T],Temp,Result).
costBusAcc([S1,S2|T],Acc,Result):-
    distance(S2,S1,Dist),
    Temp is Acc + Dist,
    costBusAcc([S2|T],Temp,Result).
