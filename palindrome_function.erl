-module(palindrome_function).
-export([palindrome/1]).


palindrome([]) ->
    false;
palindrome(List) ->
    {O, S} = split_half(remove_punctuation(to_lower(List))),
    O == S.


to_lower(String) ->
    string:to_lower(String).

remove_punctuation([]) ->
    [];
remove_punctuation([H|T]) when H < 97 ->
    remove_punctuation(T);
remove_punctuation([H|T]) when H > 122 ->
    remove_punctuation(T);
remove_punctuation([H|T]) ->
    [H|remove_punctuation(T)].

split_half(String) ->
    Len = length(String) div 2,
    {One, _} = lists:split(Len, String),
    {Second, _} = lists:split(Len, reverse(String)),
    {One, Second}.

reverse(String) ->
    lists:reverse(String).
