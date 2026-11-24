# Underviserguide: fem gange à to timer

Målgruppe: cirka 13 år, begyndere. Arbejd helst i makkerpar. Den ene skriver, den anden læser og leder efter fejl; byt cirka hvert tiende minut. Hold korte fælles oplæg på højst 5-8 minutter, og lad resten være konkrete forsøg.

## Mål og progression

| Gang | Minimumsprodukt | Eleven kan forklare | Hjælp og udvidelse |
|---|---|---|---|
| 1 | Et spil med point og sejr | Indhold, udseende og handling | Hjælp: færdig CSS. Udvidelse: klik-tæller og genstart. |
| 2 | En formular, der ændrer et profilkort | Input, submit og output | Hjælp: elementerne er fundet. Udvidelse: skibsnavn og farvevalg. |
| 3 | En logbog, der overlever F5 | Objekt, liste og lokal lagring | Hjælp: vis-funktionen. Udvidelse: tæller, tidspunkt og rækkefølge. |
| 4 | En Rails-formular med serversvar | Browser, route, controller og view | Hjælp: to linjer params. Udvidelse: ekstra formularfelt. |
| 5 | En logbog med database | Model, gem, hent og persistens | Hjælp: SQL-demonstration. Udvidelse: ny kolonne/migration. |

De præcise planer på 120 minutter står i hver elevvejledning. Alle indeholder en ti minutters pause. Bonusser er valgfri differentiering; de skal ikke alle gennemføres.

## Før forløbet

- Prøv VS Code og browseren på den ældste elevmaskine. Se [editorvejledningen](EDITOR.md). Installer editoren før første møde, så installation ikke optager undervisningstiden.
- Hent og udpak materialet. Lav gerne et USB-drev eller en lokal filkopi som reserve til de første tre gange.
- Afprøv gang 3 på samme adresse og browser, eleverne skal bruge. localStorage på file-adresser er ikke ens i alle browsere. Forbered eventuelt en statisk HTTPS-udgave.
- Byg Docker-imaget, opret hold og gennemfør [driftsprøven](DRIFT.md) inden gang 4. Giv hvert par et lille kort med editoradresse, appadresse, holdnavn og password. Passwords skal ikke stå i det offentlige repo eller i det printede fællesmateriale.
- Test alle hold samtidig og prøv login fra lokalets netværk. Kontrollér, at terminalen virker, og at en Rails-side faktisk kan åbnes via proxyen.
- Gør en egen facitapp klar til projektion. Forbered Kamal-deploy inden gang 5, inklusive registry, hostnavn, secrets og en afprøvet volume. Deploy må ikke blive en fejlsøgningssession, som stjæler databaseøvelsen.

## Gentag den samme undervisningsrytme

1. **Forudsig:** Hvad tror du, ændringen gør?
2. **Ændr:** Skriv få linjer eller ændr én værdi.
3. **Afprøv:** Gem og se resultatet.
4. **Forklar:** Fortæl din makker, hvad der skete.

Når nogen sidder fast, så spørg: Hvad forventede du? Hvad skete der? Hvilken fil ændrede du sidst? Lad eleven selv pege og skrive. Find først én fejl; undgå at rette hele filen på én gang.

## Gang 1: lad alle få en succes

Vis spillet i 30 sekunder. Lad dem gætte, hvad der ændrer pointtallet. Bed dem først ændre synlig tekst, så sammenhængen mellem kode og browser er tydelig.

Det store skrivearbejde er HTML og CSS. Hvis nogen bruger meget tid på tegn, kan de kopiere CSS fra facit og selv skrive den centrale JavaScript. Slutmålet er et forstået, fungerende klik, ikke et bestemt antal indtastede linjer.

**Typiske fejl:** F5 i editoren i stedet for browseren, `.html.txt`, manglende slut-tag, forkert id, forskel på store/små bogstaver. Vis Ctrl + Z og editorens formatér-funktion som hjælp.

**Opsamling:** Eleven peger på én linje fra hvert af de tre sprog. Spørg, hvorfor målet bruger `>=` frem for `===`.

## Gang 2: formularen som samtale

Sammenlign med at skrive en besked: feltet er input, klik/Enter er en hændelse, og kortet er output. Skeln mellem browserens normale submit og `preventDefault`.

Lad eleverne bruge tastaturet til Tab og Enter. Korrekte labels hjælper både mus, tastatur og skærmlæser. Forklar `name` nu, selv om det først bliver tydeligt på serveren senere.

**Typiske fejl:** Kun at gemme HTML, selv om CSS/JS er ændret; at bruge `textContent` til at læse et input; at sætte JavaScript ind i CSS-filen. Vis filerne i venstre side.

**Opsamling:** Eleven kan vise `value` og `textContent` og fortælle, hvilken vej data flytter sig.

## Gang 3: data har en form og en adresse

Brug papirkort med navn og eventyr. Ét kort er et objekt, en bunke er et array. Peg på forskellen mellem at ændre listen i hukommelsen, at tegne den i DOM og at skrive JSON i lageret. Tre operationer, tre forskellige formål.

Lad en anden browser være dagens overraskelse: data er ikke fælles endnu. Undgå at kalde localStorage en delt serverdatabase. Fortæl, at browseren kan rydde data, og at man ikke skal bruge personlige oplysninger i øvelsen.

**Typiske fejl:** Dubletter i visningen, fordi listen ikke ryddes; manglende `JSON.stringify`; samme nøgle bruges ikke ved gem og hent; filen er flyttet, så lageret ikke følger med.

**Opsamling:** Eleven afprøver F5 og kan forklare, hvorfor den anden maskine ikke har indlæggene.

## Gang 4: fra formular til serversvar

Vis et kort Ruby-eksempel, og lad eleverne forklare, hvad det gør. Undgå en lang introduktion til klasser, arv og hele Rails-mappetræet. Dagens fokus er tre steder: route, controller og view.

Lad en elev spille browser, en anden route og en tredje controller. Et papirkort med feltnavne sendes til den rigtige person, som skriver et svar. Databasen er endnu ikke med i rollespillet.

Startmiljøet indeholder bevidst det tekniske arbejde: server, gems, layout, CSRF-beskyttelse og valideringsstruktur. Eleverne skriver params-linjerne og ERB-output. De skal vide, hvad hjælpekoden gør, men ikke håndskrive den alt sammen.

**Typiske fejl:** Rails er ikke startet; den forkerte start/facitmappe redigeres; sidste gangs server kører stadig; et `end` mangler; Ruby skrives uden for ERB-tegn i et view.

**Opsamling:** Eleven kan følge en POST fra formular til controller og tilbage til HTML.

## Gang 5: modellen husker

Udvid rollespillet med en databaseperson, som lægger kort i en kasse. Efter genstart er kortene stadig der. Vis modelnavnet `Entry` og tabelnavnet `entries`, men brug ikke tiden på engelske bøjningsregler.

Gennemgå migrationen som en beskrivelse af tabellen. Vis, at `Entry.new` ikke gemmer noget, mens `save` først kontrollerer reglerne og derefter skriver til databasen. Brug `runner` og en enkel SELECT til at gøre Rails' arbejde synligt.

**Typiske fejl:** Kun den ene hent-linje er rettet; `if false` er ikke erstattet; `db:prepare` er ikke kørt; den gamle server er stadig på port 3000; elever forventer automatisk live-opdatering i alle browsere.

Til deploy vælger hvert par en lille personlig overskrift. Hvis alle ikke kan nå individuelt deploy, demonstrér på ét pars app i fællesskab og færdiggør de øvrige bagefter. Alle skal stadig teste deres egen database.

**Opsamling:** Eleven tegner browser, Rails og SQLite og kan placere HTML, CSS, JavaScript, Ruby og data.

## Redningsbåde og tempo

- Hvis et par er bagefter, kopier den mindste manglende blok fra facit. Bed dem forklare den og ændre én værdi. Undgå at erstatte hele deres personlige arbejde uden aftale.
- Hvis et par er hurtigt færdigt, giv en bonus med en tydelig test: eksempelvis ny grænse, ny rolle eller en ny kolonne. Lad dem hjælpe med spørgsmål frem for at overtage andres tastatur.
- Hvis serveren er utilgængelig, brug første gangs lokale spil til at øve formular og dynamik. Brug diagram og printede Rails-filer til at følge en request. Reel serverpersistens kræver, at serveren kommer tilbage; kald ikke papirøvelsen en fungerende database.
- Hold fem minutter til oprydning, gemning og en kort mundtlig refleksion hver gang.

## En enkel vurdering

Giv ingen karakterer. Markér i stedet tre niveauer: **jeg fik det til at virke**, **jeg kan forklare det**, **jeg kan ændre det selv**. Lad eleverne vælge én ting fra hver mødegang og vise den frem.
