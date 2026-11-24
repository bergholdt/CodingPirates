# Piratkode: fra skattekiste til Rails

Et dansk undervisningsforløb til Coding Pirates: **5 gange à 2 timer**, cirka 13 år, ingen forkundskaber. Eleverne bygger først et spil og udvikler derefter en piratlogbog med formularer, dynamiske sider og en rigtig database.

**Elevudstyr:** Windows, Visual Studio Code og en browser. Gang 1-3 kører som lokale filer. Gang 4-5 kører i en lokal **Dev Container**. Installér Docker Desktop og VS Code-udvidelsen Dev Containers inden gang 4; Ruby, Rails og SQLite følger med kursusmiljøet. Der kræves ingen fjernserver eller SSH-adgang. Arbejd gerne to sammen og skift tastatur hvert tiende minut.

## Start her

1. Hent repoet via **Code → Download ZIP** på GitHub, og vælg **Udpak alle** i Windows.
2. Læs [editorvejledningen](docs/EDITOR.md), og åbn [gang 1](undervisning/01-skattekisten/README.md).
3. Kopiér dagens `start`-mappe til din egen arbejdsmappe. Til gang 4-5 åbner du hele den udpakkede kursusmappe i VS Code og følger [Dev Container-vejledningen](docs/DEVCONTAINER.md). Redigér dagens `start`-mappe dér.
4. Brug `facit` som redningsbåd. Det er komplette, selvstændige eksempler; kopier ikke hele facit ind i en eksisterende fil.

[Åbn hele elevhæftet i browseren](kursus.html). Hæftet virker offline og kan printes med Ctrl + P. [Hent elevhæftet som PDF](docs/print/piratkode-elevhaefte.pdf).

| Gang | Det bygger vi | Nye begreber | Hvor kører det? |
|---|---|---|---|
| [1: Skattekisten](undervisning/01-skattekisten/README.md) | Et klikspil | HTML, CSS, JavaScript, variabel, if | Lokale filer |
| [2: Piratprofilen](undervisning/02-piratprofil/README.md) | Formular og levende profilkort | label, input, select, submit, DOM | Lokale filer |
| [3: Den lokale logbog](undervisning/03-lokal-logbog/README.md) | En liste over eventyr | objekter, arrays, løkker, JSON, localStorage | Browserlager |
| [4: Flaskepost med Rails](undervisning/04-flaskepost/README.md) | Formular med serversvar | Ruby, HTTP, routes, controller, ERB | Lokal Dev Container |
| [5: Den fælles logbog](undervisning/05-faelles-logbog/README.md) | Indlæg delt mellem browsere på samme PC | model, migration, Active Record, SQLite | Lokal Dev Container + SQLite-fil |

**Bemærk gang 3:** localStorage på en dobbeltklikket `file:`-side kan variere mellem browsere. Test elevmaskinerne. Der vises en besked, hvis lagring fejler. Prøv en anden browser, hvis lagring afvises, og aftal samme browser og filplacering til øvelsen.

## Til underviseren

- [Underviserguide](docs/UNDERVISER.md): læringsmål, forberedelse, differentiering og forklaringer. Hver elevvejledning har en fuld 120-minutters plan.
- [Lokal Dev Container](docs/DEVCONTAINER.md): installation, opstart, gemning og fejlfinding.
- [Tekniske valg og kilder](docs/TEKNIK.md): afgrænsning, versioner og hvor data gemmes.
- [Ordbog og fejlfinding](docs/ORDBOG-OG-FEJL.md).
- [Afprøvning og vedligeholdelse](tests/README.md).
- [Ekstra øvehæfte til skattekistespillet](docs/print/01-piratens-skat.pdf).
