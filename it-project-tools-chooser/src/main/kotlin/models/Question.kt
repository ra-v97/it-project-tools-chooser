package pl.edu.agh.it.tools.models

sealed class Question {
    abstract val text: String
    abstract val serializableName: String

    data class Option(val text: String, val serializableName: String)

    data class SingleAnswer(
            override val text: String,
            val options: Collection<Option>,
            override val serializableName: String,
    ): Question()

    data class NumericalAnswer(
            override val text: String,
            override val serializableName: String,
    ): Question()
}
