package pl.edu.agh.it.tools.models

import pl.edu.agh.it.tools.SmileLicense
import smile.Network

class KnowledgeBaseConnection {
    init {
       SmileLicense.getLicense()
    }

    private val net = Network().apply {
        readString(KnowledgeBaseConnection::class.java.getResource("/stachura_doleglo_it_project_advisor.xdsl").readText())
    }

    fun submitAnswers(answers: Set<Answer>) {
        answers.forEach { answer ->
            when (answer) {
                is Answer.OptionAnswer -> answer.value.forEach { value ->
                    net.setEvidence(answer.question.serializableName, value.serializableName)
                }
                is Answer.StringAnswer -> net.setEvidence(answer.question.serializableName, answer.value)
            }
        }
    }

    fun getResults(queries: Collection<KnowledgeQuery>): List<KnowledgeResult> {
        net.updateBeliefs()
        return queries.map { KnowledgeResult(it, getResult(it.serializableName)) }
    }

    fun clearEvidence() = net.clearAllEvidence()

    private fun getResult(nodeId: String) = net.getOutcomeIds(nodeId).toList().zip(net.getNodeValue(nodeId).toList())
}

