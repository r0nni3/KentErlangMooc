-module(shapes_bits).
-export([perimeter/1, area/1, enclose/1, bits/1]).


% Function cases to get Perimeter of a shape
perimeter({circle, {R}}) ->
    2*3.1415*R;
perimeter({triangle, {A, B, C}}) ->
    A + B + C;
perimeter({square, {L}}) ->
    perimeter({rectangle, {L, L}});
perimeter({rectangle, {B, H}}) ->
    2*(B+H);
perimeter(_Other) ->
    not_implemented_yet.


% Funcion to get area of a shape
area({triangle, {A, B, C}}) ->
    S = (A + B + C) / 2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area({square, {L}}) ->
    area({rectangle, {L,L}});
area({rectangle, {B, H}}) ->
    B * H;
area(_other) ->
    not_implemented_yet.


% Enclose only implemented for circle shape
enclose({circle, {R}}) ->
    L = 2 * R,
    {rectagle, {L, L}};
enclose(_other) ->
    not_implemented_yet.


% Count "on" bits for an integer
bits(N) ->
    bits(N, nearestBit(N), 0).

bits(N, {ok, _value, _bit}, Count) when N == 0 ->
    Count;
bits(N, {ok, Value, _Bit}, Count) when N > 0 ->
    bits(N-Value, nearestBit(N-Value), Count+1).

% Function that finds the "nearest" value corresponding a
% bit.
nearestBit(N) ->
    nearestBit(N, 1, 0).
nearestBit(N, Value, Bit) when Value < N ->
    nearestBit(N, math:pow(2,Bit+1), Bit+1);
nearestBit(N, Value, Bit) when Value == N ->
    {ok, Value, Bit};
nearestBit(N, Value, Bit) when Value > N ->
    {ok, math:pow(2, Bit-1), Bit-1}.
