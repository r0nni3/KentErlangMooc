-module(tail_recursion).
-export([fib/1, perfect/1]).

fib(TargetPosition) ->
    PositionZeroValue = 0,
    PositionOneValue = 1,
    NextValue = PositionOneValue + PositionZeroValue,
    fib(TargetPosition, NextValue, PositionZeroValue).

fib(0, _NextValue, Value) ->
    Value;
fib(CurrentPosition, CurrentValue, PreviousValue) ->
    NextValue = CurrentValue+PreviousValue,
    fib(CurrentPosition-1, NextValue, CurrentValue).

%
% fib(4)
%
% fib(4, 1, 0)
% fib(3, 1+0, 1)
% fib(2, 1+1, 1)
% fib(1, 2+1, 2)
% fib(0, 3+2, 3)
%

perfect(N) ->
    perfect(N, 1, 0).

perfect(N, Divisor, Sum) when N == Sum ->
    true;
perfect(N, Divisor, Sum) when N < Sum ->
    false;
perfect(N, Divisor, Sum) when N rem Divisor == 0 ->
    perfect(N, Divisor+1, Sum+Divisor);
perfect(N, Divisor, Sum) when N rem Divisor =/= 0 ->
    perfect(N, Divisor+1, Sum).
