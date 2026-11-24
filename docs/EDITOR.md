# Kom i gang med Visual Studio Code

Vi anbefaler **Visual Studio Code (VS Code)**. Det er en editor, der farver HTML, CSS og JavaScript og hjælper med afsluttende tags og kodeforslag. Du behøver ingen udvidelser, konto eller AI-assistent til kurset.

## Før første møde

Underviseren eller en voksen hjælper med installation fra [den officielle downloadside](https://code.visualstudio.com/download). Vælg Visual Studio Code, ikke det større Visual Studio.

Den aktuelle Windows-udgave kræver Windows 10 eller 11, 64-bit. Tjek [systemkrav](https://code.visualstudio.com/docs/supporting/requirements) på forhånd. På en ældre maskine, som ikke opfylder kravene, kan eleven bruge Notesblok og samme kursusfiler. Skolens eller foreningens regler for installation gælder stadig.

## De første fem minutter

1. Udpak repoets ZIP-fil i Stifinder. Kopiér dagens `start`-mappe til din egen mappe, fx `Piratkode/gang-1`.
2. Åbn VS Code. Vælg **File → Open Folder** (Filer → Åbn mappe), og vælg din arbejdsmappe. Hvis editoren spørger om tillid, så få underviseren til at bekræfte, at det er de udleverede kursusfiler.
3. Klik på `index.html` i venstre side. Kontrollér, at der står **HTML** nederst, og at filen hedder `.html`, ikke `.html.txt`.
4. Skriv en overskrift. Editorens forslag kan accepteres med Tab eller Enter og lukkes med Escape. Hvis den selv indsætter et afsluttende tag, skal du ikke skrive det én gang til.
5. Gem med **Ctrl + S**. Find filen i Stifinder, og dobbeltklik på den. Se resultatet i browseren.

## Fem nyttige genveje på Windows

| Genvej | Gør dette |
|---|---|
| Ctrl + S | Gem den aktuelle fil |
| Ctrl + Z | Fortryd seneste ændring |
| Ctrl + Space | Vis kodeforslag |
| Shift + Alt + F | Formatér HTML, CSS eller JavaScript |
| Ctrl + Shift + V | Vis en Markdown-vejledning pænt |

**F5 bruges i browseren** til at opdatere siden. F5 i VS Code starter fejlsøgning og er ikke det samme.

Brug eventuelt **View → Word Wrap** til lange linjer og zoom ind med Ctrl + plus. Åbn kode og browser ved siden af hinanden. Når flere filer er ændret, så gem dem alle før opdatering.

## Rails i gang 4 og 5

Her bruger vi en VS Code-lignende editor direkte i browseren på underviserens server. Ruby og Rails er allerede installeret dér. Åbn den udleverede editoradresse og log ind med holdets password. Find filer i venstre side og terminalen via Terminal → New Terminal. Du skal ikke installere Ruby, Docker eller Rails på Windows.

Der er to faner: editorens adresse og appens adresse. Appen viser resultatet, når Rails-serveren er startet i terminalen. Ctrl + S gemmer kode på serveren; F5 i app-fanen opdaterer resultatet. Brug de udleverede app-adresser frem for editorens automatiske port-links.

Den lokale VS Code og browsereditoren har ikke automatisk de samme filer. De første tre gange gemmer du på din PC; de sidste to i holdets workspace på serveren. Bed underviseren om en kodekopi efter forløbet.

Kilde: [VS Codes indbyggede HTML-hjælp](https://code.visualstudio.com/docs/languages/html).
