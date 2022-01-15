:-use_module(library(clpfd)).

singers:-
    FN = [C, JP, L, P, V],
    LN = [K, R1, R2, U, W],
    Voices = [S, M, T1, T2, B], 
    FN ins 1..5,
    LN ins 1..5,
    Voices ins 1..5,
    all_different(FN),
    all_different(LN),
    all_different(Voices),
    
    P + B #= 3,
    
    %check
    T1 #= 2 #<==> B1,
    T2 #= 3 #<==> B2,
    B1 + B2 #>= 1,
    
    R1 #\= 5, R2 #\= 5,
    
    % check
    (   K #= M #/\ (T1 #= 5 #\/ T2 #= 5)) #<==> C1,
    (   M #= 5 #/\ (T1 #= K #\/ T2 #= K)) #<==> C2,
    C1 + C2 #= 1,
    
    R1 #= 3 #\/ R2 #= 3,
    C #\= 3, C#\= W,
    U #\= B, U #\= M,
    L #\= T1, L #\= T2,
    V #\= T1, V #\= T2, V #\=3,
    JP #\= 3, C #\= 5,
    B #\= R1, B #\= R2,
    labeling([],FN), labeling([], LN), labeling([], Voices),
    write(result(FN, LN, Voices)), nl.
