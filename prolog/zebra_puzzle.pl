zebra_owner(Owner) :- 
    solve(Houses), member(h(Owner,zebra,_,_,_), Houses).

water_drinker(Drinker) :- 
    solve(Houses), member(h(Drinker,_,_,water,_), Houses).

solve(Houses) :-
	length(Houses, 5),                                   
	member(h(english,_,_,_,red), Houses),                
	member(h(spanish,dog,_,_,_), Houses),                
	member(h(_,_,_,coffee,green), Houses),               
	member(h(ukrainian,_,_,tea,_), Houses),              
	next(h(_,_,_,_,green), h(_,_,_,_,ivory), Houses),    
	member(h(_,snail,old_gold,_,_), Houses),              
	member(h(_,_,kool,_,yellow), Houses),                
	Houses = [_,_,h(_,_,_,milk,_),_,_],                  
	Houses = [h(norwegian,_,_,_,_)|_],                   
	next(h(_,fox,_,_,_), h(_,_,chesterfield,_,_), Houses),
	next(h(_,_,kool,_,_), h(_,horse,_,_,_), Houses),     
	member(h(_,_,lucky,juice,_), Houses),                
	member(h(japanese,_,parliament,_,_), Houses),              
	next(h(norwegian,_,_,_,_), h(_,_,_,_,blue), Houses). 


next(A, B, Ls) :- append(_, [A,B|_], Ls).
next(A, B, Ls) :- append(_, [B,A|_], Ls).
