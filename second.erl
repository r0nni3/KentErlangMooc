-module(second).
-export([hypotenuse/2,perimeter/2,area/2]).

hypotenuse(O,A) ->
    H2 = first:square(O) + first:square(A),
    math:sqrt(H2).

perimeter(O, A) ->
    H = hypotenuse(O, A),
    O + A + H.

area(O, A) ->
    H = hypotenuse(O, A),
    first:area(H, O, A).
