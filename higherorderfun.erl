-module(higherorderfun).
-export([doubleAll/1,evens/1,product/1, zip/2, zip_with/3]).
-export([zip_with2/3, zip2/2]).

doubleAll(List) ->
    lists:map(fun (X) -> X*2 end, List).


evens(List) ->
    lists:filter(fun is_even/1, List).


product(List) ->
    lists:foldr(fun (E, Acc) -> E*Acc end, 1, List).


is_even(X) when X rem 2 == 0 ->
    true;
is_even(_X) ->
    false.


zip([], _) ->
    [];
zip(_, []) ->
    [];
zip([L|Ls], [R|Rs]) ->
    [{L,R}|zip(Ls, Rs)].

zip_with(_, [], _) ->
    [];
zip_with(_, _, []) ->
    [];
zip_with(Fun, [L|Ls], [R|Rs]) ->
    [Fun(L, R)|zip_with(Fun, Ls, Rs)].

zip_with2(Fun, Ls, Rs) ->
    lists:map(fun ({X, Y}) -> Fun(X,Y) end, zip(Ls, Rs)).

zip2(Ls, Rs) ->
    zip_with(fun (X, Y) -> {X, Y} end, Ls, Rs).
