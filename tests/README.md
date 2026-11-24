# Afprøvning og vedligeholdelse

Disse kontroller er til underviseren og vedligeholderen. Eleverne følger [Dev Container-vejledningen](../docs/DEVCONTAINER.md).

## Frontend

På en maskine med Node:

```sh
node tests/frontend.cjs
```

Kontrollerer point og sejr, formularinput, trimning, JSON-genindlæsning, sletning og lagerfejl. Afprøv også de lokale filer i elevernes browsere, da file/localStorage-adfærd kan variere.

## Rails

Inde i Dev Containeren, fra kursusmappens rod:

```sh
sh tests/rails.sh
```

Testene dækker alle fire Rails-apps: startadfærd, formularer, validering, CSRF-afvisning, escaped output, modelregler, gemning, læsning i en ny browsersession og grænsen på 50 indlæg. Databasekontroller, som ikke gælder for den pågældende app, bliver sprunget over. Tests bruger separate testdatabaser; de sletter testindlæg, men ændrer ikke udviklingsdatabasen.

For at afprøve i en isoleret kopi uden VS Code, kør fra repoets rod på en maskine med Docker:

```sh
docker build -f .devcontainer/Dockerfile -t piratkode-dev:2026-11 .
docker build -f tests/Dockerfile -t piratkode-tests:2026-11 .
```

Det andet build kopierer koden til testimaget og kører Rails-testene dér. Den lokale kursusmappe bliver ikke monteret i dette testmiljø.

## Praktisk prøve før undervisningen

- Åbn hele kursusmappen med **Reopen in Container** på en faktisk elevmaskine. Første build og opsætning skal lykkes før gang 4.
- Kør alle fire valg under **Start app**, ét ad gangen. Stop hver app med Ctrl + C før næste valg.
- Besøg `http://localhost:3000`, og kontrollér, at VS Codes Ports-panel videresender port 3000 til localhost.
- Gem en kodeændring, og kontrollér resultatet efter genindlæsning.
- Gem et eventyr i gang-5-facit eller en færdig elevversion. Kontrollér samme indlæg i en anden browser på samme computer.
- Stop og start Rails. Stop og genåbn containeren. Genopbyg derefter containeren. Kontrollér efter hvert trin, at både kodeændring og indlæg findes.
- Kontrollér, at start og facit har separate databaser.
- Stop Rails, tag en filbackup, og afprøv kopien i en separat mappe. Stop originalens app før kopien startes på samme port.
- Afprøv de første tre øvelser uden container, inklusive localStorage efter F5.

Et bestået Docker-build erstatter ikke prøven med VS Code på elevernes Windows-maskiner.
