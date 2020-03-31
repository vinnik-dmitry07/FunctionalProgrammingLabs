list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
    Min1 is min(L, Min0),
    list_min(Ls, Min1, Min).

index_of([Element|_], Element, 0).
index_of([_|Tail], Element, Index):-
  index_of(Tail, Element, Index1),
  Index is Index1+1.

?-List = [5, 2, 3, 2], list_min(List, Min), index_of(List, Min, MinIndex), write(MinIndex)
