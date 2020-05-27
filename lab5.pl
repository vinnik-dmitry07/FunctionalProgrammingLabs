:- dynamic known/3.

top_goal(X) :-
	bird(X).

order(tubenose) :-
	nostrils(external_tubular),
	live(at_sea),
	bill(hooked).
order(waterfowl) :-
	feet(webbed),
	bill(flat).
order(falconiforms) :-
	eats(meat),
	feet(curved_talons),
	bill(sharp_hooked).
order(passerformes) :-
	feet(one_long_backward_toe).

family(albatross) :-
	order(tubenose),
	size(large),
	wings(long_narrow).
family(swan) :-
	order(waterfowl),
	neck(long),
	color(white),
	flight(ponderous).
family(goose) :-
	order(waterfowl),
	size(plump),
	flight(powerful).
family(duck) :-
	order(waterfowl),
	feed(on_water_surface),
	flight(agile).
family(vulture) :-
	order(falconiforms),
	feed(scavange),
	wings(broad).
family(falcon) :-
	order(falconiforms),
	wings(long_pointed),
	head(large),
	tail(narrow_at_tip).
family(flycatcher) :-
	order(passerformes),
	bill(flat),
	eats(flying_insects).
family(swallow) :-
	order(passerformes),
	wings(long_pointed),
	tail(forked),
	bill(short).

bird(waved_albatross) :-
	family(albatross),
	color(white).
bird(wandering_albatross) :-
	family(albatross),
	color(dark).
bird(whistling_swan) :-
	family(swan),
	voice(muffled_musical_whistle).
bird(whooper_swan) :-
	family(swan),
	voice(loud_trumpeting).
bird(vishtines_goose) :-
	family(goose),
	season(winter),
	country(united_states),
	head(black), % patterns
	cheek(white).
bird(vishtines_goose) :-
	family(goose),
	season(summer),
	country(canada),
	head(black),
	cheek(white).
bird(venetian_goose) :-
	family(goose),
	color(white).
bird(vouille_duck) :-
	family(duck),
	voice(quack),
	head(green).
bird(vouille_duck) :-
	family(duck),
	voice(quack),
	color(mottled_brown).
bird(venetian_duck) :-
	family(duck),
	voice(short_whistle).
bird(vulture_king) :-
	family(vulture),
	flight_profile(v_shaped).
bird(vulture_griffon) :-
	family(vulture),
	flight_profile(flat).
bird(white_rumped_falcon) :-
	family(falcon),
	eats(insects).
bird(white_throated_falcon) :-
	family(falcon),
	eats(birds).
bird(variegated_flycatcher) :-
	family(flycatcher),
	tail(long_rusty).
bird(vermilion_flycatcher) :-
	family(flycatcher),
	throat(white).
bird(violet_swallow) :-
	family(swallow),
	tail(forked).
bird(white_eyed_swallow) :-
	family(swallow),
	tail(square).
bird(welcome_swallow) :-
	family(swallow),
	color(dark).

country(united_states) :-
	region(new_england).
country(united_states) :-
	region(south_east).
country(united_states) :-
	region(mid_west).
country(united_states) :-
	region(south_west).
country(united_states) :-
	region(north_west).
country(united_states) :-
	region(mid_atlantic).
country(canada) :-
	province(ontario).
country(canada) :-
	province(quebec).
country(canada) :-
	province(etc).

region(new_england) :-
	state(X),
	member(X, [massachusetts, vermont, etc]).
region(south_east) :-
	state(X),
	member(X, [florida, mississippi, etc]).
region(canada) :-
	province(X),
	member(X, [ontario, quebec, etc]).

nostrils(X) :-
	ask(nostrils, X).
live(X) :-
	ask(live, X).
bill(X) :-
	ask(bill, X).
size(X) :-
	menuask(size, X, [large, plump, medium, small]).
eats(X) :-
	ask(eats, X).
feet(X) :-
	ask(feet, X).
wings(X) :-
	ask(wings, X).
neck(X) :-
	ask(neck, X).
color(X) :-
	ask(color, X).
flight(X) :-
	menuask(flight, X, [ponderous, powerful, agile, flap_glide, other]).
feed(X) :-
	ask(feed, X).
head(X) :-
	ask(head, X).
tail(X) :-
	menuask(tail, X, [narrow_at_tip, forked, long_rusty, square, other]).
voice(X) :-
	ask(voice, X).
season(X) :-
	menuask(season, X, [winter, summer]).
cheek(X) :-
	ask(cheek, X).
flight_profile(X) :-
	menuask(flight_profile, X, [flat, v_shaped, other]).
throat(X) :-
	ask(throat, X).
state(X) :-
	menuask(state, X, [massachusetts, vermont, florida, mississippi, etc]).
province(X) :-
	menuask(province, X, [ontario, quebec, etc]).
multivalued(voice).
multivalued(color).
multivalued(eats). 

ask(A, V):-
	known(yes, A, V),
	!. % stop looking
ask(A, V):-
	known(_, A, V),
	!,
	fail.
ask(A, V):-
	write(A:V),
	write('? : '),
	read(Y),
	asserta(known(Y, A, V)),
	Y == yes. % succeed or fail 
ask(A, V):-
	\+ multivalued(A),
	known(yes, A, V2),
	V \== V2,
	!,
	fail.
menuask(A, V, MenuList) :-
	write('What is the value for '), write(A), write('?'), nl,
	write(MenuList), nl,
	read(X),
	check_val(X, A, V, MenuList),
	asserta( known(yes, A, X) ),
	X == V.
check_val(X, _, _, MenuList) :-
	member(X, MenuList),
	!.
check_val(X, A, V, MenuList) :-
	write(X), write(' is not a legal value, try again.'), nl,
	menuask(A, V, MenuList). 
