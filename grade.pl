%someone's answer

%Using facts
grade(danny,fai,20).
grade(danny,fai,20).
grade(toon,plmp,18).
grade(toon,fai,14).
grade(toon,uai,4).

%More examples for testing
grade(juan,plmp,2).
grade(pepe,plmp,20).
grade(pedro,plmp,17).

topscore(Class,Result):-
    findall((N,G),grade(N,Class,G),Grades),
    getHighest(Grades,0,0,Result).

getHighest([(Name,Grade)|T],MaxAcc,_,Result):-
    Grade >= MaxAcc,
    getHighest(T,Grade,Name,Result).
getHighest([(_,Grade)|T],MaxAcc,MaxName,Result):-
    Grade < MaxAcc,
    getHighest(T,MaxAcc,MaxName,Result).
getHighest([],_,MaxName,MaxName).

%Using Lists
%[(danny,fai,20),(danny,fai,20),(toon,plmp,18),(toon,fai,14),(toon,uai,4)]
%More examples for testing
%[(danny,fai,20),(danny,fai,20),(toon,plmp,18),(toon,fai,14),(toon,uai,4),(pepe,plmp,20),(pepe,plmp,20),(pedro,plmp,17)]
topscoreList(List,Class,Result):-
    getTopAcc(List,Class,0,0,Result).

getTopAcc([(Name,C,Grade)|T],Class,MaxAcc,_,Result):-
    Grade >= MaxAcc,
    C = Class,
    getTopAcc(T,Class,Grade,Name,Result).
getTopAcc([(_,C,Grade)|T],Class,MaxAcc,NameAcc,Result):-
    Grade < MaxAcc,
    C = Class,
    getTopAcc(T,Class,MaxAcc,NameAcc,Result).
getTopAcc([(_,C,_)|T],Class,MaxAcc,NameAcc,Result):-
    C \= Class,
    getTopAcc(T,Class,MaxAcc,NameAcc,Result).
getTopAcc([],_,_,NameAcc,NameAcc).
