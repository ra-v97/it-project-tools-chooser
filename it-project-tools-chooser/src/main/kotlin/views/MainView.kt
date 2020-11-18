package pl.edu.agh.it.tools.views

import javafx.beans.property.ReadOnlyObjectProperty
import javafx.beans.property.ReadOnlyProperty
import javafx.beans.property.SimpleStringProperty
import javafx.scene.control.RadioButton
import javafx.scene.control.Toggle
import javafx.scene.layout.Pane
import pl.edu.agh.it.tools.controllers.SurveyController
import pl.edu.agh.it.tools.models.Answer
import pl.edu.agh.it.tools.models.Question
import pl.edu.agh.it.tools.models.questions.questions
import tornadofx.*


class MainView : View() {
    private val optionString = "option"
    private val notSure = "Bez znaczenia"
    private val controller: SurveyController by inject()

    override val root = vbox(20) {
        val answers = questions.chunked(4).flatMap { questions ->
            val x: MutableList<Pair<Question, ReadOnlyProperty<out Any>>> = mutableListOf()
            hbox(30) {
                questions.forEach {
                    vbox(10) {
                        renderQuestion(it).let { x.add(it) }
                        style {
//                            borderColor += box(Color.BLACK)
//                            borderWidth += box(1.px)
                        }
                    }
                }
            }
            x.toList()
        }

        val resultLanguage = SimpleStringProperty()
        val resultMethodology = SimpleStringProperty()

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

                            is Question.MultiAnswer -> {
                                TODO()
//                            val value = (((prop as ReadOnlyObjectProperty<Toggle>).get() as Checkbox).userData as Map<String, Question.Option?>)?.getOrDefault(optionString, null)
//                            Answer.OptionAnswer(question, setOfNotNull(value))
                            }

                            is Question.NumericalAnswer -> {
                                (prop as? ReadOnlyProperty<String>)?.value?.takeIf { it.isNotBlank() }?.toInt()?.let {
                                    Answer.NumericAnswer(question, it)
                                }
                            }
                        }

                    }.let {
                        controller.getSuggestedItems(it.filterNotNull().toSet())
                    }
                } ui { (lang, method) ->
                    val suggestedLanguage = lang.joinToString(", ").takeIf { it.isNotBlank() } ?: "Nie znaleziono"
                    resultLanguage.set(suggestedLanguage)

                    val suggestedMethodology = method.joinToString(", ").takeIf { it.isNotBlank() } ?: "Nie znaleziono"
                    resultMethodology.set(suggestedMethodology)
                }
            }
        }

        hbox {
            text("Sugerowany język: ")
            text(resultLanguage)
        }
        hbox {
            text("Sugerowana metodyka: ")
            text(resultMethodology)
        }
    }

    private fun Pane.renderQuestion(question: Question): Pair<Question, ReadOnlyProperty<out Any>> {
        text(question.text)
        val tg = when (question) {
            is Question.SingleAnswer ->
                togglegroup {
                    question.options.forEach {
                        radiobutton(it.text) {
                            userData = mapOf(optionString to it)
                        }
                    }
                    radiobutton(notSure) {
                        userData = mapOf(optionString to null)
                    }
                }.selectedToggleProperty()

            is Question.MultiAnswer -> {
                togglegroup {
                    question.options.forEach {
                        checkbox(it.text) {
                            userData = mapOf(optionString to it)
                        }
                    }
                }.selectedToggleProperty()
            }
            is Question.NumericalAnswer -> {
                textfield().textProperty() as ReadOnlyProperty<String>
            }
        }
        return question to tg
    }
}
