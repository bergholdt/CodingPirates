# Underviserens Linux-server med Docker

Denne vejledning beskriver underviserens opsætning af værksteder til gang 4 og 5. Eleverne arbejder i browseren via HTTPS. SSH kan forblive begrænset til underviserens lokale netværk; elevadgang kræver ingen offentlig SSH-port. Underviseren administrerer Docker, domæner og HTTPS.

## Den valgte opbygning

```text
Elevens browser
  ├─ kode-hold01.example.dk → HTTPS-proxy → 127.0.0.1:18080 → browsereditor
  └─ app-hold01.example.dk  → HTTPS-proxy → 127.0.0.1:18081 → Rails :3000
                                                        samme holdcontainer
                                                        egen arbejdsvolume

Underviserens maskine → Kamal + registry → separat produktionscontainer
  └─ hold01.example.dk → HTTPS-proxy → 127.0.0.1:18090 → kamal-proxy → Rails
                                                        egen databasevolume
```

Hvert makkerpar får sin egen udviklingscontainer og en lille nginx-gateway. Gatewayen er den eneste container med publicerede localhost-porte og videresender kun HTTP/WebSocket til holdets editor og Rails. Den forbinder et adgangsnetværk med holdets interne netværk, fordi publicerede porte på et rent internt Docker-netværk ikke fungerer i alle Docker-opsætninger. Eleverne har en terminal inde i containeren, men ikke Docker-socket, SSH-nøgler til værten eller bind-mounts af værtens filsystem. Interne Docker-netværk er separate pr. hold og begrænser normal udgående netadgang. Udvidelser og nye gems installeres derfor af underviseren i fællesimaget, ikke under øvelsen.

Dette er isolation til et betroet undervisningshold, ikke en offentlig tjeneste til vilkårlig kode. Containere deler Linux-kernen. Ingen får hostens Docker-adgang; en separat Unix-bruger i docker-gruppen giver ikke tilstrækkelig isolation.

## Før du begynder

På **serveren** skal Docker Engine med Compose-plugin, Git og OpenSSL være tilgængelige. Brug officielle installationsvejledninger, som passer til din distribution. Du behøver ikke installere Ruby eller Rails på værten for at køre værkstederne.

Brug en eksisterende reverse proxy, hvis du har en. Eksemplerne nedenfor er til **Caddy på værtsmaskinen**; nginx eller Traefik kan udføre samme opgave. Hvis proxyen selv kører i Docker, er `127.0.0.1` dens egen container, ikke værtsmaskinen. Så skal upstream-netværket tilpasses bevidst; kopiér ikke host-eksemplet uændret.

Kontrollér ledige porte med `ss -ltn`. Eksemplerne bruger 18080/18081 til hold01, 18082/18083 til hold02 og 18090/18443 til Kamal-proxy. Lav ikke ændringer i en eksisterende Kamal-proxy uden at vurdere de apps, der allerede bruger den.

**Kapacitet:** Start med en prøve med ét hold, og se `docker stats`. Skabelonen begrænser hvert værksted til 1,5 GB RAM og 1,5 CPU; gatewayen har yderligere højst 64 MB RAM. Det er en budgetgrænse, ikke et målt minimum. Gang antallet af hold op og læg plads til vært, proxy, builds og produktionsapps til. Test hele klassen samtidig inden kursusstart. Docker-images kan bruge flere GB disk.

## 1. Hent og byg én gang

Hent undervisningsrepoet på serveren. Kør fra repoets rod:

```sh
docker build -f drift/Dockerfile -t piratkode-workshop:2026-11 .
```

Imaget indeholder Ruby 4.0.8, Rails 8.1.4.1, SQLite, låste gems og code-server 4.146.0. Ingen Node/npm-installation er nødvendig på elevmaskinerne. Første build henter afhængigheder fra nettet. Senere elevstart kræver ikke en ny installation.

## 2. Opret ét hold

Opret en privat holdmappe fra skabelonen. Brug en ny mappe for hvert hold:

```sh
mkdir -m 700 drift/hold/hold01
cp drift/hold.example/compose.json drift/hold/hold01/
cp drift/hold.example/nginx.conf drift/hold/hold01/
cp drift/hold.example/Caddyfile.example drift/hold/hold01/
cp drift/hold.example/env.example drift/hold/hold01/.env
chmod 600 drift/hold/hold01/.env
openssl rand -hex 24
```

Redigér `.env`: angiv holdnavn, appens domæne og to ledige porte. Indsæt det genererede password i både `PASSWORD` og `COURSE_PASSWORD`. Brug egne domæner i `Caddyfile.example`, og tilpas proxyportene til `.env`.

Kontrollér konfigurationen, og start holdet:

```sh
docker compose -f drift/hold/hold01/compose.json config --quiet
docker compose -f drift/hold/hold01/compose.json up -d
```

Kontrollér med `ss -ltn`, at portene er ledige, og brug forskellige porte til hvert hold.

`drift/hold/hold01/.env` indeholder holdets password og er udeladt fra Git. Editorlogin bruger kun password. Rails-login bruger `hold01` plus samme password. Del kun holdets eget password med makkerparret.

Første start kopierer materialet til holdets volume. Genstart kopierer ikke på ny og overskriver ikke elevkode. Nye repo-versioner opdaterer derfor ikke automatisk eksisterende elevmapper. Tag backup og kopier kun de aftalte filer ved en opdatering.

## 3. Giv browserne adgang

Lav DNS for begge værtsnavne. Flet holdets `Caddyfile.example` ind i din eksisterende host-Caddy-konfiguration, kontrollér den med `caddy validate`, og genindlæs via din normale driftsmetode. WebSocket-proxy skal virke for browsereditoren; Caddy håndterer den normalt direkte.

Caddy-eksemplet afslutter HTTPS og videresender til localhost-portene. Editor og app får hver sin adresse for at undgå problemer med Rails-routes under en `/proxy/3000`-sti. Den udleverede app bruger `APP_HOST` til Rails' hostkontrol.

På en hjemmeserver kræver adgang udefra fungerende routing, DNS og HTTPS. Hvis din forbindelse er bag CGNAT, kan simpel port-forwarding være utilstrækkelig. Brug din eksisterende VPN/tunnelløsning eller lokalt netværk med betroet HTTPS; dette repo opretter ikke en tunnel.

**Prøve uden domæne, kun for underviseren:** Brug SSH-portforward til localhost på din egen computer. Behold passwords. Browsereditoren kan afprøves på localhost, som browsere behandler som en sikker kontekst. Dette er ikke elevsporet; eleverne får ingen SSH-adgang til værten.

## 4. Start Rails i værkstedet

Log ind i browsereditoren. Bekræft tillid til den udleverede `/workspace`-mappe sammen med underviseren, hvis editoren viser Restricted Mode/Workspace Trust. Luk eventuelt velkomst- og chatpanelet; de bruges ikke i kurset. Vælg Terminal → New Terminal og kør:

```sh
cd /workspace/undervisning/04-flaskepost/start
bin/rails db:prepare
bin/rails server -b 0.0.0.0
```

Besøg app-adressen. En 502 før Rails er startet er forventelig. Holdet stopper serveren med Ctrl + C ved skift til gang 5 og følger den gangs startkommandoer. Koden ændres i browsereditoren og indlæses ved næste request. Der skal ikke deployes ved hvert tastetryk.

Holdets skoleopgaver og udviklingsdatabase ligger under `/workspace` i en named volume. Stop/start eller container-genoprettelse bevarer den. `docker compose down` bevarer normalt volumener; **brug ikke `down -v`**, når der ligger elevdata.

## 5. Flere hold

Gentag opsætningen i en ny mappe `drift/hold/hold02`. Sæt `HOLD=hold02`, et andet appdomæne og porte 18082/18083 i dens `.env`, og tilpas dens Caddy-eksempel. Hvert Compose-projekt får eget netværk og egen volume. Brug én app pr. makkerpar. Hvis hele holdet skal læse samme logbog, deler du én apps adresse; de får ikke automatisk adgang til de øvrige databaser.

Til gang 3 kan du også lægge de statiske facitfiler bag en almindelig HTTPS-side, hvis elevbrowseren blokerer localStorage på `file:`. Den statiske mappe kræver ingen Rails-proces. Den skal kopieres til din eksisterende statiske webrod, uden resten af repoet.

## 6. Backup og gendannelse af et værksted

Stop holdets container, før du laver en fuld filbackup af SQLite-data. Kør fra repoets rod; backup-mappen er din egen lokale, private destination:

```sh
mkdir -p /srv/pirat-backup/hold01
docker compose -f drift/hold/hold01/compose.json stop
docker compose -f drift/hold/hold01/compose.json cp vaerksted:/workspace/. /srv/pirat-backup/hold01/
docker compose -f drift/hold/hold01/compose.json start
```

Afprøv gendannelse i et **nyt prøvehold**, ikke oven på elevernes eksisterende arbejde. Opret og start prøveholdet én gang, stop det, og brug `docker compose cp /srv/pirat-backup/hold01/. vaerksted:/workspace/`. Ret ejerskab til UID 1000 via en engangscontainer/Compose exec som root, hvis dit kopieringsværktøj har ændret det. Start prøveholdet og kontrollér kode og indlæg. Gem også holdkonfiguration og `.env` separat og privat.

## 7. Kamal: underviserens opgave

Den afsluttende deploy bruger en **separat kopi af elevens Rails-app**, ikke hele undervisningsrepoet. Fra repoets rod kan du hente holdets færdige gang-5-app, mens Rails er stoppet:

```sh
mkdir -p drift/deploy/hold01
docker compose -f drift/hold/hold01/compose.json cp \
  vaerksted:/workspace/undervisning/05-faelles-logbog/start/. drift/deploy/hold01/
```

Vær opmærksom på, at `start` her er elevens redigerede mappe, ikke repoets urørte startversion. Test kopien først. Fjern kopierede `storage/*.sqlite3*`, logs og midlertidige filer fra deploy-kopien. Gem aldrig disse i Git. En `.gitignore` til Rails-apps findes i hver start/facitmappe.

Opret et Git-repo i deploy-kopien. Tilføj og commit kode med dit navn og mailadresse. Kamal bygger den committede kode; ændringer skal være committed før deploy. Eleven behøver ikke selv at oprette et GitHub-repo for at deltage.

På **din deploy-maskine** skal Ruby, Docker/buildx, SSH-adgang og Kamal 2.12.0 være tilgængelige. Installér fx med `gem install kamal -v 2.12.0`. Brug din egen deployment-maskine, aldrig elevens container. Kamal-nøgler og registry-token skal ikke ligge i elevvolumen.

Kopiér `drift/deploy.yml.example` fra undervisningsrepoet til deploy-appens `config/deploy.yml`, og `drift/secrets.example` til `.kamal/secrets`. Udfyld:

- `service`, `image` og volume-navn: unikke pr. hold.
- Server-IP, SSH-bruger og registry-bruger med de rigtige værdier.
- `proxy.host` og `APP_HOST` med appens rigtige produktionsdomæne.
- `builder.arch`: `amd64` på en almindelig x86-server eller `arm64` på en ARM-server.
- Miljøvariablerne `KAMAL_REGISTRY_PASSWORD`, `SECRET_KEY_BASE` og `COURSE_PASSWORD` på din deploy-maskine. Generér en ny secret med `ruby -rsecurerandom -e 'puts SecureRandom.hex(64)'`, gem den privat og genbrug den ved næste deploy. Skift den ikke ved hver kodeændring.

### Sameksistens med din HTTPS-proxy

Skabelonen er til Kamal bag hostens Caddy/nginx. Kamal-proxy bindes kun til localhost på 18090/18443; `ssl: false` betyder, at **den forreste proxy** håndterer HTTPS. Flet fx følgende ind i Caddy på værten:

```caddy
hold01.pirater.example.dk {
    reverse_proxy 127.0.0.1:18090
}
```

Brug samme navn i `proxy.host` og `APP_HOST`. Kamal fordeler på Host-headeren, så flere elevapps kan bruge samme localhost-port. Skabelonens `proxy.run` er fælles for værtsmaskinens Kamal-proxy. Hvis du allerede har Kamal-apps, skal deres eksisterende proxyopsætning respekteres; en proxy-genstart påvirker dem alle.

Du kan i stedet lade Kamal eje 80/443 på en server uden anden proxy, men så skal `run`-overrides fjernes, `ssl: true` sættes, og editorernes HTTPS-routing planlægges særskilt. Det er ikke opskriften ovenfor.

### Deploy

Kør fra deploy-appens rod efter lokal konfiguration og commit:

```sh
kamal config
kamal setup
```

`kamal config` er en lokal konfigurationskontrol. `kamal setup` forbinder til serveren og ændrer den; kør den kun mod den tilsigtede server. Efterfølgende kodeændringer committes og udgives med `kamal deploy`.

Appens entrypoint kører `db:prepare` før start. Produktionsdata ligger i `/rails/storage`, som skabelonen monterer fra en separat volume. Der er kun én instans af hver app. Ingen Redis, Postgres, Sidekiq eller Node-service kræves. Databasen kopieres ikke automatisk fra udviklingsmiljøet.

## 8. Afsluttende driftsprøve

1. Besøg produktionsadressen over HTTPS. Uden holdlogin skal appen kræve login; `/up` er en offentlig teknisk sundhedskontrol uden elevdata.
2. Gem et eventyr, genindlæs og åbn fra en anden browser.
3. Commit og deploy en lille overskriftsændring. Kontrollér, at eventyret stadig findes.
4. Tag en konsistent SQLite-backup, fx med SQLite `.backup` eller mens appen er stoppet. En tilfældig kopi af en åben SQLite-fil kan mangle WAL-data.
5. Afprøv backupgendannelse i et separat prøveprojekt, før data bliver vigtige.

## Efter forløbet

Stop værksteder, som ikke bruges. Bevar eller eksporter elevkoden efter aftale. Bevar produktionsvolumener, så længe apps skal leve.

## Kilder

- [code-server: installation](https://coder.com/docs/code-server/install) og [HTTPS/adgang](https://coder.com/docs/code-server/guide).
- [Rails: Getting Started](https://guides.rubyonrails.org/getting_started.html).
- [Kamal: installation](https://kamal-deploy.org/docs/installation/) og [proxykonfiguration](https://kamal-deploy.org/docs/configuration/proxy/).
- [Docker: betydningen af adgang til docker-gruppen](https://docs.docker.com/engine/install/linux-postinstall/).
