# Rails på din egen computer

Til gang 4 og 5 bruger vi **VS Code Dev Containers**. Containeren indeholder Ruby, Rails og SQLite. Du redigerer i VS Code og ser appen i din almindelige browser. Alt kører lokalt; du skal ikke forbinde til underviserens server.

## Før gang 4: få hjælp af en voksen

Installationen og den første opstart skal være færdige inden undervisningen. Der hentes værktøjer fra internettet, og første build kan tage tid.

1. Installér [Visual Studio Code](https://code.visualstudio.com/download), hvis det ikke allerede er på computeren.
2. Kontrollér [Docker Desktops aktuelle Windows-systemkrav](https://docs.docker.com/desktop/setup/install/windows-install/). Der kræves en understøttet Windows-version, mindst 8 GB RAM og aktiveret hardwarevirtualisering. Brug **WSL 2** og **Linux containers**. En voksen hjælper med Windows-funktioner, opdateringer og eventuel genstart. På en administreret skolecomputer skal skolens IT hjælpe, hvis installationen er låst.
3. Installér Docker Desktop fra samme officielle side, og start programmet. Vent, til Docker-motoren kører. Hvis Docker efterspørger en nyere WSL, følg installationsvejledningen og genstart efter behov.
4. Åbn Extensions i VS Code med **Ctrl + Shift + X**. Installér **Dev Containers**, udgivet af **Microsoft** (`ms-vscode-remote.remote-containers`).

På Mac bruges [Docker Desktop til Mac](https://docs.docker.com/desktop/setup/install/mac-install/) til den rigtige processor: Apple Silicon eller Intel. På Linux kan underviseren bruge Docker Engine og samme Dev Containers-udvidelse.

Du skal ikke installere Ruby, Rails, SQLite, Node eller Git separat for at følge øvelserne. Hvis computeren ikke kan køre Docker, arbejder du sammen med en makker på en afprøvet computer. Gang 1-3 kræver stadig kun editor og browser.

## Åbn kursusmappen første gang

1. Hent kursusmaterialet via **Code → Download ZIP**, eller få ZIP-filen af underviseren. Vælg **Udpak alle** i Stifinder.
2. Læg den udpakkede mappe et fast sted på computeren, fx `C:\Users\dit-navn\Piratkode`. Brug en lokal mappe uden for OneDrive, iCloud og netværksdrev. Arbejd ikke inde i ZIP-filen.
3. Åbn **File → Open Folder** i VS Code. Vælg **hele kursusmappen**, hvor `README.md`, `.devcontainer`, `.vscode` og `undervisning` ligger. Til gang 4-5 skal du ikke åbne en enkelt `start`-mappe som projekt.
4. Hvis VS Code spørger om tillid, få underviseren til at bekræfte, at det er de udleverede kursusfiler.
5. Tryk **Ctrl + Shift + P**, skriv **Dev Containers: Reopen in Container**, og vælg kommandoen. På Mac bruges Cmd + Shift + P.
6. Vent på, at miljøet bliver bygget, og opsætningen er færdig. VS Code viser containerens navn i nederste venstre hjørne. Der installeres værktøjer og klargøres databaser; din elevkode bliver ikke erstattet med facit.

Åbn **Terminal → New Terminal** og prøv `ruby --version`. Hvis du ser en Ruby-version, er terminalen inde i det rigtige miljø.

## Start appen

1. Vælg **Terminal → Run Task → Start app**.
2. Vælg **Gang 4 - min flaskepost** eller **Gang 5 - min logbog**. Facitmulighederne åbner de færdige eksempler og har egne databaser.
3. Vent på, at terminalen viser, at Rails lytter på port 3000.
4. Åbn **http://localhost:3000** i din almindelige browser. Du skal ikke logge ind.

Redigér filerne under dagens `undervisning/.../start`. Gem med **Ctrl + S**, og opdater browseren med **F5**. Ruby-koden kører i containeren, og browseren modtager HTML.

`localhost` betyder **denne computer**. En makker på en anden computer ser ikke din app ved at skrive samme adresse. I gang 5 tester vi den fælles database med to forskellige browsere på samme computer.

## Stop, skift opgave og kom tilbage

Klik i terminalen, hvor Rails kører, og tryk **Ctrl + C**. Vent, til serveren er stoppet. Vælg derefter **Start app** igen og den nye opgave. Der kan kun køre én kursusapp på port 3000 ad gangen.

Når du er færdig: gem alle filer, stop appen, og luk VS Code. Du kan stoppe kursuscontaineren i Docker Desktop. Næste gang starter du Docker Desktop, åbner **samme kursusmappe** i VS Code og vælger **Reopen in Container**, hvis den ikke allerede er åben dér. Start derefter appen igen.

## Hvor bliver arbejdet gemt?

| Indhold | Placering |
|---|---|
| Din kode | Dagens `start`-mappe i den lokale kursusmappe |
| Logbogens database | `undervisning/05-faelles-logbog/start/storage/development.sqlite3` |
| Ruby, Rails og værktøjerne | Containerens image |

Kursusmappen er tilgængelig inde i containeren som `/workspace`. Det er de samme filer, du kan finde i Stifinder. Stop, genstart og **Dev Containers: Rebuild Container** bevarer dem. En genopbygning kan kræve internet igen. Slet ikke kursusmappen for at genstarte miljøet.

**Backup:** Stop Rails med Ctrl + C, og kopiér hele kursusmappen til en backupmappe eller et USB-drev. Databaser er udeladt fra Git; en Git-commit er derfor ikke en backup af indlæggene. Ved gendannelse bruger du en separat mappe og åbner den i VS Code. Stop den oprindelige app, før du starter kopien på port 3000.

## Når noget driller

| Problem | Prøv dette |
|---|---|
| Reopen in Container findes ikke | Kontrollér, at Microsofts Dev Containers-udvidelse er installeret. |
| VS Code foreslår at vælge en containeropskrift | Du har sandsynligvis åbnet en undermappe. Åbn hele kursusmappen med `.devcontainer`. |
| Cannot connect to Docker | Start Docker Desktop, og vent på, at motoren kører. |
| WSL eller virtualisering fejler | Få en voksen til at følge Docker-installationsvejledningen. Fortsæt på en afprøvet makkermaskine imens. |
| Første opstart fejler ved download | Kontrollér internetforbindelsen. Brug Rebuild Container efter forbindelsen er tilbage. |
| localhost:3000 svarer ikke | Kontrollér, at Start app stadig kører. Åbn VS Codes **Ports**-panel, og kontrollér videresendelsen af port 3000. |
| Port 3000 er optaget | Stop den forrige kursusapp med Ctrl + C. Luk også andre kursusprojekter, som bruger porten. Bed underviseren undersøge andre programmer, før de stoppes. |
| Ruby findes ikke, eller kommandoen køres i PowerShell | Åbn mappen i containeren, og brug **Terminal → New Terminal** inde i VS Code. |
| Koden ændrer ikke den viste side | Kontrollér, om Start app kører start eller facit, og gem den tilsvarende fil. |
| Gamle indlæg mangler | Kontrollér kursusmappe og start/facit-valg. Hver app har sin egen database. Slet ikke filer for at prøve dig frem. |

## Senere kurser

Dev Containers kan også bruges med fx PHP eller .NET. Et nyt kursus får sin egen opskrift med de nødvendige værktøjer; elevernes arbejdsgang er stadig at åbne projektet i en container og starte appen. Dette kursusmiljø indeholder Ruby og Rails.

Kilde: [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).
