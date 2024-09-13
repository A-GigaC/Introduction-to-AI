/* 
 * List - sequence of elements in "[]" brackets
 * List has a head(s) and tail. [H|T] or [H1, H2 | T],
 * where tail T is a subsequence of length < list.length and can be eqto 0.
 * 
 * member(X, L). predicate shows how many times X includes in ;
 * memberchk(X, L). check that X includes in L at least 1 time ;
 */

% Custom member() realisation
mem(E, [E|_]).
mem(E, [_|Ls]) :- mem(E, Ls).

% Concatination of two lists 
% My face after I've realize that it works 🤯🤯🤯🤯🤯🤯🤯
cat([], L, L).
cat([H|L1], L2, [H|L]) :- cat(L1, L2, L).

% !! Reverse cat usage 🤯🤯🤯🤯🤯🤯🤯
% getting all month before may
%% L = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec], cat(BeforeMay,[may|_],L).

% Shift left
shift([X|Xs], S) :- cat(Xs, [X], S).


% Reverse list
rev(L, R) :- rev(L, [], R).

rev([], R, R).
rev([X|Xs], Buff, R) :- rev(Xs, [X|Buff], R).