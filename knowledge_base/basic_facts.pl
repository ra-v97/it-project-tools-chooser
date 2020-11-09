:- module(basic_facts,
  [
    stos_technologiczny/1,
    jezyk/1,
    metodyka_projektowa/1,
    rodzaj_typowania_jezyka/1,
    paradygmat_jezyka_programowania/1,
    zastosowanie_jezyka_programowania/1,
    forma_projektu/1,
    rozmiar_zepolu_projektowego/1,
    typ_uzytkownika/1
  ]).

/*
===== Facts =====
*/
stos_technologiczny(prosty_desktopowy).
stos_technologiczny(zlozony_desktopowy).
stos_technologiczny(prototyp_mobilny).
stos_technologiczny(system_mobilny).
stos_technologiczny(zaawansowane_systemy_wbudowane).
stos_technologiczny(podstawowe_systemy_wbudowane).
stos_technologiczny(prototyp_webowy).
stos_technologiczny(webowy).
stos_technologiczny(zaawansowany_system_rozproszony).
stos_technologiczny(system_uczenia_maszynowego).

jezyk(java).
jezyk(python).
jezyk(java_script).
jezyk(c).

metodyka_projektowa(scrum).
metodyka_projektowa(lean).
metodyka_projektowa(iterative_process).
metodyka_projektowa(waterfall).
metodyka_projektowa(extream_programming).

rodzaj_typowania_jezyka(statyczne).
rodzaj_typowania_jezyka(dynamiczne).
rodzaj_typowania_jezyka(silne).
rodzaj_typowania_jezyka(slabe).

paradygmat_jezyka_programowania(obiektowy).
paradygmat_jezyka_programowania(imperatywny).
paradygmat_jezyka_programowania(funkcyjny).

zastosowanie_jezyka_programowania(aplikacje_mobilne).
zastosowanie_jezyka_programowania(aplikacje_webowe).
zastosowanie_jezyka_programowania(system_rozproszone).
zastosowanie_jezyka_programowania(aplikacje_desktopowe).
zastosowanie_jezyka_programowania(prototypowanie).
zastosowanie_jezyka_programowania(machine_learning).
zastosowanie_jezyka_programowania(systemy_wbudowane).
zastosowanie_jezyka_programowania(symulacje_komputerowe).
zastosowanie_jezyka_programowania(ogolnego_przeznaczenia).

forma_projektu(projekt_dlugoterminowy).
forma_projektu(projekt_dwuletni).
forma_projektu(projekt_roczny).
forma_projektu(projekt_szybki).

rozmiar_zepolu_projektowego(duzy_zespol_projektowy).
rozmiar_zepolu_projektowego(standardowy_zespol_projektowy).
rozmiar_zepolu_projektowego(maly_zespol_projektowy).
rozmiar_zepolu_projektowego(mikro_zespol_projektowy).

typ_uzytkownika(uzytkownik_zaawansowany).
typ_uzytkownika(uzytkownik_sredniozaawansowany).
typ_uzytkownika(uzytkownik_poczatkujacy).