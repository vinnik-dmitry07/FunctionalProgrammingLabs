get_peaks(List, Res) :- 
    append([-1.0Inf | List], [-1.0Inf], List1),
    get_peaks(List1, Res, 1).

get_peaks([_, _], [], _).
get_peaks([L1, L2, L3 | LS], [(L2, Pos)| R], Pos) :-
    L2>L1, L2>L3, 
    Pos1 is Pos + 1,
    get_peaks([L2, L3 | LS], R, Pos1), !.
get_peaks([_, L2, L3 | LS], R, Pos) :- 
    Pos1 is Pos + 1, 
    get_peaks([L2, L3 | LS], R, Pos1).

?- List=[5,4,2,8,3,1,6,9,5], get_peaks(List, Res), write(Res).
