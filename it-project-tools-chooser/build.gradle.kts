plugins {
    kotlin("jvm") version "1.4.20"
    application
}

group = "pl.edu.agh"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven(url = "https://maven.pkg.github.com/SWI-Prolog/packages-jpl/")
    maven(url = "https://jitpack.io")
}

dependencies {
    implementation(kotlin("stdlib-jdk8"))
    implementation("no.tornado:tornadofx:1.7.20")
    implementation("com.github.SWI-Prolog:packages-jpl:V8.3.2")
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}

application {
    mainClassName = "pl.edu.agh.it.tools.MainKt"
    val jpl_path: String by project
    applicationDefaultJvmArgs = listOf("-Djava.library.path=$jpl_path")
}
