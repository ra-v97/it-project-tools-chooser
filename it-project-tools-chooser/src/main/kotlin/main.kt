package pl.edu.agh.it.tools

import tornadofx.launch


fun main(args: Array<String>) {
    launch<MainApp>(args)
//    JPL.init()
//    Query("consult", arrayOf(Atom("stack_supervisor_engine.pl"))).hasSolution().also(::println)
//    Query("inicjalizuj", emptyArray()).hasSolution().also(::println)
//    Query("definiuj", arrayOf(Atom("paradygmat"), Atom("obiektowy"))).hasSolution().also(::println)
//    val x = Variable("X")
//    val q = Query("sugerowany_stos_technologiczny", arrayOf(x))
//    q.allSolutions().forEach {
//        println(it["X"])
//    }
}

