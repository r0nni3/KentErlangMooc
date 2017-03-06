-module(exercices).
-export([double/1, evens/1, median/1, modes/1]).


% =====================================================================
%
% Double elements of a list
%
double([_|_]=L) ->
    list_invert(double(L, [])).
double([], Doubled) ->
    Doubled;
double([Current|Rest], Doubled) ->
    double(Rest, [2*Current|Doubled]).


% =====================================================================
%
% Filters even elements of a list
%
evens([_|_]=L) ->
    list_invert(evens(L, [])).
evens([], Evens) ->
    Evens;
evens([Current|Rest], Evens) when Current rem 2 =/= 0 ->
    evens(Rest, Evens);
evens([Current|Rest], Evens) when Current rem 2 == 0 ->
    evens(Rest, [Current|Evens]).


% =====================================================================
%
% Gets the median of the list data set
%
median([_|_]=L) when length(L) rem 2 == 0 ->
    Pos = length(L) div 2,
    Sorted = list_sort(L),
    (get_position(Sorted ,Pos-1) + get_position(Sorted ,Pos)) / 2;
median([_|_]=L) when length(L) rem 2 =/= 0 ->
    Pos = length(L) div 2,
    Sorted = list_sort(L),
    get_position(Sorted, Pos).


% =====================================================================
%
% Gets a list of modes of the lis data set
%
modes(L) ->
    not_implemented.


% =====================================================================
%
% Helper functions
%

% Sorts list ascending
list_sort(List) ->
    lists:sort(List).

% Invert list order
list_invert([_|_]=List) ->
    lists:reverse(List).    

% Gets a value of a position
get_position([_|_]=List, Pos) ->
    lists:nth(Pos+1, List).
