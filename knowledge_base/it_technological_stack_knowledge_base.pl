:- module(it_technological_stack_knowledge_base,
  [
    sugerowany_stos_technologiczny/1,
    sugerowany_jezyk/1,
    sugerowana_metodyka_projektowa/1,
    zdefiniowane/2,
    zdefiniowane/3,
    wykluczone/2,
    nieznane/1
  ]).

:- use_module(basic_facts).

:- dynamic
        zdefiniowane/2,
        zdefiniowane/3,
        wykluczone/2,
        nieznane/1.

/*
===== Hypotheses =====
*/
sugerowany_stos_technologiczny(prosty_desktopowy) :-
    sugerowany_jezyk(python),
    sugerowana_metodyka_projektowa(lean).

sugerowany_stos_technologiczny(zlozony_desktopowy) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process).

sugerowany_stos_technologiczny(prototyp_mobilny) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(waterfall).

sugerowany_stos_technologiczny(system_mobilny) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process).

sugerowany_stos_technologiczny(zaawansowane_systemy_wbudowane) :-
    sugerowany_jezyk(c),
    sugerowana_metodyka_projektowa(scrum).

sugerowany_stos_technologiczny(podstawowe_systemy_wbudowane) :-
    sugerowany_jezyk(c),
    sugerowana_metodyka_projektowa(extream_programming).

sugerowany_stos_technologiczny(prototyp_webowy) :-
    sugerowany_jezyk(java_script),
    sugerowana_metodyka_projektowa(extream_programming).

sugerowany_stos_technologiczny(webowy) :-
    sugerowany_jezyk(java_script),
    sugerowana_metodyka_projektowa(scrum).

sugerowany_stos_technologiczny(zaawansowany_system_rozproszony) :-
    sugerowany_jezyk(java),
    sugerowana_metodyka_projektowa(iterative_process). 

sugerowany_stos_technologiczny(system_uczenia_maszynowego) :-
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
    planowany_czas_prac(projekt_dwuletni),
    liczebnosc_zespolu(standardowy_zespol_projektowy),!.

sugerowana_metodyka_projektowa(scrum) :-
    planowany_czas_prac(projekt_dlugoterminowy),
    liczebnosc_zespolu(standardowy_zespol_projektowy).

sugerowana_metodyka_projektowa(lean) :-
    liczebnosc_zespolu(standardowy_zespol_projektowy),
    planowany_czas_prac(projekt_roczny),!.

sugerowana_metodyka_projektowa(lean) :-
    liczebnosc_zespolu(standardowy_zespol_projektowy),
    planowany_czas_prac(projekt_dwuletni), !.

sugerowana_metodyka_projektowa(lean) :-
    liczebnosc_zespolu(maly_zespol_projektowy),
    planowany_czas_prac(projekt_roczny), !.

sugerowana_metodyka_projektowa(lean) :-
    liczebnosc_zespolu(maly_zespol_projektowy),
    planowany_czas_prac(projekt_dwuletni).

sugerowana_metodyka_projektowa(iterative_process) :-
    liczebnosc_zespolu(duzy_zespol_projektowy),
    planowany_czas_prac(projekt_dlugoterminowy).

sugerowana_metodyka_projektowa(waterfall) :-
    planowany_czas_prac(projekt_szybki),
    liczebnosc_zespolu(mikro_zespol_projektowy).

sugerowana_metodyka_projektowa(extream_programming) :-
    planowany_czas_prac(projekt_roczny),
    liczebnosc_zespolu(maly_zespol_projektowy),!.

sugerowana_metodyka_projektowa(extream_programming) :-
    planowany_czas_prac(projekt_szybki),
    liczebnosc_zespolu(maly_zespol_projektowy).

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
zastosowanie(J, ogolnego_przeznaczenia) :- aggregate_all(count, zastosowanie(J, _), N), 
    minimalna_liczba_zastosowan_dla_ogolnego_przenznaczenia(M),
    N >=  M, !.

/*
===== Magic  numbers =====
*/
minimalna_liczba_zastosowan_dla_ogolnego_przenznaczenia(3).

minimalny_czas_projektu_dlugoterminowego(24).
minimalny_czas_projektu_dwuletniego(12).
minimalny_czas_projektu_rocznego(4).

minimalna_liczba_czlonkow_duzego_zespolu(15).
minimalna_liczba_czlonkow_standardowego_zespolu(8).
minimalna_liczba_czlonkow_malego_zespolu(3).

/*
===== Rules =====
*/
dopuszczenie_jezyka(J) :-
    dopuszczenie_jezyka_paradygmat(J),
    dopuszczenie_jezyka_typowanie(J),
    dopuszczenie_jezyka_zastosowanie(J).

dopuszczenie_jezyka_paradygmat(_) :-
    not(wykluczone(paradygmat,_)), !.

dopuszczenie_jezyka_paradygmat(J) :-
    paradygmat_jezyka_programowania(P),
    wykluczone(paradygmat, P), 
    not(paradygmat(J, P)).

dopuszczenie_jezyka_typowanie(_) :-
    not(wykluczone(typowanie,_)), !.

dopuszczenie_jezyka_typowanie(J) :-
    rodzaj_typowania_jezyka(T),
    wykluczone(typowanie, T), 
    not(typowanie(J, T, _)), 
    not(typowanie(J, _, T)).

dopuszczenie_jezyka_zastosowanie(_) :-
    not(wykluczone(zastosowanie,_)), !.

dopuszczenie_jezyka_zastosowanie(J) :-
    zastosowanie_jezyka_programowania(Z),
    wykluczone(zastosowanie, Z), 
    not(zastosowanie(J, Z)).

spelnia_wymagania_jezyka(J) :-
    jezyk(J),
    dopuszczenie_jezyka(J),
    spelnia_wymagania_jezyka_paradygmat(J),
    spelnia_wymagania_jezyka_typowanie(J),
    spelnia_wymagania_jezyka_zastosowanie(J).

spelnia_wymagania_jezyka_paradygmat(_) :-
    nieznane(paradygmat), !.

spelnia_wymagania_jezyka_paradygmat(J) :-
    zdefiniowane(paradygmat, P1), 
    paradygmat(J, P1).

spelnia_wymagania_jezyka_typowanie(_) :-
    nieznane(typowanie), !.

spelnia_wymagania_jezyka_typowanie(J) :-
    zdefiniowane(typowanie, T1, T2), 
    typowanie(J, T1, T2).

spelnia_wymagania_jezyka_zastosowanie(_) :-
    nieznane(zastosowanie), !.

spelnia_wymagania_jezyka_zastosowanie(J) :-
    zdefiniowane(zastosowanie, Z), 
    zastosowanie(J, Z).

uzytkownik_zaawansowany :-
    zdefiniowane(uzytkownik, zaawansowany).

uzytkownik_sredniozaawansowany :-
    uzytkownik_zaawansowany, !.

uzytkownik_sredniozaawansowany :-
    zdefiniowane(uzytkownik, sredniozaawansowany).

uzytkownik_poczatkujacy :-
    uzytkownik_sredniozaawansowany, !.

uzytkownik_poczatkujacy :-
    zdefiniowane(uzytkownik, poczatkujacy),!.

uzytkownik_poczatkujacy :-
    not(zdefiniowane(uzytkownik, _)).

liczebnosc_zespolu(duzy_zespol_projektowy) :- 
    zdefiniowane(liczba_czlonkow, N),
    integer(N),
    minimalna_liczba_czlonkow_duzego_zespolu(X),
    N > X.

liczebnosc_zespolu(standardowy_zespol_projektowy) :- 
    zdefiniowane(liczba_czlonkow, N), 
    integer(N),
    minimalna_liczba_czlonkow_standardowego_zespolu(X), 
    N > X, !.

liczebnosc_zespolu(standardowy_zespol_projektowy) :- 
    not(zdefiniowane(liczba_czlonkow, _)).

liczebnosc_zespolu(maly_zespol_projektowy)  :-
    zdefiniowane(liczba_czlonkow, N), 
    integer(N),
    minimalna_liczba_czlonkow_malego_zespolu(X),
    N > X, !.

liczebnosc_zespolu(mikro_zespol_projektowy) :-
    zdefiniowane(liczba_czlonkow, _), !.

planowany_czas_prac(projekt_dlugoterminowy) :-
    zdefiniowane(miesiace_pracy, M), 
    integer(M),
    minimalny_czas_projektu_dlugoterminowego(T), 
    M >= T, !.

planowany_czas_prac(projekt_dwuletni) :-
    zdefiniowane(miesiace_pracy, M), 
    integer(M), 
    minimalny_czas_projektu_dwuletniego(T),
    M >= T, !.

planowany_czas_prac(projekt_dwuletni) :-
    not(zdefiniowane(miesiace_pracy, _)), !.

planowany_czas_prac(projekt_roczny) :-
    zdefiniowane(miesiace_pracy, M), 
    integer(M),
    minimalny_czas_projektu_rocznego(T), 
    M >= T, !.

planowany_czas_prac(projekt_szybki) :-
    zdefiniowane(miesiace_pracy, _).

/*
===== Helpers =====
*/
len([] , 0 ) :- !.
len([_|X], L) :- len(X,N), L is N+1.
