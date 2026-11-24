var formular = document.getElementById("log-form");
var pirat = document.getElementById("pirat");
var tekst = document.getElementById("tekst");
var liste = document.getElementById("liste");
var statusfelt = document.getElementById("status");
var slet = document.getElementById("slet");
var noegle = "piratkode-logbog-v1";
var indlaeg = [];

function visIndlaeg() {
  // TRIN 1: Vis hvert indlæg som et li-element.
}

function gemIndlaeg() {
  try {
    // TRIN 3: Gem listen som JSON i localStorage.
    statusfelt.textContent = "Startversion: endnu ikke gemt på disk.";
  } catch (fejl) {
    statusfelt.textContent = "Kan ikke gemme. Listen er kun i hukommelsen. Spørg din underviser.";
  }
}

function hentIndlaeg() {
  try {
    var gemt = localStorage.getItem(noegle);
    var data = gemt ? JSON.parse(gemt) : [];
    // Hjælpekode: Accepter kun den form for data, vi selv bruger.
    if (!Array.isArray(data) || data.length > 100) {
      throw new Error("Ugyldig logbog");
    }
    data.forEach(function(post) {
      if (!post || typeof post.pirat !== "string" || typeof post.tekst !== "string" ||
          post.pirat.length > 24 || post.tekst.length > 280) {
        throw new Error("Ugyldigt indlæg");
      }
    });
    indlaeg = data;
    statusfelt.textContent = "Logbogen er hentet fra denne browser.";
  } catch (fejl) {
    statusfelt.textContent = "Kan ikke læse den gemte logbog. Spørg din underviser, før du sletter noget.";
  }
}

formular.onsubmit = function(event) {
  event.preventDefault();
  if (pirat.value.trim() === "" || tekst.value.trim() === "") {
    statusfelt.textContent = "Udfyld begge felter med mere end mellemrum.";
    return;
  }
  if (indlaeg.length >= 100) {
    statusfelt.textContent = "Logbogen er fuld (100 indlæg). Kopiér det, du vil beholde, før du sletter.";
    return;
  }
  // TRIN 2: Byg et objekt, og læg det i listen med push.
  visIndlaeg();
  gemIndlaeg();
  tekst.value = "";
};

slet.onclick = function() {
  if (!confirm("Vil du slette alle dine lokale eventyr?")) { return; }
  try {
    localStorage.removeItem(noegle);
    indlaeg = [];
    visIndlaeg();
    statusfelt.textContent = "Din lokale logbog er slettet.";
  } catch (fejl) {
    statusfelt.textContent = "Kunne ikke slette den gemte logbog.";
  }
};

hentIndlaeg();
visIndlaeg();
