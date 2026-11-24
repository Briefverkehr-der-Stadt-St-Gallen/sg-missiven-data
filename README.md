# Briefverkehr der Stadt St. Gallen 1400–1650 (Daten)

## Daten
Es werden die Missiven aus dem Ordner `34_finalized` mit dem TEI Publisher publiziert.

## Aktualisierung der Website-Daten

Die Website-Daten liegen im GitHub-Repository [sg-missiven-data](https://github.com/Briefverkehr-der-Stadt-St-Gallen/sg-missiven-data). Zwei Skripte dort halten sie aktuell:

- `update.sh` holt den neusten Stand aus diesem Repository (`missive-data`), kopiert `34_finalized`, `README.md`, `info` und `pages` hinüber, aktualisiert die Register aus Anton, baut das Datenpaket (`ant xar`) und installiert es (`xst package install`). Die Pfade `../missive-data`, `../sg-missiven-data` und `../sg-missiven-app` sind relativ zum Arbeitsverzeichnis.
- `update-anton.sh` aktualisiert nur die Register (`person/person.xml`, `place/place.xml`, `keyword/keyword.xml`).

Das `README.md` im GitHub-Repository wird bei jedem Lauf von `update.sh` durch dieses hier ersetzt. Änderungen gehören darum hierher.

### Anton-Token

Die Registerdatenbank `stadtasg.anton.ch` ist nicht öffentlich. Die Skripte brauchen deshalb einen API-Token. Er steht nie in den Skripten oder in einem README, denn das GitHub-Repository ist öffentlich.

Die Skripte lesen den Token aus der Umgebungsvariable `ANTON_API_TOKEN` oder, wenn sie leer ist, aus der Datei `.anton-token` im GitHub-Repository neben den Skripten. Die Datei enthält nur den Token auf einer Zeile, ist in `.gitignore` eingetragen und sollte nur für den eigenen Benutzer lesbar sein:

```bash
chmod 600 .anton-token
```

Fehlt der Token oder antwortet Anton mit einem Fehler (etwa «Invalid access token»), brechen die Skripte ab, ohne die Registerdateien zu überschreiben. Läuft ein Token ab oder wird er widerrufen, den neuen in `.anton-token` ablegen.

Den Token braucht auch das Konvertierungswerkzeug in der Dropbox (`sg-missiven/4_tools/zero`), das aus Anton die Listen für Schlagworte, Orte und Personen holt; es liest ihn noch nicht aus `.anton-token` und muss dafür angepasst werden.
