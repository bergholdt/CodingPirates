# Gang 5: En fælles logbog med database

**Mission:** Gem eventyr, så andre kan læse dem, og vis appen online.

**Du lærer:** database, tabel, række, model, migration, validering og gem/hent med Active Record. Vi bruger SQLite: en rigtig database i en fil på serveren.

**Start:** Brug samme browsereditor. Gem gang 4, og stop dens Rails-server med Ctrl + C. Gang 5 har sin egen startmappe; dit arbejde fra gang 4 bliver liggende. Flaskepostdelen er allerede færdig i den nye mappe. Dagens nye filer er markeret nedenfor.

## Plan: 120 minutter

| Minutter | Aktivitet |
|---|---|
| 0-10 | Tegn forskellen på en lokal liste og en fælles database. |
| 10-25 | Undersøg modellen og migrationen; start appen. |
| 25-45 | Hent indlæg og forstå listen i viewet. |
| 45-55 | Gem første indlæg. |
| 55-65 | Pause. |
| 65-85 | Test fra to browsere, fejl og genstart. |
| 85-100 | Egen ændring, validering og bonus. |
| 100-115 | Underviserstyret deploy med Kamal; se adressen virke. |
| 115-120 | Vis jeres app og forklar, hvor data bor. |

Deploy er forberedt og øvet af underviseren. Hvis netværket driller, viser I den fungerende app på udviklingsadressen; databaseøvelsen kan stadig gennemføres.

## 1. Fra papirkort til database

Tegn en tabel med kolonnerne `id`, `pirat` og `tekst`. Skriv tre eventyr på hver sin række. Databasen husker disse rækker for os. `id` er et unikt nummer; to pirater må gerne have samme navn.

I sidste gang kendte serveren kun den aktuelle formular. Nu gemmer vi den i en database, som serveren kan læse igen senere. Det kaldes **persistens**: data overlever den enkelte forespørgsel og en genstart.

## 2. Modellen og migrationen

Åbn `05-faelles-logbog/start/app/models/entry.rb`:

```ruby
class Entry < ApplicationRecord
  validates :pirat, presence: true, length: { maximum: 24 }
  validates :tekst, presence: true, length: { maximum: 280 }
end
```

En **model** forbinder Ruby med data. `Entry` betyder et indlæg. Rails forbinder modellen `Entry` med tabellen `entries`. Vi bruger engelske navne til Rails-klasser og almindelige danske tekster på siden.

`validates` fortæller, hvilke regler der gælder: begge felter skal have indhold, og de må ikke være for lange.

Åbn filen i `db/migrate`. Den har et tidsstempel i navnet:

```ruby
create_table :entries do |t|
  t.string :pirat, null: false
  t.text :tekst, null: false
  t.timestamps
end
```

En **migration** beskriver en ændring af databasens struktur. Denne laver tabellen. Rails tilføjer et id; `timestamps` tilføjer oprettelses- og ændringstid. Migrationen ligger klar som hjælpekode; du skal forstå felterne, ikke lære kommandoerne udenad.

Start nu appen i terminalen:

```sh
cd /workspace/undervisning/05-faelles-logbog/start
bin/rails db:prepare
bin/rails server -b 0.0.0.0
```

`db:prepare` opretter databasen og kører de migrationer, der mangler. Kommandoen sletter ikke eksisterende indlæg. Åbn eller opdater app-adressen. Listen er tom, og startversionen gemmer endnu intet.

## 3. Hent data

Åbn `app/controllers/entries_controller.rb`. Der er **to** linjer med `TRIN 1`. Erstat hver af dem med:

```ruby
@entries = Entry.order(id: :desc).limit(50)
```

Her beder vi modellen hente de seneste 50 indlæg, med højeste id først. `@entries` er en samling af modeller. Den ene linje bruges til den almindelige side, den anden til at vise siden igen ved ugyldigt input.

Åbn `app/views/entries/index.html.erb`, og find:

```erb
<% @entries.each do |entry| %>
  <li><strong><%= entry.pirat %></strong>: <%= entry.tekst %></li>
<% end %>
```

Ruby-`each` minder om JavaScripts `forEach`: én tur gennem løkken for hvert indlæg. Viewet er allerede skrevet, så det kan vise de data, I henter.

## 4. Gem et indlæg

Tilbage i `entries_controller.rb`: erstat linjen `if false # TRIN 2...` med:

```ruby
if @entry.save
```

Den udleverede linje før betingelsen bygger en ny model:

```ruby
@entry = Entry.new(entry_params)
```

`new` bygger et objekt i hukommelsen. `save` kontrollerer reglerne og gemmer i databasen, hvis de er opfyldt. Derfor er `new` alene ikke nok.

`entry_params` nederst i filen accepterer kun felterne `pirat` og `tekst`. Når det lykkes, sender `redirect_to` browseren til listen. Det gør, at almindelig F5 ikke sender den samme formular igen. Hvis data er forkerte, viser Rails formularen med de indtastede værdier og en fejlbesked.

**Kontrol:** Gem filen, opdater browseren og send et eventyr. Det skal dukke op i listen, og formularen bliver tom.

## 5. Se ind i databasen

Åbn en ekstra terminal i samme appmappe:

```sh
bin/rails runner 'puts Entry.count'
```

Det viser antallet af indlæg. Rails bruger SQL under overfladen. Underviseren viser en forespørgsel direkte i SQLite:

```sh
sqlite3 storage/development.sqlite3 'SELECT id, pirat, tekst FROM entries;'
```

`SELECT` læser rækker. En gemning bruger normalt `INSERT`. I har fået en første smagsprøve på begge lag: Ruby-modellen og databasen bag den.

## Makkerprøven

1. Gem to eventyr. Er det nyeste øverst?
2. Tryk F5 flere gange. Antallet af indlæg skal være uændret.
3. Åbn **samme app-adresse** på en anden maskine og log ind. Kan I læse begge indlæg? En anden holds adresse har sin egen database.
4. Stop Rails-serveren med Ctrl + C og start den igen med samme kommando og mappe. Er indlæggene der stadig?
5. Send kun mellemrum. Der skal komme en fejl og ingen ny række.
6. Skriv `<b>Skat!</b>` i et eventyr. Det skal vises som tekst, ikke udføres som HTML.

Listen opdateres ved en ny sideindlæsning, ikke automatisk i alle åbne faner. Klik *Hent nyeste eventyr*, når en makker har skrevet.

## Bonusmissioner

- **Let:** Vis tidspunktet under hvert indlæg. Hint: `entry.created_at.strftime("%d/%m %H:%M")`.
- **Mellem:** Sæt tekstgrænsen til 140 tegn. Ret modellen, formularens `maxlength` og fejlbeskeden, så regler og beskeder stemmer overens. Undersøg, om serveren også afviser for lang tekst.
- **Svær:** Tilføj et skibsnavn via en ny migration, model, formular og `entry_params`. Få underviseren til at hjælpe med migrationskommandoen. Redigér ikke en allerede kørt migration for at ændre tabellen.

## 6. Gør appen tilgængelig med Kamal

Underviseren hjælper med at tage en kopi af jeres færdige kode, gemme den i Git og køre deployment. I ændrer selv en overskrift, som gør jeres app genkendelig.

Se forløbet: **kode → Docker-image → server → webadresse**. Kamal starter appen og forbinder adressen med den. Databasen ligger i en separat volume, som bliver bevaret, når appens kode udskiftes.

Udviklingsdatabasen flyttes ikke automatisk til den publicerede app. Skriv et nyt testeventyr på den publicerede adresse, deploy en lille tekstændring, og kontrollér, at indlægget stadig findes. Det er vores sidste persistensprøve.

## Før du går

Forklar med egne ord: Hvad kører i browseren? Hvad kører på serveren? Hvor gemmes eventyrene? Hvad er forskellen på at gemme kode i Git og at gemme data i SQLite?

Du har nu bygget både en hjemmeside, et spil, en formular, dynamisk indhold og en app med database.
