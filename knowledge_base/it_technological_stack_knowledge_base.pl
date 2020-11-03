:- dynamic
        zdefiniowane/2,
        zdefiniowane/3,
        nieznane/1.

/*
===== Hypotheses =====
*/

/*
===== Symptomes =====
*/
sugerowany_jezyk(java) :- 
    spelnia_wymagania_jezyka(java).

sugerowany_jezyk(python) :- 
    spelnia_wymagania_jezyka(python).

sugerowany_jezyk(java_script) :- 
    spelnia_wymagania_jezyka(java_script).

sugerowany_jezyk(c) :- 
    spelnia_wymagania_jezyka(c).

/*
===== Facts =====
*/
paradygmat(java, obiektowy).
paradygmat(python, obiektowy).
paradygmat(python, imperatywny).
paradygmat(java_script, obiektowy).
paradygmat(java_script, funkcyjny).
paradygmat(c, imperatywny).

typowanie(java, statyczne, silne).
typowanie(python, dynamiczne, silne).
typowanie(c, statyczne, slabe).
typowanie(java_script, dynamiczne, slabe).

zastosowanie(java, aplikacje_mobilne).
zastosowanie(java, aplikacje_webowe).
zastosowanie(java, system_rozproszone).
zastosowanie(java, aplikacje_desktopowe).
zastosowanie(python, prototypowanie).
zastosowanie(python, machine_learning).
zastosowanie(python, aplikacje_desktopowe).
zastosowanie(python, aplikacje_webowe).
zastosowanie(c, systemy_wbudowane).
zastosowanie(c, symulacje_komputerowe).
zastosowanie(java_script, aplikacje_webowe).

/*
===== Rules =====
*/
zastosowanie(J, ogolnego_przeznaczenia) :- findall(X, zastosowanie(J, X), Y), len(Y,N), N >=3, !.
% zastosowanie(J, ogolnego_przeznaczenia) :- aggregate_all(count, zastosowanie(J, _), N), N >=3.

spelnia_wymagania_jezyka(J) :-
    ((zdefiniowane(paradygmat, P), paradygmat(J, P)); nieznane(paradygmat)),
    ((zdefiniowane(typowanie, T1, T2), typowanie(J, T1, T2)); nieznane(typowanie)),
    ((zdefiniowane(zastosowanie, Z), zastosowanie(J, Z)); nieznane(zastosowanie)), !.

inicjlizuj_sugerowanie_stan_jezyka :- 
    retractall(zdefiniowane(paradygmat, _)),
    retractall(zdefiniowane(typowanie, _, _)),
    retractall(zdefiniowane(zastosowanie,_)),
    assertz(nieznane(paradygmat)),
    assertz(nieznane(typowanie)),
    assertz(nieznane(zastosowanie)).

definiuj(C, W) :- 
    retractall(nieznane(C)),
    assertz(zdefiniowane(C,W)).

definiuj(C, W1, W2) :- 
    retractall(nieznane(C)),
    assertz(zdefiniowane(C,W1,W2)).

inicjalizuj :- 
    inicjlizuj_sugerowanie_stan_jezyka.
/*
===== Helpers =====
*/
len([] , 0 ) :- !.
len([_|X], L) :- len(X,N), L is N+1.
