# Gang 3: Den lokale logbog

**Mission:** Byg en liste over pirat-eventyr, der stadig findes efter F5.

**Du lærer:** objekter, arrays, `push`, `forEach`, nye HTML-elementer, JSON og `localStorage`. Du undersøger forskellen på at vise data og gemme data.

**Start:** Kopiér denne gangs `start`-mappe. Formular og CSS er klar. I `app.js` er felterne allerede fundet. Hjælpekode til indlæsning, validering og sletning er udleveret, så du kan fokusere på de tre markerede trin. Startversionen gemmer endnu intet.

## Plan: 120 minutter

| Minutter | Aktivitet |
|---|---|
| 0-10 | Hvorfor forsvandt vores data? Gæt, hvor de kan gemmes. |
| 10-25 | Tegn et objekt og en liste på papir. |
| 25-45 | Vis en liste med forEach og createElement. |
| 45-55 | Tilføj indlæg fra formularen. |
| 55-65 | Pause. |
| 65-85 | Gem JSON og prøv F5. |
| 85-100 | Test genåbning, sletning og anden browser. |
| 100-115 | Bonusmission og design. |
| 115-120 | Forklar, hvorfor makkeren ikke ser dine indlæg. |

## 1. Ét objekt, mange indlæg

Et objekt samler data om én ting:

```javascript
var eventyr = { pirat: "Kaptajn Krabbe", tekst: "Vi fandt en ø!" };
```

Et array er en liste. I vores kode hedder listen `indlaeg`:

```javascript
var indlaeg = [];
```

`[]` starter en tom liste. Vi kan tilføje et objekt med `indlaeg.push(eventyr)`.

**Papirmission:** Tegn tre kort med felterne `pirat` og `tekst`. Læg dem i en række. Ét kort er et objekt; hele rækken er et array. Der er ikke brug for at skrive papirøvelsens `eventyr` ind i programmet.

## 2. Vis listen på siden

Find funktionen `visIndlaeg` i `app.js`. Erstat kun kommentaren `TRIN 1` mellem dens klammer med:

```javascript
liste.textContent = "";
indlaeg.forEach(function(indlaeg) {
  var punkt = document.createElement("li");
  punkt.textContent = indlaeg.pirat + ": " + indlaeg.tekst;
  liste.appendChild(punkt);
});
```

Den første linje rydder den viste liste, så vi ikke får dubletter. `forEach` kører funktionen én gang for hvert indlæg. `createElement("li")` laver et nyt listepunkt. `appendChild` sætter det ind i `<ul id="liste">`.

Her hedder det enkelte indlæg `indlaeg` inde i funktionen. Det er en lokal variabel; udenfor er `indlaeg` hele listen. Prøv at læse koden højt med ordene *listen* og *dette indlæg*.

## 3. Lav et objekt fra formularen

Find `TRIN 2` inde i `formular.onsubmit`, og erstat kommentaren med:

```javascript
var nytIndlaeg = {
  pirat: pirat.value.trim(),
  tekst: tekst.value.trim()
};
indlaeg.push(nytIndlaeg);
```

De næste linjer i startkoden kalder allerede `visIndlaeg()` og `gemIndlaeg()`. De skal blive stående. Bagefter tømmes tekstfeltet, mens piratnavnet bliver stående.

**Kontrol:** Skriv to eventyr. Begge skal stå i listen. F5 mister dem endnu, fordi vi mangler den næste del.

## 4. Gem i browseren

Find `TRIN 3` inde i `gemIndlaeg`. Erstat kommentaren **og linjen med beskeden om startversionen** med:

```javascript
localStorage.setItem(noegle, JSON.stringify(indlaeg));
statusfelt.textContent = "Gemt i denne browser.";
```

`localStorage` er browserens lille lager. Det gemmer tekst. `JSON.stringify` omdanner listen til en tekst, der kan genskabes senere. `noegle` er navnet på vores lagerplads; det står øverst i filen. Vi bruger én særlig nøgle og sletter aldrig andre hjemmesiders data.

Den udleverede `hentIndlaeg()` gør det omvendte: den læser med `getItem` og genskaber listen med `JSON.parse`. Nederst i filen bliver indlæggene hentet og vist, når siden åbner.

**Kontrol:** Tilføj et nyt eventyr. Tryk F5. Det skal stadig være der.

## 5. Undersøg lagringen

1. Luk fanen, og åbn præcis den samme fil eller webadresse i samme browser. Er teksten der?
2. Åbn siden i en anden browser. Den browser har sit eget lager.
3. Åbn siden på makkerens maskine. Der ligger ikke automatisk en kopi af din logbog.
4. Tryk *Slet min lokale logbog*, vælg først Annuller og bagefter OK. Opdater siden og se forskellen.

**Vigtigt:** Lokal lagring er ikke vores fælles database. Privat browsing, browseroprydning og flytning af filen kan ændre eller fjerne lagringen. Gem ikke noget vigtigt eller personligt her.

**Hvis du får beskeden "Kan ikke gemme":** Spørg underviseren. Browseren kan blokere lagring fra en dobbeltklikket fil. Prøv en anden browser sammen med underviseren. Brug derefter samme browser og filplacering til øvelsen; gamle data flytter ikke automatisk med.

## Hjælpekoden

`try` forsøger noget; `catch` fanger en fejl og viser en forståelig besked. Den udleverede kode tjekker også formen på data, begrænser listen til 100 indlæg og spørger før sletning. Du behøver ikke skrive den del selv.

Vi bruger `textContent` frem for `innerHTML`, fordi indlæg skal være tekst. Prøv at gemme `<h1>Skat!</h1>` som eventyr; det må ikke blive til en rigtig overskrift.

## Bonusmissioner

- **Let:** Vis antallet af indlæg. Hint: `indlaeg.length` og et ekstra tekstfelt.
- **Mellem:** Vis nyeste indlæg først. Undersøg `unshift` som alternativ til `push`.
- **Svær:** Giv hvert indlæg et tidspunkt med `new Date().toLocaleString()`. Tilføj en ny egenskab i objektet, og vis den. Gamle indlæg mangler egenskaben, så vælg en reserveværdi.

## Før du går

Tegn tre kasser: JavaScript-hukommelse, browserens lager og server. Placér dagens data i de rigtige kasser. Hvad mangler vi, før alle pirater kan læse den samme logbog?
