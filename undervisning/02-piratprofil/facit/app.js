var formular = document.getElementById("profil-form");
var navn = document.getElementById("navn");
var rolle = document.getElementById("rolle");
var preview = document.getElementById("preview");
var resultat = document.getElementById("resultat");

navn.oninput = function() {
  preview.textContent = "Hej, " + navn.value + "!";
};

formular.onsubmit = function(event) {
  event.preventDefault();
  var piratnavn = navn.value.trim();
  if (piratnavn === "") {
    resultat.textContent = "Skriv et piratnavn, ikke kun mellemrum.";
    return;
  }
  resultat.textContent = piratnavn + " er nu " + rolle.value + "!";
};
