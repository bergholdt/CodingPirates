# Teknik, afgrænsning og kilder

## Hvorfor denne kombination?

HTML, CSS og JavaScript giver først et synligt resultat med lokale filer. Formularer og DOM kommer før serveren. localStorage gør lagring konkret uden at påstå, at data deles. Ruby og Rails introducerer derefter serverkode, formularbehandling og en fælles database.

Rails-øvelserne kører i en lokal Linux-container via Docker Desktop og VS Code Dev Containers. Browseren åbner appen på localhost; underviserens server indgår ikke.

Vi bruger en lille, eksplicit Rails-app med Active Record, Action Controller og Action View. Vi indlæser ikke Active Storage, mail, køer eller websockets, selv om nogle biblioteker følger Rails-gemmen. Der er ingen JavaScript-bundler, Redis, separat databaseserver eller npm-trin. CSS ligger som én almindelig fil i `public` for at holde fokus på elevens kode.

## Hvad er gemt hvor?

| Data | Placering | Overlever F5? | Delt med andre? |
|---|---|---|---|
| Gang 1: guld | JavaScript-hukommelsen | Nej | Nej |
| Gang 2: piratpas | Formular/DOM | Ikke gemt af appen | Nej |
| Gang 3: logbog | localStorage i én browser/origin | Normalt ja | Nej |
| Gang 4: flaskepost | Den aktuelle forespørgsel | Ikke ved en ny GET | Ingen fælles historik |
| Gang 5: logbog | SQLite i appens lokale `storage`-mappe | Ja | Mellem browsere på samme computer |
| Programkode | Filer, eventuelt Git-commits | Ja | Hvis filerne/repoet deles |

En origin er kombinationen af protokol, værtsnavn og port. `file:`-lagring er ikke ens defineret i alle browsere. At flytte en fil eller skifte HTTP-adresse kan derfor ændre, hvilket lager eleven ser.

## Begreber vi ikke når på ti timer

Personlige konti, login pr. elev, rettigheder til egne indlæg, redigering/sletning af fælles indlæg, chat i realtid, billeder, betaling og eksterne API'er er ikke en del af minimumsforløbet. Appen bruges lokalt uden login. Offentlig hosting og deployment indgår ikke i forløbet. Gem kun opdigtede navne og eventyr.

Der er ikke en komplet CRUD-øvelse: alle lærer at oprette og læse. Opdatering og sletning kan være næste forløb, når man også kan tale om ejerskab og adgang.

Sikker grundadfærd er inkluderet: tekst-output escapes, Rails-formularer har CSRF, kun kendte parametre accepteres, modellen validerer, og produktionsappen har holdlogin. Dev Containeren videresender port 3000 til localhost via VS Code. Ingen af disse tiltag gør en skoleapp til en generel offentlig platform med anti-spam og individuelle brugerkonti.

## Versioner

Ruby 4.0.8 og Rails 8.1.4.1. Gemfile.lock fastholder gems og omfatter både x86_64-linux og aarch64-linux. Opdater afhængigheder og afprøv materialet inden nye kursusrunder.

## Primære kilder

- [MDN om localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage): browserlager og begrænsningen ved file-adresser.
- [VS Code: HTML](https://code.visualstudio.com/docs/languages/html) og [systemkrav](https://code.visualstudio.com/docs/supporting/requirements).
- [Rails Getting Started](https://guides.rubyonrails.org/getting_started.html): model, controller, view, SQLite og deployment.
- [Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html) og [Migrations](https://guides.rubyonrails.org/active_record_migrations.html).
- [Rails-version på RubyGems](https://rubygems.org/gems/rails).
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).
- [Docker Desktop til Windows](https://docs.docker.com/desktop/setup/install/windows-install/).
