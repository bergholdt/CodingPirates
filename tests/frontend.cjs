// Ingen npm-pakker: Node bruges kun af underviseren til kontrol.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
function setup(file, stored = {}, blocked = false) {
  const nodes = {};
  function node() { return {value: '', textContent: '', children: [], appendChild(x) { this.children.push(x); }}; }
  const ctx = {document: {getElementById(id) { return nodes[id] ||= node(); }, createElement: node},
    localStorage: {getItem(k) { if(blocked) throw Error(); return stored[k] ?? null; },
      setItem(k,v) { if(blocked) throw Error(); stored[k]=v; }, removeItem(k) {if(blocked) throw Error(); delete stored[k];}},
    confirm: () => true, Math: Object.assign(Object.create(Math), {random: () => 0})};
  vm.createContext(ctx);
  let source = fs.readFileSync(path.join(root, file), 'utf8');
  if (file.endsWith('.html')) source = source.match(/<script>([\s\S]*?)<\/script>/)[1];
  vm.runInContext(source, ctx);
  return {ctx, nodes, stored};
}
let a = setup('undervisning/01-skattekisten/facit/index.html');
for(let i=0;i<19;i++) a.nodes.kiste.onclick();
assert.equal(a.ctx.guld,19); assert.notEqual(a.nodes.kiste.disabled,true);
a.nodes.kiste.onclick(); assert.equal(a.ctx.guld,20); assert.equal(a.nodes.kiste.disabled,true);
a = setup('undervisning/02-piratprofil/facit/app.js');
a.nodes.navn.value = '  Krabbe  '; a.nodes.rolle.value = 'Navigatør';
let stopped = false; a.nodes['profil-form'].onsubmit({preventDefault(){stopped=true;}});
assert(stopped); assert.equal(a.nodes.resultat.textContent, 'Krabbe er nu Navigatør!');
a.nodes.navn.value='   '; a.nodes['profil-form'].onsubmit({preventDefault(){}});
assert.match(a.nodes.resultat.textContent,/mellemrum/);
const file='undervisning/03-lokal-logbog/facit/app.js';
a=setup(file); a.nodes.pirat.value='Ø-pirat'; a.nodes.tekst.value='<b>Skat</b>';
a.nodes['log-form'].onsubmit({preventDefault(){}});
assert.equal(a.ctx.indlaeg.length,1);
let b=setup(file,a.stored); assert.equal(b.ctx.indlaeg[0].tekst,'<b>Skat</b>');
b.nodes.slet.onclick(); assert.equal(b.ctx.indlaeg.length,0);
assert.equal(setup(file,b.stored).ctx.indlaeg.length,0);
a=setup(file,{},true); a.nodes.pirat.value='Pirat'; a.nodes.tekst.value='Hej';
a.nodes['log-form'].onsubmit({preventDefault(){}});
assert.match(a.nodes.status.textContent,/Kan ikke gemme/);
assert.equal(setup(file,{'piratkode-logbog-v1':'ugyldig-json'}).ctx.indlaeg.length,0);
console.log('Frontend: spil, formular, persistens, sletning og lagerfejl OK.');
