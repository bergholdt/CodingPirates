# Ordbog og fejlfinding

## Ordbog

| Ord | Kort forklaring |
|---|---|
| HTML | Beskriver indholdet på en side. |
| Tag | En markering som `<p>` eller `</p>`. |
| CSS | Regler for sidens udseende. |
| JavaScript | Kode, vi kører i browseren for at reagere på handlinger. |
| Variabel | Et navn, som peger på en værdi. |
| Funktion/metode | En navngivet eller samlet portion kode. |
| Event | Noget der sker, fx klik, input eller submit. |
| DOM | Browserens model af sidens elementer. |
| Formular | Felter og en måde at sende deres indhold på. |
| Validering | At kontrollere, om data følger reglerne. |
| Objekt | Flere egenskaber samlet om én ting. |
| Array | En liste med værdier eller objekter. |
| JSON | En tekstform, som kan beskrive lister og objekter. |
| localStorage | Lager i én browser, knyttet til sidens adresse. |
| Server | En computer/proces, der svarer på browserens forespørgsler. |
| HTTP, GET, POST | Måden browser og server taler sammen; hent en side eller send data. |
| Ruby | Programmeringssproget bag vores Rails-kode. |
| Rails | Et Ruby-framework med færdige dele til webapps. |
| Route | Vejviser fra en webadresse og metode til controllerkode. |
| Controller | Modtager en request og vælger, hvad der skal ske. |
| View/ERB | HTML-skabelon, der kan vise værdier fra Ruby. |
| Model | Ruby-objekt med regler og adgang til data. |
| Database | Struktureret lager med tabeller og rækker. |
| SQLite | En database, der ligger i en fil og ikke kræver en separat serverproces. |
| SQL | Sprog til at læse og ændre databasedata. |
| Migration | En versioneret ændring af databasens struktur. |
| Persistens | At data bliver bevaret mellem forespørgsler/genstarter. |
| Docker-image | En pakket opskrift på app og dens runtime. |
| Container | Et kørende miljø baseret på et image. |
| Dev Container | Et udviklingsmiljø, som VS Code åbner i en container på din computer. |
| localhost | Denne computer; samme adresse på en anden PC peger på den anden PC. |
| Bind mount | En lokal mappe, som også er tilgængelig inde i containeren. |
| Git-commit | Et gemt trin i programkodens historie; det er ikke en databasebackup. |

## Find fejlen

| Symptom | Prøv først |
|---|---|
| Ændringen vises ikke | Gem den rigtige fil. Opdater den rigtige browserfane. |
| HTML åbner som tekst | Kontrollér filtypen; filen må ikke hedde `.html.txt`. |
| CSS virker ikke | Kontrollér href, filnavn og at filen er i samme mappe. |
| JavaScript reagerer ikke | Kontrollér id'er og store bogstaver. Åbn F12 → Console og læs første fejl. |
| En liste vises dobbelt | Ryd listen før du tegner den igen; undersøg `visIndlaeg`. |
| Lokal logbog er væk | Samme browser, samme adresse og ikke privat browsing? Spørg før du sletter lageret. |
| Forkerte æ/ø/å | Gem som UTF-8, og behold `<meta charset="utf-8">`. |
| localhost:3000 svarer ikke | Start Docker Desktop, åbn kursusmappen i containeren, og vælg Start app. Kontrollér port 3000 i VS Codes Ports-panel. |
| Reopen in Container mangler | Installér Microsofts Dev Containers-udvidelse, og åbn hele kursusmappen. |
| Address already in use | Stop den gamle Rails-proces med Ctrl + C. Start ikke flere på port 3000. |
| Blocked host | Brug http://localhost:3000 på din egen computer. |
| Rails viser en syntax error | Gå til den nævnte fil/linje; se efter et manglende `end` eller anførselstegn. |
| Databasetabellen mangler | Kør `ruby bin/rails db:prepare` fra den rigtige appmappe. |
| Startversionen af gang 5 gemmer ikke | Er begge TRIN 1-linjer og `if false` erstattet? |
| Makkeren ser ikke mit indlæg | Brug to browsere på samme computer, og genindlæs. Appen deles ikke mellem computere. |
| Indlæggene ser ud til at være væk | Kontrollér, at du bruger samme kursusmappe og start/facit-app som før. De har hver sin database. |

## Tre gode fejlvaner

1. Læs den første fejl, ikke alle fejl på én gang.
2. Lav én lille ændring, gem og prøv igen.
3. Forklar din forventning til en makker, før I kopierer fra facit.
