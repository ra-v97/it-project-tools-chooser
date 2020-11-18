package pl.edu.agh.it.tools.models

import org.jpl7.*

class KnowledgeBaseConnection {

    fun submitAnswers(answers: Set<Answer>): Pair<List<String>, List<String>> {
        JPL.init()
        Query("consult", arrayOf(Atom("../knowledge_base/stack_supervisor_engine.pl"))).hasSolution()
        Query("inicjalizuj", emptyArray()).hasSolution()

        answers.forEach { answer ->
            when (answer) {
                is Answer.OptionAnswer -> {
                    answer.value.forEach { value ->
                        Query("definiuj", arrayOf(Atom(answer.question.serializableName), *value.serializableName.toAtoms().toTypedArray())).hasSolution()
                    }
                }
                is Answer.NumericAnswer -> Query("definiuj", arrayOf(Atom(answer.question.serializableName), Integer(answer.value.toLong()))).hasSolution()
            }
        }
        val x = Variable("X")
        val lang = Query("sugerowany_jezyk", arrayOf(x)).allSolutions().map { s -> s["X"].toString().snakeToCamelCase() }.also(::println)
        val method = Query("sugerowana_metodyka_projektowa", arrayOf(x)).allSolutions().map { s -> s["X"].toString().snakeToCamelCase() }.also(::println)

        return lang to method
    }

    private fun String.toAtoms() = split(" ").map { Atom(it) }

    private fun String.snakeToCamelCase(): String = replace("_[a-zA-Z]".toRegex()) {
        it.value.replace("_", "").toUpperCase()
    }.capitalize()

}
