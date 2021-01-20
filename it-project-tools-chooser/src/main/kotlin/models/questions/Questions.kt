package pl.edu.agh.it.tools.models.questions

import pl.edu.agh.it.tools.models.Question


val applicationType = Question.YesNoMultiAnswer("Rodzaj aplikacji", setOf(
        Question.YesNoAnswer("Wysoka skalowalność",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "wysoka_skalowalnosc"),
        Question.YesNoAnswer("Korzystanie z bazy danych",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "korzystanie_z_bazy_danych"),
        Question.YesNoAnswer("Ogracznione zasoby sprzętowe",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "dzialanie_na_urzadzeniu_o_ograniczonych_zasobach_sprzetowych"),
        Question.YesNoAnswer("Stosowanie metod uczenia maszynowego",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "stosowanie_metod_uczenia_maszynowego"),
        Question.YesNoAnswer("GUI",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "GUI_dla_uzytkownika"),
        Question.YesNoAnswer("Obsługa funkcji sieciowych",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "obsluga_funkcji_sieciowych"))
)


val languageParadigm = Question.YesNoMultiAnswer("Paradygmat języka", setOf(
        Question.YesNoAnswer("Obiektowy",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "paradygmat_obiektowy"),
        Question.YesNoAnswer("Imperatywny",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "paradygmat_imperatywny"),
        Question.YesNoAnswer("Funkcyjny",
                yesSerializableName = "Yes",
                noSerializableName = "No",
                "paradygmat_funkcyjny"))
)


val projectType = Question.SingleAnswer("Rodzaj projektu", setOf(
        Question.Option("Komercyjny", "komercyjny"),
        Question.Option("Open source", "open_source"),
),
        "rodzaj_projektu"
)

val projectLength = Question.NumericalAnswer("Planowany czas trwania projektu (w miesiącach)", mapOf(
        (0 to 6) to "m1_m6",
        (7 to 12) to "m7_r1",
        (13 to 24) to "r1_r2",
        (25 to Int.MAX_VALUE) to "r2_nd"
), "planonowany_czas_prac")

val teamSize = Question.NumericalAnswer("Rozmiar zespołu projektowego", mapOf(
        (0 to 3) to "max3",
        (4 to 6) to "from4_to6",
        (7 to 12) to "from7_to12",
        (13 to Int.MAX_VALUE) to "min13"
), "rozmiar_zespolu")

val financingType = Question.SingleAnswer("Forma finansowania projektu", setOf(
        Question.Option("Inwestorzy", "inwestor"),
        Question.Option("Crowdfunding", "crowdfounding"),
        Question.Option("Brak", "brak"),
),
        "forma_finansowania"
)

val userType = Question.SingleAnswer("Poziom zaawansowania użytkownika", setOf(
        Question.Option("Początkujący", "High"),
        Question.Option("Średniozaawansowany", "Medium"),
        Question.Option("Zaawansowany", "Low"),
),
        "poziom_zaawansowania_uzytkownika"
)

val questions = listOf(financingType, languageParadigm, projectType, userType, applicationType, projectLength, teamSize)
