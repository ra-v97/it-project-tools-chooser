package pl.edu.agh.it.tools.models.questions

import pl.edu.agh.it.tools.models.Question

val languageType = Question.SingleAnswer("Typowanie języka", setOf(
        Question.Option("Statycznie, silnie typowany", "statyczne silne"),
        Question.Option("Statycznie, słabo typowany", "statyczne slabe"),
        Question.Option("Dynamicznie silnie typowany", "dynamiczne silne"),
        Question.Option("Dynamicznie słabo typowany", "dynamiczne slabe"),
),
        "typowanie"
)


val languageParadigm = Question.SingleAnswer("Paradygmat języka", setOf(
        Question.Option("Obiektowy", "obiektowy"),
        Question.Option("Imperatywny", "imperatywny"),
        Question.Option("Funkcyjny", "funkcyjny"),
),
        "paradygmat"
)


val languageApplication = Question.SingleAnswer("Typ projektu", setOf(
        Question.Option("Prototyp", "prototypowanie"),
        Question.Option("Aplikacja mobilna", "aplikacje_mobilne"),
        Question.Option("Aplikacja webowa", "aplikacje_webowe"),
        Question.Option("Aplikacja desktopowa", "aplikacje_desktopowe"),
        Question.Option("Aplikacja na systemy wbudowane", "systemy_wbudowane"),
        Question.Option("System rozproszony", "system_rozproszone"),
        Question.Option("Machine learning", "machine_learning"),
        Question.Option("Symulacja komputerowa", "symulacje_komputerowe"),
        Question.Option("Ogólnego przeznaczenia", "ogolnego_przeznaczenia"),
),
        "zastosowanie"
)

val projectLength = Question.NumericalAnswer("Czas trwania projektu (w miesiącach)", "miesiace_pracy")

val teamSize = Question.NumericalAnswer("Rozmiar zepsołu projektowego", "liczba_czlonkow")


val userType = Question.SingleAnswer("Poziom zaawansowania użytkownika", setOf(
        Question.Option("Początkujący", "poczatkujacy"),
        Question.Option("Średniozaawansowany", "sredniozaawansowany"),
        Question.Option("Zaawansowany", "zaawansowany"),
),
        "uzytkownik"
)


val questions = listOf(languageType, languageParadigm, languageApplication, userType, projectLength, teamSize)
