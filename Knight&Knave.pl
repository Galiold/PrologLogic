:- discontiguous ~ / 1.

% KB
isKnight(knight).
isSoldier(soldier).
~(isKnight(soldier)).
~(isSoldier(knight)).


% Rules
says_truth(X):- isKnight(X).
lies(X):- isSoldier(X).


% A says: "Either I am a soldier, or B is a knight."
% The statement here should be implemented as an XOR predicate.
% In order to implement XOR, we can use 2 ANDs and combine them with OR.
% The following terms are statements that are true according to what A says, so
% they can only be said by the knight.
statement1(X, Y):-
    isSoldier(X),  ~(isKnight(Y)).
statement1(X, Y):-
    ~(isSoldier(X)), isKnight(Y).

% The followings are statements that evaluate false according to what A says, so
% they can only be said by the soldier.
~(statement1(X, Y)) :-
    isSoldier(X), isKnight(Y).
~(statement1(X, Y)):-
    isKnight(X), isSoldier(Y).

% The solution is true if the statement evaluates true and the speaker is the knight,
% or if the statement is false, and the speaker is the soldier. 
solution1(X, Y):-
    statement1(X, Y),
    says_truth(X).
solution1(X, Y):-
    ~(statement1(X, Y)),
    lies(X).

% A says: "I am a solider, but B is not."
% This can be stated as an AND expression.
% The following evaluates true according to what A says, so it should be said by the knight.
statement2(X, Y):-
    isSoldier(X), ~(isSoldier(Y)).

% The following evaluates false according to what B says, so it should be said by the soldier.
~(statement2(X, Y)):-
    ~(isSoldier(X)); isSoldier(Y).

% The solution is true if the statement evaluates true and the speaker is the knight,
% or if the statement is false, and the speaker is the soldier.
solution2(X, Y) :-
    statement2(X, Y),
	says_truth(X).
solution2(X, Y) :-
    ~(statement2(X, Y)),
    lies(X).


% A says: "At least one of us is a soldier."
% There are 3 situations in which this statement evaluates true,
% These statements are as follows: 
statement3(X, Y) :-
    isSoldier(X), ~(isSoldier(Y)).
statement3(X, Y) :-
    ~(isSoldier(X)), isSoldier(Y).
statement3(X, Y) :-
    isSoldier(X), isSoldier(Y).

% There is one condition in which what A says is not true:
~(statement3(X, Y)):-
    isKnight(X), isKnight(Y).

% The solution is true if the statement evaluates true and the speaker is the knight,
% or if the statement is false, and the speaker is the soldier.
solution3(X, Y) :-
    statement3(X, Y),
	says_truth(X).
solution3(X, Y) :-
    ~(statement3(X, Y)),
    lies(X).

/** <examples>
?- solution1(A, B)
?- solution2(A, B)
?- solution3(A, B)
*/
