# Anleitung

- Die Edition darf nicht frei auf dem Internet zugänglich sein. Das Logo und die Farbpalette sind noch nicht öffentlich und noch nicht offiziell in Gebrauch, sondern werden durch die Ortsbürgergemeinde erst im Dezember präsentiert. Sperrung per .htaccess?

- Die Edition wird deshalb erst 2024 offiziell publiziert, sollte aber bis __20. Oktober 2023__ fertiggestellt sein (interner Termin).

- Für die Farbgestaltung am besten Farben der Farbpalette verwenden. Als Hauptfarben "Naturgrün" und "Stadtblau" verwenden. Für die Registerauszeichnung können die anderen Farben verwendet werden (nicht zu hell). Vgl. [Farbpalette](/info/Farbpalette_OBG_2024.pdf)

- Als Schrift würde ich eine gängige serifenlose Schrift verwenden (Neue Helvetica, Helvetica, Arial o.ä.)

- zwei Textansichten:
  - Text und Register (default)
  - Text und Bild 

## Seite mit Suche und Missivenliste

### Suche
- Suche (Volltextsuche)
- durchsuche Regest, Anmerkungen und Kommentar
- durchsuche Editionstext

### Felder und Facetten
- Absender
- Empfänger
- Namen
- Ort
- Schlagwort
- Sprache

## Kopf 
- Signatur, Datum, Liste der Absender (die Liste mit höchstens 3 Namen, wenn sie länger ist dann "u.a." anfügen), Empfänger
- Regest und Kommentar per default immer sichtbar und aufgeklappt; Regest in normaler Schrift; Kommentar kleiner
- Stückbeschreibung und Weitere Überlieferungen fällt weg

## Textdarstellung
- Zeilenumbrüche beachten

### Farbig hervorgehoben
- Register Darstellung wie bei rqzh; Farben aus Farbpalette
  - persName und orgName: Namen (Personen, Familien, Organisationen mit derselben Farbe (@type="issuer" etwas kräfiger wie ohne Attribut)), Farbe "Hellblau"
  - placeName und origPlace: Orte (origPlace etwas kräftiger als placeName), Farbe "Hellgrün"
  - term: Schlagworte (kommt nur im Header vor also nur am Rand), Farbe "Purpur"
- date und origDate: origDate kräftiger als date, Farbe "Violett"

### gap, unclear, supplied, ex, abbr

- `<gap />`
  - Anzeige: […] , grau
  - Popup: Textlücke
- `<unclear>`
  - Anzeige: Text NICHT in eckige Klammer, nur grau
  - Popup: Unsichere Lesung
- `<supplied>`
  - Anzeige: Text in eckige Klammer, grau
  - Popup:  Herausgeberergänzung
- `<supplied cert="medium">`
  - Anzeige: Text in eckige Klammer, grau
  - Popup:  Unsichere Herausgeberergänzung
- `<ex>`
  - Anzeige: Text in eckige Klammer, grau
  - Popup:  Auflösung von Abkürzung
- `<ex cert="medium">`
  - Anzeige: Text in eckige Klammer, grau
  - Popup:  Unsichere Auflösung von Abkürzung
- `<abbr>`
  - Anzeige: Text NICHT in eckige Klammer, nur grau
  - Popup:  Abkürzung
- `<choice><abbr></abbr><expan></expan></choice>`
  -	Anzeige: Text NICHT in eckige Klammer, nur grau
  -	Popup: Inhalt von <expan></expan>


## Registerdaten

### Daten aktualisieren

Hierfür ist eine Authentifizierung mit dem api_token nötig:

https://stadtasg.anton.ch/api/tei/refresh?api_token={api_token}

Nach Anmeldung auf Anton ist der api_token für Lars hier zu sehen: https://stadtasg.anton.ch/users/8


### Download
[Namen](https://stadtasg.anton.ch/api/actors?format=tei)

[Orte](https://stadtasg.anton.ch/api/places?format=tei)

[Schlagworte](https://stadtasg.anton.ch/api/keywords?format=tei)




## Registerspalte
- Namen 
- Orte
- Schlagworte

(( Namen beinhaltet Personen, Familien, Organisationen))

## Register
- Namen 
- Orte
- Schlagworte

((Wie JC Fischer, allerdings ohne Bilder))
