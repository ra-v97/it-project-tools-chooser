:- dynamic
        zdefiniowane/2,
        zdefiniowane/3,
        wykluczone/2,
        nieznane/1.

/*
===== Jak dziala program =====
1. zaimportuj baze wiedzy do prologa ?- [it_technological_stack_knowledge_base].
2. uzyj predykatu inicjalizuj. - ustawienie poczatkowego stanu systemu.
3. określ wymagania korzystajac z nastepujacych predykatow;
    3.1 ?- definiuj(property, value). lub definiuj(property, value1, value2) - informujemy system, że pewna cecha ma być obecna w sugerowanym stosie technologicznym
    3.2 ?- redefiniuj(property, value). lub redefiniuj(property, value1, value2) - ustawiamy konkretną wartość dla wybranej cechy i czyscimy pozostałe wartosci dla tej cechy
    3.3 ?- wyklucz(property, value). - informujemy system, że kategorycznie nie chcemy, aby dana cecha była obecna w stosie technologicznym
    3.4 ?- wyczysc(C). - czyscimy całe wejście wprowadzone w odniesieniu do danej cechy
    3.5 kroki od 3.1-3.4 mogą być używane dowolną ilośc razy i w dowolnej kolejności
4. zapytaj system o proponowany stos technologiczny predykatem stos_technologiczny(S). Uzyj średnika, aby zobaczyć wszytskie rezultaty, może być ich wiele.

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

/*
===== Hypotheses =====
*/
stos_technologiczny(prosty_desktopowy) :-
    sugerowany_jezyk(python),
    sugerowana_metodyka_projektowa(lean).

stos_technologiczny(zlozony_desktopowy) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process).

stos_technologiczny(prototyp_mobilny) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(waterfall).

stos_technologiczny(system_mobilny) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process).

stos_technologiczny(zaawansowane_systemy_wbudowane) :-
    sugerowany_jezyk(c),
    sugerowana_metodyka_projektowa(scrum).

stos_technologiczny(podstawowe_systemy_wbudowane) :-
    sugerowany_jezyk(c),
    sugerowana_metodyka_projektowa(extream_programming).

stos_technologiczny(prototyp_webowy) :-
    sugerowany_jezyk(java_script),
    sugerowana_metodyka_projektowa(extream_programming).

stos_technologiczny(webowy) :-
    sugerowany_jezyk(java_script),
    sugerowana_metodyka_projektowa(scrum).

stos_technologiczny(zaawansowany_system_rozproszony) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process). 

stos_technologiczny(system_uczenia_maszynowego) :-
    sugerowany_jezyk(python),
    sugerowana_metodyka_projektowa(lean).

/*
===== Symptomes =====
*/
sugerowany_jezyk(java) :- 
    spelnia_wymagania_jezyka(java),
    uzytkownik_sredniozaawansowany.

sugerowany_jezyk(python) :- 
    spelnia_wymagania_jezyka(python),
    uzytkownik_poczatkujacy.

sugerowany_jezyk(java_script) :- 
    spelnia_wymagania_jezyka(java_script),
    uzytkownik_sredniozaawansowany.

sugerowany_jezyk(c) :- 
    spelnia_wymagania_jezyka(c),
    uzytkownik_zaawansowany.

sugerowana_metodyka_projektowa(scrum) :-
    (planowany_czas_prac(projekt_dlugoterminowy); planowany_czas_prac(projekt_dwuletni)),
    liczebnosc_zespolu(standardowy_zespol_projektowy),!.

sugerowana_metodyka_projektowa(lean) :-
    (liczebnosc_zespolu(standardowy_zespol_projektowy);
    liczebnosc_zespolu(maly_zespol_projektowy)),
    (planowany_czas_prac(projekt_roczny);
    planowany_czas_prac(projekt_dwuletni)),!.

sugerowana_metodyka_projektowa(iterative_process) :-
    liczebnosc_zespolu(duzy_zespol_projektowy),
    planowany_czas_prac(projekt_dlugoterminowy).

sugerowana_metodyka_projektowa(waterfall) :-
    planowany_czas_prac(projekt_szybki),
    liczebnosc_zespolu(mikro_zespol_projektowy),!.

sugerowana_metodyka_projektowa(extream_programming) :-
    (planowany_czas_prac(projekt_szybki) ; planowany_czas_prac(projekt_roczny)),
    liczebnosc_zespolu(maly_zespol_projektowy),!.
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

dopuszczenie_jezyka(J) :-
    (not(wykluczone(paradygmat,_)); (wykluczone(paradygmat, P), not(paradygmat(J, P)))),
    (not(wykluczone(typowanie,_)); (wykluczone(typowanie, T),(not(typowanie(J, T, _)), not(typowanie(J, _, T))))),
    (not(wykluczone(zastosowanie,_)); (wykluczone(zastosowanie, Z), not(zastosowanie(J, Z)))), !.

spelnia_wymagania_jezyka(J) :-
    dopuszczenie_jezyka(J),
    (nieznane(paradygmat); (zdefiniowane(paradygmat, P1), paradygmat(J, P1))),
    (nieznane(typowanie); (zdefiniowane(typowanie, T1, T2), typowanie(J, T1, T2))),
    (nieznane(zastosowanie) ; (zdefiniowane(zastosowanie, Z), zastosowanie(J, Z))), !.

inicjalizuj_sugerowanie_stan_jezyka :- 
    wyczysc(paradygmat),
    wyczysc(typowanie),
    wyczysc(zastosowanie).

uzytkownik_zaawansowany :-
    zdefiniowane(uzytkownik, zaawansowany),!.

uzytkownik_sredniozaawansowany :-
    (zdefiniowane(uzytkownik, sredniozaawansowany),!);
    uzytkownik_zaawansowany,!.

uzytkownik_poczatkujacy :-
    (zdefiniowane(uzytkownik, poczatkujacy),!);
    (uzytkownik_sredniozaawansowany,!);
    not(zdefiniowane(uzytkownik, _)),!.

liczebnosc_zespolu(duzy_zespol_projektowy) :- 
    zdefiniowane(liczba_czlonkow, N),
    integer(N),
    N > 15,!.

liczebnosc_zespolu(standardowy_zespol_projektowy) :- 
    (zdefiniowane(liczba_czlonkow, N), integer(N), N > 8);
    not(zdefiniowane(liczba_czlonkow, _)),!.

liczebnosc_zespolu(maly_zespol_projektowy)  :-
    zdefiniowane(liczba_czlonkow, N), integer(N), N > 3,!.

liczebnosc_zespolu(mikro_zespol_projektowy) :-
    zdefiniowane(liczba_czlonkow, _),!.

planowany_czas_prac(projekt_dlugoterminowy) :-
    zdefiniowane(miesiace_pracy, M), integer(M), M >= 24,!.

planowany_czas_prac(projekt_dwuletni) :-
    (zdefiniowane(miesiace_pracy, M), integer(M), M >= 12);
    not(zdefiniowane(miesiace_pracy, _)),!.

planowany_czas_prac(projekt_roczny) :-
    zdefiniowane(miesiace_pracy, M), integer(M), M >= 4,!.

planowany_czas_prac(projekt_szybki) :-
    zdefiniowane(miesiace_pracy, _).

definiuj(C, W) :-
    not(zdefiniowane(C,W)), 
    retractall(nieznane(C)),
    retractall(wykluczone(C, W)),
    assertz(zdefiniowane(C,W)),!.

redefiniuj(C, W) :- 
    zdefiniowane(C,_),
    retractall(zdefiniowane(C,_)),
    assertz(zdefiniowane(C,W)),!.

definiuj(C, W1, W2) :- 
    retractall(nieznane(C)),
    retractall(wykluczone(C, W1)),
    retractall(wykluczone(C, W2)),
    assertz(zdefiniowane(C, W1, W2)),!.

redefiniuj(C, W1, W2) :- 
    zdefiniowane(C,_, _),
    retractall(zdefiniowane(C,_, _)),
    assertz(zdefiniowane(C,W1, W2)),!.

wyklucz(C, W) :-
    retractall(zdefiniowane(C, W)),
    retractall(zdefiniowane(C, W, _)),
    retractall(zdefiniowane(C, _, W)),
    assertz(wykluczone(C, W)),!.

wyczysc(C) :-
    (retractall(zdefiniowane(C,_));
    retractall(zdefiniowane(C,_, _))),
    retractall(wykluczone(C, _)), 
    assertz(nieznane(C)), !.

inicjalizuj :- 
    inicjalizuj_sugerowanie_stan_jezyka.

/*
===== Helpers =====
*/
len([] , 0 ) :- !.
len([_|X], L) :- len(X,N), L is N+1.
