plugins {
    kotlin("jvm") version "1.4.21"
    application
}

group = "pl.edu.agh"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven(url = "https://jitpack.io")
}

dependencies {
    implementation(kotlin("stdlib-jdk8"))
    implementation("no.tornado:tornadofx:1.7.20")
    implementation(files("src/main/resources/jsmile-1.6.0.jar"))
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}

application {
    mainClassName = "pl.edu.agh.it.tools.MainKt"
    val jsmile_path: String by project
    applicationDefaultJvmArgs = listOf("-Djava.library.path=$jsmile_path")
}
