% my solution

copy(N,L,L3):-
    length(L1,N),
    append(L1,L2,L),
    L2 = [_|T],
    last(L1,E),
    append(L1,[E|T],L3).

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

iterative_deepening(InitialState,Trace):-
	natural(DepthLim),
        solve_depthlim(InitialState,DepthLim,Trace),
        write('Nb of steps: '), write(DepthLim), nl,!.

natural(1).
natural(N) :-
	natural(N1),
	N is N1+1.

solve_depthlim(InitialState,DepthLim,Trace) :- 
        search_depthlim(InitialState,DepthLim,[InitialState],Trace).

search_depthlim(CurrentState,_,Trace,Trace):-
        is_solution(CurrentState).

search_depthlim(CurrentState,StepsLeft,AccTrace,Trace):-
	StepsLeft>0,
        try_action(CurrentState,NewState),
        no_loop(NewState,AccTrace),
	NewStepsLeft is StepsLeft-1,
        search_depthlim(NewState,NewStepsLeft,[NewState|AccTrace],Trace).

no_loop(NewState,AccTrace) :-
        not(member(NewState,AccTrace)).

member(H,[H|_]).
member(H,[_|T]) :-
	member(H,T).
 
is_solution([a,a,c,c,d,d]).

try_action(L,L2):-
    length(L,N1),
    N2 is N1-1,
    numlist(1,N2,NumList),
    member(N, NumList),
    copy(N,L,L2);
    length(L,N1),
    numlist(1,N1,NumList),
    member(M1, NumList),
    member(M2, NumList),
    M1 < M2,
    swap(L,M1,M2,L2).



%someone's answer


%Exercise 5
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
%Returns the length of the list
lengthList([],Acc,Acc).
lengthList([_|T],Acc,Result):-
    Temp is Acc + 1,
    lengthList(T,Temp,Result).
%Copies the value of the index on the next one
copy(List,Index,Result):-
    lengthList(List,0,L),
    Index \= L,
    get(List,Index,Element),
    Set is Index + 1,
    set(List,Set,Element,Result).
copy(List,Index,Result):-
    lengthList(List,0,L),
    Index == L,
    get(List,Index,Element),
    set(List,1,Element,Result).
%Swaps the values of the specified indexes
swap(List,I,J,Result):-
    get(List,I,IElement),
    get(List,J,JElement),
    set(List,I,JElement,Temp),
    set(Temp,J,IElement,Result).
%Returns list with the numbers from 1 to N of the specified length (N)
numberedList(1,Acc,[1|Acc]).
numberedList(N,Acc,Result):-
    Temp is N-1,
    N \= 1,
    numberedList(Temp,[N|Acc],Result).
%Returns one instruction for the specified refisters
getInstruction(Registers,Instruction):-
    member(X,Registers),
    Instruction = c(X).
getInstruction(Registers,Instruction):-
    member(I,Registers),
    member(J,Registers),
    I < J,
    Instruction = s(I,J).
%Returns one instruction sequence of Length N for the specified registers
instructionSequence(RegisterNumbers,1,[Result]):-
    getInstruction(RegisterNumbers,Result).
instructionSequence(RegisterNumbers,N,Result):-
    N \= 1,
    Next is N-1,
    instructionSequence(RegisterNumbers,Next,Temp),
    getInstruction(RegisterNumbers,NewInst),
    Result = [NewInst|Temp].
%Returns all possible sequences of specified Length
allSequences(Registers,N,Result):-
    lengthList(Registers,0,L),
    numberedList(L,[],RegNum),
    findall(Seq,instructionSequence(RegNum,N,Seq),Result).
%Checks if two register lists are the same
equalRegisters([],[]).
equalRegisters([H|T1],[H|T2]):-
    equalRegisters(T1,T2).
%Checks if a squence reaches a solution
validSequence([],RegAcc,FinalReg):-
    equalRegisters(RegAcc,FinalReg).
validSequence([c(N)|T],RegAcc,FinalReg):-
    copy(RegAcc,N,NewReg),
    validSequence(T,NewReg,FinalReg).
validSequence([s(I,J)|T],RegAcc,FinalReg):-
    swap(RegAcc,I,J,NewReg),
    validSequence(T,NewReg,FinalReg).
%Given a set of sequences returns a valid one
checkValidity([H|_],Registers,FinalRegisters,H):-
    validSequence(H,Registers,FinalRegisters).
checkValidity([H|T],Registers,FinalRegisters,Result):-
    not(validSequence(H,Registers,FinalRegisters)),
    checkValidity(T,Registers,FinalRegisters,Result).
%Performs iterative deepening
iterativeDeepening(Depth,Registers,FinalRegisters,Result):-
    allSequences(Registers,Depth,PosSequences),
    checkValidity(PosSequences,Registers,FinalRegisters,Result).
iterativeDeepening(Depth,Registers,FinalRegisters,Result):-
    allSequences(Registers,Depth,PosSequences),
    not(checkValidity(PosSequences,Registers,FinalRegisters,_)),
    NewDepth is Depth+1,
    iterativeDeepening(NewDepth,Registers,FinalRegisters,Result).

