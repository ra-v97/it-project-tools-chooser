package pl.edu.agh.it.tools.models

sealed class Answer {
    abstract val question: Question

    data class OptionAnswer(
            override val question: Question,
            val value: Set<Question.Option>,
    ) : Answer()

    data class NumericAnswer(
            override val question: Question,
            val value: Int,
    ) : Answer()
}
