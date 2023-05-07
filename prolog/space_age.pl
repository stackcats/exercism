space_age("Earth", AgeSec, Years) :-
    Years is AgeSec / 31557600.

space_age("Mercury", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 0.2408467.

space_age("Venus", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 0.61519726.

space_age("Mars", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 1.8808158.

space_age("Jupiter", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 11.862615.

space_age("Saturn", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 29.447498.

space_age("Uranus", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 84.016846.

space_age("Neptune", AgeSec, Years) :-
    space_age("Earth", AgeSec, Age),
    Years is Age / 164.79132.
