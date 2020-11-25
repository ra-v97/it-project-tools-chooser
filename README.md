# it-project-tools-chooser
System ekspertowy sugerujący odpowiedni stos technologiczny dla projektu

Uruchomienie aplikacji wymaga:

* JDK z JavaFX (najprościej więc używać Javy 8) 

* posiadania zainstalowanego SWI-Prologa 

* ustawienia ścieżki do natywnej biblioteki `jpl.dll(Windows)/libjpl.so(Linux)/libjpl.dylib(MacOS)` w pliku `gradle.properties`. Dodatkowe instrukcje można znaleźć na stronie https://jpl7.org/Deployment oraz podstronach dla konkretnych platform

Następnie wystarczy wywołać `./gradlew run`, by uruchomić aplikację

Szczegółowy opis uruchomienia na systemie operacyjnym Windows 10:

1. Dodaj nową systemową zmienną środowiskową SWI_HOME_DIR , która ustawi ścieżkę do pliku, gdzie został zainstalowany Prolog np. C:\Program Files\swipl

2. Dodaj ścieżkę %SWI_HOME_DIR%\bin do zmiennej  środowiskowej PATH. Ważne, aby nie zmieniać  ścieżki

3. Dodaj ścieżkę %SWI_HOME_DIR%\lib\jpl.jar do zmiennej  środowiskowej PATH. Ważne, aby nie zmieniać  ścieżki

4. Upewnij się, że w pliku `gradle.properties` jest ustawiona prawidłowa ścieżka do swipl np. `jpl_path=C:/Program Files/swipl/bin`

5. Wywołaj polecenie `./gradlew run` w katalogu projektu z aplikacją Java

