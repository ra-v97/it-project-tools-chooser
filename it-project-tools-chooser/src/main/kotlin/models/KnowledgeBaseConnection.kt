package pl.edu.agh.it.tools.models

import org.jpl7.*

class KnowledgeBaseConnection {
    fun submitAnswers(answers: Set<Answer>): KnowledgeResult {
        JPL.init()
        Query("consult", arrayOf(Atom("../knowledge_base/stack_supervisor_engine.pl"))).apply {
            hasSolution()
            close()
        }

        Query("inicjalizuj", emptyArray()).apply {
            hasSolution().also(::println)
            close()
        }

        answers.forEach { answer ->
            when (answer) {
                is Answer.OptionAnswer -> {
                    answer.value.forEach { value ->
                        Query("definiuj", arrayOf(Atom(answer.question.serializableName), *value.serializableName.toAtoms().toTypedArray())).apply {
                            hasSolution()
                            close()
                        }
                    }
                }
                is Answer.NumericAnswer -> Query("definiuj", arrayOf(Atom(answer.question.serializableName), Integer(answer.value.toLong()))).apply {
                    hasSolution()
                    close()
                }
            }
        }
        val x = Variable("X")
        val lang = Query("sugerowany_jezyk", arrayOf(x)).allSolutions().map { s -> s["X"].toString().snakeToCamelCase() }.distinct().also(::println)
        val method = Query("sugerowana_metodyka_projektowa", arrayOf(x)).allSolutions().map { s -> s["X"].toString().snakeToCamelCase() }.distinct().also(::println)
        val stack = Query("sugerowany_stos_technologiczny", arrayOf(x)).allSolutions().map { s -> s["X"].toString().snakeToString() }.distinct().also(::println)

        return KnowledgeResult(lang, method, stack)
    }

    private fun String.toAtoms() = split(" ").map { Atom(it) }

    private fun String.snakeToCamelCase(): String = replace("_[a-zA-Z]".toRegex()) {
        it.value.replace("_", "").toUpperCase()
    }.capitalize()

    private fun String.snakeToString(): String = replace("_[a-zA-Z]".toRegex()) {
        it.value.replace("_", " ")
    }.capitalize()
}

data class KnowledgeResult(val suggestedLanguages: List<String>, val suggestedMethods: List<String>, val suggestedStack: List<String>)
