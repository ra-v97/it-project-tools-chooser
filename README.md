# it-project-tools-chooser
System ekspertowy sugerujący odpowiedni stos technologiczny dla projektu

Uruchomienie aplikacji wymaga:

* JDK z JavaFX (najprościej więc używać Javy 8) 

* posiadania zainstalowanego SWI-Prologa 

* ustawienia ścieżki do natywnej biblioteki `jpl.dll(Windows)/libjpl.so(Linux)/libjpl.dylib(MacOS)` w pliku `gradle.properties`. Dodatkowe instrukcje można znaleźć na stronie https://jpl7.org/Deployment oraz podstronach dla konkretnych platform

  

Następnie wystarczy wywołać `./gradlew run`, by uruchomić aplikację