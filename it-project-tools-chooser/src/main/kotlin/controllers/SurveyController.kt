package pl.edu.agh.it.tools.controllers

import pl.edu.agh.it.tools.models.Answer
import pl.edu.agh.it.tools.models.KnowledgeBaseConnection
import tornadofx.Controller

class SurveyController : Controller() {
    private val model = KnowledgeBaseConnection()

    fun getSuggestedItems(input: Set<Answer>): Pair<List<String>, List<String>> = model.submitAnswers(input)

}
