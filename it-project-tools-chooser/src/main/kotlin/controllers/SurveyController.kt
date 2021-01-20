package pl.edu.agh.it.tools.controllers

import pl.edu.agh.it.tools.models.Answer
import pl.edu.agh.it.tools.models.KnowledgeBaseConnection
import pl.edu.agh.it.tools.models.KnowledgeQuery
import pl.edu.agh.it.tools.models.KnowledgeResult
import tornadofx.Controller

class SurveyController : Controller() {
    private val model = KnowledgeBaseConnection()
    val resultItems = KnowledgeQuery.values().toList()

    fun getSuggestedItems(input: Set<Answer>): List<KnowledgeResult> {
        model.clearEvidence()
        model.submitAnswers(input)
        return model.getResults(resultItems)
    }
}
