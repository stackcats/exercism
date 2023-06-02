garden(Garden, Child, Plants) :-
    Children = [
	alice, bob, charlie, david, eve, fred, ginny, harriet, ileana, joseph, kincaid, larry
    ],
    split_string(Garden, "\n", "", Xs),
    maplist(string_chars, Xs, Ys),
    nth0(Ndx, Children, Child),
    PlantNdx is Ndx * 2,
    PlantNdx1 is PlantNdx + 1,
    nth0(0, Ys, Row0),
    nth0(1, Ys, Row1),
    nth0(PlantNdx, Row0, P0),
    nth0(PlantNdx, Row0, P1),
    nth0(PlantNdx, Row1, P2),
    nth0(PlantNdx1, Row1, P3),
    maplist(plant, [P0, P1, P2, P3], Plants).


plant('V', violets).
plant('R', radishes).
plant('G', grass).
plant('C', clover).
