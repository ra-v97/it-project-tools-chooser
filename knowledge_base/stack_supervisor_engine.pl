:- use_module(it_technological_stack_knowledge_base).

:- dynamic
        zdefiniowane/2,
        zdefiniowane/3,
        wykluczone/2,
        nieznane/1.

/*
===== Jak dziala program =====
1. zaimportuj baze wiedzy do prologa ?- [stack_supervisor_engine].
2. uzyj predykatu inicjalizuj. - ustawienie poczatkowego stanu systemu.
3. określ wymagania korzystajac z nastepujacych predykatow;
    3.1 ?- definiuj(property, value). lub definiuj(property, value1, value2) - informujemy system, że pewna cecha ma być obecna w sugerowanym stosie technologicznym
    3.2 ?- redefiniuj(property, value). lub redefiniuj(property, value1, value2) - ustawiamy konkretną wartość dla wybranej cechy i czyscimy pozostałe wartosci dla tej cechy
    3.3 ?- wyklucz(property, value). - informujemy system, że kategorycznie nie chcemy, aby dana cecha była obecna w stosie technologicznym
    3.4 ?- wyczysc(C). - czyscimy całe wejście wprowadzone w odniesieniu do danej cechy
    3.5 kroki od 3.1-3.4 mogą być używane dowolną ilośc razy i w dowolnej kolejności
4. zapytaj system o proponowany stos technologiczny predykatem sugerowany_stos_technologiczny(S). Uzyj średnika, aby zobaczyć wszytskie rezultaty, może być ich wiele.

Aktualnie dostępne jest określanie cech dotyczących języka programowania i uzytkownika.
Mozna okreslic paradygmat, typowanie, zastosowanie. Po szczegóły i ilośc argumentów spójrz do bazy faktów.
Dla uzytkownika mozna okreslic poziom zaawansowania. 

przyklad okreslenia zastosowania
?- definiuj(typowanie, aplikacje_desktopowe).

przyklad okreslenia typowania
?- definiuj(typowanie, statyczne, silne).

przyklad wykluczenia  paradygmatu
?- wyklucz(paradygmat, obiektowy).

przykald definiowania poziomu uzytkownika - domyslny poziom to uzytkownik_poczatkujacy
?- definiuj(uzytkownik, uzytkownik_sredniozaawansowany).

*/

definiuj(C, W) :-
    not(zdefiniowane(C,W)), 
    retractall(nieznane(C)),
    retractall(wykluczone(C, W)),
    assertz(zdefiniowane(C,W)), !.

redefiniuj(C, W) :- 
    zdefiniowane(C,_),
    retractall(zdefiniowane(C,_)),
    assertz(zdefiniowane(C,W)), !.

definiuj(C, W1, W2) :- 
    retractall(nieznane(C)),
    retractall(wykluczone(C, W1)),
    retractall(wykluczone(C, W2)),
    assertz(zdefiniowane(C, W1, W2)), !.

redefiniuj(C, W1, W2) :- 
    zdefiniowane(C,_, _),
    retractall(zdefiniowane(C,_, _)),
    assertz(zdefiniowane(C,W1, W2)), !.

wyklucz(C, W) :-
    retractall(zdefiniowane(C, W)),
    retractall(zdefiniowane(C, W, _)),
    retractall(zdefiniowane(C, _, W)),
    assertz(wykluczone(C, W)), !.

wyczysc(C) :-
    (retractall(zdefiniowane(C,_));
    retractall(zdefiniowane(C,_, _))),
    retractall(wykluczone(C, _)), 
    assertz(nieznane(C)), !.

inicjalizuj :- 
    inicjalizuj_sugerowanie_jezyka.

inicjalizuj_sugerowanie_jezyka :- 
    wyczysc(paradygmat),
    wyczysc(typowanie),
    wyczysc(zastosowanie).