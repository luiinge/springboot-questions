// Plantilla pandoc -> Typst para la edición impresa (KDP, 6 x 9 in, sin sangrado)

#let book-title = [$title$]
#let book-subtitle = [$subtitle$]
#let book-author = [$author$]

// Márgenes KDP: el interior (lomo) depende del número de páginas
#let trim-width = $if(trim-width)$$trim-width$$else$6in$endif$
#let trim-height = $if(trim-height)$$trim-height$$else$9in$endif$
#let gutter = $if(gutter)$$gutter$$else$0.75in$endif$

#let body-font = "Libertinus Serif"
#let code-font = "DejaVu Sans Mono"

#let horizontalRule = line(start: (25%, 0%), end: (75%, 0%), stroke: 0.5pt)
#let divider = horizontalRule

#let to-string(it) = {
  if type(it) == str { it }
  else if it.has("text") { it.text }
  else if it.has("children") { it.children.map(to-string).join("") }
  else if it.has("body") { to-string(it.body) }
  else if it == [ ] { " " }
  else { "" }
}

$if(highlighting-definitions)$
$highlighting-definitions$
$endif$

#set document(title: book-title, author: "$author$")
#set text(font: body-font, size: 10.5pt, lang: "es", region: "ES", hyphenate: true)
#set par(justify: true, leading: 0.62em, spacing: 0.95em)

// ---------- Página ----------

// Título del capítulo (nivel 1) vigente en una página, para la cabecera
#let chapter-at(page-loc) = {
  let before = query(heading.where(level: 1).before(page-loc))
  if before.len() == 0 { none } else { before.last() }
}

#let is-chapter-start() = {
  let p = here().page()
  query(heading.where(level: 1)).any(h => h.location().page() == p)
}

// Páginas pares que quedan en blanco al saltar a un capítulo (que empieza en impar)
#let in-front-matter() = {
  let start = query(<body-start>)
  start.len() == 0 or here().page() < start.first().location().page()
}

#let is-blank-page() = {
  let p = here().page()
  let ends = query(<chapter-end>)
  let starts = query(heading.where(level: 1))
  ends.zip(starts).any(((e, s)) => e.location().page() < p and s.location().page() > p)
}

#let running-header = context {
  if in-front-matter() or is-chapter-start() { return }
  if is-blank-page() { return }
  set text(size: 8pt, style: "italic")
  let p = here().page()
  if calc.even(p) {
    align(left, book-title)
  } else {
    let ch = chapter-at(here())
    if ch != none { align(right, ch.body) }
  }
  v(-4pt)
  line(length: 100%, stroke: 0.4pt)
}

#let running-footer = context {
  if in-front-matter() { return }
  if is-blank-page() { return }
  set text(size: 9pt)
  let n = counter(page).display()
  if calc.even(here().page()) { align(left, n) } else { align(right, n) }
}

#set page(
  width: trim-width,
  height: trim-height,
  margin: (inside: gutter, outside: 0.6in, top: 0.8in, bottom: 0.75in),
  header: running-header,
  footer: running-footer,
  header-ascent: 35%,
  footer-descent: 40%,
)

// ---------- Títulos ----------

#set heading(numbering: none)
#show heading: set text(font: body-font, hyphenate: false)
#show heading: set par(justify: false)

#show heading.where(level: 1): it => {
  [#metadata(none)<chapter-end>]
  pagebreak(to: "odd", weak: true)
  v(1.2in)
  let parts = to-string(it.body).split(" · ")
  if parts.len() >= 3 {
    // "Nivel 1 · Básico · Fundamentos..." -> etiqueta + título
    text(size: 10pt, weight: "regular", tracking: 0.08em, upper(parts.slice(0, -1).join(" · ")))
    v(0.4em)
    text(size: 21pt, weight: "bold", parts.last())
  } else if parts.len() == 2 {
    text(size: 10pt, weight: "regular", tracking: 0.08em, upper(parts.first()))
    v(0.4em)
    text(size: 21pt, weight: "bold", parts.last())
  } else {
    text(size: 21pt, weight: "bold", it.body)
  }
  v(0.3em)
  line(length: 30%, stroke: 0.8pt)
  v(0.6in)
}

#show heading.where(level: 2): it => {
  v(1.3em, weak: true)
  block(sticky: true, below: 0.8em, text(size: 12.5pt, weight: "bold", it.body))
}

#show heading.where(level: 3): it => {
  v(1em, weak: true)
  block(sticky: true, below: 0.6em, text(size: 11pt, weight: "bold", style: "italic", it.body))
}

// ---------- Código ----------

#show raw: set text(font: code-font, size: 8.4pt)
#show raw.where(block: false): it => box(
  fill: luma(238), inset: (x: 2pt), outset: (y: 2pt), radius: 1.5pt, text(size: 8.8pt, it)
)
#show raw.where(block: true): it => block(
  width: 100%, fill: luma(245), stroke: (left: 1.5pt + luma(150)),
  inset: (left: 7pt, right: 5pt, y: 6pt), breakable: true,
  { set par(justify: false, leading: 0.5em); set text(size: 7.4pt); it }
)

// ---------- Otros elementos ----------

#show link: it => it
#set list(indent: 0.8em, body-indent: 0.5em)
#set enum(indent: 0.8em, body-indent: 0.5em)
#set terms(hanging-indent: 1.5em)
#show quote.where(block: true): it => block(
  inset: (left: 1em, y: 0.3em), stroke: (left: 0.8pt + luma(120)), it.body
)
#set table(inset: 4pt, stroke: (x, y) => (
  top: if y == 0 { 0.8pt } else if y == 1 { 0.5pt } else { 0pt },
  bottom: 0.8pt,
))
#show table: set text(size: 8.8pt)
#show table: set par(justify: false)
#show table.cell.where(y: 0): set text(weight: "bold")
#show figure.where(kind: table): set figure.caption(position: top)
#show table: set align(left)

// ---------- Portadilla y créditos (sin numerar) ----------

#counter(page).update(0)
#page(header: none, footer: none)[
  #set par(justify: false)
  #v(1.8in)
  #align(center)[
    #text(size: 22pt, weight: "bold", hyphenate: false, book-title)
    #v(0.6em)
    #text(size: 13pt, style: "italic", book-subtitle)
    #v(1.6in)
    #text(size: 13pt, book-author)
  ]
]

#page(header: none, footer: none)[
  #set text(size: 8.5pt)
  #set par(justify: false)
  #v(1fr)
  *#book-title* \
  #book-subtitle

  © $if(copyright-year)$$copyright-year$$else$2026$endif$ #book-author

  Todos los derechos reservados. Ninguna parte de esta publicación puede ser reproducida, almacenada o transmitida por ningún medio sin el permiso previo y por escrito del autor.

  Aunque se ha puesto el máximo cuidado en la preparación de este libro, el autor no asume responsabilidad alguna por errores u omisiones, ni por los daños que pudieran derivarse del uso de la información que contiene.

  Todas las marcas mencionadas pertenecen a sus respectivos propietarios.

$if(isbn)$
  ISBN: $isbn$

$endif$
  Primera edición: $if(copyright-year)$$copyright-year$$else$2026$endif$
]

// ---------- Índice ----------

#show outline.entry.where(level: 1): it => {
  v(0.9em, weak: true)
  strong(it)
}
#set outline.entry(fill: repeat(gap: 0.3em)[.])
#page(header: none, footer: none)[
  #text(size: 21pt, weight: "bold")[Índice]
  #v(0.6in)
  #set text(size: 9pt)
  #set par(justify: false)
  #outline(title: none, depth: $if(toc-depth)$$toc-depth$$else$2$endif$)
]

// ---------- Cuerpo ----------

#pagebreak(to: "odd", weak: true)
#counter(page).update(1)
#metadata(none)<body-start>

$body$
