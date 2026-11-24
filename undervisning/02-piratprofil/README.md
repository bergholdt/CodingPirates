# Gang 2: Piratprofilen

**Mission:** Lav et piratpas med navn og rolle. Siden skal reagere på det, du skriver.

**Du lærer:** formularer, `label`, `input`, `select`, `submit`, `value`, events og DOM. Du deler koden i HTML, CSS og JavaScript-filer.

**Start:** Kopiér denne gangs `start`-mappe til en ny arbejdsmappe. Den indeholder et færdigt layout og en formular. Dit spil fra gang 1 bliver liggende i sin egen mappe. Åbn `index.html` i browseren og de tre filer i VS Code. Se `facit`, hvis du får brug for et fungerende eksempel.

## Plan: 120 minutter

| Minutter | Aktivitet |
|---|---|
| 0-10 | Vis et spil fra sidste gang. Find en variabel og en betingelse. |
| 10-25 | Undersøg de tre filer og deres forbindelser. |
| 25-45 | Udforsk og ændr formularens HTML. |
| 45-55 | Find elementerne i JavaScript. |
| 55-65 | Pause. |
| 65-85 | Fang submit og byg piratpasset. |
| 85-105 | Tilføj live-tekst og makkerprøve. |
| 105-115 | Bonusmission og eget design. |
| 115-120 | Forklar forskellen på value og textContent. |

## 1. Tre filer, én hjemmeside

Åbn `index.html`, og find disse forbindelser:

```html
<link rel="stylesheet" href="style.css">
<script src="app.js"></script>
```

HTML henter udseendet fra `style.css` og handlingerne fra `app.js`. Derfor skal alle tre filer blive i samme mappe. `<script>` står nederst, så HTML-elementerne er læst, før JavaScript leder efter dem.

**Prøv:** Skift baggrundsfarven i `style.css`. Gem filen og opdater browseren. Der skal ikke stå `<style>` i en CSS-fil eller `<script>` i en JavaScript-fil.

## 2. Undersøg formularen

Find disse linjer i `index.html`:

```html
<label for="navn">Piratnavn</label>
<input id="navn" name="pirat" maxlength="24" required>
```

`label` er feltets beskrivelse. `for="navn"` peger på `id="navn"`. Klik på teksten *Piratnavn*: markøren hopper ind i feltet. `required` betyder, at browseren kræver indhold; `maxlength` begrænser længden. `name` er navnet, serveren senere kan bruge til at modtage feltet. `id` og `name` har forskellige job.

Dropdown-menuen er et `<select>` med flere `<option>`. Knappen har `type="submit"`, som sender formularen. Man kan også sende med Enter fra navnefeltet.

**Prøv:** Tilføj denne mulighed inde i `<select>`:

```html
<option value="Skibskok">Skibskok</option>
```

**Stop og tænk:** Hvad sker der, når du prøver at sende formularen uden navn? Hvad sker der med siden, hvis du sender et gyldigt navn, før vi har skrevet JavaScript?

## 3. Find elementerne

Skriv i `app.js`, under eller i stedet for kommentarerne:

```javascript
var formular = document.getElementById("profil-form");
var navn = document.getElementById("navn");
var rolle = document.getElementById("rolle");
var preview = document.getElementById("preview");
var resultat = document.getElementById("resultat");
```

**DOM** er browserens model af sidens elementer. `getElementById` finder et element i modellen. Det er samme teknik, som fandt skattekisteknappen.

## 4. Reagér på formularen

Skriv dette under variablerne:

```javascript
formular.onsubmit = function(event) {
  event.preventDefault();
  var piratnavn = navn.value.trim();
  if (piratnavn === "") {
    resultat.textContent = "Skriv et piratnavn, ikke kun mellemrum.";
    return;
  }
  resultat.textContent = piratnavn + " er nu " + rolle.value + "!";
};
```

`event.preventDefault()` stopper browserens normale afsendelse, så vi kan opdatere siden med JavaScript. `value` er det, spilleren har skrevet eller valgt. `trim()` fjerner mellemrum i begyndelsen og slutningen. `return` stopper funktionen, når input er forkert.

**Kontrol:** Skriv *Kaptajn Krabbe*, vælg *Navigatør*, og send. Nu vises navnet og rollen i kortet uden en ny sideindlæsning.

## 5. Gør kortet levende

Tilføj efter submit-funktionen:

```javascript
navn.oninput = function() {
  preview.textContent = "Hej, " + navn.value + "!";
};
```

`input`-hændelsen sker, når feltet ændres. Det føles dynamisk, fordi browseren ændrer siden med det samme. Denne kode sender stadig ingen data til en server.

## Makkerprøven

- Klik på en label og brug Tab til at hoppe gennem felterne.
- Send et tomt navn. Browseren skal stoppe dig.
- Prøv kun mellemrum. JavaScript skal vise en besked.
- Skriv `<b>Pirat</b>` som navn. Tegnene skal vises som tekst, ikke som fed HTML. Derfor bruger vi `textContent` til brugerens tekst.
- Tryk F5. Profilen er ikke gemt af vores kode. Browseren kan dog selv genudfylde nogle formularfelter.

## Bonusmissioner

- **Let:** Lav dit eget design på profilkortet i `.kort` i CSS.
- **Mellem:** Tilføj et skibsnavn med `label` og `input`. Find feltet i JavaScript og brug værdien i resultatet.
- **Svær:** Tilføj en farvevælger (`type="color"`), og brug dens `oninput` til at ændre kortets kantfarve. Hint: find kortet med et id, og brug `kort.style.borderColor = farve.value`.

## Før du går

Forklar, hvad der er forskellen på at **skrive i et felt** og at **sende en formular**. Peg på input og output i din kode. Næste gang lærer du at gemme data, når siden genindlæses.
