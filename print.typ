// Plantilla pandoc -> Typst para la edición impresa (KDP, A4 con sangrado, color).
// Se usa junto con print.lua, que aporta <chapter-info> y <question-topic>.

#let book-title = [$title$]
#let book-subtitle = [$subtitle$]
#let book-author = [$author$]

// ---------- Formato KDP ----------
// A4 (8,27 x 11,69 in) + sangrado de 0,125 in en el borde exterior, superior e inferior
#let bleed = 0.125in
#let trim-width = 8.27in
#let trim-height = 11.69in
#let gutter = $if(gutter)$$gutter$$else$0.8in$endif$

// ---------- Paleta ----------
#let navy = rgb("#1c2733")
#let ink = rgb("#2b2f36")
#let muted = rgb("#6b7280")
#let faint = rgb("#9da2ab")
#let rule-color = rgb("#e5e7eb")
#let code-bg = rgb("#f4f5f7")
#let code-ink = rgb("#9b2c3a")
#let spring = rgb("#6db33f")
#let level-colors = (
  rgb("#2f8f4e"), rgb("#4f9a3a"), rgb("#7f9427"), rgb("#b3871c"),
  rgb("#cf6f1c"), rgb("#c24a26"), rgb("#9c2b2b"),
)
#let monograph-colors = (A: rgb("#2b6cb0"), B: rgb("#1f7a8c"), C: rgb("#6b4fa0"))
#let appendix-color = rgb("#4a5568")
#let default-accent = level-colors.first()

#let tint(c) = c.lighten(91%)

#let sans = "DejaVu Sans"
#let mono = "DejaVu Sans Mono"

#let horizontalRule = line(length: 100%, stroke: 0.5pt + rule-color)
#let divider = horizontalRule

#let to-string(it) = {
  if type(it) == str { it }
  else if it.has("text") { it.text }
  else if it.has("children") { it.children.map(to-string).join("") }
  else if it.has("body") { to-string(it.body) }
  else if it == [ ] { " " }
  else { "" }
}

// Color de acento según el título del capítulo
#let accent-for(title) = {
  let m = title.match(regex("^Nivel (\d+)"))
  if m != none { return level-colors.at(int(m.captures.first()) - 1) }
  let m = title.match(regex("^Monográfico ([A-Z])"))
  if m != none { return monograph-colors.at(m.captures.first(), default: default-accent) }
  if title.starts-with("Apéndice") { return appendix-color }
  default-accent
}

#let accent = state("accent", default-accent)

$if(highlighting-definitions)$
$highlighting-definitions$
$endif$

#set document(title: book-title, author: "$author$")
#set text(font: sans, size: 9.6pt, fill: ink, lang: "es", region: "ES", hyphenate: true)
#set par(justify: false, leading: 0.72em, spacing: 1.05em)

// ---------- Página ----------

#let in-front-matter() = {
  let start = query(<body-start>)
  start.len() == 0 or here().page() < start.first().location().page()
}

#let outside(body) = context {
  if calc.even(here().page()) { align(left, body) } else { align(right, body) }
}

#set page(
  width: trim-width + bleed,
  height: trim-height + 2 * bleed,
  margin: (inside: gutter, outside: 0.75in + bleed, top: 0.85in + bleed, bottom: 0.8in + bleed),
  header: context {
    if in-front-matter() { return }
    set text(size: 7.5pt, fill: muted)
    outside[$title$]
    v(-5pt)
    line(length: 100%, stroke: 0.5pt + rule-color)
  },
  footer: context {
    if in-front-matter() { return }
    set text(size: 8pt, fill: faint)
    outside(counter(page).display())
  },
  header-ascent: 40%,
  footer-descent: 40%,
)

// Página de fondo oscuro a sangre (portada interior y separadores de parte)
#let dark-page(body) = page(
  fill: navy, header: none, footer: none,
  margin: (inside: gutter, outside: 0.9in + bleed, top: 1in + bleed, bottom: 1in + bleed),
  body,
)

// Franja con los colores de los niveles, de sangre a sangre
#let level-bar(height: 5pt) = context {
  let even = calc.even(here().page())
  let left-margin = if even { 0.9in + bleed } else { gutter }
  let right-margin = if even { gutter } else { 0.9in + bleed }
  move(dx: -left-margin, block(
    width: 100% + left-margin + right-margin,
    grid(columns: (1fr,) * level-colors.len(), ..level-colors.map(c => rect(width: 100%, height: height, fill: c, stroke: none))),
  ))
}

// ---------- Títulos ----------

#set heading(numbering: none)
#show heading: set text(font: sans, fill: navy, hyphenate: false)
#show heading: set par(justify: false)

#let chapter-info() = {
  let found = query(selector(<chapter-info>).before(here()))
  if found.len() == 0 { none } else { found.last().value }
}

#show heading.where(level: 1): it => {
  let title = to-string(it.body)
  let parts = title.split(" · ")
  let color = accent-for(title)
  accent.update(color)

  context {
    let info = chapter-info()
    if title.starts-with("Parte") {
      // Separador de parte: página oscura completa
      dark-page[
        #v(2.2in)
        #text(size: 9pt, weight: "bold", fill: spring, tracking: 0.06em, upper(parts.first()))
        #v(0.5em)
        #text(size: 30pt, weight: "bold", fill: white, parts.slice(1).join(" · "))
        #v(1.2em)
        #if info != none {
          set text(size: 11pt, weight: "regular", fill: white.darken(15%))
          block(width: 85%, info.desc)
        }
        #v(1fr)
        #level-bar()
      ]
    } else if info != none {
      // Nivel o monográfico: bloque de color
      pagebreak(weak: true)
      let kicker = parts.slice(0, -1).join(" · ")
      if info.count != "" { kicker += " · " + info.count + " preguntas" }
      block(width: 100%, fill: color, inset: (x: 20pt, top: 18pt, bottom: 20pt), below: 22pt, {
        set text(fill: white)
        text(size: 8.5pt, weight: "bold", tracking: 0.03em, upper(kicker))
        v(4pt)
        text(size: 21pt, weight: "bold", parts.last())
        if info.desc != [] {
          v(6pt)
          set par(leading: 0.6em)
          text(size: 10pt, weight: "regular", fill: white.darken(6%), info.desc)
        }
      })
    } else {
      // Introducción, guía de uso, apéndices
      pagebreak(weak: true)
      v(8pt)
      text(size: 20pt, weight: "bold", it.body)
      v(2pt)
      line(length: 100%, stroke: 0.8pt + rule-color)
      v(10pt)
    }
  }
}

// Cabecera con distintivo: preguntas (P001) y apéndices (A)
#let badged-heading(badge, kicker, title, color) = block(
  width: 100%, sticky: true, above: 20pt, below: 12pt, {
    grid(
      columns: (auto, 1fr), column-gutter: 12pt,
      box(fill: color, inset: (x: 7pt, y: 4.5pt), text(size: 9pt, weight: "bold", fill: white, badge)),
      {
        if kicker != "" {
          text(size: 6.8pt, weight: "bold", fill: muted, tracking: 0.03em, upper(kicker))
          v(-3pt)
        }
        text(size: 12pt, weight: "bold", fill: navy, title)
      },
    )
    v(-2pt)
    line(length: 100%, stroke: 0.5pt + rule-color)
  }
)

#show heading.where(level: 2): it => {
  let title = to-string(it.body)
  let q = title.match(regex("^(P\d+) · (.*)$$"))
  let a = title.match(regex("^Apéndice ([A-Z]) · (.*)$$"))
  if q != none {
    context {
      let topics = query(selector(<question-topic>).before(here()))
      let topic = if topics.len() > 0 { topics.last().value } else { "" }
      badged-heading(q.captures.at(0), topic, q.captures.at(1), accent.get())
    }
  } else if a != none {
    accent.update(appendix-color)
    pagebreak(weak: true)
    badged-heading(a.captures.at(0), "Apéndice", a.captures.at(1), appendix-color)
  } else {
    block(sticky: true, above: 18pt, below: 9pt, text(size: 13pt, weight: "bold", it.body))
  }
}

#show heading.where(level: 3): it => context block(
  sticky: true, above: 16pt, below: 8pt,
  text(size: 8pt, weight: "bold", fill: accent.get(), tracking: 0.04em, upper(it.body)),
)

// ---------- Texto ----------

#set list(indent: 2pt, body-indent: 7pt, marker: context text(fill: accent.get(), size: 1.1em)[•])
#set enum(indent: 2pt, body-indent: 7pt)
#set terms(hanging-indent: 1.5em)

// "Clave para la entrevista" (única cita en bloque del libro)
#show quote.where(block: true): it => context {
  let c = accent.get()
  block(
    width: 100%, fill: tint(c), stroke: (left: 3pt + c),
    inset: (left: 13pt, right: 12pt, y: 9pt), above: 14pt, below: 14pt,
    {
      set text(size: 8.8pt)
      show strong: set text(fill: c)
      it.body
    },
  )
}

// ---------- Código ----------

#show raw: set text(font: mono)
#show raw.where(block: false): set text(size: 8.3pt, fill: code-ink)
#show raw.where(block: true): it => block(
  width: 100%, fill: code-bg, radius: 2pt, inset: (x: 9pt, y: 8pt),
  above: 12pt, below: 12pt, breakable: true,
  { set par(leading: 0.5em); set text(size: 7.4pt, fill: ink); it },
)

// ---------- Tablas ----------

#show figure.where(kind: table): set align(left)
#show table: set align(left)
#show table: set par(justify: false)
#show table: set text(size: 8.5pt)
#set table(
  inset: (x: 6pt, y: 6pt),
  stroke: (x, y) => (
    bottom: if y == 0 { 0.9pt + navy } else { 0.5pt + rule-color },
  ),
)
#show table.cell.where(y: 0): set text(weight: "bold", fill: navy)
#show figure.where(kind: table): set figure.caption(position: top)
#show link: it => it

// ---------- Portada interior ----------

#counter(page).update(0)
#dark-page[
  #set par(justify: false)
  #v(2.1in)
  #text(size: 8.5pt, weight: "bold", fill: spring, tracking: 0.06em)[GUÍA DE PREPARACIÓN DE ENTREVISTAS TÉCNICAS]
  #v(0.9em)
  #text(size: 30pt, weight: "bold", fill: white, hyphenate: false, book-title)
  #v(0.8em)
  #text(size: 11pt, fill: white.darken(18%), book-subtitle)
  #v(1.1in)
  #level-bar()
  #v(0.35in)
  #{
    set text(size: 8.5pt, fill: white.darken(12%))
    let names = (
      "Básico — Fundamentos de Spring y Spring Boot",
      "Básico-Intermedio — Spring Boot en la práctica",
      "Intermedio — Persistencia, transacciones y testing",
      "Intermedio — Patrones de diseño aplicados a Java y Spring",
      "Intermedio-Avanzado — Microservicios: fundamentos, comunicación e infraestructura",
      "Avanzado — Resiliencia, datos distribuidos y patrones de microservicios",
      "Experto — Internals, rendimiento y diseño de sistemas",
    )
    for (i, n) in names.enumerate() {
      block(above: 5pt, below: 5pt)[#text(fill: level-colors.at(i))[●] #h(5pt) Nivel #(i + 1) · #n]
    }
    v(4pt)
    for (k, n) in (("A", "Apache Kafka en profundidad"), ("B", "Docker y Kubernetes"), ("C", "Observabilidad y monitorización")) {
      block(above: 5pt, below: 5pt)[#text(fill: monograph-colors.at(k))[●] #h(5pt) Monográfico #k · #n]
    }
  }
  #v(1fr)
  #text(size: 12pt, weight: "bold", fill: white, book-author)
]

// ---------- Créditos ----------

#page(header: none, footer: none)[
  #set text(size: 8pt, fill: muted)
  #set par(justify: false)
  #v(1fr)
  #text(weight: "bold", fill: navy, book-title) \
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
  v(14pt, weak: true)
  set text(size: 9.5pt, weight: "bold", fill: navy)
  link(it.element.location(), grid(columns: (1fr, auto), column-gutter: 8pt, it.body(), it.page()))
  v(3pt)
}
#show outline.entry.where(level: 2): it => {
  set text(size: 7.8pt, fill: ink)
  block(above: 3.5pt, below: 3.5pt, inset: (left: 10pt), it)
}
#set outline.entry(fill: box(width: 1fr, repeat(gap: 2.5pt, text(fill: faint)[.])))

#page(header: none, footer: none)[
  #text(size: 20pt, weight: "bold", fill: navy)[Índice]
  #v(18pt)
  #set par(justify: false)
  #outline(title: none, depth: $if(toc-depth)$$toc-depth$$else$2$endif$)
]

// ---------- Cuerpo ----------

#pagebreak(to: "odd", weak: true)
#counter(page).update(1)
#metadata(none)<body-start>

$body$
