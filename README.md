# dmifblueletter — lettera con la nuova intestazione blu DMIF

Versione di `dmifletter.cls` (v1.1) che usa la nuova carta intestata blu al posto di
`dmifhead.pdf`. Rinominata come richiesto dalla nota di licenza della classe originale.

## File

| File | Descrizione |
|---|---|
| `dmifblueletter.cls` | classe (derivata da `letter`) |
| `dmif-sfondo.png` | fondo grafico A4: logo DMIF, filetti, logo Ateneo, marchi |
| `template.tex` | **template generale** con tutte le opzioni e i comandi spiegati |
| `main.tex` | la tua lettera, con solo il nome della classe cambiato |
| `main.pdf` | anteprima (la firma è un segnaposto: `mysignature.png` non era fra i file) |

Compilare con **pdfLaTeX**. Servono nella cartella del `.tex`: la classe, `dmif-sfondo.png`
e `mysignature.png` (o quello che usi in `\signature`).

## Cosa cambia rispetto a dmifletter v1.1

* Intestazione e piè di pagina blu (italiano o inglese) su **tutte** le pagine (anche le successive, come nel
  modello Word); dalla pagina 2 compare in alto a destra «Page n» (`\pagename`).
* Geometria: testo da 113.4 bp dall'alto fino a 113.4 bp dal basso; larghezza 160 mm e
  margine sinistro 1 in come prima.
* Eliminati: `dmifhead.pdf`, il logo `pollo` delle pagine successive e la riga C.F./P.I.
* `\opening` termina con `\startbreaks`: nella v1.1 lo `\stopbreaks` iniziale restava attivo
  per tutta la lettera e impediva di spezzare i paragrafi fra due pagine. Per il vecchio
  comportamento togliere quella riga.

## Piè di pagina

Sempre presenti: nome del dipartimento e riga «indirizzo - t telefono - sito».
Opzionali (compaiono solo se impostati):

    \email{marino.miculan@uniud.it}                 % "Marino Miculan - email" (usa \name)
    \responsabile{Nome Cognome}{nome.cognome@uniud.it}
    \compilatore{Nome Cognome}{nome.cognome@uniud.it}
    \telephone{+39 0432 558400}                     % numero completo
    \dipartimento{...}  \indirizzo{...}  \sitoweb{www....}

Gli indirizzi diventano link cliccabili se carichi `hyperref` (con `hidelinks` senza riquadri).

## Opzioni

`english` (default), `italian`, `11pt`, ... come prima, più:

* `englishhead`: carta intestata in inglese. Il nome del dipartimento diventa
  «Department of Mathematics, Computer Science and Physics», «Italia» diventa «Italy» e le
  etichette opzionali del piè di pagina diventano «Person in charge of the procedure» e
  «Prepared by» (traduzioni mie, non ufficiali: modificarle in `\dmif@respstring` e
  `\dmif@compstring`). La lingua dell'intestazione è indipendente da quella della lettera:
  senza `englishhead` l'intestazione resta in italiano.
* `nosfondo`: omette l'intera carta intestata, per stampare su carta intestata reale.
