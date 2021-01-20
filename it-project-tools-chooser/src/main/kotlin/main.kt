package pl.edu.agh.it.tools

import pl.edu.agh.it.tools.views.MainView
import tornadofx.App
import tornadofx.launch


fun main(args: Array<String>): Unit = launch<MainApp>(args)

class MainApp : App(MainView::class)

object SmileLicense {
    fun getLicense() = smile.License( // TODO: provide your license here
            "",
            byteArrayOf()
    )
}
