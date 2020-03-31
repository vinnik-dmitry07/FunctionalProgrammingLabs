remove_duplicates([], []).
remove_duplicates([H | T], List) :-    
     member(H, T),
     remove_duplicates(T, List).
remove_duplicates([H | T], [H | T1]) :- 
      \+member(H, T),
      remove_duplicates(T, T1).

count([], _, 0).
count([X | T], X, Y):- !, count(T, X, Z), Y is 1 + Z.
count([_|T], X, Z):- count(T, X, Z).

get_entries([], _).
get_entries([H | T], L) :- count(L, H, R), write(H), write(" - "), write(R), write("; "), get_entries(T, L).

?- List = [5, 2, 3, 2], remove_duplicates(List, List1), sort(List1, List1Sorted), get_entries(List1Sorted, List).
