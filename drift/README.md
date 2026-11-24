# Driftfiler

Læs [opsætningen](../docs/DRIFT.md), før du starter noget.

- `Dockerfile`: fælles image med Ruby, Rails og browsereditoren code-server.
- `start-editor.sh`: kopierer kursusmaterialet til et nyt holds volume én gang. Overskriver aldrig et eksisterende workspace.
- `hold.example/`: Compose-, nginx- og miljøskabeloner til et nyt hold.
- `hold/`: private holdkonfigurationer og passwords; ignoreres af Git.
- `deploy.yml.example` og `secrets.example`: underviserens Kamal-skabeloner.

Elevernes containere har ikke Docker-socket, privilegeret tilstand, værtens mapper eller deploy-nøgler. Hvert hold har separat volume og internt Docker-netværk. En lille nginx-gateway publicerer localhost-portene og videresender browsertrafik. Containere deler værtens kerne og er ikke VM-isolation.
