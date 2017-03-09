-module(index).
-export([get_file_contents/1,show_file_contents/1,main/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    lists:reverse(Rev).


% Auxiliary function for get_file_contents.
% Not exported.
get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.


% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.
show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
show_file_contents([]) ->
    ok.    



% ===============================================================
% Challenge implementation starts here
%
%     Example usage:
%         c(index).
%         index:main(index:get_file_contents("filename.txt")).
%
% ===============================================================
main(FileLines) ->
    alpha_sort(tokens(FileLines)).

% Tokens function separates lines into usable units.
% Each token is a group continous characters not including:
%     Whitespace: ' ', '\n', '\t'
%     Punctuation: '.', ';', ',', ':', '-'
tokens([]) ->
    [];
tokens(Lines) ->
    tokens(Lines, 1, []).

tokens([], _LineNumber, Tokens) ->
    Tokens;
tokens([[]|Rest], LineNumber, Tokens) ->
    tokens(Rest, LineNumber+1, Tokens);
tokens([Line|Rest], LineNumber, Tokens) ->
    tokens(Rest, LineNumber+1, words(Line, LineNumber, Tokens)).

% Get Words of a Line
words(Line, LineNumber, Words) ->
    words(Line, LineNumber, [], Words).

words([], _, [], Words) ->
    Words;
words([], LineNumber, Word, Words) ->
    add_word(Word, LineNumber, Words);
words([[]|Rest], LineNumber, Word, Words) ->
    words(Rest, LineNumber, [], add_word(Word, LineNumber, Words));
words([Char|Rest], LineNumber, Word, Words) ->
    case Char of
        C when  C >= $a andalso C =< $z ->
            words(Rest, LineNumber, [C|Word], Words);
        C when C >= $A andalso C =< $Z ->
            words(Rest, LineNumber, [C|Word], Words);
        32 ->
            words(Rest, LineNumber, [], add_word(Word, LineNumber, Words));
        _ ->
            words(Rest, LineNumber, [], add_word(Word, LineNumber, Words))
    end.


% -------------------------------------------------------
% Helper functions
% -------------------------------------------------------

% Adds a word to the word accumulator
add_word([], _, Words) ->
    Words;
add_word(Word, _, Words) when length(Word) < 3 ->
    Words;
add_word(Word, LineNumber, Words) ->
    TrueWord = word_to_lower(list_reverse(Word)),
    case key_find(TrueWord, Words) of
        {TrueWord, Lines} ->
            key_replace(TrueWord, Words, {TrueWord, add_line(LineNumber, Lines)});
        false ->
            Words++[{TrueWord,add_line(LineNumber,[])}]
    end.


% Adds a line to the range of lines tuple list
add_line(N, Ns) ->
    case find_range(N, Ns) of
        found -> Ns;
        not_found -> Ns++[{N,N}];
        {add, {S, F}} -> key_replace(S, Ns, {S, F+1})
    end.


% Looks up if the line number to add belongs to a range already existing
% or creates a new
find_range(_L, []) ->
    not_found;
find_range(L, [{S, F}|_R]) when L >= S andalso L =< F  ->
    found;
find_range(L, [{S, F}|_R]) when L >= S andalso L == F+1 ->
    {add, {S,F}};
find_range(L, [_|R]) ->
    find_range(L,R).


% Sorts the word list alphabeticaly
alpha_sort(L) ->
    lists:keysort(1, L).


% Reverse a list
list_reverse(L) ->
    lists:reverse(L).


% Find a Word in the Words list
key_find(Word, Words) ->
    lists:keyfind(Word, 1, Words).


% Updates an entry on a list of tuples by first value
key_replace(Key, TupleList, NewTuple) ->
    lists:keyreplace(Key, 1, TupleList, NewTuple).


% Normalizes capitalization of a word
word_to_lower(Word) ->
    string:to_lower(Word).
