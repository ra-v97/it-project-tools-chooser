package pl.edu.agh.it.tools.views

import javafx.beans.property.ReadOnlyObjectProperty
import javafx.beans.property.ReadOnlyProperty
import javafx.beans.property.SimpleStringProperty
import javafx.scene.control.RadioButton
import javafx.scene.control.Toggle
import javafx.scene.layout.Pane
import javafx.scene.text.FontWeight
import pl.edu.agh.it.tools.controllers.SurveyController
import pl.edu.agh.it.tools.models.Answer
import pl.edu.agh.it.tools.models.KnowledgeQuery
import pl.edu.agh.it.tools.models.Question
import pl.edu.agh.it.tools.models.questions.questions
import tornadofx.*

private const val answersToDisplay = 1
private const val decimalPlaces = 0

class MainView : View(title = "It project tools chooser") {
    private val optionString = "option"
    private val notSure = "Bez znaczenia"
    private val controller: SurveyController by inject()

    override val root = vbox(20) {
        style {
            padding = box(10.px, 10.px, 50.px, 10.px)
        }

        val answers = questions.chunked(4).flatMap { questions ->
            val questionProperties: MutableList<Pair<Question, ReadOnlyProperty<out Any>>> = mutableListOf()
            hbox(30) {
                questions.forEach {
                    vbox(10) {
                        renderQuestion(it).forEach { questionProperties.add(it) }
                    }
                }
            }
            questionProperties.toList()
        }

        val resultProperties = controller.resultItems.map { it.serializableName to (it.displayableName to SimpleStringProperty()) }.toMap()

        @Suppress("UNCHECKED_CAST")
        button("Sprawdź") {
            action {
                runAsync {
                    answers.map { (question, prop) ->
                        when (question) {
                            is Question.SingleAnswer -> {
                                val value = (((prop as ReadOnlyObjectProperty<Toggle>).get() as? RadioButton)?.userData as? Map<String, Question.Option?>)?.getOrDefault(optionString, null)
                                Answer.OptionAnswer(question, setOfNotNull(value))
                            }

                            is Question.NumericalAnswer -> {
                                (prop as? ReadOnlyProperty<String>)?.value?.takeIf { it.isNotBlank() }?.toInt()?.let { answer ->
                                    question.rangeName(answer)?.let { Answer.StringAnswer(question, it) }
                                }
                            }

                            is Question.YesNoAnswer -> {
                                (prop as? ReadOnlyProperty<Boolean?>)?.value?.let { answer ->
                                    if (answer) {
                                        Answer.StringAnswer(question, question.yesSerializableName)
                                    } else {
                                        Answer.StringAnswer(question, question.noSerializableName)
                                    }
                                }
                            }
                            else -> TODO()
                        }

                    }.let {
                        controller.getSuggestedItems(it.filterNotNull().toSet())
                    }
                } ui { results ->

                    results.forEach { (query, answers) ->
                        val answerText = answers
                                .sortedByDescending { it.second }
                                .take(answersToDisplay)
                                .joinToString {
                                    it.first.translateYesNo().snakeToString() +
                                            (": ${it.second.roundToString(decimalPlaces)}").takeIf { decimalPlaces > 0 }.orEmpty()
                                }
                        resultProperties[query.serializableName]?.second?.set(answerText)
                    }
                }
            }
        }

        resultProperties.forEach {
            hbox {
                text("${it.value.first}: ") {
                    style {
                        fontFamily = "sans-serif"
                        fontWeight = FontWeight.EXTRA_BOLD
                    }
                }
                textflow {
                    style {
                        maxWidth = getMaxWidth().px
                        wrapText = true
                    }
                    text(it.value.second)
                }
            }
        }
    }

    private fun Pane.renderQuestion(question: Question): Collection<Pair<Question, ReadOnlyProperty<out Any>>> {
        return when (question) {
            is Question.SingleAnswer -> {
                text(question.text)

                val tg = togglegroup {
                    question.options.forEach {
                        radiobutton(it.text) {
                            userData = mapOf(optionString to it)
                        }
                    }
                    radiobutton(notSure) {
                        userData = mapOf(optionString to null)
                        isSelected = true
                    }
                }.selectedToggleProperty()
                listOf(question to tg)
            }

            is Question.NumericalAnswer -> {
                text(question.text)
                listOf(question to (textfield().textProperty() as ReadOnlyProperty<String>))
            }

            is Question.YesNoAnswer -> {
                listOf(question to (checkbox { text(question.text) }.selectedProperty()))
            }

            is Question.YesNoMultiAnswer -> {
                text(question.text)
                question.options.flatMap { renderQuestion(it) }
            }
        }
    }

    private fun Double.roundToString(decimals: Int = 2): String = "%.${decimals}f".format(this)

    private fun String.snakeToCamelCase(): String = replace("_[a-zA-Z]".toRegex()) {
        it.value.replace("_", "").toUpperCase()
    }.capitalize()

    private fun String.snakeToString(): String = replace("_[a-zA-Z]".toRegex()) {
        it.value.replace("_", " ")
    }.capitalize()

    private fun String.translateYesNo(): String = when {
        toLowerCase() == "yes" -> "Tak"
        toLowerCase() == "no" -> "Nie"
        else -> this
    }
}
