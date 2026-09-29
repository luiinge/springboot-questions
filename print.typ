// Plantilla pandoc -> Typst del libro en PDF (A4, color).
// Dos ediciones: "screen" (por defecto, para leer en pantalla) y "print"
// (imprenta: sangrado y márgenes de encuadernación). Se elige con -V edition=print.
// Se usa junto con print.lua, que aporta <chapter-info> y <question-topic>.

#let book-title = [$title$]
#let book-subtitle = [$subtitle$]
#let book-author = [$author$]

// ---------- Textos por idioma ----------
#let lang-code = "$if(lang)$$lang$$else$es-ES$endif$"
#let is-en = lang-code.starts-with("en")
#let L = if is-en { (
  lang: "en", region: "US",
  guide: "TECHNICAL INTERVIEW PREPARATION GUIDE",
  level: "Level", monograph: "Deep Dive", part: "Part", appendix: "Appendix",
  questions: "questions", contents: "Contents",
  levels: (
    "Basic — Spring and Spring Boot fundamentals",
    "Basic-Intermediate — Spring Boot in practice",
    "Intermediate — Persistence, transactions and testing",
    "Intermediate — Design patterns applied to Java and Spring",
    "Intermediate-Advanced — Microservices: fundamentals, communication and infrastructure",
    "Advanced — Resilience, distributed data and microservice patterns",
    "Expert — Internals, performance and system design",
  ),
  monographs: (("A", "Apache Kafka in depth"), ("B", "Docker and Kubernetes"), ("C", "Observability and monitoring")),
  rights: [This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International licence (CC BY-SA 4.0). You may copy, redistribute and adapt it, including for commercial purposes, provided that you credit the author and share any derivative works under the same licence. Licence text: #link("https://creativecommons.org/licenses/by-sa/4.0/")[creativecommons.org/licenses/by-sa/4.0]. The code examples are licensed under the MIT licence.],
  source: [Latest version and source files: #link("https://github.com/luiinge/springboot-questions")[github.com/luiinge/springboot-questions]],
  disclaimer: [Although every care has been taken in the preparation of this book, the author assumes no responsibility for errors or omissions, or for any damage resulting from the use of the information it contains.],
  trademarks: [All trademarks mentioned belong to their respective owners.],
  edition: "First edition",
) } else { (
  lang: "es", region: "ES",
  guide: "GUÍA DE PREPARACIÓN DE ENTREVISTAS TÉCNICAS",
  level: "Nivel", monograph: "Monográfico", part: "Parte", appendix: "Apéndice",
  questions: "preguntas", contents: "Índice",
  levels: (
    "Básico — Fundamentos de Spring y Spring Boot",
    "Básico-Intermedio — Spring Boot en la práctica",
    "Intermedio — Persistencia, transacciones y testing",
    "Intermedio — Patrones de diseño aplicados a Java y Spring",
    "Intermedio-Avanzado — Microservicios: fundamentos, comunicación e infraestructura",
    "Avanzado — Resiliencia, datos distribuidos y patrones de microservicios",
    "Experto — Internals, rendimiento y diseño de sistemas",
  ),
  monographs: (("A", "Apache Kafka en profundidad"), ("B", "Docker y Kubernetes"), ("C", "Observabilidad y monitorización")),
  rights: [Esta obra se publica bajo la licencia Creative Commons Reconocimiento-CompartirIgual 4.0 Internacional (CC BY-SA 4.0). Se permite copiarla, redistribuirla y adaptarla, incluso con fines comerciales, siempre que se cite al autor y las obras derivadas se compartan con la misma licencia. Texto de la licencia: #link("https://creativecommons.org/licenses/by-sa/4.0/deed.es")[creativecommons.org/licenses/by-sa/4.0]. Los ejemplos de código se publican bajo la licencia MIT.],
  source: [Versión más reciente y ficheros fuente: #link("https://github.com/luiinge/springboot-questions")[github.com/luiinge/springboot-questions]],
  disclaimer: [Aunque se ha puesto el máximo cuidado en la preparación de este libro, el autor no asume responsabilidad alguna por errores u omisiones, ni por los daños que pudieran derivarse del uso de la información que contiene.],
  trademarks: [Todas las marcas mencionadas pertenecen a sus respectivos propietarios.],
  edition: "Primera edición",
) }

// ---------- Formato ----------
// A4 (8,27 x 11,69 in). En la edición impresa se añade un sangrado de 0,125 in en el
// borde exterior, superior e inferior, y un margen interior mayor para la encuadernación.
#let is-print = "$edition$" == "print"
#let bleed = if is-print { 0.125in } else { 0in }
#let trim-width = 8.27in
#let trim-height = 11.69in
#let gutter = if is-print { 0.8in } else { 0.75in }
#let dark-inner = if is-print { gutter } else { 0.9in }

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
  let m = title.match(regex("^" + L.level + " (\d+)"))
  if m != none { return level-colors.at(int(m.captures.first()) - 1) }
  let m = title.match(regex("^" + L.monograph + " ([A-Z])"))
  if m != none { return monograph-colors.at(m.captures.first(), default: default-accent) }
  if title.starts-with(L.appendix) { return appendix-color }
  default-accent
}

#let accent = state("accent", default-accent)

$if(highlighting-definitions)$
$highlighting-definitions$
$endif$

#set document(title: book-title, author: "$author$")
#set text(font: sans, size: 9.6pt, fill: ink, lang: L.lang, region: L.region, hyphenate: true)
#set par(justify: false, leading: 0.72em, spacing: 1.05em)

// ---------- Página ----------

#let in-front-matter() = {
  let start = query(<body-start>)
  start.len() == 0 or here().page() < start.first().location().page()
}

// Cabecera y número de página: en el borde exterior (impresa) o siempre a la derecha (pantalla)
#let outside(body) = context {
  if is-print and calc.even(here().page()) { align(left, body) } else { align(right, body) }
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
  margin: (inside: dark-inner, outside: 0.9in + bleed, top: 1in + bleed, bottom: 1in + bleed),
  body,
)

// Franja con los colores de los niveles, de sangre a sangre
#let level-bar(height: 5pt) = context {
  let even = calc.even(here().page())
  let left-margin = if even { 0.9in + bleed } else { dark-inner }
  let right-margin = if even { dark-inner } else { 0.9in + bleed }
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
    if title.starts-with(L.part + " ") {
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
      if info.count != "" { kicker += " · " + info.count + " " + L.questions }
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
  let q = title.match(regex("^([PQ]\d+) · (.*)$$"))
  let a = title.match(regex("^" + L.appendix + " ([A-Z]) · (.*)$$"))
  if q != none {
    context {
      let found = query(selector(<question-topic>).before(here()))
      let meta = if found.len() > 0 { found.last().value } else { (topic: "", first: false) }
      // Cada pregunta en página nueva, salvo la primera del capítulo (va tras el bloque de color)
      if not meta.first { pagebreak(weak: true) }
      badged-heading(q.captures.at(0), meta.topic, q.captures.at(1), accent.get())
    }
  } else if a != none {
    accent.update(appendix-color)
    badged-heading(a.captures.at(0), L.appendix, a.captures.at(1), appendix-color)
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
// El código en línea puede partirse tras . _ / - (nombres largos de propiedades, paquetes...)
#show raw.where(block: false): it => text(
  font: mono, size: 8.3pt, fill: code-ink, hyphenate: false,
  it.text.replace(regex("([._/-])"), m => m.text + "\u{200B}"),
)
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
  #text(size: 8.5pt, weight: "bold", fill: spring, tracking: 0.06em, L.guide)
  #v(0.9em)
  #text(size: 30pt, weight: "bold", fill: white, hyphenate: false, book-title)
  #v(0.8em)
  #text(size: 11pt, fill: white.darken(18%), book-subtitle)
  #v(1.1in)
  #level-bar()
  #v(0.35in)
  #{
    set text(size: 8.5pt, fill: white.darken(12%))
    let names = L.levels
    for (i, n) in names.enumerate() {
      block(above: 5pt, below: 5pt)[#text(fill: level-colors.at(i))[●] #h(5pt) #L.level #(i + 1) · #n]
    }
    v(4pt)
    for (k, n) in L.monographs {
      block(above: 5pt, below: 5pt)[#text(fill: monograph-colors.at(k))[●] #h(5pt) #L.monograph #k · #n]
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

  #L.rights

  #L.disclaimer

  #L.trademarks

  #L.source

$if(isbn)$
  ISBN: $isbn$

$endif$
  #L.edition: $if(copyright-year)$$copyright-year$$else$2026$endif$
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
  #text(size: 20pt, weight: "bold", fill: navy, L.contents)
  #v(18pt)
  #set par(justify: false)
  #outline(title: none, depth: $if(toc-depth)$$toc-depth$$else$2$endif$)
]

// ---------- Cuerpo ----------

#if is-print { pagebreak(to: "odd", weak: true) } else { pagebreak(weak: true) }
#counter(page).update(1)
#metadata(none)<body-start>

$body$
