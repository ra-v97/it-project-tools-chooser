package pl.edu.agh.it.tools.models

typealias KnowledgeQueryAnswer = Pair<String, Double>

data class KnowledgeResult(val query: KnowledgeQuery, val answers: List<KnowledgeQueryAnswer>)
