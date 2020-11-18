plugins {
    kotlin("jvm") version "1.4.10"
}

group = "pl.edu.agh"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven(url = "https://maven.pkg.github.com/SWI-Prolog/packages-jpl/")
    maven(url = "https://jitpack.io")
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("no.tornado:tornadofx:1.7.20")
    implementation("com.github.SWI-Prolog:packages-jpl:V8.3.2")
//    implementation("jpl:jpl:7.6.1")
//    implementation(file("/usr/local/Cellar/swi-prolog/8.2.2/libexec/lib/swipl/lib/x86_64-darwin/"))
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}

