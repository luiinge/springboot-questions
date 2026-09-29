# Entrevista Técnica Java: Spring Boot y Microservicios

*158 preguntas con respuestas explicadas, de junior a senior* · [English version below](#java-technical-interview-spring-boot-and-microservices)

Libro libre con las preguntas más habituales en entrevistas técnicas para puestos de backend con Java, Spring Boot y microservicios. Cada respuesta empieza por la idea central y sigue con los matices, los errores habituales, los *trade-offs* y, cuando ayuda, código.

- **Parte I**: siete niveles de dificultad creciente, desde los fundamentos de Spring hasta rendimiento, internals y diseño de sistemas.
- **Parte II**: monográficos sobre Apache Kafka, Docker y Kubernetes, y observabilidad.
- **Apéndices**: preguntas relámpago, chuletas de anotaciones y propiedades, glosario, plan de estudio y consejos para la entrevista.

## Leer o descargar

| | PDF | EPUB | Markdown |
|---|---|---|---|
| Español | [Descargar](https://github.com/luiinge/springboot-questions/releases/latest/download/springboot-questions-es.pdf) | [Descargar](https://github.com/luiinge/springboot-questions/releases/latest/download/springboot-questions-es.epub) | [Leer online](es.md) |
| English | [Download](https://github.com/luiinge/springboot-questions/releases/latest/download/springboot-questions-en.pdf) | [Download](https://github.com/luiinge/springboot-questions/releases/latest/download/springboot-questions-en.epub) | [Read online](en.md) |

Todas las versiones están en [Releases](https://github.com/luiinge/springboot-questions/releases).

## Cómo se ha elaborado

Las preguntas y respuestas se recopilaron y redactaron con ayuda de herramientas de inteligencia artificial, y después se repasaron y validaron. Si encuentras un error, abre un [issue](https://github.com/luiinge/springboot-questions/issues) o una pull request.

## Licencia

El texto se publica bajo [Creative Commons Reconocimiento-CompartirIgual 4.0 (CC BY-SA 4.0)](LICENSE): puedes copiarlo, redistribuirlo y adaptarlo, incluso con fines comerciales, siempre que cites al autor y compartas las obras derivadas con la misma licencia. Los ejemplos de código se publican bajo la [licencia MIT](LICENSE-CODE).

© 2026 Luis Iñesta Gelabert

---

# Java Technical Interview: Spring Boot and Microservices

*158 questions with explained answers, from junior to senior*

A free book with the questions that come up most often in technical interviews for Java backend positions with Spring Boot and microservices. Each answer starts with the core idea and goes on to the nuances, common mistakes, *trade-offs* and, when it helps, code.

- **Part I**: seven levels of increasing difficulty, from Spring fundamentals to performance, internals and system design.
- **Part II**: deep dives on Apache Kafka, Docker and Kubernetes, and observability.
- **Appendices**: rapid-fire questions, annotation and property cheat sheets, glossary, study plan and interview advice.

Download links are in the table above; every version is available under [Releases](https://github.com/luiinge/springboot-questions/releases).

## How this book was made

The questions and answers were collected and drafted with the help of artificial intelligence tools, and then reviewed and validated. If you find a mistake, please open an [issue](https://github.com/luiinge/springboot-questions/issues) or a pull request.

## Licence

The text is licensed under [Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)](LICENSE): you may copy, redistribute and adapt it, including for commercial purposes, provided that you credit the author and share derivative works under the same licence. The code examples are licensed under the [MIT licence](LICENSE-CODE).

---

## Generar el libro / Building the book

Requiere / Requires [pandoc](https://pandoc.org) 3.x, [Typst](https://typst.app) 0.15+ y/and the DejaVu fonts.

```bash
./build.sh              # build/es.pdf, build/en.pdf, build/es.epub, build/en.epub
./build.sh en           # solo un idioma / a single language
./build.sh --print      # añade la edición de imprenta con sangrado / adds the print edition with bleed
```

Cada push a `main` genera los ficheros como artefacto de GitHub Actions; al publicar una etiqueta `vX.Y` se crea una release con ellos.
Every push to `main` builds the files as a GitHub Actions artifact; pushing a `vX.Y` tag creates a release with them.
