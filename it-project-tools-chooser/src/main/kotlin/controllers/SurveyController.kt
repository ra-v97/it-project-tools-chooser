package pl.edu.agh.it.tools.controllers

import org.jpl7.PrologException
import pl.edu.agh.it.tools.models.Answer
import pl.edu.agh.it.tools.models.KnowledgeBaseConnection
import pl.edu.agh.it.tools.models.KnowledgeResult
import tornadofx.Controller

class SurveyController : Controller() {
    private val model = KnowledgeBaseConnection()

    fun getSuggestedItems(input: Set<Answer>) = try {
        model.submitAnswers(input)
    } catch (e: PrologException) {
        KnowledgeResult(emptyList<String>(), emptyList<String>(), emptyList<String>())
    }

}
