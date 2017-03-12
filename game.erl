-module(game).
-export([result/2, tournament/2]).


beat(rock) -> paper;
beat(paper) -> scissors;
beat(scissors) -> rock;
beat(_) -> false.


lose(rock) -> scissors;
lose(scissors) -> paper;
lose(paper) -> rock;
lose(_) -> false.


result(A,A) -> draw;
result(C1, C2) ->
    case {beat(C1), lose(C1)} of
        {C, _} when C == C2 -> lose;
        {_, C} when C == C2-> win;
        _ -> nil
    end.


tournament(PLs, PRs) ->
    list_fold(list_map(tournament(PLs, PRs, []))).
tournament([], _, Rs) -> Rs;
tournament(_, [], Rs) -> Rs;
tournament([L|PLs], [R|PRs], Rs) ->
    tournament(PLs, PRs, [result(L, R)|Rs]).


list_fold(List) ->
    lists:foldr(fun sum/2, 0, List).

list_map(List) ->
    lists:map(fun result_to_value/1, List).


result_to_value(win) -> 1; 
result_to_value(lose) -> -1; 
result_to_value(draw) -> 0;
result_to_value(nil) -> nil.


sum(X,Y) -> X+Y.
