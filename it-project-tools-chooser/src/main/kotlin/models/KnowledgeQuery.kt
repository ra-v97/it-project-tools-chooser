package pl.edu.agh.it.tools.models

enum class KnowledgeQuery(val displayableName: String, val serializableName: String) {
    AppType("Rodzaj aplikacji", "rodzaj_aplikacji"),
    Methodology("Metodyka projektowa", "metodyka_projektowa"),
    Language("Język programowania", "jezyk_programowania"),
    Overtime("Wydłużenie czasu prac", "wydluzenie_czasu_prac"),
    Overbudget("Przekroczenie budżetu", "przekroczenie_budzetu"),
    Finalization("Ukończenie projektu", "ukonczenie_projektu"),
}
