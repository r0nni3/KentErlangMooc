-module(functions_and_patterns).
-export([xorA/2, xorB/2, xorC/2,maxThree/3, howManyEqual/3]).

xorA (V,W) ->
    not(V) == W.

xorB (V, W) ->
    (V =/= W).

xorC (V, W) ->
    not(V == W).

maxThree (A,A,A) ->
    A;
maxThree (X,A,A) ->
    max(A,X);
maxThree (A,X,A) ->
    max(A,X);
maxThree (A,A,X) ->
    max(A,X);
maxThree (A,B,C) ->
    max(max(A,B),C).


howManyEqual (A,A,A) ->
    3;
howManyEqual (_,A,A) ->
    2;
howManyEqual (A,_,A) ->
    2;
howManyEqual (A,A,_) ->
    2;
howManyEqual (_,_,_) ->
    0.
