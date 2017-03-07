-module(nub_function).
-export([nub/1]).


nub([]) ->
    [];
nub(List) ->
    nub(List, []).

nub([], Out) ->
    lists:reverse(Out);
nub([X|Xs], Out) ->
    case lists:member(X, Out) of
        false ->
            nub(Xs, [X|Out]);
        _ ->
            nub(Xs, Out)
    end.

