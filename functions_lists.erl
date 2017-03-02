-module(functions_lists).
-export([product/1, productTail/1, maximum/1, maximumTail/1]).

%==============================================================
%
% Direct Recursion Product
%
% Note: For the product, the base case is 1 because this is
%       the neutral operator for the multiplication operation.
%
product([]) -> 1;
product([Head|Tail]) -> Head * product(Tail).


%
% Tail Recursion Product
%
% Note: Implemented this way instead of using guards
%
productTail([Head|Tail]) -> product([Head|Tail], 1).
product([], Product) -> Product;
product([Head|Tail], Product) -> product(Tail, Head*Product).



% =============================================================
%
% Direct Recursion Maximum
%
maximum([Last|[]]) -> Last;
maximum([First,Second|Tail]) -> maximum([max(First, Second)|Tail]).


%
% Tail Recursion Maximum
%
% Assumption: The Frist value is the Maximum on first call.
%
maximumTail([Head|Tail]) -> maximum(Tail, Head).
maximum([Last|[]], Max) -> max(Last, Max);
maximum([Head|Tail], Max) -> maximum(Tail, max(Max, Head)).
 
