# Gang 1: Skattekisten

**Mission:** Byg et spil, hvor et klik finder guld. Du vinder ved mindst 20 guld.

**Du lærer:** at HTML giver indhold, CSS giver udseende, og JavaScript giver handling. Du møder en variabel, en funktion og en betingelse.

**Filer:** Kopiér `start` til din egen mappe, og åbn mappen i VS Code. Åbn `index.html` i browseren. Se [editorhjælpen](../../docs/EDITOR.md). Det færdige spil ligger i `facit/index.html`. Den [oprindelige PDF](../../docs/print/01-piratens-skat.pdf) kan også bruges til denne gang.

## Plan: 120 minutter

| Minutter | Aktivitet |
|---|---|
| 0-10 | Spil underviserens eksempel. Gæt, hvordan det virker. |
| 10-20 | Åbn VS Code, find filen, og lær gem → opdater. |
| 20-40 | Byg indhold med HTML. |
| 40-55 | Giv spillet farver med CSS. |
| 55-65 | Pause væk fra skærmen. |
| 65-90 | Få knappen til at finde guld med JavaScript. |
| 90-110 | Tilføj sejr, afprøv med en makker og løs en bonus. |
| 110-120 | Vis spillet og forklar én linje kode. |

## 1. HTML: Byg indholdet

I `index.html` finder du kommentaren `TRIN 1`. Erstat den med:

```html
<h1>Piratens skat</h1>
<p>Find mindst 20 guld for at vinde!</p>
<button id="kiste">Åbn skattekisten</button>
<p>Dit guld: <span id="guld">0</span></p>
<p id="besked">Er du klar, kaptajn?</p>
```

Gem med **Ctrl + S** i editoren. Skift til browseren og tryk **F5**. Knappen vises, men gør endnu ingenting.

Et **tag** fortæller, hvad noget er. `<h1>` starter en stor overskrift; `</h1>` afslutter den. `<p>` er et afsnit. Et `id` er et unikt navneskilt. JavaScript skal bruge `kiste`, `guld` og `besked` senere, så behold de navne.

**Miniopgave:** Giv overskriften et andet navn. Hvad ændrer `<title>` i toppen af filen? Prøv og kig på browserens faneblad.

## 2. CSS: Giv spillet dit look

Erstat kommentaren `TRIN 2` inde i `<style>` med:

```css
body {
  background: #14213d;
  color: white;
  font-family: Arial, sans-serif;
  text-align: center;
  padding: 40px;
}
h1 {
  color: gold;
  font-size: 42px;
}
p {
  font-size: 22px;
}
button {
  background: gold;
  color: black;
  font-size: 24px;
  padding: 20px;
  border: 4px solid orange;
  border-radius: 12px;
  cursor: pointer;
}
button:hover {
  background: orange;
}
```

`h1` vælger overskrifter. `{ }` holder indstillingerne samlet. `color: gold;` giver tekstfarven guld. Kolon og semikolon er en del af sproget.

**Kontrol:** Siden er mørk, teksten er lys, og knappen skifter farve under musen.

**Designlaboratorium:** Skift én værdi ad gangen. Prøv `border-radius: 0px`, `font-size: 32px` eller en anden baggrund. Bevar en tekstfarve, som er let at læse. Vis makkeren, hvilken regel du ændrede.

## 3. JavaScript: Få noget til at ske

Erstat kommentaren `TRIN 3` inde i `<script>` med:

```javascript
var guld = 0;
var knap = document.getElementById("kiste");
var guldtal = document.getElementById("guld");
var besked = document.getElementById("besked");

knap.onclick = function() {
  var fund = Math.floor(Math.random() * 3) + 1;
  guld = guld + fund;
  guldtal.textContent = guld;
  besked.textContent = "Du fandt " + fund + " guld!";
};
```

**Kontrol:** Ét klik giver 1, 2 eller 3 guld, og tallet på siden ændrer sig.

En **variabel** husker en værdi. `guld = guld + fund` tager den gamle værdi, lægger fundet til og gemmer det nye tal. `textContent` ændrer teksten i et HTML-element. En **funktion** samler de instruktioner, som skal køres ved et klik.

Linjen med `Math.random()` vælger et tilfældigt antal. Du behøver ikke lære hele regnestykket udenad. Prøv at ændre 3 til 6, og undersøg forskellen.

## 4. Tilføj en sejr

Indsæt dette **inde i klikfunktionen**, lige efter linjen der begynder med `besked.textContent`, og før den afsluttende `};`:

```javascript
if (guld >= 20) {
  besked.textContent = "Du vandt, kaptajn!";
  knap.textContent = "Skatten er din!";
  knap.disabled = true;
}
```

`if` betyder *hvis*. `>=` betyder *større end eller lig med*. Det er nødvendigt, fordi spilleren kan hoppe fra 19 til 22 guld. `disabled` slår knappen fra. F5 starter et nyt spil med 0 guld.

## Makkerprøven

1. Start på 0. Klik én gang. Fik du mellem 1 og 3 guld?
2. Spil til mindst 20. Stopper knappen, og står der, at du vandt?
3. Opdater siden. Er guldet tilbage på 0?
4. Skift tastatur. Lad makkeren ændre målet til 50 både i HTML-teksten og JavaScript.

## Bonusmissioner

- **Let:** Gør det til et rumspil med krystaller. Ret overskrift, knap og beskeder.
- **Mellem:** Tæl klik i en ny variabel. Vis dem i et ekstra `<span id="klik">`.
- **Svær:** Tilføj en ny knap, der starter forfra uden F5. Den skal nulstille guldet, teksten og `disabled`.

**Hint til svær:** Find startknappen med `getElementById`. I dens klikfunktion sættes `guld = 0`, guldtallet opdateres, og `knap.disabled = false`.

## Før du går

Vis, hvor HTML, CSS og JavaScript ligger. Forklar: Hvorfor forsvinder guldet ved F5? Skriv en sætning om, hvad du vil lave om næste gang. Gem mappen; den er dit første spil.
