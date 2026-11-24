# Afprøvning og vedligeholdelse

Disse værktøjer er til underviser/vedligeholder. Eleverne behøver ingen af installationerne nedenfor.

## Frontend

Med Node på din egen maskine:

```sh
node tests/frontend.cjs
```

Kontrollerer point og sejr, formularinput, trimning, JSON-genindlæsning, sletning og lagerfejl. Brug også browserprøverne i elevvejledningerne, da en JavaScript-test ikke kan garantere en bestemt elevbrowsers file/localStorage-politik.

## Rails

Byg workshop-imaget som beskrevet i driftsguiden. Fra repoets rod på en udviklingsmaskine, der må køre betroet kursuskode:

```sh
docker run --rm --entrypoint sh \
  -v "$PWD:/kursus" \
  piratkode-workshop:2026-11 /kursus/tests/rails.sh
```

Dette bind-mount er kun et vedligeholdelsestestmiljø. Elevernes Compose-filer bruger named volumes og monterer ikke værtens repo. Tests opretter kun Rails-testdatabaser under de fire appmapper; brug ikke produktionsdata til test.

Testene dækker alle fire Rails-apps: forventet startadfærd, formularer, validering, CSRF-afvisning, escaped output, modelregler, gemning, visning i ny session og grænse/rækkefølge på 50 indlæg. Nogle databasetests er kun relevante i gang 5 og udfører derfor ingen databasepåstande i gang 4.

## Manuel acceptprøve før et hold starter

- Alle tre lokale facitapps åbner og virker på en faktisk elevmaskine.
- localStorage overlever F5 på den valgte adresse, eller eleven får en klar fejlbesked.
- Browsereditoren virker over HTTPS, inklusive terminal og filgemning.
- Hvert hold kan starte gang 4 og 5 uden at installere gems.
- To browsere kan læse samme database, og to hold har forskellige databaser.
- Gem et eventyr, stop/start containeren, start Rails igen, og kontrollér indlægget.
- Tag backup og afprøv gendannelse i et separat testhold.
- En lille Kamal-deploy bevarer et eksisterende produktionsindlæg.

Den sidste del kræver underviserens rigtige server, DNS, proxy og secrets. Den kan ikke bevises alene ved at bygge repoet lokalt.
