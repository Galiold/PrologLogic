% We describe this problem using a Houses list, which containts the 5 houses,
% and the order of them in this list matters. now we describe the houses in this
% list as the form of this functor:
%   resident(house_color, nationality, pet_kind, drink_name, cigarette_type)
% now by describing the clues we get from the question, we can describe this problem for prolog. 


house_order(Houses):-
    % There are 5 houses, so the length of the houses list should be 5.
    length(Houses, 5),
    % The English lives in the red house.
    member(resident(red, english, _, _, _), Houses),
    % The Spnaish owns a dog.
    member(resident(_, spanish, dog, _, _), Houses),
    % Coffee is drunken in the green house.
    member(resident(green, _, _, coffee, _), Houses),
    % The Ukrainian drinks tea.
    member(resident(_, ukrainian, _, tea, _), Houses),
    % % The green house is exactly at the right of the ivory house.
    rightNeighbor(resident(green, _, _, _, _), resident(ivory, _, _, _, _), Houses),
    % The person who smokes Golden cigarette, owns a snail.
    member(resident(_, _, snail, _, golden), Houses),
    % Cool cigarette is smoked at the yellow house.
    member(resident(yellow, _, _, _, cool), Houses),
    % Milk is drunken in the middle house.
    Houses = [_, _, resident(_, _, _, milk, _), _, _],
    % Norwegians live in the first house.
    Houses = [resident(_, norwegian, _, _, _) | _],
    % The person who smokes Chesterfield, lives near the house of the person who keeps a fox.
    near(resident(_, _, _, _, chesterfield), resident(_, _, fox, _, _), Houses),
    % Cool is smoked near the house in which horse is kept.
    near(resident(_, _, _, _, cool), resident(_, _, horse, _, _), Houses),
    % The person who smokes Lucky Strike drinks orange juice.
    member(resident(_, _, _, orangeJuice, luckyStrike), Houses),
    % Japanese smoke parliament.
    member(resident(_, japanese, _, _, parliament), Houses),
    % Norwegians live near the blue house.
    near(resident(_, norwegian, _, _, _), resident(blue, _, _, _, _), Houses),
    % There is somebody who drinks water.
    member(resident(_, _, _, water, _), Houses),
    % There is somebody who keeps zebra.
    member(resident(_, _, zebra, _, _), Houses).

% This functor checks if house Y is at the right of house X,
% using the append function it checks if [X, Y] is a sublist of the house list.
rightNeighbor(X, Y, HouseList):-
          append(_, [X, Y | _], HouseList).

% This functor checks if house Y is at the left of house X,
% using the append function it checks if [Y, X] is a sublist of the house list.
leftNeighbor(X, Y, HouseList):-
           append(_, [Y, X | _], HouseList).

% This functor returns true if X and Y are side by side of each other,
% may the house X be at the right of Y, or at the left of it.
near(X, Y, HouseList):-
    rightNeighbor(X, Y, HouseList);
    leftNeighbor(X, Y, HouseList).

zebraOwner(X):-
    house_order(Houses),
    member(resident(_, X, zebra, _, _), Houses).

waterDrinker(X):-
    house_order(Houses),
    member(resident(_, X, _, water, _), Houses).

/** <examples>
?- zebraOwner(A)
?- waterDrinker(A)
*/


