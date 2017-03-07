-module(take).
-export([take/2]).


take(0, _List) ->
    [];
take(_N, []) ->
    [];
take(N, List) when N >= erlang:length(List) ->
    List;
take(N, [Head|Tail]) when N > 0 ->
    [Head|take(N-1,Tail)].

