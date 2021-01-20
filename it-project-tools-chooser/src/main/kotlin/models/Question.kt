package pl.edu.agh.it.tools.models

typealias ValueRange = Pair<Int, Int>

sealed class Question {
    abstract val text: String
    abstract val serializableName: String

    data class Option(val text: String, val serializableName: String)

    data class SingleAnswer(
            override val text: String,
            val options: Collection<Option>,
            override val serializableName: String,
    ) : Question()

    data class YesNoAnswer(
            override val text: String,
            val yesSerializableName: String,
            val noSerializableName: String,
            override val serializableName: String,
    ) : Question()

    data class YesNoMultiAnswer(
            override val text: String,
            val options: Collection<YesNoAnswer>
    ) : Question() {
        override val serializableName: String
            get() = "multiAnswer"
    }

    data class NumericalAnswer(
            override val text: String,
            val ranges: Map<ValueRange, String>,
            override val serializableName: String,
    ) : Question() {
        fun rangeName(value: Int) = ranges
                .filterKeys { range -> (range.first <= value) && (range.second > value) }
                .values
                .firstOrNull()
    }
}
