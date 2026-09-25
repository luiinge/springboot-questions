---
title: "Entrevista Técnica Java: Spring Boot y Microservicios"
subtitle: "158 preguntas con respuestas explicadas, de junior a senior"
lang: es-ES
toc: true
toc-depth: 2
---

# Introducción

Este libro reúne **158 preguntas** habituales en entrevistas técnicas para puestos de desarrollo backend con Java, Spring Boot y microservicios, cada una con una respuesta explicada como la darías en una entrevista bien preparada: primero la idea central, después los matices y, cuando ayuda, código.

## Cómo está organizado

La **primera parte** recorre siete niveles de dificultad creciente, desde los fundamentos de Spring hasta preguntas de perfil senior y ejercicios de diseño de sistemas. Está pensada para leerse en orden: cada nivel se apoya en los anteriores.

La **segunda parte** contiene tres monográficos sobre tecnologías que aparecen en casi cualquier oferta de desarrollo con microservicios: **Apache Kafka**, **Docker y Kubernetes** y **observabilidad**. Dentro de cada monográfico, las preguntas también van de menor a mayor dificultad, y pueden leerse de forma independiente.

Los **apéndices** incluyen una batería de preguntas relámpago, chuletas de anotaciones y propiedades, un glosario, un plan de estudio y consejos para cada tipo de entrevista.

## Cómo leer cada pregunta

Cada pregunta indica su tema y su nivel. Muchas terminan con dos elementos adicionales:

- **Clave para la entrevista**: qué suele buscar el entrevistador o qué detalle diferencia una respuesta correcta de una excelente.
- **Repreguntas frecuentes**: las preguntas de seguimiento que suelen venir a continuación, con su respuesta breve. En una entrevista real, la primera respuesta rara vez es la última.

Recomendaciones: intenta responder en voz alta antes de leer la respuesta; relaciona cada concepto con tu propia experiencia; y en los niveles avanzados, céntrate en los *trade-offs*, porque rara vez hay una única respuesta correcta.

Las referencias a versiones corresponden al ecosistema actual (Java 21 o superior, Spring Boot 3.x y 4.x). Cuando una funcionalidad depende de la versión, se indica expresamente.

## Contenido

| Parte | Capítulo | Preguntas |
|---|---|---|
| I | Nivel 1 · Básico: Fundamentos de Spring y Spring Boot | P001 – P017 |
| I | Nivel 2 · Básico-Intermedio: Spring Boot en la práctica | P018 – P036 |
| I | Nivel 3 · Intermedio: Persistencia, transacciones y testing | P037 – P055 |
| I | Nivel 4 · Intermedio: Patrones de diseño aplicados a Java y Spring | P056 – P073 |
| I | Nivel 5 · Intermedio-Avanzado: Microservicios: fundamentos, comunicación e infraestructura | P074 – P090 |
| I | Nivel 6 · Avanzado: Resiliencia, datos distribuidos y patrones de microservicios | P091 – P108 |
| I | Nivel 7 · Experto: Internals, rendimiento y diseño de sistemas | P109 – P125 |
| II | Monográfico A: Apache Kafka en profundidad | P126 – P137 |
| II | Monográfico B: Docker y Kubernetes para desarrolladores Spring Boot | P138 – P147 |
| II | Monográfico C: Observabilidad y monitorización | P148 – P158 |

# Parte I · Preguntas por nivel de dificultad

Siete capítulos ordenados de menor a mayor dificultad. Cada uno se apoya en los conceptos de los anteriores.

# Nivel 1 · Básico · Fundamentos de Spring y Spring Boot

Conceptos que cualquier entrevistador da por sabidos: IoC, inyección de dependencias, beans, anotaciones esenciales y qué aporta Spring Boot sobre Spring.

Este capítulo contiene 17 preguntas.

## P001 · ¿Qué es Spring Framework y qué problema resuelve?

*Tema: Spring Core · Nivel 1 · Básico*

Spring es un framework de Java cuyo núcleo es un **contenedor de Inversión de Control (IoC)**. Su objetivo original fue simplificar el desarrollo empresarial frente a la complejidad de J2EE/EJB: en lugar de que cada clase cree y busque sus dependencias, el contenedor crea los objetos (beans), los conecta entre sí y gestiona su ciclo de vida.

Sobre ese núcleo se construye un ecosistema amplio:

- **Spring MVC / WebFlux** para aplicaciones web y APIs REST.
- **Spring Data** para acceso a datos (JPA, MongoDB, Redis...).
- **Spring Security** para autenticación y autorización.
- **Spring AOP** para programación orientada a aspectos (transacciones, seguridad, logging transversal).
- **Spring Cloud** para sistemas distribuidos.

El beneficio principal es el **bajo acoplamiento**: el código depende de interfaces y el contenedor decide qué implementación inyectar, lo que facilita el testing (se pueden sustituir dependencias por mocks) y la evolución del código.

> **Clave para la entrevista.** No te quedes en «es un framework para hacer webs». Menciona IoC/DI como núcleo y el bajo acoplamiento como beneficio clave.

### Repreguntas frecuentes

**¿Spring es solo para aplicaciones web?**

No. El contenedor de IoC sirve para cualquier tipo de aplicación: procesos batch (Spring Batch), consumidores de mensajes, aplicaciones de línea de comandos o integraciones (Spring Integration). La parte web es solo uno de sus módulos.

**¿Qué alternativas a Spring existen en el ecosistema Java?**

Jakarta EE (con servidores como WildFly, Payara u Open Liberty), Quarkus y Micronaut. Estos dos últimos resuelven buena parte de la inyección de dependencias en tiempo de compilación, lo que reduce el tiempo de arranque y la memoria. Spring respondió con su motor AOT y el soporte de imágenes nativas. Conocer las alternativas y sus trade-offs demuestra perspectiva.

## P002 · ¿Qué es Spring Boot y en qué se diferencia de Spring?

*Tema: Spring Boot · Nivel 1 · Básico*

Spring Boot no sustituye a Spring: es una capa **opinada** encima de Spring que elimina la configuración repetitiva. Sus pilares son:

- **Autoconfiguración**: detecta qué hay en el classpath y configura beans razonables por defecto. Si añades `spring-boot-starter-data-jpa` y un driver de base de datos, crea automáticamente el `DataSource`, el `EntityManagerFactory` y el gestor de transacciones.
- **Starters**: dependencias agregadas que traen un conjunto coherente y probado de librerías con versiones compatibles.
- **Servidor embebido**: Tomcat (por defecto), Jetty o Undertow dentro de la propia aplicación; se ejecuta con `java -jar`.
- **Configuración externa** unificada (properties, YAML, variables de entorno, perfiles).
- **Production-ready**: Actuator con health checks, métricas e información de la aplicación.

Con Spring «clásico» había que declarar manualmente la configuración (XML o clases `@Configuration`), desplegar un WAR en un servidor de aplicaciones y gestionar versiones de dependencias a mano. Spring Boot aplica el principio de **convención sobre configuración**, pero todo lo que autoconfigura se puede sobrescribir.

> **Clave para la entrevista.** Deja claro que Boot es Spring + convenciones, no un framework distinto. Mencionar que todo es sobrescribible demuestra que entiendes que no es magia.

### Repreguntas frecuentes

**¿Qué significa que Spring Boot sea «opinado»?**

Que toma decisiones por defecto razonables (Tomcat como servidor, Jackson para JSON, HikariCP como pool, Logback para logs) para que puedas empezar sin configurar nada. Las opiniones son sustituibles: añadir otra librería o declarar tu propio bean hace que Boot se retire.

**¿Cómo sabes qué ha configurado Spring Boot automáticamente?**

Arrancando con --debug para ver el informe de condiciones, consultando /actuator/conditions y /actuator/beans, o revisando la documentación de propiedades comunes de Spring Boot, donde aparecen todos los valores por defecto.

## P003 · ¿Qué son la Inversión de Control y la Inyección de Dependencias? ¿Qué tipos de inyección existen?

*Tema: Spring Core · Nivel 1 · Básico*

**Inversión de Control (IoC)** es el principio por el cual el control de la creación y el ciclo de vida de los objetos pasa del código de la aplicación a un framework. **Inyección de Dependencias (DI)** es la forma concreta de aplicar IoC: las dependencias se «inyectan» desde fuera en lugar de que el objeto las cree con `new`.

Spring admite tres tipos de inyección:

- **Por constructor** (recomendada): las dependencias son obligatorias, pueden ser `final` (inmutabilidad), el objeto nunca queda a medio construir y se puede instanciar en un test unitario sin Spring. Desde Spring 4.3, si hay un único constructor no hace falta `@Autowired`.
- **Por setter**: útil para dependencias opcionales o que pueden cambiar.
- **Por campo** (`@Autowired` sobre el atributo): cómoda pero desaconsejada; oculta dependencias, impide `final`, obliga a usar reflexión o Spring en los tests y facilita que una clase acumule demasiadas dependencias sin que se note.

```java
@Service
public class PedidoService {
    private final PedidoRepository repo;
    private final NotificadorClient notificador;

    public PedidoService(PedidoRepository repo, NotificadorClient notificador) {
        this.repo = repo;
        this.notificador = notificador;
    }
}
```

Con Lombok se suele abreviar con `@RequiredArgsConstructor`.

> **Clave para la entrevista.** Es casi seguro que te pregunten «¿por qué constructor?». Las tres razones fuertes: inmutabilidad, testabilidad sin Spring y detección temprana de clases con demasiadas dependencias.

### Repreguntas frecuentes

**¿Es necesario poner @Autowired en el constructor?**

No desde Spring 4.3 si la clase tiene un único constructor. Si tiene varios, hay que marcar con @Autowired el que Spring debe usar.

**¿Cómo inyectarías una dependencia opcional?**

Con ObjectProvider<T> (getIfAvailable), con Optional<T> como parámetro del constructor o con @Autowired(required = false) en un setter. ObjectProvider es la opción más flexible porque además permite resolución perezosa.

## P004 · ¿Qué hace la anotación @SpringBootApplication?

*Tema: Spring Boot · Nivel 1 · Básico*

Es una meta-anotación que combina tres:

- `@SpringBootConfiguration`: especialización de `@Configuration`; marca la clase como fuente de definiciones de beans.
- `@EnableAutoConfiguration`: activa el mecanismo de autoconfiguración de Spring Boot.
- `@ComponentScan`: escanea el paquete de la clase anotada **y sus subpaquetes** en busca de `@Component`, `@Service`, `@Repository`, `@Controller`, etc.

```java
@SpringBootApplication
public class TiendaApplication {
    public static void main(String[] args) {
        SpringApplication.run(TiendaApplication.class, args);
    }
}
```

Consecuencia práctica importante: la clase principal debe estar en el **paquete raíz**. Si un componente está en un paquete «hermano» (fuera del árbol), no se detectará. Se pueden excluir autoconfiguraciones concretas con `@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)`.

> **Clave para la entrevista.** Menciona el detalle del paquete raíz: es una fuente clásica de errores «No qualifying bean found» en proyectos reales.

### Repreguntas frecuentes

**¿Puedo tener varias clases con @SpringBootApplication en el mismo proyecto?**

Técnicamente sí, pero es mala idea: cada una escanearía su árbol de paquetes y podrían solaparse. Un caso legítimo son los tests con configuraciones propias, donde se usa @SpringBootConfiguration o @TestConfiguration en su lugar.

**¿Cómo escanearías componentes de un paquete fuera del árbol principal?**

Con @SpringBootApplication(scanBasePackages = {...}) o @ComponentScan, o importando explícitamente una configuración con @Import. Para librerías compartidas lo correcto es una autoconfiguración, no ampliar el escaneo.

## P005 · ¿Qué diferencia hay entre @Component, @Service, @Repository, @Controller y @RestController?

*Tema: Spring Core · Nivel 1 · Básico*

Todas son **estereotipos** que registran la clase como bean durante el component scan. `@Service`, `@Repository` y `@Controller` están meta-anotadas con `@Component`, pero cada una aporta semántica y, en algunos casos, comportamiento:

- `@Component`: genérica, para cualquier bean gestionado.
- `@Service`: lógica de negocio. No añade comportamiento, solo intención (útil para legibilidad y para pointcuts de AOP).
- `@Repository`: acceso a datos. **Sí añade comportamiento**: activa la traducción de excepciones específicas de la tecnología (SQLException, excepciones de Hibernate) a la jerarquía `DataAccessException` de Spring.
- `@Controller`: controlador MVC; sus métodos devuelven normalmente nombres de vistas.
- `@RestController`: `@Controller` + `@ResponseBody`; lo que devuelven los métodos se serializa directamente en el cuerpo de la respuesta (JSON por defecto, vía Jackson).

> **Clave para la entrevista.** El detalle que marca la diferencia es la traducción de excepciones de @Repository.

### Repreguntas frecuentes

**¿Qué pasa si anoto un servicio con @Component en lugar de @Service?**

Funciona igual: el bean se registra. Solo se pierde la intención semántica, que es útil para la legibilidad y para aspectos o reglas de arquitectura que seleccionan por estereotipo (por ejemplo, reglas de ArchUnit sobre clases @Service).

**¿Puedo crear mis propios estereotipos?**

Sí: una anotación propia meta-anotada con @Component (por ejemplo @UseCase o @Adapter en una arquitectura hexagonal). Spring la detectará en el escaneo, y el nombre expresa mejor la arquitectura.

## P006 · ¿Qué son los starters de Spring Boot?

*Tema: Spring Boot · Nivel 1 · Básico*

Un starter es un POM (o módulo Gradle) de dependencias agregadas para un caso de uso. No suele contener código propio; su valor está en reunir un conjunto coherente de librerías con **versiones compatibles** gestionadas por el BOM de Spring Boot (`spring-boot-dependencies`).

Ejemplos habituales:

- `spring-boot-starter-web`: Spring MVC, Tomcat embebido, Jackson.
- `spring-boot-starter-webflux`: stack reactivo con Netty.
- `spring-boot-starter-data-jpa`: Spring Data JPA, Hibernate, HikariCP.
- `spring-boot-starter-security`, `-actuator`, `-validation`, `-test`.

Gracias al BOM, en el `pom.xml` normalmente no se indica versión en las dependencias gestionadas: se hereda de `spring-boot-starter-parent` o se importa el BOM. Esto evita el «infierno de versiones» (por ejemplo, incompatibilidades entre Hibernate y Spring Data).

La convención de nombres es `spring-boot-starter-*` para los oficiales y `*-spring-boot-starter` para los de terceros.

## P007 · ¿Qué es un bean y qué scopes existen?

*Tema: Spring Core · Nivel 1 · Básico*

Un **bean** es un objeto cuya creación, configuración y ciclo de vida gestiona el contenedor de Spring. Los scopes determinan cuántas instancias se crean y cuánto viven:

- **singleton** (por defecto): una única instancia por `ApplicationContext`. Todas las inyecciones reciben la misma.
- **prototype**: una instancia nueva cada vez que se solicita el bean. Spring no gestiona su destrucción (no llama a `@PreDestroy`).
- **request**: una instancia por petición HTTP (solo en contextos web).
- **session**: una instancia por sesión HTTP.
- **application**: una por `ServletContext`.
- **websocket**: una por sesión WebSocket.

Trampa clásica: inyectar un bean **prototype dentro de un singleton**. La inyección ocurre una sola vez al crear el singleton, así que siempre se usa la misma instancia del prototype. Soluciones: inyectar un `ObjectProvider<T>` y llamar a `getObject()`, usar `@Lookup` o un proxy de scope (`proxyMode = ScopedProxyMode.TARGET_CLASS`).

Como los singletons se comparten entre hilos, **deben ser stateless** o thread-safe.

> **Clave para la entrevista.** La trampa prototype-en-singleton y el «los singletons deben ser stateless» son los dos puntos que suelen buscar.

### Repreguntas frecuentes

**¿Cómo compruebas que un singleton es realmente thread-safe?**

Revisando que no tenga estado mutable compartido: solo atributos final con dependencias también stateless o thread-safe. Si necesita estado, usar estructuras concurrentes (ConcurrentHashMap, AtomicLong) o reconsiderar el diseño. Los tests de concurrencia son difíciles; la revisión de diseño es la principal defensa.

**¿Cuándo usarías un bean de scope request?**

Para guardar información de la petición accesible desde varias capas sin pasarla como parámetro, por ejemplo el contexto del tenant o del usuario. Spring inyecta un proxy que resuelve la instancia de la petición actual. Hoy muchas veces se prefiere pasar el contexto explícitamente o usar el SecurityContext.

## P008 · ¿Cuál es la diferencia entre @Bean y @Component?

*Tema: Spring Core · Nivel 1 · Básico*

Ambas registran beans, pero de forma distinta:

- `@Component` (y sus estereotipos) se pone **sobre la clase**. Spring la descubre por component scan y la instancia él mismo. Solo sirve para clases que controlas.
- `@Bean` se pone **sobre un método** dentro de una clase `@Configuration`. Tú escribes el código de creación y Spring registra el objeto devuelto. Es la opción para clases de terceros (que no puedes anotar) o cuando la construcción requiere lógica.

```java
@Configuration
public class ClientesConfig {
    @Bean
    public ObjectMapper objectMapper() {
        return JsonMapper.builder()
            .addModule(new JavaTimeModule())
            .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
            .build();
    }
}
```

Detalle avanzado: las clases `@Configuration` se procesan con un proxy CGLIB (modo «full»), de forma que si un método `@Bean` llama a otro, se devuelve el singleton ya existente en lugar de crear uno nuevo. Con `@Configuration(proxyBeanMethods = false)` (modo «lite») se evita el proxy y el arranque es algo más rápido, a cambio de no poder llamar entre métodos `@Bean`.

### Repreguntas frecuentes

**¿Qué pasa si defino dos métodos @Bean que devuelven el mismo tipo?**

Se registran dos beans y los puntos de inyección de ese tipo serán ambiguos. Hay que marcar uno como @Primary, nombrarlos y usar @Qualifier, o inyectarlos todos como lista.

**¿Puede un método @Bean recibir parámetros?**

Sí, y es la forma recomendada de expresar dependencias entre beans: Spring resuelve cada parámetro como una inyección. Así se evitan llamadas entre métodos @Bean y funciona también en modo lite (proxyBeanMethods = false).

## P009 · ¿Qué diferencia hay entre application.properties y application.yml? ¿Qué son los perfiles?

*Tema: Configuración · Nivel 1 · Básico*

Ambos ficheros sirven para lo mismo; cambia la sintaxis. Properties es plano (`clave=valor`); YAML es jerárquico, más legible para configuraciones anidadas y admite listas de forma natural. Si coexisten, se cargan los dos (properties tiene precedencia sobre yml en la misma ubicación).

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/tienda
    username: app
server:
  port: 8081
```

Los **perfiles** permiten tener configuración distinta por entorno. Se crean ficheros `application-{perfil}.yml` (por ejemplo `application-dev.yml`, `application-prod.yml`) que sobrescriben la configuración base. Se activan con `spring.profiles.active=prod`, con la variable de entorno `SPRING_PROFILES_ACTIVE` o por línea de comandos.

Los perfiles también condicionan beans: `@Profile("dev")` sobre un `@Component` o `@Bean` hace que solo se registre con ese perfil activo (por ejemplo, un stub de un servicio externo para desarrollo). También se pueden agrupar perfiles con `spring.profiles.group`.

> **Clave para la entrevista.** Añade que los secretos nunca deben ir en el fichero: se inyectan por variables de entorno o un gestor de secretos (Vault, Secrets de Kubernetes).

### Repreguntas frecuentes

**¿Puedo activar varios perfiles a la vez?**

Sí, separados por comas (spring.profiles.active=prod,aws). Si definen la misma propiedad, gana el último perfil de la lista.

**¿Cómo pondrías configuración de varios perfiles en un único fichero YAML?**

Con documentos separados por tres guiones y la propiedad spring.config.activate.on-profile en cada documento. Es cómodo para configuraciones pequeñas, aunque con muchas diferencias es más legible usar ficheros separados.

## P010 · ¿Qué es el ApplicationContext? ¿En qué se diferencia de BeanFactory?

*Tema: Spring Core · Nivel 1 · Básico*

`BeanFactory` es la interfaz raíz del contenedor: sabe crear beans y resolver dependencias, con inicialización **perezosa** (crea cada bean cuando se pide).

`ApplicationContext` extiende `BeanFactory` y añade funcionalidades empresariales:

- Inicialización **ansiosa** de singletons al arrancar (los errores de configuración salen en el arranque, no en producción a las 3 de la madrugada).
- Publicación de eventos (`ApplicationEventPublisher`).
- Internacionalización (`MessageSource`).
- Acceso a recursos (`ResourceLoader`) y al `Environment` (propiedades y perfiles).
- Registro automático de `BeanPostProcessor` y `BeanFactoryPostProcessor`, que son la base de AOP, `@Transactional`, `@Autowired`, etc.

En la práctica siempre se usa `ApplicationContext`; en Spring Boot la implementación concreta depende del tipo de aplicación (por ejemplo, `AnnotationConfigServletWebServerApplicationContext` para una app web con servlets). Se puede activar lazy initialization global con `spring.main.lazy-initialization=true`, útil en desarrollo pero arriesgado en producción porque retrasa los errores.

### Repreguntas frecuentes

**¿Puede haber varios ApplicationContext en una aplicación?**

Sí, en jerarquía padre-hijo: los beans del hijo ven los del padre pero no al revés. Era habitual en aplicaciones Spring MVC clásicas (contexto raíz y contexto del DispatcherServlet) y aparece en Spring Cloud (contextos hijos por cliente). En una aplicación Boot típica hay uno solo.

**¿Por qué no deberías llamar a applicationContext.getBean() en tu código de negocio?**

Porque es el antipatrón Service Locator: oculta las dependencias, acopla el código al contenedor y dificulta los tests. La inyección de dependencias existe precisamente para evitarlo.

## P011 · ¿Qué ocurre si hay dos beans del mismo tipo? ¿Cómo se usan @Qualifier y @Primary?

*Tema: Spring Core · Nivel 1 · Básico*

Si un punto de inyección admite varios candidatos, Spring lanza `NoUniqueBeanDefinitionException`. Hay varias formas de resolverlo:

- `@Primary`: marca un bean como el preferido por defecto.
- `@Qualifier("nombre")`: en el punto de inyección, elige explícitamente uno. Tiene prioridad sobre `@Primary`.
- **Nombre del parámetro**: si coincide con el nombre de un bean, Spring lo usa como desempate.
- **Inyectar todos**: `List<Interfaz>` (ordenables con `@Order`) o `Map<String, Interfaz>` (clave = nombre del bean). Es la base del patrón Strategy en Spring.

```java
@Service
public class PagoService {
    private final PasarelaPago pasarela;

    public PagoService(@Qualifier("stripe") PasarelaPago pasarela) {
        this.pasarela = pasarela;
    }
}
```

Para evitar «strings mágicos», se pueden crear anotaciones cualificadoras propias meta-anotadas con `@Qualifier`.

### Repreguntas frecuentes

**¿En qué orden se inyectan los beans en una List<Interfaz>?**

Según @Order o la interfaz Ordered si están presentes; en otro caso, en el orden de registro, que no conviene dar por garantizado. Si el orden importa (una cadena de validadores, por ejemplo), hay que declararlo explícitamente.

**¿@Primary o @Qualifier?**

@Primary cuando existe una implementación por defecto clara y otras que solo se usan en casos concretos. @Qualifier cuando cada punto de inyección debe elegir explícitamente. Abusar de @Primary en muchos beans genera confusión.

## P012 · ¿Cómo se empaqueta y ejecuta una aplicación Spring Boot? ¿Qué es un fat jar?

*Tema: Spring Boot · Nivel 1 · Básico*

El plugin de Maven o Gradle de Spring Boot genera un **fat jar** (o «uber jar») ejecutable que contiene las clases de la aplicación, **todas sus dependencias** en `BOOT-INF/lib` y un servidor embebido. Se ejecuta con `java -jar app.jar`.

Como Java no sabe cargar jars anidados de forma nativa, Spring Boot incluye su propio lanzador (`JarLauncher`), declarado como `Main-Class` en el manifiesto; este crea un classloader capaz de leer los jars internos y después invoca tu clase `main` (declarada como `Start-Class`).

Ventajas: un único artefacto autocontenido, ideal para contenedores y para el modelo «build once, run anywhere». También se puede generar un WAR para servidores de aplicaciones tradicionales extendiendo `SpringBootServletInitializer`.

Para Docker, es buena práctica usar **capas** (`layertools` / `-Djarmode=tools extract`), separando dependencias (cambian poco) del código propio (cambia mucho), de modo que la caché de Docker se aproveche y las imágenes se reconstruyan más rápido. También existen los buildpacks: `mvn spring-boot:build-image` genera la imagen OCI sin Dockerfile.

> **Clave para la entrevista.** Si te postulas a perfiles con componente DevOps, las capas de Docker y los buildpacks son un plus muy valorado.

### Repreguntas frecuentes

**¿Puedo pasar configuración al ejecutar el jar?**

Sí: argumentos (--server.port=9090), propiedades del sistema (-Dspring.profiles.active=prod), variables de entorno o un fichero application.yml junto al jar o en ./config. Todo sigue el orden de precedencia de la configuración externa.

**¿Qué es CDS y cómo mejora el arranque?**

Class Data Sharing guarda en un fichero las clases ya cargadas y procesadas por la JVM para reutilizarlas en arranques siguientes. Spring Boot 3.3+ facilita crear el archivo CDS a partir del jar extraído, reduciendo el tiempo de arranque de forma notable sin los inconvenientes de una imagen nativa.

## P013 · ¿Cómo se crea un proyecto Spring Boot y cómo conviene organizar sus paquetes?

*Tema: Proyecto · Nivel 1 · Básico*

La forma habitual es **Spring Initializr** (start.spring.io, integrado en IntelliJ IDEA, VS Code y Eclipse): se elige herramienta de build (Maven o Gradle), lenguaje, versión de Spring Boot y de Java, y los starters necesarios. Genera un esqueleto con la clase principal, el `pom.xml` o `build.gradle`, `application.properties` y un test que verifica que el contexto arranca.

```text
tienda/
├── pom.xml
├── src/main/java/com/miempresa/tienda/
│   └── TiendaApplication.java
├── src/main/resources/
│   ├── application.yml
│   └── db/migration/
└── src/test/java/com/miempresa/tienda/
    └── TiendaApplicationTests.java
```

Hay dos grandes estrategias para organizar los paquetes:

- **Por capas** (package by layer): `controller`, `service`, `repository`, `model`. Es sencilla y muy común en tutoriales, pero en proyectos medianos cada funcionalidad queda repartida por todo el árbol, y todas las clases tienen que ser públicas para verse entre paquetes.
- **Por funcionalidad** (package by feature): `pedidos`, `clientes`, `catalogo`, y dentro de cada uno sus controladores, servicios y repositorios. Aumenta la cohesión, permite usar visibilidad de paquete para ocultar detalles internos y facilita extraer un módulo a un servicio independiente en el futuro.

```text
com.miempresa.tienda
├── pedidos
│   ├── PedidoController.java
│   ├── PedidoService.java        (público: API del módulo)
│   ├── PedidoRepository.java     (package-private)
│   └── Pedido.java
├── clientes
└── compartido
```

Para proyectos que van a crecer, la organización por funcionalidad es la opción más defendible. Es además el requisito de partida para herramientas como Spring Modulith, que tratan cada paquete de primer nivel como un módulo.

> **Clave para la entrevista.** Si te preguntan por la estructura, justificar la organización por funcionalidad con el argumento de la cohesión y la visibilidad de paquete suele sorprender positivamente.

## P014 · ¿Qué requisitos de Java tiene Spring Boot 3 y qué supuso el paso de javax a jakarta?

*Tema: Plataforma · Nivel 1 · Básico*

Spring Boot 3 (y Spring Framework 6) exige **Java 17 como mínimo** y se alinea con **Jakarta EE 9+**. El cambio más visible es el de espacio de nombres: todas las APIs empresariales pasaron de `javax.*` a `jakarta.*`.

¿Por qué ocurrió? Oracle transfirió Java EE a la Eclipse Foundation, que lo rebautizó como Jakarta EE, pero no cedió el uso de la marca «java» en los paquetes. Para poder evolucionar las especificaciones, estas tuvieron que moverse a un nuevo espacio de nombres.

```java
// Spring Boot 2.x
import javax.persistence.Entity;
import javax.validation.constraints.NotBlank;
import javax.servlet.http.HttpServletRequest;

// Spring Boot 3.x
import jakarta.persistence.Entity;
import jakarta.validation.constraints.NotBlank;
import jakarta.servlet.http.HttpServletRequest;
```

Implicaciones de una migración de Boot 2 a Boot 3:

- Cambiar los imports (herramientas como **OpenRewrite** lo automatizan con recetas específicas).
- Actualizar librerías de terceros a versiones compatibles con Jakarta (Hibernate 6, Tomcat 10, Jetty 11+...).
- Revisar cambios asociados: Hibernate 6 modifica algunos comportamientos y la generación de identificadores; Spring Security 6 elimina `WebSecurityConfigurerAdapter` en favor de beans `SecurityFilterChain`; Spring Cloud Sleuth se sustituye por Micrometer Tracing.
- Se recomienda pasar primero por la última versión 2.7, resolver sus avisos de deprecación, y después saltar a la 3.x.

Nota de ecosistema: Spring Boot 4 (sobre Spring Framework 7) mantiene Java 17 como base, recomienda versiones más recientes y se alinea con Jakarta EE 11.

Además de ser un requisito, trabajar con Java 17+ permite aprovechar **records**, **sealed classes**, *pattern matching* para `instanceof` y `switch`, *text blocks* y, con Java 21, **hilos virtuales**.

## P015 · ¿Qué son Spring Boot DevTools y para qué sirven?

*Tema: Herramientas · Nivel 1 · Básico*

`spring-boot-devtools` es un módulo pensado solo para **desarrollo** que mejora el ciclo de trabajo:

- **Reinicio automático**: cuando cambian clases en el classpath (al recompilar), reinicia la aplicación. Es más rápido que un arranque en frío porque usa dos classloaders: uno *base* para las dependencias, que no cambian, y otro *restart* para tu código, que se descarta y se recrea.
- **LiveReload**: refresca automáticamente el navegador cuando cambian recursos estáticos o plantillas.
- **Valores por defecto de desarrollo**: desactiva la caché de plantillas (Thymeleaf, FreeMarker) y activa logging web más detallado.
- **Configuración global** en `~/.config/spring-boot/` para preferencias personales.
- Soporte de desarrollo remoto (poco utilizado hoy).

Se declara como dependencia opcional o `developmentOnly` para que no acabe en el artefacto final:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

DevTools se **desactiva automáticamente** cuando la aplicación se ejecuta como jar empaquetado (`java -jar`), para evitar sorpresas en producción.

Un problema habitual: como hay dos classloaders, algunas librerías que cachean clases o usan serialización pueden producir `ClassCastException` del tipo «X no se puede convertir a X». Se soluciona excluyendo o incluyendo jars en el classloader de reinicio mediante `META-INF/spring-devtools.properties`.

## P016 · ¿Qué es Lombok? ¿Qué riesgos tiene usarlo, especialmente con entidades JPA?

*Tema: Herramientas · Nivel 1 · Básico*

Lombok es un procesador de anotaciones que genera código repetitivo en tiempo de compilación: getters y setters, constructores, `equals`/`hashCode`, `toString`, builders y loggers.

- `@Getter`, `@Setter`
- `@RequiredArgsConstructor`: constructor para los campos `final` (muy útil para la inyección por constructor).
- `@Builder`, `@Value` (clase inmutable), `@Data` (todo lo anterior mutable junto), `@Slf4j`.

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class PedidoService {
    private final PedidoRepository repo;
    private final ApplicationEventPublisher eventos;
}
```

Riesgos y malas prácticas:

- **`@Data` en entidades JPA** es la trampa más conocida. Genera `equals` y `hashCode` con todos los campos, incluidas las relaciones: al meter una entidad en un `HashSet` y después asignarle un ID al persistirla, su hash cambia y «desaparece» del conjunto. Además, recorrer relaciones perezosas en `equals`, `hashCode` o `toString` dispara consultas inesperadas, `LazyInitializationException` o incluso `StackOverflowError` con relaciones bidireccionales.
- `@ToString` con relaciones: mismo problema de recursión y de carga perezosa.
- Setters públicos para todo, lo que empuja a un **modelo anémico** y rompe la encapsulación.
- Dependencia de una herramienta que se engancha a detalles internos del compilador; cada versión nueva de Java requiere actualizar Lombok.

Recomendaciones: en entidades usar solo `@Getter` (y setters seleccionados) y escribir `equals`/`hashCode` a mano; para DTOs y value objects, preferir los **records** de Java, que ya son inmutables y generan `equals`, `hashCode` y `toString` sin herramientas externas.

> **Clave para la entrevista.** Muchos entrevistadores preguntan «¿usas Lombok?» esperando que menciones el problema de @Data con entidades JPA.

## P017 · ¿Qué papel juegan Maven y Gradle en un proyecto Spring Boot? ¿Qué es spring-boot-starter-parent?

*Tema: Build · Nivel 1 · Básico*

Ambas herramientas gestionan dependencias, compilan, ejecutan tests y empaquetan. Spring Boot aporta plugins para las dos.

**Maven**: configuración declarativa en XML (`pom.xml`) con un ciclo de vida fijo (`validate`, `compile`, `test`, `package`, `verify`, `install`, `deploy`). Es muy predecible y estándar en entornos corporativos.

El `spring-boot-starter-parent` es un POM padre que proporciona:

- La gestión de versiones de cientos de dependencias (hereda del BOM `spring-boot-dependencies`).
- La versión de Java y la codificación UTF-8 por defecto.
- Configuración razonable de plugins (surefire, failsafe, resources con filtrado).
- La configuración del `spring-boot-maven-plugin` para crear el jar ejecutable.

Si el proyecto ya tiene un padre corporativo propio, se puede importar el BOM en `dependencyManagement` en lugar de heredar:

```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-dependencies</artifactId>
      <version>${spring-boot.version}</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>
```

**Gradle**: configuración como código (Groovy o Kotlin DSL), builds incrementales y caché de build, lo que lo hace más rápido en proyectos grandes y multimódulo. Se usa el plugin `org.springframework.boot` junto con la gestión de dependencias (plugin `io.spring.dependency-management` o la plataforma `platform(SpringBootPlugin.BOM_COORDINATES)`).

Comandos útiles:

- `./mvnw spring-boot:run` / `./gradlew bootRun`: ejecutar en desarrollo.
- `./mvnw package` / `./gradlew bootJar`: generar el jar ejecutable.
- `./mvnw spring-boot:build-image` / `./gradlew bootBuildImage`: generar la imagen OCI con buildpacks.
- `./mvnw dependency:tree`: diagnosticar conflictos de versiones.

Usar siempre el **wrapper** (`mvnw`, `gradlew`) para que todos los desarrolladores y el pipeline de CI compilen con la misma versión de la herramienta.

# Nivel 2 · Básico-Intermedio · Spring Boot en la práctica

APIs REST, configuración externa, validación, manejo de errores, Actuator y el funcionamiento de la autoconfiguración.

Este capítulo contiene 19 preguntas.

## P018 · ¿Cómo se crea un endpoint REST? ¿Qué diferencia hay entre @PathVariable, @RequestParam y @RequestBody?

*Tema: REST · Nivel 2 · Básico-Intermedio*

Se anota una clase con `@RestController` y sus métodos con `@GetMapping`, `@PostMapping`, `@PutMapping`, `@PatchMapping` o `@DeleteMapping` (atajos de `@RequestMapping`).

- `@PathVariable`: extrae un segmento de la URL. Identifica **un recurso concreto**: `/clientes/42`.
- `@RequestParam`: extrae parámetros de la query string. Para **filtros, ordenación o paginación**: `/clientes?ciudad=Valencia&page=0`. Pueden ser opcionales (`required = false` o `Optional`) o tener `defaultValue`.
- `@RequestBody`: deserializa el cuerpo de la petición (JSON) a un objeto, usando los `HttpMessageConverter` (Jackson).
- `@RequestHeader`: lee cabeceras.

```java
@RestController
@RequestMapping("/api/v1/clientes")
public class ClienteController {

    @GetMapping("/{id}")
    public ClienteDto obtener(@PathVariable Long id) { ... }

    @GetMapping
    public List<ClienteDto> buscar(@RequestParam(required = false) String ciudad) { ... }

    @PostMapping
    public ResponseEntity<ClienteDto> crear(@Valid @RequestBody CrearClienteRequest req) {
        ClienteDto creado = service.crear(req);
        URI location = URI.create("/api/v1/clientes/" + creado.id());
        return ResponseEntity.created(location).body(creado);
    }
}
```

### Repreguntas frecuentes

**¿Cómo diseñarías la URL para una acción que no es CRUD, como cancelar un pedido?**

Hay dos estilos aceptados: modelar la acción como un subrecurso (POST /pedidos/42/cancelacion) o como un cambio de estado (PATCH /pedidos/42 con el nuevo estado). Se desaconsejan verbos en la URL como /cancelarPedido. Lo importante es la coherencia en toda la API.

**¿Controladores síncronos que devuelven entidades o ResponseEntity?**

Devolver el DTO directamente es más limpio cuando la respuesta siempre es 200. ResponseEntity se usa cuando hay que controlar el estado o las cabeceras (201 con Location, 204, ETag, caché).

## P019 · ¿Qué códigos HTTP y qué semántica deben tener los verbos en una API REST? ¿Qué es la idempotencia?

*Tema: REST · Nivel 2 · Básico-Intermedio*

Semántica de los verbos principales:

- **GET**: lee. Seguro (no modifica estado) e idempotente.
- **POST**: crea o ejecuta una acción. **No idempotente**: repetirlo puede crear dos recursos.
- **PUT**: reemplaza el recurso completo. Idempotente.
- **PATCH**: modificación parcial. No es idempotente por definición (depende de la implementación).
- **DELETE**: elimina. Idempotente (borrar dos veces deja el mismo estado).

**Idempotente** significa que ejecutar la operación N veces produce el mismo efecto en el servidor que ejecutarla una vez. Es crucial en sistemas distribuidos porque los clientes reintentan ante timeouts.

Códigos habituales: `200 OK`, `201 Created` (con cabecera `Location`), `204 No Content`, `400 Bad Request` (validación), `401 Unauthorized` (no autenticado), `403 Forbidden` (autenticado sin permiso), `404 Not Found`, `409 Conflict` (conflicto de estado o de versión), `422 Unprocessable Content` (semánticamente inválido), `429 Too Many Requests`, `500 Internal Server Error`, `502/503/504` (problemas con dependencias o sobrecarga).

Para hacer un POST idempotente se usa una **Idempotency-Key** enviada por el cliente: el servidor guarda la clave y, si llega repetida, devuelve la respuesta original en lugar de volver a ejecutar la operación.

> **Clave para la entrevista.** Distinguir bien 401 vs 403 y conocer la Idempotency-Key suelen ser los puntos diferenciadores.

### Repreguntas frecuentes

**¿Qué código devolverías para un recurso que existe pero el usuario no puede ver?**

Técnicamente 403, pero muchas APIs devuelven 404 para no revelar la existencia del recurso (por ejemplo, pedidos de otros clientes). Es una decisión de seguridad que debe ser coherente en toda la API.

**¿Qué diferencia hay entre 400 y 422?**

400 indica una petición mal formada (JSON inválido, tipos incorrectos). 422 indica una petición sintácticamente correcta pero que no se puede procesar por reglas de negocio (una fecha de fin anterior a la de inicio). Muchas APIs usan 400 para ambos casos; lo importante es documentarlo.

## P020 · ¿Cómo se gestionan las excepciones de forma global en una API Spring Boot?

*Tema: REST · Nivel 2 · Básico-Intermedio*

Con una clase anotada con `@RestControllerAdvice` (o `@ControllerAdvice`) que contiene métodos `@ExceptionHandler`. Centraliza la traducción de excepciones a respuestas HTTP, evitando try/catch repetidos en cada controlador.

Desde Spring 6 / Boot 3 se recomienda devolver `ProblemDetail`, que implementa el estándar **RFC 9457** (antes RFC 7807) para errores en APIs HTTP (`type`, `title`, `status`, `detail`, `instance` y propiedades extra). Se puede activar el soporte automático con `spring.mvc.problemdetails.enabled=true`.

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RecursoNoEncontradoException.class)
    public ProblemDetail noEncontrado(RecursoNoEncontradoException ex) {
        ProblemDetail pd = ProblemDetail.forStatusAndDetail(HttpStatus.NOT_FOUND, ex.getMessage());
        pd.setTitle("Recurso no encontrado");
        return pd;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ProblemDetail validacion(MethodArgumentNotValidException ex) {
        ProblemDetail pd = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        pd.setTitle("Datos no válidos");
        pd.setProperty("errores", ex.getBindingResult().getFieldErrors().stream()
            .map(e -> e.getField() + ": " + e.getDefaultMessage()).toList());
        return pd;
    }
}
```

Buenas prácticas: no exponer stack traces ni mensajes internos al cliente, loguear el error con un identificador de correlación y tener un handler genérico para `Exception` que devuelva 500.

### Repreguntas frecuentes

**¿Excepciones propias comprobadas o no comprobadas?**

En aplicaciones Spring se prefieren las no comprobadas (extender RuntimeException): no contaminan las firmas, provocan rollback por defecto y se traducen a HTTP en el advice. Conviene una jerarquía pequeña con significado de negocio (RecursoNoEncontrado, ReglaNegocioViolada, ConflictoDeVersion).

**¿Cómo añadirías un identificador de error para soporte?**

Incluyendo el traceId en el ProblemDetail (como propiedad extra o en instance). El cliente lo muestra o lo reporta, y con él se localizan todos los logs y la traza de esa petición.

## P021 · ¿Cómo funciona la validación de datos de entrada? ¿Qué diferencia hay entre @Valid y @Validated?

*Tema: Validación · Nivel 2 · Básico-Intermedio*

Spring Boot integra **Jakarta Bean Validation** (implementación Hibernate Validator) al añadir `spring-boot-starter-validation`. Se anotan los campos del DTO con restricciones y se dispara la validación con `@Valid`:

```java
public record CrearClienteRequest(
    @NotBlank @Size(max = 100) String nombre,
    @Email @NotNull String email,
    @Past LocalDate fechaNacimiento,
    @Valid @NotNull DireccionDto direccion   // validación en cascada
) {}
```

Si falla en un `@RequestBody`, se lanza `MethodArgumentNotValidException` (400).

Diferencias:

- `@Valid` es estándar de Jakarta; activa validación y **cascada** en objetos anidados.
- `@Validated` es de Spring; admite **grupos de validación** (por ejemplo, reglas distintas en creación y actualización) y, puesta **sobre una clase**, activa la validación de parámetros de métodos mediante un proxy AOP (útil para validar `@PathVariable`, `@RequestParam` o parámetros de servicios, que lanzan `ConstraintViolationException`).

Para reglas complejas se crean validadores personalizados implementando `ConstraintValidator` con una anotación propia (por ejemplo, `@NifValido`).

### Repreguntas frecuentes

**¿Dónde deberían vivir las reglas de negocio: en anotaciones de validación o en el dominio?**

Las anotaciones cubren validaciones de formato y estructura en la frontera (campos obligatorios, longitudes, formatos). Las reglas de negocio que dependen del estado (no se puede cancelar un pedido enviado) pertenecen al dominio, dentro de las entidades o servicios.

**¿Cómo validarías una regla que implica varios campos, como fechaFin > fechaInicio?**

Con una anotación de validación a nivel de clase y su ConstraintValidator, o con un método anotado con @AssertTrue en el DTO. En records también se puede validar en el constructor compacto.

## P022 · ¿Qué diferencia hay entre @Value y @ConfigurationProperties?

*Tema: Configuración · Nivel 2 · Básico-Intermedio*

- `@Value("${app.timeout:5s}")` inyecta **una propiedad suelta**, admite valores por defecto y expresiones SpEL. Adecuado para uno o dos valores.
- `@ConfigurationProperties(prefix = "app.pagos")` enlaza **un grupo de propiedades** a un objeto tipado. Es la opción recomendada para configuración estructurada.

```java
@ConfigurationProperties(prefix = "app.pagos")
@Validated
public record PagosProperties(
    @NotBlank String urlPasarela,
    Duration timeout,
    int reintentosMaximos,
    Map<String, String> comercios
) {}
```

Ventajas de `@ConfigurationProperties`: tipado fuerte (convierte `Duration`, `DataSize`, listas, mapas), validación con `@Validated` al arrancar (falla rápido si falta configuración), **relaxed binding** (`url-pasarela`, `URL_PASARELA` y `urlPasarela` se enlazan igual, lo que encaja con variables de entorno), autocompletado en el IDE con `spring-boot-configuration-processor` y agrupación lógica. Se registran con `@EnableConfigurationProperties` o `@ConfigurationPropertiesScan`.

### Repreguntas frecuentes

**¿Puedo usar @ConfigurationProperties sobre un método @Bean?**

Sí: enlaza las propiedades sobre el objeto devuelto. Es útil para configurar clases de terceros, por ejemplo un DataSource adicional con prefijo propio.

**¿Qué es el relaxed binding y por qué importa en contenedores?**

Es la capacidad de enlazar la misma propiedad escrita de distintas formas. Gracias a ello, app.pagos.url-pasarela puede configurarse con la variable de entorno APP_PAGOS_URLPASARELA, que es la forma natural en Kubernetes y Docker.

## P023 · ¿Cuál es el orden de precedencia de la configuración externa en Spring Boot?

*Tema: Configuración · Nivel 2 · Básico-Intermedio*

Spring Boot lee propiedades de muchas fuentes y las de mayor precedencia sobrescriben a las de menor. Simplificando, de **mayor a menor** prioridad:

- Propiedades de test (`@TestPropertySource`, `@SpringBootTest(properties = ...)`, `@DynamicPropertySource`).
- Argumentos de línea de comandos (`--server.port=9000`).
- `SPRING_APPLICATION_JSON`.
- Propiedades del sistema Java (`-Dserver.port=9000`).
- Variables de entorno del sistema operativo (`SERVER_PORT=9000`).
- Ficheros de configuración: primero los específicos de perfil (`application-prod.yml`) y después el genérico; los de **fuera del jar** (junto al jar o en `./config/`) tienen prioridad sobre los empaquetados dentro.
- `@PropertySource` en clases de configuración.
- Valores por defecto (`SpringApplication.setDefaultProperties`).

La consecuencia práctica es que la misma imagen Docker se configura por entorno mediante **variables de entorno**, sin reconstruirla, lo que encaja con la metodología 12-factor. Con `spring.config.import` se pueden añadir fuentes adicionales (por ejemplo, `configserver:` o `optional:file:`).

> **Clave para la entrevista.** No hace falta recitar la lista completa: basta con el orden gordo (tests > línea de comandos > variables de entorno > ficheros externos > ficheros internos) y la consecuencia para contenedores.

### Repreguntas frecuentes

**¿Cómo sobrescribirías una sola propiedad en un pod de Kubernetes sin tocar la imagen?**

Con una variable de entorno en el manifiesto (por ejemplo, SPRING_DATASOURCE_HIKARI_MAXIMUMPOOLSIZE=15), que tiene más precedencia que los ficheros empaquetados.

## P024 · ¿Qué es Spring Boot Actuator y qué endpoints son los más importantes?

*Tema: Actuator · Nivel 2 · Básico-Intermedio*

Actuator añade endpoints de **operación y monitorización** listos para producción. Los más utilizados:

- `/actuator/health`: estado de la aplicación y de sus dependencias (BD, disco, broker...). Admite grupos como `liveness` y `readiness` para las sondas de Kubernetes.
- `/actuator/metrics` y `/actuator/prometheus`: métricas vía Micrometer (JVM, HTTP, pool de conexiones, métricas propias).
- `/actuator/info`: información de build y git.
- `/actuator/env` y `/actuator/configprops`: propiedades efectivas (sensibles; los valores se enmascaran).
- `/actuator/loggers`: consultar y **cambiar el nivel de log en caliente**.
- `/actuator/threaddump` y `/actuator/heapdump`: diagnóstico.
- `/actuator/mappings`, `/actuator/beans`, `/actuator/conditions`: introspección (el último explica qué autoconfiguraciones se aplicaron y por qué).

Por defecto, vía HTTP solo se expone `health`. Se amplía con `management.endpoints.web.exposure.include=health,info,prometheus`.

**Seguridad**: nunca exponer `env`, `heapdump` o `threaddump` públicamente. Buenas prácticas: puerto de gestión separado (`management.server.port`), protegerlos con Spring Security y exponer solo lo necesario. Se pueden crear indicadores propios implementando `HealthIndicator`.

### Repreguntas frecuentes

**¿Cómo añadirías información de la versión desplegada al endpoint info?**

Con el goal build-info del plugin de Spring Boot (genera META-INF/build-info.properties) y el plugin git-commit-id para la información de Git. Actuator las publica automáticamente; es muy útil para confirmar qué versión corre en cada entorno.

**¿Cómo crearías un endpoint de Actuator propio?**

Con una clase anotada con @Endpoint(id = "...") y métodos @ReadOperation, @WriteOperation o @DeleteOperation. Se expone por HTTP y JMX con la misma seguridad y configuración que los endpoints estándar.

## P025 · ¿Cómo funciona la autoconfiguración de Spring Boot por dentro?

*Tema: Autoconfiguración · Nivel 2 · Básico-Intermedio*

`@EnableAutoConfiguration` importa un `ImportSelector` que carga la lista de clases de autoconfiguración declaradas en `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` de cada jar (antes de Boot 2.7/3 se usaba `spring.factories`).

Cada autoconfiguración es una clase `@AutoConfiguration` protegida con **anotaciones condicionales** que deciden si se aplica:

- `@ConditionalOnClass` / `@ConditionalOnMissingClass`: según exista una clase en el classpath.
- `@ConditionalOnBean` / `@ConditionalOnMissingBean`: según exista ya un bean. Es la clave de la sobrescritura: **si defines tu propio bean, la autoconfiguración se retira**.
- `@ConditionalOnProperty`: según el valor de una propiedad.
- `@ConditionalOnWebApplication`, `@ConditionalOnResource`, etc.

```java
@AutoConfiguration
@ConditionalOnClass(DataSource.class)
@EnableConfigurationProperties(DataSourceProperties.class)
public class MiDataSourceAutoConfiguration {
    @Bean
    @ConditionalOnMissingBean
    DataSource dataSource(DataSourceProperties props) { ... }
}
```

Las autoconfiguraciones se procesan **después** de la configuración del usuario, precisamente para que las condiciones `OnMissingBean` vean tus beans. Para depurar: arrancar con `--debug` genera el **Condition Evaluation Report**, o consultar `/actuator/conditions`.

> **Clave para la entrevista.** Mencionar @ConditionalOnMissingBean como mecanismo de «back-off» y el informe de condiciones para depurar es lo que diferencia a quien lo ha usado de quien lo ha leído.

### Repreguntas frecuentes

**¿Cómo desactivarías una autoconfiguración concreta?**

Con exclude en @SpringBootApplication o con la propiedad spring.autoconfigure.exclude, que permite hacerlo por entorno sin recompilar.

**¿Por qué una autoconfiguración no debe usar @ComponentScan?**

Porque registraría beans sin las condiciones que permiten al usuario sobrescribirlos y podría escanear paquetes de la aplicación. Todo debe declararse explícitamente con @Bean y condiciones.

## P026 · ¿Cómo funciona el logging en Spring Boot?

*Tema: Operación · Nivel 2 · Básico-Intermedio*

Spring Boot usa **SLF4J** como fachada y **Logback** como implementación por defecto (se puede cambiar a Log4j2 con su starter). Se configura en properties o YAML:

```yaml
logging:
  level:
    root: INFO
    com.miempresa.pedidos: DEBUG
    org.hibernate.SQL: DEBUG
  file:
    name: logs/app.log
```

Para configuraciones avanzadas se usa `logback-spring.xml` (el sufijo `-spring` permite usar `<springProfile>` y propiedades de Spring). Desde Boot 3.4 hay soporte nativo de **logging estructurado** en JSON (formatos ECS, GELF, Logstash) con `logging.structured.format.console=ecs`, ideal para agregadores como ELK o Loki.

Buenas prácticas:

- Usar placeholders (`log.info("Pedido {} creado", id)`) en lugar de concatenar cadenas.
- Incluir en el **MDC** identificadores de traza y correlación (con Micrometer Tracing se añaden `traceId` y `spanId` automáticamente).
- No loguear datos personales, contraseñas ni tokens.
- En contenedores, loguear a stdout y dejar la recolección a la plataforma.

### Repreguntas frecuentes

**¿Cómo cambiarías el nivel de log en producción sin reiniciar?**

Con el endpoint /actuator/loggers (POST con el nuevo nivel para un paquete) o, en plataformas con configuración centralizada, actualizando la propiedad y refrescando. Debe estar protegido y es conveniente volver al nivel normal tras la investigación.

**¿Por qué es costoso concatenar cadenas en los logs?**

Porque la concatenación y las llamadas a toString se ejecutan aunque el nivel esté desactivado. Con placeholders, el mensaje solo se construye si se va a escribir. Para cálculos caros se usa la API fluida de SLF4J 2 (log.atDebug().addArgument(() -> ...)) o se comprueba isDebugEnabled.

## P027 · ¿Cuál es el ciclo de vida de un bean?

*Tema: Spring Core · Nivel 2 · Básico-Intermedio*

Simplificado, para un singleton:

- **Instanciación**: se invoca el constructor (con inyección por constructor).
- **Población de propiedades**: inyección por setter y campo.
- **Aware callbacks**: `BeanNameAware`, `ApplicationContextAware`...
- `BeanPostProcessor.postProcessBeforeInitialization`.
- **Inicialización**: `@PostConstruct`, luego `InitializingBean.afterPropertiesSet()`, luego el `initMethod` declarado en `@Bean`.
- `BeanPostProcessor.postProcessAfterInitialization`: **aquí se crean los proxies AOP** (transacciones, caché, seguridad...). Lo que se inyecta en otros beans es el proxy, no el objeto original.
- El bean está listo y se usa.
- **Destrucción** al cerrar el contexto: `@PreDestroy`, `DisposableBean.destroy()`, `destroyMethod`.

Implicaciones prácticas: en el constructor el proxy aún no existe, así que llamar a un método `@Transactional` desde el constructor o desde `@PostConstruct` no abre transacción. Para tareas tras el arranque completo es mejor escuchar `ApplicationReadyEvent`.

> **Clave para la entrevista.** El punto que más valor aporta: los proxies se crean en postProcessAfterInitialization. Conecta con preguntas posteriores sobre @Transactional.

### Repreguntas frecuentes

**¿Qué diferencia hay entre @PostConstruct y escuchar ApplicationReadyEvent?**

@PostConstruct se ejecuta al inicializar ese bean concreto, cuando otros beans pueden no estar listos y el contexto no ha terminado de arrancar. ApplicationReadyEvent llega cuando toda la aplicación está arrancada, que es el momento adecuado para tareas que dependen de todo el contexto o que tardan.

## P028 · ¿Por qué usar DTOs en lugar de exponer directamente las entidades JPA?

*Tema: Arquitectura · Nivel 2 · Básico-Intermedio*

Exponer entidades en la API acopla el **contrato público** al **modelo de persistencia**, y causa varios problemas:

- **Seguridad / mass assignment**: un cliente podría enviar campos que no debería modificar (por ejemplo `rol` o `saldo`).
- **Fugas de información**: se serializan campos internos o sensibles.
- **Problemas de lazy loading**: Jackson accede a relaciones perezosas fuera de la transacción (`LazyInitializationException`) o dispara consultas N+1.
- **Recursión infinita** en relaciones bidireccionales.
- **Evolución**: cambiar una columna rompe la API para todos los consumidores.

Los DTOs (idealmente `record` inmutables) definen un contrato estable y adaptado a cada caso de uso (petición de creación, respuesta de detalle, respuesta de listado). El mapeo se hace a mano o con **MapStruct**, que genera el código en tiempo de compilación (sin reflexión, rápido y verificable), frente a ModelMapper, que usa reflexión en tiempo de ejecución.

```java
@Mapper(componentModel = "spring")
public interface ClienteMapper {
    ClienteDto toDto(Cliente entidad);
    Cliente toEntity(CrearClienteRequest req);
}
```

### Repreguntas frecuentes

**¿No es demasiado código duplicado tener entidades, DTOs y mappers?**

Es un coste real, pero compensa en cuanto la API es pública o el modelo evoluciona. Los records y MapStruct lo reducen mucho. En servicios muy pequeños e internos se puede ser pragmático, siendo consciente del acoplamiento que se asume.

## P029 · ¿Qué son CommandLineRunner, ApplicationRunner y los eventos del ciclo de vida de la aplicación?

*Tema: Spring Boot · Nivel 2 · Básico-Intermedio*

`CommandLineRunner` y `ApplicationRunner` son interfaces cuyos beans se ejecutan **justo después de arrancar el contexto**, antes de que la aplicación se considere lista. La diferencia es que `ApplicationRunner` recibe los argumentos ya parseados (`ApplicationArguments`), y `CommandLineRunner` los recibe como `String[]`. Se ordenan con `@Order`. Casos de uso: carga de datos iniciales, calentar cachés, tareas de un solo uso.

Spring Boot también publica **eventos** a lo largo del arranque, en este orden aproximado: `ApplicationStartingEvent`, `ApplicationEnvironmentPreparedEvent`, `ApplicationContextInitializedEvent`, `ApplicationPreparedEvent`, `ContextRefreshedEvent`, `WebServerInitializedEvent`, `ApplicationStartedEvent`, `AvailabilityChangeEvent` (liveness), ejecución de runners, `ApplicationReadyEvent`, `AvailabilityChangeEvent` (readiness) y, si algo falla, `ApplicationFailedEvent`.

```java
@EventListener(ApplicationReadyEvent.class)
public void alArrancar() {
    log.info("Aplicación lista para recibir tráfico");
}
```

Relación con Kubernetes: la sonda de readiness no pasa a `ACCEPTING_TRAFFIC` hasta después de los runners, así que una carga inicial lenta retrasa correctamente la entrada de tráfico.

### Repreguntas frecuentes

**¿Usarías un CommandLineRunner para cargar datos de prueba?**

En desarrollo, sí, protegido con @Profile("dev"). En producción, los datos iniciales deberían cargarse con migraciones versionadas (Flyway), que son idempotentes y quedan registradas.

## P030 · ¿Qué es el DispatcherServlet y cómo fluye una petición HTTP en Spring MVC?

*Tema: Spring MVC · Nivel 2 · Básico-Intermedio*

El `DispatcherServlet` implementa el patrón **Front Controller**: es un único servlet que recibe todas las peticiones y las delega en los componentes adecuados. Spring Boot lo registra automáticamente y lo mapea a `/`.

Recorrido de una petición a un `@RestController`:

- La petición atraviesa primero la cadena de **filtros de servlet** (incluida la cadena de Spring Security, filtros de CORS, de trazas, etc.).
- Llega al `DispatcherServlet`, que consulta los **`HandlerMapping`** para localizar qué método de qué controlador atiende esa URL y verbo (`RequestMappingHandlerMapping` para los métodos anotados con `@GetMapping`, etc.).
- Se ejecutan los métodos `preHandle` de los **`HandlerInterceptor`** registrados.
- Un **`HandlerAdapter`** invoca el método del controlador. Antes, los **`HandlerMethodArgumentResolver`** construyen cada argumento: leen variables de ruta, parámetros o cabeceras, y deserializan el cuerpo con un **`HttpMessageConverter`** (Jackson para JSON). Si hay `@Valid`, se valida aquí.
- El método se ejecuta y devuelve un valor. Los **`HandlerMethodReturnValueHandler`** lo procesan: en un `@RestController`, el valor se serializa con un `HttpMessageConverter` elegido por **negociación de contenido** (cabecera `Accept`).
- Se ejecutan `postHandle` y, al final, `afterCompletion` de los interceptores.
- Si en cualquier punto se lanza una excepción, los **`HandlerExceptionResolver`** la gestionan; entre ellos está el que invoca los métodos `@ExceptionHandler` de tus `@ControllerAdvice`.
- La respuesta vuelve atravesando los filtros en orden inverso.

En el caso de un `@Controller` que devuelve una vista, el nombre de la vista lo resuelve un `ViewResolver` (Thymeleaf, por ejemplo), que genera el HTML.

Conocer este flujo ayuda a responder preguntas como dónde colocar una lógica transversal, por qué un error de deserialización no llega al controlador o por qué una excepción lanzada en un filtro no la captura el `@ControllerAdvice` (los filtros se ejecutan fuera del `DispatcherServlet`).

> **Clave para la entrevista.** El detalle final (las excepciones lanzadas en filtros no llegan al @ControllerAdvice) es un ejemplo excelente de comprensión práctica del flujo.

## P031 · ¿Qué diferencia hay entre un Filter, un HandlerInterceptor y un aspecto AOP? ¿Cuándo usar cada uno?

*Tema: Spring MVC · Nivel 2 · Básico-Intermedio*

Los tres permiten ejecutar lógica transversal, pero actúan en niveles distintos:

- **Filter** (`jakarta.servlet.Filter`, o `OncePerRequestFilter` de Spring): pertenece a la especificación Servlet y actúa **antes de llegar a Spring MVC**. Ve la petición y la respuesta HTTP «en bruto», puede envolverlas o cortar la cadena. No sabe qué controlador atenderá la petición. Adecuado para: seguridad, CORS, compresión, logging de peticiones, añadir o propagar identificadores de correlación.
- **HandlerInterceptor**: pertenece a Spring MVC y actúa **dentro del `DispatcherServlet`**, cuando ya se conoce el handler (el método del controlador y sus anotaciones). Tiene tres puntos: `preHandle`, `postHandle` y `afterCompletion`. Adecuado para lógica que depende del controlador: comprobar una anotación propia, métricas por endpoint, localización.
- **Aspecto AOP** (`@Aspect`): actúa sobre **llamadas a métodos de beans** de cualquier capa, no solo web. Adecuado para lógica transversal de negocio: auditoría de métodos de servicio, medición de tiempos, reintentos, control de permisos a nivel de método.

```java
@Component
public class CorrelationIdFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res,
                                    FilterChain chain) throws ServletException, IOException {
        String id = Optional.ofNullable(req.getHeader("X-Correlation-Id"))
                            .orElse(UUID.randomUUID().toString());
        MDC.put("correlationId", id);
        res.setHeader("X-Correlation-Id", id);
        try {
            chain.doFilter(req, res);
        } finally {
            MDC.remove("correlationId");
        }
    }
}
```

```java
@Aspect
@Component
public class TiempoEjecucionAspect {
    @Around("@annotation(com.miempresa.Medido)")
    public Object medir(ProceedingJoinPoint pjp) throws Throwable {
        long inicio = System.nanoTime();
        try {
            return pjp.proceed();
        } finally {
            log.info("{} tardó {} ms", pjp.getSignature().toShortString(),
                     (System.nanoTime() - inicio) / 1_000_000);
        }
    }
}
```

Nótese el `finally` para limpiar el MDC: los hilos del servidor se reutilizan y un valor olvidado «contaminaría» la siguiente petición atendida por ese hilo.

## P032 · ¿Cómo se documenta una API REST en Spring Boot? ¿Contract-first o code-first?

*Tema: Documentación · Nivel 2 · Básico-Intermedio*

El estándar de facto es **OpenAPI** (antes Swagger): una especificación en YAML o JSON que describe endpoints, parámetros, esquemas, códigos de respuesta y seguridad. Sirve para generar documentación interactiva, clientes y servidores, mocks y tests.

En Spring Boot, la librería más usada es **springdoc-openapi**, que genera la especificación inspeccionando los controladores:

```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
</dependency>
```

Con eso ya se sirven `/v3/api-docs` (la especificación) y `/swagger-ui.html` (la interfaz interactiva). Se enriquece con anotaciones:

```java
@Operation(summary = "Obtiene un cliente por su identificador")
@ApiResponse(responseCode = "404", description = "El cliente no existe")
@GetMapping("/{id}")
public ClienteDto obtener(@Parameter(description = "ID del cliente") @PathVariable Long id) { ... }
```

Dos enfoques:

- **Code-first**: se escribe el código y la especificación se genera a partir de él. Rápido para empezar, siempre sincronizado con la implementación. El riesgo es que el diseño de la API quede condicionado por la implementación y que los cambios incompatibles pasen desapercibidos.
- **Contract-first** (API-first): se diseña primero el fichero OpenAPI, se revisa con los consumidores y se generan las interfaces del servidor y los clientes con **OpenAPI Generator**. El contrato es la fuente de verdad, los equipos pueden trabajar en paralelo (el frontend usa un mock generado) y los cambios son explícitos en las revisiones. Exige más disciplina y herramientas.

En organizaciones con muchos equipos o APIs públicas, contract-first suele ser preferible. En ambos casos conviene publicar la especificación en el pipeline y **detectar automáticamente cambios incompatibles** comparando versiones (herramientas como openapi-diff u oasdiff).

Seguridad: en producción, desactivar Swagger UI o protegerlo (`springdoc.swagger-ui.enabled=false`) si la API no es pública.

## P033 · ¿Qué es CORS y cómo se configura en Spring Boot?

*Tema: Web · Nivel 2 · Básico-Intermedio*

**CORS** (Cross-Origin Resource Sharing) es un mecanismo del **navegador**. Por la política del mismo origen, el JavaScript de una página servida desde `https://app.tienda.com` no puede leer respuestas de `https://api.tienda.com` (distinto origen: esquema, dominio o puerto) salvo que el servidor lo autorice expresamente con cabeceras como `Access-Control-Allow-Origin`.

Para peticiones «no simples» (por ejemplo, con `Content-Type: application/json`, cabecera `Authorization` o verbos como PUT y DELETE), el navegador envía antes una petición **preflight** `OPTIONS` para preguntar si la petición real está permitida.

Puntos importantes:

- CORS **no es una medida de seguridad del servidor**: protege a los usuarios del navegador. Clientes como curl, Postman o un servicio backend lo ignoran completamente.
- Un error de CORS se ve en la consola del navegador aunque el servidor haya procesado la petición.

Configuración global en Spring MVC:

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("https://app.tienda.com")
            .allowedMethods("GET", "POST", "PUT", "DELETE")
            .allowedHeaders("*")
            .allowCredentials(true)
            .maxAge(3600);
    }
}
```

También se puede usar `@CrossOrigin` en controladores concretos. Si se usa **Spring Security**, hay que habilitar CORS también en la cadena de seguridad (`http.cors(Customizer.withDefaults())`); de lo contrario, la petición preflight puede ser rechazada por falta de autenticación antes de llegar a la configuración de MVC.

Errores comunes: usar `allowedOrigins("*")` junto con `allowCredentials(true)` (no está permitido; hay que listar orígenes o usar `allowedOriginPatterns`) y configurar CORS en varios sitios a la vez (gateway y servicios), lo que duplica cabeceras y confunde al navegador. En microservicios, lo habitual es gestionarlo solo en el API Gateway.

## P034 · ¿Cómo se personaliza la serialización JSON con Jackson en Spring Boot?

*Tema: Serialización · Nivel 2 · Básico-Intermedio*

Spring Boot configura automáticamente un `ObjectMapper` de Jackson y lo usa en los `HttpMessageConverter`. Hay varias formas de personalizarlo, de más global a más local:

- **Propiedades**: `spring.jackson.property-naming-strategy=SNAKE_CASE`, `spring.jackson.default-property-inclusion=non_null`, `spring.jackson.serialization.write-dates-as-timestamps=false`, `spring.jackson.time-zone`.
- Un bean **`Jackson2ObjectMapperBuilderCustomizer`** (o el equivalente de Jackson 3 en Boot 4), que modifica la configuración de Boot sin reemplazarla. Es preferible a declarar un `ObjectMapper` propio desde cero, que anularía la autoconfiguración.
- **Anotaciones** en las clases: `@JsonProperty("nombre_completo")`, `@JsonIgnore`, `@JsonInclude(NON_NULL)`, `@JsonFormat(pattern = "yyyy-MM-dd")`, `@JsonCreator`, `@JsonView`.
- **Serializadores personalizados** con `JsonSerializer` / `JsonDeserializer`, registrados como `@JsonComponent`.

```java
public record ProductoDto(
    Long id,
    String nombre,
    @JsonFormat(shape = JsonFormat.Shape.STRING) BigDecimal precio,
    @JsonInclude(JsonInclude.Include.NON_EMPTY) List<String> etiquetas,
    LocalDate disponibleDesde    // se serializa como "2026-10-01"
) {}
```

Aspectos que suelen salir en entrevistas:

- **Fechas**: Boot registra el módulo de `java.time` y, por defecto, las escribe como cadenas ISO-8601. Conviene usar `Instant` u `OffsetDateTime` para instantes y `LocalDate` para fechas sin zona.
- **Números grandes y dinero**: los `BigDecimal` y los `long` pueden perder precisión en JavaScript; a veces se serializan como cadena.
- **Campos desconocidos**: Boot desactiva `FAIL_ON_UNKNOWN_PROPERTIES`, lo que hace a los clientes tolerantes a campos nuevos (compatibilidad hacia delante).
- **Seguridad**: nunca activar la tipificación polimórfica por defecto (`enableDefaultTyping`) con datos no confiables; ha sido origen de vulnerabilidades de deserialización.
- **Recursión** en relaciones bidireccionales: se resuelve con DTOs o con `@JsonManagedReference` / `@JsonBackReference`.

Nota de versiones: Spring Boot 4 adopta **Jackson 3**, cuyo paquete base cambia a `tools.jackson` y cuyo `ObjectMapper` es inmutable (se configura con `JsonMapper.builder()`), manteniendo un soporte de compatibilidad con Jackson 2.

## P035 · ¿Cómo se ejecutan tareas programadas y asíncronas en Spring Boot? ¿Qué problemas tienen en entornos con varias instancias?

*Tema: Tareas · Nivel 2 · Básico-Intermedio*

**Tareas programadas**: se activan con `@EnableScheduling` y se anotan métodos con `@Scheduled`:

```java
@Scheduled(cron = "0 0 3 * * *", zone = "Europe/Madrid")   // cada día a las 3:00
public void purgarCarritosAbandonados() { ... }

@Scheduled(fixedDelayString = "PT30S")   // 30 s después de terminar la ejecución anterior
public void sincronizarStock() { ... }
```

`fixedRate` mide desde el inicio de la ejecución anterior; `fixedDelay`, desde su final. Por defecto, Spring usa **un único hilo** para todas las tareas programadas: una tarea lenta retrasa a las demás. Se amplía con `spring.task.scheduling.pool.size`, o se aprovechan los hilos virtuales.

**Ejecución asíncrona**: con `@EnableAsync`, un método `@Async` se ejecuta en otro hilo y el llamante continúa. Puede devolver `void` o `CompletableFuture<T>`.

```java
@Async
public CompletableFuture<Informe> generarInforme(Long id) {
    return CompletableFuture.completedFuture(generador.generar(id));
}
```

Cuidados con `@Async`: es un proxy, así que sufre el problema de la auto-invocación; las excepciones en métodos `void` se pierden salvo que se configure un `AsyncUncaughtExceptionHandler`; el contexto de seguridad, el MDC y la transacción **no se propagan** al nuevo hilo por defecto (se usan `TaskDecorator` o la librería Context Propagation de Micrometer); y conviene configurar el pool (`spring.task.execution.pool.*`) para no crear hilos sin límite.

**Problema con varias instancias**: si hay tres réplicas del servicio, cada una ejecutará la tarea programada, así que se enviarán tres emails o se procesará tres veces el mismo lote. Soluciones:

- **ShedLock**: bloqueo distribuido sobre la base de datos, Redis o ZooKeeper para que solo una instancia ejecute la tarea (`@SchedulerLock(name = "purga", lockAtMostFor = "10m")`).
- Sacar la tarea del servicio: un **CronJob de Kubernetes** o un planificador externo.
- Diseñar la tarea para ser **idempotente** y repartir el trabajo con `SELECT ... FOR UPDATE SKIP LOCKED` para que varias instancias procesen lotes distintos sin pisarse.
- Para procesos batch complejos (lectura, procesamiento y escritura por lotes, reinicio desde el punto de fallo), **Spring Batch**.

> **Clave para la entrevista.** El problema de las tareas programadas duplicadas con varias réplicas y la solución con ShedLock es una pregunta práctica muy frecuente.

## P036 · ¿Cómo funciona Spring Security a alto nivel?

*Tema: Seguridad · Nivel 2 · Básico-Intermedio*

Spring Security se integra como una **cadena de filtros de servlet**. Un filtro delegado (`DelegatingFilterProxy` → `FilterChainProxy`) elige, según la URL, qué `SecurityFilterChain` aplicar; cada cadena contiene filtros especializados en orden: gestión de cabeceras de seguridad, CSRF, CORS, extracción de credenciales (formulario, HTTP Basic, token Bearer), gestión de excepciones y autorización.

Componentes principales:

- **`Authentication`**: representa al usuario autenticado (o el intento de autenticarse), con su *principal* y sus *authorities* (roles o permisos).
- **`SecurityContextHolder`**: almacena la autenticación del usuario actual, por defecto en un `ThreadLocal`, de forma que cualquier capa puede consultarla.
- **`AuthenticationManager`** y sus **`AuthenticationProvider`**: validan las credenciales (usuario y contraseña contra un `UserDetailsService`, un token JWT, LDAP...). Es una aplicación del patrón Strategy.
- **`PasswordEncoder`**: las contraseñas se guardan con hash adaptativo (**BCrypt**, Argon2, SCrypt), nunca en claro ni con MD5/SHA simples.
- **Autorización**: por URL en la cadena (`authorizeHttpRequests`) o por método con `@PreAuthorize` (activado con `@EnableMethodSecurity`).

```java
@Configuration
@EnableMethodSecurity
public class SeguridadConfig {

    @Bean
    SecurityFilterChain api(HttpSecurity http) throws Exception {
        return http
            .csrf(csrf -> csrf.disable())          // API sin estado con tokens, sin cookies
            .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(a -> a
                .requestMatchers(HttpMethod.GET, "/api/productos/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated())
            .oauth2ResourceServer(o -> o.jwt(Customizer.withDefaults()))
            .build();
    }
}
```

`401` frente a `403`: el `AuthenticationEntryPoint` responde cuando no hay autenticación válida (401) y el `AccessDeniedHandler` cuando el usuario autenticado no tiene permisos (403).

Sobre **CSRF**: es necesario cuando el navegador envía credenciales automáticamente (cookies de sesión). En APIs sin estado que reciben el token en la cabecera `Authorization`, se puede desactivar; si la API usa cookies (por ejemplo, detrás de un BFF), debe mantenerse.

Al añadir el starter sin configuración, Spring Boot protege todos los endpoints y genera un usuario `user` con una contraseña aleatoria que imprime en el log: útil para descubrirlo, nunca para producción.

# Nivel 3 · Intermedio · Persistencia, transacciones y testing

Spring Data JPA, problemas clásicos de rendimiento, @Transactional por dentro y cómo se prueba una aplicación Spring Boot de verdad.

Este capítulo contiene 19 preguntas.

## P037 · ¿Cómo funcionan los repositorios de Spring Data JPA?

*Tema: Spring Data · Nivel 3 · Intermedio*

Declaras una **interfaz** que extiende `JpaRepository<Entidad, Id>` y Spring Data genera en tiempo de ejecución una implementación (un proxy respaldado por `SimpleJpaRepository`) con CRUD, paginación y ordenación.

Formas de definir consultas:

- **Query methods derivados del nombre**: `findByEmailAndActivoTrue(String email)`, `countByCiudad(String ciudad)`, `existsByNif(String nif)`. Se validan al arrancar.
- `@Query` con **JPQL** o SQL nativo (`nativeQuery = true`), para consultas complejas. Las modificaciones requieren `@Modifying`.
- **Proyecciones**: devolver interfaces o records con solo los campos necesarios, que generan un SELECT más ligero.
- **Specifications** / Criteria API o **Querydsl** para filtros dinámicos.
- **Query by Example**.

```java
public interface PedidoRepository extends JpaRepository<Pedido, Long> {

    List<Pedido> findByClienteIdAndEstado(Long clienteId, EstadoPedido estado);

    @Query("select p from Pedido p join fetch p.lineas where p.id = :id")
    Optional<Pedido> findConLineas(@Param("id") Long id);

    @Modifying
    @Query("update Pedido p set p.estado = :estado where p.fecha < :limite")
    int cancelarAntiguos(@Param("estado") EstadoPedido estado, @Param("limite") LocalDate limite);
}
```

Ojo: los métodos del repositorio son transaccionales por defecto (`readOnly = true` en lecturas), pero las operaciones que implican varias llamadas al repositorio necesitan su propio `@Transactional` en el servicio.

### Repreguntas frecuentes

**¿Qué diferencia hay entre findById y getReferenceById?**

findById lanza la consulta y devuelve un Optional con la entidad. getReferenceById devuelve un proxy sin consultar la base de datos; solo la consulta al acceder a un atributo. Es útil para asignar relaciones sin cargar la entidad (pedido.setCliente(clientes.getReferenceById(id))), pero lanza excepción si el registro no existe al usarlo.

**¿Cómo harías una búsqueda con filtros opcionales combinables?**

Con Specifications (JpaSpecificationExecutor) componiendo solo los criterios presentes, con Querydsl o con Query by Example. Escribir un query method por cada combinación de filtros no escala.

## P038 · ¿Qué es el problema N+1 y cómo se soluciona?

*Tema: JPA · Nivel 3 · Intermedio*

Ocurre cuando se carga una lista de N entidades con una consulta y, después, al acceder a una relación de cada una, se lanza **una consulta adicional por elemento**: 1 + N consultas. Con 500 pedidos y sus clientes, 501 consultas donde bastaba una. Es la causa de rendimiento más frecuente en aplicaciones JPA.

```java
List<Pedido> pedidos = repo.findAll();          // 1 consulta
pedidos.forEach(p -> p.getCliente().getNombre()); // N consultas
```

Soluciones:

- **JOIN FETCH** en JPQL: `select p from Pedido p join fetch p.cliente`.
- **@EntityGraph** en el repositorio: `@EntityGraph(attributePaths = {"cliente", "lineas"})`.
- **Batch fetching**: `@BatchSize(size = 50)` o `hibernate.default_batch_fetch_size=50`, que agrupa las cargas perezosas en consultas `IN (...)`: de N+1 a 1 + N/50.
- **Proyecciones DTO**: consultar directamente solo los datos necesarios.

Precaución: hacer `JOIN FETCH` de **dos colecciones** a la vez provoca un producto cartesiano (o `MultipleBagFetchException` con `List`). En ese caso, conviene hacer fetch de una colección y usar batch fetching para la otra, o dividir en dos consultas. Paginar con `JOIN FETCH` de colecciones hace que Hibernate pagine en memoria (aviso `HHH90003004`).

Para detectarlo: activar el log de SQL en desarrollo, las estadísticas de Hibernate o herramientas como Hypersistence Optimizer o datasource-proxy en tests.

> **Clave para la entrevista.** Explicar la causa, dar al menos dos soluciones y mencionar el problema del producto cartesiano demuestra experiencia real.

### Repreguntas frecuentes

**¿Cómo detectarías automáticamente el N+1 en los tests?**

Contando las sentencias SQL ejecutadas en un test de integración con librerías como datasource-proxy o las estadísticas de Hibernate, y fallando si se supera el número esperado. Así una regresión se detecta en la CI.

**¿El N+1 solo ocurre con relaciones LAZY?**

No. Con relaciones EAGER en @ManyToOne, al cargar una lista con JPQL Hibernate lanza una consulta adicional por cada relación EAGER no incluida en un fetch join. EAGER no evita el problema: lo esconde.

## P039 · ¿Qué diferencia hay entre carga LAZY y EAGER? ¿Qué es LazyInitializationException y Open Session In View?

*Tema: JPA · Nivel 3 · Intermedio*

- **EAGER**: la relación se carga junto con la entidad. Por defecto en `@ManyToOne` y `@OneToOne`.
- **LAZY**: se carga al acceder a ella por primera vez, mediante un proxy. Por defecto en `@OneToMany` y `@ManyToMany`.

Recomendación general: **todo LAZY** (incluidas las `@ManyToOne`) y decidir qué cargar en cada consulta con fetch joins o entity graphs. EAGER no se puede «desactivar» por consulta y provoca cargas innecesarias o N+1 ocultos.

`LazyInitializationException` aparece cuando se accede a una relación perezosa **después de cerrar la sesión** de Hibernate (fuera de la transacción), por ejemplo al serializar la entidad en el controlador.

**Open Session In View (OSIV)** mantiene la sesión abierta durante toda la petición HTTP, incluida la serialización de la vista. Spring Boot lo activa **por defecto** (`spring.jpa.open-in-view=true`) y avisa en el log al arrancar. Evita la excepción pero es considerado un **anti-patrón**: retiene una conexión del pool durante toda la petición y oculta consultas N+1 lanzadas desde la capa web.

Lo recomendable es `spring.jpa.open-in-view=false` y resolver en la capa de servicio qué datos se necesitan, devolviendo DTOs.

### Repreguntas frecuentes

**¿Por qué Spring Boot mantiene Open Session In View activado por defecto si es un anti-patrón?**

Por compatibilidad y para que las aplicaciones sencillas funcionen sin errores de carga perezosa. Por eso muestra un aviso al arrancar: invita a desactivarlo conscientemente.

## P040 · ¿Cómo funciona @Transactional? ¿Qué tipos de propagación existen?

*Tema: Transacciones · Nivel 3 · Intermedio*

`@Transactional` se implementa con **AOP**: Spring envuelve el bean en un **proxy** que, antes de invocar el método, obtiene o crea una transacción a través del `PlatformTransactionManager` y, al terminar, hace commit o rollback. El estado de la transacción se asocia al hilo mediante `ThreadLocal` (`TransactionSynchronizationManager`).

Tipos de **propagación** (qué ocurre si ya existe una transacción):

- `REQUIRED` (por defecto): se une a la existente o crea una nueva.
- `REQUIRES_NEW`: suspende la existente y crea una **independiente** (útil para auditoría que debe persistir aunque la operación principal falle). Consume una segunda conexión.
- `SUPPORTS`: usa la existente si la hay; si no, ejecuta sin transacción.
- `MANDATORY`: exige una existente; si no, lanza excepción.
- `NOT_SUPPORTED`: suspende la existente y ejecuta sin transacción.
- `NEVER`: lanza excepción si existe una.
- `NESTED`: crea un **savepoint** dentro de la existente (rollback parcial); requiere soporte JDBC de savepoints.

Otros atributos: `readOnly` (optimizaciones: Hibernate no hace dirty checking y puede enrutar a réplicas), `timeout`, `isolation`, `rollbackFor` / `noRollbackFor`.

Trampa con `REQUIRED`: si un método interno marca la transacción como rollback-only (por una excepción capturada más arriba), el commit del externo fallará con `UnexpectedRollbackException`.

### Repreguntas frecuentes

**¿Dónde pondrías @Transactional: en el controlador, el servicio o el repositorio?**

En la capa de servicio (o de casos de uso), que define la unidad de trabajo de negocio. En el controlador alargaría la transacción innecesariamente y la acoplaría a la web; en el repositorio sería demasiado granular para operaciones que implican varios accesos.

**¿Qué hace @Transactional sobre la clase en lugar de sobre el método?**

Aplica la configuración a todos los métodos públicos. Un patrón habitual es @Transactional(readOnly = true) a nivel de clase y @Transactional en los métodos que escriben.

## P041 · ¿Cuándo hace rollback @Transactional? ¿Qué niveles de aislamiento existen?

*Tema: Transacciones · Nivel 3 · Intermedio*

**Regla de rollback por defecto**: se hace rollback ante excepciones **no comprobadas** (`RuntimeException` y `Error`), pero **no** ante excepciones comprobadas (checked). Es una herencia de EJB que sorprende a muchos: si un método lanza `IOException`, la transacción hace commit. Se cambia con `@Transactional(rollbackFor = Exception.class)`. Y si capturas la excepción dentro del método y no la relanzas, no hay rollback.

**Niveles de aislamiento** (qué anomalías de concurrencia se permiten):

- `READ_UNCOMMITTED`: permite **lecturas sucias** (ver datos no confirmados de otra transacción).
- `READ_COMMITTED`: evita lecturas sucias, pero permite **lecturas no repetibles** (leer dos veces la misma fila con resultados distintos). Por defecto en PostgreSQL, Oracle y SQL Server.
- `REPEATABLE_READ`: evita lecturas no repetibles; en teoría permite **lecturas fantasma** (aparecen filas nuevas en un rango). Por defecto en MySQL/InnoDB.
- `SERIALIZABLE`: máximo aislamiento, como si las transacciones se ejecutaran en serie; más bloqueos o fallos de serialización que requieren reintento.

`Isolation.DEFAULT` usa el de la base de datos. Además de estas anomalías, existen las **actualizaciones perdidas** (dos transacciones leen, modifican y escriben la misma fila), que se previenen con bloqueo optimista o pesimista.

> **Clave para la entrevista.** La regla de las checked exceptions es una pregunta trampa muy frecuente.

### Repreguntas frecuentes

**¿Qué nivel de aislamiento elegirías para un sistema de reservas?**

Normalmente se mantiene READ_COMMITTED y se protegen las operaciones críticas con bloqueo optimista, pesimista o actualizaciones condicionales atómicas. Subir el aislamiento global a SERIALIZABLE penaliza toda la aplicación y obliga a reintentar fallos de serialización.

## P042 · ¿Qué es el problema de la auto-invocación (self-invocation) con @Transactional?

*Tema: Transacciones · Nivel 3 · Intermedio*

Como `@Transactional` funciona mediante un proxy, solo se aplica cuando la llamada **atraviesa el proxy**, es decir, cuando viene desde otro bean. Si un método de una clase llama a otro método `@Transactional` **de la misma clase** (`this.metodo()`), la llamada no pasa por el proxy y la anotación se **ignora** silenciosamente.

```java
@Service
public class InformeService {
    public void generarTodos() {
        for (var id : ids) {
            generar(id);          // this.generar(): NO pasa por el proxy
        }
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void generar(Long id) { ... }  // la anotación no tiene efecto
}
```

Lo mismo sucede con `@Async`, `@Cacheable`, `@Retryable` o `@PreAuthorize`. Otras limitaciones del proxy: con proxies CGLIB, métodos `private` o `final` no se interceptan.

Soluciones:

- **Mover el método a otro bean** (la más limpia y habitual).
- Usar `TransactionTemplate` para gestionar la transacción programáticamente.
- Autoinyectarse el bean (`@Lazy` sobre el propio servicio) o usar `AopContext.currentProxy()`, soluciones que funcionan pero se consideran poco elegantes.
- Usar AspectJ con weaving en compilación o carga, que no depende de proxies.

> **Clave para la entrevista.** Es probablemente la pregunta más repetida sobre Spring en entrevistas de nivel medio. Dominarla con el ejemplo es obligatorio.

### Repreguntas frecuentes

**¿Cómo comprobarías en un test que un método realmente se ejecuta en una transacción?**

Consultando TransactionSynchronizationManager.isActualTransactionActive() dentro del método en un test de integración, o verificando el efecto: provocar una excepción tras una escritura y comprobar que se ha revertido.

## P043 · ¿Qué diferencia hay entre bloqueo optimista y pesimista?

*Tema: JPA · Nivel 3 · Intermedio*

Ambos previenen **actualizaciones perdidas** cuando varias transacciones modifican el mismo registro.

**Bloqueo optimista**: asume que los conflictos son raros. Se añade una columna de versión con `@Version`. Al actualizar, Hibernate ejecuta `UPDATE ... SET ..., version = 6 WHERE id = ? AND version = 5`. Si otra transacción ya la cambió, se actualizan 0 filas y se lanza `OptimisticLockException` (en Spring, `ObjectOptimisticLockingFailureException`). No bloquea nada en la base de datos, escala bien y funciona incluso entre peticiones HTTP distintas (enviando la versión al cliente, por ejemplo con ETag / `If-Match`). La aplicación decide qué hacer: reintentar o devolver un 409 Conflict.

```java
@Entity
public class Producto {
    @Id Long id;
    int stock;
    @Version Long version;
}
```

**Bloqueo pesimista**: asume que habrá conflictos y bloquea la fila en la base de datos (`SELECT ... FOR UPDATE`) hasta el fin de la transacción. En Spring Data: `@Lock(LockModeType.PESSIMISTIC_WRITE)`. Garantiza exclusión, pero reduce la concurrencia y puede provocar **deadlocks**; conviene configurar un timeout de bloqueo.

Criterio: optimista para la mayoría de los casos (baja contención); pesimista cuando la contención es alta y reintentar sale caro (por ejemplo, reservar las últimas unidades de stock de un producto muy demandado). Para contadores simples, una actualización atómica (`UPDATE ... SET stock = stock - 1 WHERE stock > 0`) suele ser la mejor opción.

### Repreguntas frecuentes

**¿Cómo expondrías el bloqueo optimista en una API REST?**

Devolviendo la versión como ETag en las respuestas GET y exigiendo la cabecera If-Match en PUT o PATCH. Si la versión no coincide, se responde 412 Precondition Failed (o 409), y el cliente sabe que debe recargar el recurso antes de modificarlo.

**¿Qué harías al recibir una OptimisticLockException en un proceso automático?**

Reintentar la operación completa (volver a leer, aplicar la lógica y guardar) un número limitado de veces, por ejemplo con @Retryable. Reintentar solo el guardado con la entidad antigua volvería a fallar.

## P044 · ¿Cómo se gestionan los cambios de esquema de base de datos? ¿Por qué no usar ddl-auto en producción?

*Tema: Persistencia · Nivel 3 · Intermedio*

`spring.jpa.hibernate.ddl-auto` (`create`, `create-drop`, `update`, `validate`, `none`) permite a Hibernate generar el esquema. En producción es peligroso: `update` no borra columnas, no migra datos, no es versionable ni reproducible y puede aplicar cambios inesperados. Lo correcto en producción es `validate` o `none`.

Se usan herramientas de **migraciones versionadas**:

- **Flyway**: scripts SQL numerados (`V1__crear_tablas.sql`, `V2__add_email.sql`) en `db/migration`. Guarda en la tabla `flyway_schema_history` qué migraciones se han aplicado y su checksum. Simple y explícito.
- **Liquibase**: changelogs en XML, YAML, JSON o SQL, con más abstracción entre bases de datos, preconditions y rollbacks declarativos.

Spring Boot ejecuta las migraciones automáticamente al arrancar si detecta la dependencia.

Buenas prácticas: nunca modificar una migración ya aplicada (el checksum fallará); migraciones pequeñas y reversibles; en despliegues sin downtime, aplicar el patrón **expand/contract** (primero añadir sin romper, desplegar código compatible y, en una versión posterior, eliminar lo antiguo); probar las migraciones en CI contra la base de datos real con Testcontainers.

### Repreguntas frecuentes

**¿Qué harías si una migración falla a mitad en producción?**

En PostgreSQL, el DDL es transaccional y Flyway revierte la migración completa. En MySQL no, y la migración puede quedar a medias: hay que reparar manualmente el esquema y la tabla de historial (flyway repair). Por eso las migraciones deben ser pequeñas y probadas contra la misma base de datos que en producción.

## P045 · ¿Qué diferencia hay entre @SpringBootTest y los test slices como @WebMvcTest o @DataJpaTest?

*Tema: Testing · Nivel 3 · Intermedio*

- `@SpringBootTest` levanta el **contexto completo** de la aplicación. Es un test de integración: fiel a la realidad, pero lento. Con `webEnvironment = RANDOM_PORT` arranca el servidor real y se puede probar con `TestRestTemplate`, `WebTestClient` o `RestTestClient` (Boot 4).
- Los **test slices** cargan solo una «rebanada» del contexto, mucho más rápidos:
  - `@WebMvcTest(ClienteController.class)`: capa web (controladores, advice, filtros, conversores Jackson, validación) con `MockMvc`; los servicios se sustituyen por mocks.
  - `@DataJpaTest`: entidades, repositorios y `EntityManager`; cada test es transaccional con rollback. Por defecto intenta usar una BD embebida.
  - `@JsonTest`, `@RestClientTest`, `@WebFluxTest`, `@DataMongoTest`...

```java
@WebMvcTest(ClienteController.class)
class ClienteControllerTest {
    @Autowired MockMvc mvc;
    @MockitoBean ClienteService service;

    @Test
    void devuelve404SiNoExiste() throws Exception {
        when(service.obtener(99L)).thenThrow(new RecursoNoEncontradoException("99"));
        mvc.perform(get("/api/v1/clientes/99"))
           .andExpect(status().isNotFound())
           .andExpect(jsonPath("$.title").value("Recurso no encontrado"));
    }
}
```

Nota de versiones: desde Spring Boot 3.4, `@MockBean` y `@SpyBean` están deprecadas en favor de `@MockitoBean` y `@MockitoSpyBean` (de Spring Framework).

Rendimiento: Spring **cachea el contexto** entre tests con la misma configuración. Cada `@MockitoBean` distinto o cada cambio de propiedades crea un contexto nuevo; conviene homogeneizar configuraciones para que la suite no se vuelva lenta.

> **Clave para la entrevista.** Hablar de la caché de contextos y de cómo la rompen los mocks distintos es un detalle muy valorado, sobre todo en perfiles de QA Automation.

### Repreguntas frecuentes

**¿Cómo probarías un endpoint protegido con Spring Security en @WebMvcTest?**

Con spring-security-test: @WithMockUser para simular un usuario con roles, o post-procesadores de MockMvc como jwt() para simular un token con scopes concretos. Así se prueban tanto los accesos permitidos como los 401 y 403.

## P046 · ¿Qué es Testcontainers y por qué es preferible a una base de datos en memoria como H2?

*Tema: Testing · Nivel 3 · Intermedio*

**Testcontainers** es una librería que levanta contenedores Docker desechables durante los tests: PostgreSQL, Kafka, Redis, RabbitMQ, LocalStack, WireMock, etc.

Problemas de H2 como sustituto: dialecto SQL distinto, tipos (JSONB, arrays), funciones, comportamiento de bloqueos y constraints diferentes. Los tests pasan con H2 y la aplicación falla en producción. Además, no permite probar migraciones Flyway escritas en SQL nativo.

Con Testcontainers se prueba contra **la misma tecnología y versión** que en producción. Spring Boot 3.1+ simplifica su uso con `@ServiceConnection`, que configura automáticamente la conexión sin `@DynamicPropertySource`:

```java
@SpringBootTest
@Testcontainers
class PedidoRepositoryIT {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired PedidoRepository repo;

    @Test
    void guardaYRecupera() { ... }
}
```

Buenas prácticas: contenedores `static` compartidos (o el patrón singleton container) para no arrancar uno por clase, reutilización en local (`testcontainers.reuse.enable=true`) y fijar las versiones de las imágenes. Boot también permite usar Testcontainers en **desarrollo local** (`SpringApplication.from(App::main).with(TestConfig.class)`) o Docker Compose (`spring-boot-docker-compose`).

### Repreguntas frecuentes

**¿Qué inconvenientes tiene Testcontainers?**

Requiere Docker en las máquinas de desarrollo y en la CI, y el primer arranque de los contenedores tarda. Se mitiga reutilizando contenedores entre clases de test y con imágenes ligeras. En CI sin Docker se puede usar Testcontainers Cloud o runners con Docker disponible.

## P047 · ¿Cómo se estructura la estrategia de testing en microservicios? ¿Qué es el contract testing?

*Tema: Testing · Nivel 3 · Intermedio*

La pirámide clásica (muchos unitarios, menos de integración, pocos end-to-end) sigue siendo válida, pero en microservicios cobran peso los **tests de integración del servicio** y los **tests de contrato**:

- **Unitarios**: lógica de dominio aislada, sin Spring. Rápidos.
- **Integración / componente**: el servicio completo con sus dependencias de infraestructura reales (Testcontainers) y las dependencias de otros servicios simuladas (WireMock).
- **Contrato**: verifican que proveedor y consumidor están de acuerdo en la API, **sin desplegar ambos a la vez**.
- **End-to-end**: pocos, sobre flujos críticos, porque son lentos, frágiles y caros de mantener.

**Contract testing**: el problema que resuelve es que el servicio A tiene mocks de B que pueden quedar desactualizados; los tests de A pasan pero en producción falla la integración.

- **Pact** (consumer-driven): el consumidor define en sus tests qué espera del proveedor y genera un contrato («pact»). Se publica en un **Pact Broker** y el proveedor lo verifica en su pipeline. Con `can-i-deploy` se decide si una versión es compatible con lo desplegado.
- **Spring Cloud Contract**: el contrato se escribe en el lado del proveedor (Groovy/YAML), que genera tests para el proveedor y **stubs** WireMock para los consumidores.

Para mensajería asíncrona también existen contratos de mensajes (Pact message pacts). Otras técnicas: tests de rendimiento (Gatling, k6), chaos engineering y smoke tests tras cada despliegue.

> **Clave para la entrevista.** Muy relevante si la posición tiene componente de QA: conocer Pact, WireMock y Testcontainers y saber cuándo usar cada uno es un fuerte diferenciador.

### Repreguntas frecuentes

**¿Qué es la pirámide de testing «en forma de panal» (honeycomb)?**

Es una propuesta para microservicios que pone el peso en los tests de integración del servicio (probar el servicio completo a través de su API con dependencias reales o simuladas), con menos tests unitarios de detalle de implementación y muy pocos tests de integración entre servicios. Refleja que en servicios pequeños la mayor parte del riesgo está en las integraciones.

**¿Quién debería escribir los tests de contrato?**

En el enfoque consumer-driven, el equipo consumidor escribe las expectativas y el proveedor las verifica en su pipeline. La clave es que el fallo aparezca en la pipeline del proveedor antes de desplegar un cambio que rompe a un consumidor.

## P048 · ¿Cómo se implementan paginación y ordenación? ¿Qué problemas tiene la paginación por offset?

*Tema: Spring Data · Nivel 3 · Intermedio*

Spring Data acepta un `Pageable` y devuelve `Page<T>` (con total de elementos, que implica una consulta `count` extra) o `Slice<T>` (solo sabe si hay página siguiente, más barato). En los controladores se resuelve directamente de la query string: `?page=0&size=20&sort=fecha,desc`.

```java
@GetMapping
public Page<PedidoDto> listar(@PageableDefault(size = 20, sort = "fecha",
        direction = Sort.Direction.DESC) Pageable pageable) {
    return repo.findAll(pageable).map(mapper::toDto);
}
```

Buenas prácticas: limitar el tamaño máximo (`spring.data.web.pageable.max-page-size`), validar los campos de ordenación permitidos y no serializar `PageImpl` directamente (Boot 3.3+ avisa; usar `PagedModel` o un DTO propio con `@EnableSpringDataWebSupport(pageSerializationMode = VIA_DTO)`).

Problema de la paginación por **offset** (`LIMIT 20 OFFSET 100000`): la base de datos tiene que recorrer y descartar todas las filas previas, así que las páginas profundas son lentas; además, si se insertan filas mientras el usuario pagina, aparecen duplicados o se saltan elementos.

Alternativa: **paginación por cursor / keyset** (`WHERE fecha < :ultimaFecha ORDER BY fecha DESC LIMIT 20`), que usa el índice y tiene coste constante. Spring Data 3.1+ la soporta con `ScrollPosition` y `Window<T>`.

### Repreguntas frecuentes

**¿Cómo evitarías que un cliente ordene por un campo que no tiene índice?**

Validando los campos de ordenación contra una lista permitida antes de construir el Pageable, y devolviendo 400 si no es válido. Además de rendimiento, evita exponer nombres internos o provocar errores por campos inexistentes.

## P049 · ¿Cuál es el ciclo de vida de una entidad JPA? ¿Qué diferencia hay entre persist y merge? ¿Qué es el dirty checking?

*Tema: JPA · Nivel 3 · Intermedio*

Una entidad pasa por cuatro estados respecto al **contexto de persistencia** (el `EntityManager`, que en Spring vive normalmente lo que dura la transacción):

- **Transient** (nueva): creada con `new`, sin relación con el contexto ni fila en la base de datos.
- **Managed** (gestionada): asociada al contexto. Hibernate vigila sus cambios.
- **Detached** (separada): tuvo relación con un contexto que ya se cerró (por ejemplo, fuera de la transacción). Sus cambios ya no se vigilan.
- **Removed** (eliminada): marcada para borrarse al hacer flush.

**persist** convierte una entidad *transient* en *managed*; la fila se inserta en el siguiente flush. **merge** copia el estado de una entidad (normalmente *detached*) sobre una instancia *managed*, cargándola de la base de datos si hace falta, y **devuelve esa instancia gestionada**; el objeto que se pasa como argumento sigue separado. Error típico: seguir modificando el objeto original después de `merge` y esperar que se guarde.

El `save()` de Spring Data decide: si la entidad es nueva (ID nulo o versión nula) llama a `persist`, y si no, a `merge`. Con IDs asignados manualmente (por ejemplo, UUID generados en el constructor), Spring Data cree que la entidad ya existe y hace `merge`, lo que provoca un `SELECT` innecesario antes del `INSERT`. Se resuelve implementando `Persistable<ID>` con un `isNew()` propio.

**Dirty checking**: al hacer flush, Hibernate compara el estado actual de cada entidad gestionada con una copia (snapshot) tomada al cargarla y genera automáticamente los `UPDATE` necesarios. Por eso, dentro de una transacción, **no hace falta llamar a `save()`** para guardar cambios en una entidad cargada:

```java
@Transactional
public void cambiarEmail(Long id, String email) {
    Cliente c = repo.findById(id).orElseThrow();
    c.cambiarEmail(email);   // al hacer commit, Hibernate genera el UPDATE
}
```

El **flush** (sincronizar el contexto con la base de datos) ocurre antes del commit, antes de ejecutar consultas JPQL que puedan verse afectadas por cambios pendientes (modo `AUTO`) o al llamar a `flush()` explícitamente. Con `@Transactional(readOnly = true)`, Hibernate evita el snapshot y el dirty checking, lo que ahorra memoria y CPU en lecturas.

> **Clave para la entrevista.** Saber que no hace falta llamar a save() dentro de una transacción, y por qué, es una señal clara de que entiendes JPA más allá de los tutoriales.

## P050 · ¿Cómo se implementan correctamente equals y hashCode en una entidad JPA?

*Tema: JPA · Nivel 3 · Intermedio*

Es un problema sutil porque la identidad de una entidad cambia a lo largo de su vida: antes de persistirse, si el ID lo genera la base de datos, vale `null`.

Opciones y sus problemas:

- **No sobrescribirlos** (identidad de objeto Java): funciona dentro de un mismo contexto de persistencia, porque Hibernate garantiza una única instancia por fila, pero falla al comparar entidades de contextos distintos (por ejemplo, una separada con otra recién cargada).
- **Usar todos los campos** (lo que hace `@Data` de Lombok): el hash cambia cada vez que cambia un atributo y recorre relaciones perezosas. Incorrecto.
- **Usar solo el ID generado**: el hash cambia al persistir (de `null` a un valor), así que una entidad añadida a un `HashSet` antes de guardarla ya no se encuentra después.

Soluciones correctas:

- **Clave natural** inmutable y única (NIF, ISBN, código de producto), si existe. Se anota con `@NaturalId` en Hibernate.
- **ID generado en la aplicación** (UUID, idealmente UUIDv7 por ordenación temporal, o TSID) asignado en el constructor: la identidad existe desde el principio y no cambia.
- **ID generado por la base de datos** con un `hashCode` constante:

```java
@Entity
public class Pedido {
    @Id @GeneratedValue
    private Long id;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Pedido other)) return false;
        return id != null && id.equals(other.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();   // constante: no cambia al persistir
    }
}
```

Un `hashCode` constante hace que todas las entidades de esa clase caigan en el mismo cubo de un `HashSet`, lo cual es ineficiente para colecciones enormes, pero las colecciones de entidades en memoria suelen ser pequeñas y la corrección es prioritaria.

Hay otro detalle: con proxies de Hibernate, `getClass()` del proxy no coincide con el de la entidad, así que en lugar de comparar clases se usa `instanceof` y se accede a los campos mediante getters, o se desenvuelve el proxy con `Hibernate.getClass()`.

## P051 · ¿Cómo se modelan las relaciones en JPA? ¿Qué son el lado propietario, cascade y orphanRemoval?

*Tema: JPA · Nivel 3 · Intermedio*

Tipos de relación: `@OneToOne`, `@ManyToOne`, `@OneToMany` y `@ManyToMany`. Pueden ser unidireccionales o bidireccionales.

En una relación bidireccional, **uno de los lados es el propietario** (*owning side*): el que tiene la clave foránea y cuyos cambios determina lo que se escribe en la base de datos. El otro lado se marca con `mappedBy` y es solo un reflejo en memoria. En `@OneToMany` / `@ManyToOne`, el propietario es siempre el lado `@ManyToOne`.

```java
@Entity
public class Pedido {
    @Id @GeneratedValue Long id;

    @OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LineaPedido> lineas = new ArrayList<>();

    public void anadirLinea(LineaPedido linea) {   // mantiene ambos lados sincronizados
        lineas.add(linea);
        linea.setPedido(this);
    }

    public void quitarLinea(LineaPedido linea) {
        lineas.remove(linea);
        linea.setPedido(null);
    }
}

@Entity
public class LineaPedido {
    @Id @GeneratedValue Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "pedido_id")
    private Pedido pedido;
}
```

Error clásico: añadir la línea solo a la lista `lineas` sin asignar `linea.setPedido(pedido)`. Como el lado propietario no cambia, la clave foránea queda a `null`. Los métodos auxiliares como `anadirLinea` evitan el problema.

**Cascade** propaga operaciones del padre a los hijos (`PERSIST`, `MERGE`, `REMOVE`, `ALL`...). Tiene sentido en relaciones de **composición**, donde el hijo no existe sin el padre (líneas de un pedido: dentro del mismo agregado en términos DDD). No debe usarse `CascadeType.REMOVE` en relaciones `@ManyToOne` ni en `@ManyToMany`: borrar un pedido no debe borrar al cliente.

**orphanRemoval = true** borra el hijo cuando se quita de la colección del padre, sin necesidad de llamar a `delete`.

Otras recomendaciones: preferir `Set` o `List` según la semántica y el problema de fetch múltiple; evitar `@ManyToMany` cuando la relación tiene atributos propios (se modela una entidad intermedia explícita); y en `@OneToMany` unidireccional sin `@JoinColumn`, Hibernate crea una tabla intermedia innecesaria.

## P052 · ¿Cuándo usarías JDBC (JdbcClient) o jOOQ en lugar de JPA?

*Tema: Persistencia · Nivel 3 · Intermedio*

JPA/Hibernate es excelente cuando se trabaja con un **modelo de dominio rico** y operaciones centradas en agregados: cargar una entidad, modificarla aplicando reglas de negocio y guardar. Aporta dirty checking, caché de primer nivel, gestión de relaciones y bloqueo optimista.

Sus costes: una curva de aprendizaje considerable (estados, lazy loading, N+1, flush), consultas generadas que no siempre son las óptimas y poca comodidad para SQL avanzado (funciones de ventana, CTE, `UPSERT`, operaciones masivas).

Alternativas en el ecosistema Spring:

- **JdbcClient** (Spring 6.1+): API fluida sobre `JdbcTemplate`. SQL explícito, sin magia, ideal para consultas de lectura, informes y operaciones masivas.

```java
List<VentaMensual> ventas = jdbcClient.sql("""
        SELECT date_trunc('month', fecha) AS mes, sum(total) AS importe
        FROM pedido
        WHERE fecha >= :desde
        GROUP BY 1 ORDER BY 1
        """)
    .param("desde", desde)
    .query(VentaMensual.class)
    .list();
```

- **Spring Data JDBC**: repositorios al estilo Spring Data pero sin contexto de persistencia, sin lazy loading y sin dirty checking. Cada `save` escribe explícitamente. Encaja muy bien con agregados DDD pequeños y un modelo más predecible.
- **jOOQ**: genera clases a partir del esquema y permite escribir SQL **tipado** en Java, con errores detectados en compilación. Muy potente para consultas complejas.
- **MyBatis**: mapeo de SQL escrito a mano en XML o anotaciones; común en proyectos heredados.

Es perfectamente válido **combinar** enfoques en el mismo servicio: JPA para el lado de escritura (comandos sobre agregados) y JdbcClient o jOOQ para el lado de lectura (consultas e informes), una aplicación natural de CQRS a pequeña escala.

## P053 · ¿Cómo se escriben tests unitarios con JUnit 5 y Mockito? ¿Qué diferencia hay entre mock, spy y stub?

*Tema: Testing · Nivel 3 · Intermedio*

Un test unitario prueba una clase aislada de sus dependencias, que se sustituyen por **dobles de prueba**. Con inyección por constructor no hace falta Spring: basta con crear el objeto.

- **Stub**: doble que devuelve respuestas predefinidas (`when(...).thenReturn(...)`). Se usa para controlar las entradas indirectas.
- **Mock**: doble sobre el que además se **verifican interacciones** (`verify(...)`). Se usa para comprobar las salidas indirectas (que se envió una notificación, por ejemplo). En Mockito, el mismo objeto `mock()` sirve para ambas cosas.
- **Spy**: envuelve un objeto **real**; por defecto llama a los métodos reales, salvo los que se redefinen. Útil con código heredado; si se necesita a menudo, suele indicar un problema de diseño.
- **Fake**: implementación funcional simplificada (un repositorio en memoria).

```java
@ExtendWith(MockitoExtension.class)
class PedidoServiceTest {

    @Mock PedidoRepository repo;
    @Mock Notificador notificador;
    @InjectMocks PedidoService service;

    @Captor ArgumentCaptor<Pedido> pedidoCaptor;

    @Test
    void confirmarPedidoPendienteLoGuardaYNotifica() {
        Pedido pedido = Pedido.pendiente(1L, List.of(linea("PROD-1", 2)));
        when(repo.findById(1L)).thenReturn(Optional.of(pedido));

        service.confirmar(1L);

        verify(repo).save(pedidoCaptor.capture());
        assertThat(pedidoCaptor.getValue().getEstado()).isEqualTo(EstadoPedido.CONFIRMADO);
        verify(notificador).pedidoConfirmado(1L);
    }

    @Test
    void confirmarPedidoInexistenteLanzaExcepcion() {
        when(repo.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.confirmar(99L))
            .isInstanceOf(RecursoNoEncontradoException.class);
        verifyNoInteractions(notificador);
    }
}
```

Buenas prácticas:

- Estructura **Arrange / Act / Assert** (o *Given / When / Then*) y nombres de test que describan el comportamiento.
- Aserciones expresivas con **AssertJ**.
- **No mockear lo que no es tuyo** (por ejemplo, `RestClient` o `EntityManager`): se envuelve en un adaptador propio y se mockea el adaptador, o se prueba con un test de integración.
- No mockear value objects ni entidades de dominio: se usan instancias reales.
- Evitar verificar cada interacción; verificar solo lo relevante para el comportamiento. El exceso de `verify` produce tests frágiles que se rompen con cualquier refactorización.
- Mockito en modo estricto (por defecto con la extensión) falla si hay stubs no utilizados, lo que ayuda a mantener los tests limpios.
- Tests parametrizados con `@ParameterizedTest` y `@CsvSource` o `@MethodSource` para cubrir muchos casos sin duplicar código.

> **Clave para la entrevista.** En perfiles con componente QA, explicar la diferencia entre verificar estado y verificar comportamiento, y el peligro de los tests acoplados a la implementación, suma muchos puntos.

## P054 · ¿Cómo se prueban los clientes HTTP que llaman a otros servicios? ¿Qué es WireMock?

*Tema: Testing · Nivel 3 · Intermedio*

Probar un cliente HTTP contra el servicio real es lento, frágil y no permite simular errores. Mockear el `RestClient` con Mockito no verifica nada útil: ni la URL, ni la serialización, ni el manejo de códigos de error.

**WireMock** levanta un **servidor HTTP falso** configurable: se definen respuestas para peticiones concretas y después se verifica qué peticiones se recibieron. Permite simular retardos, errores 500, respuestas malformadas o conexiones cortadas, ideal para probar timeouts, reintentos y circuit breakers.

```java
@SpringBootTest
@EnableWireMock(@ConfigureWireMock(name = "clientes", baseUrlProperties = "clientes.url"))
class ClientesClientIT {

    @InjectWireMock("clientes") WireMockServer wiremock;
    @Autowired ClientesClient client;

    @Test
    void obtieneClienteExistente() {
        wiremock.stubFor(get("/api/clientes/42")
            .willReturn(okJson("""
                {"id": 42, "nombre": "Ana", "email": "ana@ejemplo.com"}
                """)));

        ClienteDto cliente = client.obtener(42L);

        assertThat(cliente.nombre()).isEqualTo("Ana");
        wiremock.verify(getRequestedFor(urlEqualTo("/api/clientes/42"))
            .withHeader("Accept", containing("application/json")));
    }

    @Test
    void propagaTimeoutComoExcepcionControlada() {
        wiremock.stubFor(get(anyUrl()).willReturn(ok().withFixedDelay(5_000)));

        assertThatThrownBy(() -> client.obtener(1L))
            .isInstanceOf(ServicioNoDisponibleException.class);
    }
}
```

(El ejemplo usa la integración Spring de WireMock; también se puede arrancar con `WireMockExtension` de JUnit o como contenedor con Testcontainers).

Alternativas: `@RestClientTest` con `MockRestServiceServer` (sin red real, intercepta el cliente de Spring, rápido pero menos realista), y **MockServer**. Los stubs de WireMock pueden generarse a partir de contratos (Spring Cloud Contract) para asegurar que coinciden con el proveedor real.

WireMock también es muy útil fuera de los tests automatizados: para desarrollo local sin depender de otros equipos y en entornos de pruebas de rendimiento, simulando proveedores externos.

## P055 · ¿Cómo se prueba código asíncrono o basado en mensajes, por ejemplo un consumidor de Kafka?

*Tema: Testing · Nivel 3 · Intermedio*

El reto es que el resultado no está disponible justo después de la acción: el mensaje se procesa en otro hilo al cabo de unos milisegundos. Usar `Thread.sleep()` produce tests lentos (si se espera demasiado) o inestables (si se espera poco).

La solución estándar es **Awaitility**: reintenta una aserción hasta que se cumple o se agota un tiempo máximo.

```java
@SpringBootTest
@Testcontainers
class PagoRecibidoListenerIT {

    @Container @ServiceConnection
    static KafkaContainer kafka = new KafkaContainer("apache/kafka-native:3.8.0");

    @Container @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired KafkaTemplate<String, Object> kafkaTemplate;
    @Autowired PedidoRepository pedidos;

    @Test
    void marcaElPedidoComoPagadoAlRecibirElEvento() {
        Long id = pedidos.save(Pedido.pendiente(...)).getId();

        kafkaTemplate.send("pagos", id.toString(), new PagoRecibido(UUID.randomUUID(), id));

        await().atMost(Duration.ofSeconds(10))
               .untilAsserted(() -> assertThat(pedidos.findById(id))
                   .get().extracting(Pedido::getEstado).isEqualTo(EstadoPedido.PAGADO));
    }

    @Test
    void ignoraEventosDuplicados() {
        // enviar el mismo eventId dos veces y comprobar que el efecto se aplica una sola vez
    }
}
```

Opciones para el broker en tests:

- **Testcontainers** con la imagen real de Kafka (la opción más fiel).
- `@EmbeddedKafka` de spring-kafka-test: broker en memoria dentro de la JVM, rápido de arrancar, sin Docker.

Qué merece la pena probar en un consumidor: el procesamiento correcto (camino feliz), la **idempotencia** (mensajes duplicados), mensajes malformados (no deben bloquear la partición: deben ir a la DLT), fallos transitorios (reintentos) y, en el productor, que el evento se publica con la clave y el formato correctos. La lógica de negocio del listener conviene extraerla a un servicio y probarla con tests unitarios; el test de integración se centra en la configuración y el cableado.

# Nivel 4 · Intermedio · Patrones de diseño aplicados a Java y Spring

Patrones GoF, SOLID, arquitectura hexagonal y DDD, siempre conectados con cómo los usa Spring internamente.

Este capítulo contiene 18 preguntas.

## P056 · ¿Qué son los patrones de diseño y cómo se clasifican?

*Tema: Patrones · Nivel 4 · Intermedio*

Un patrón de diseño es una **solución reutilizable y probada a un problema recurrente** de diseño de software, descrita a un nivel que permite adaptarla a cada contexto. No es código para copiar, sino un vocabulario común entre desarrolladores.

El catálogo clásico es el del libro *Design Patterns* (1994) de la «Gang of Four» (GoF), con 23 patrones en tres categorías:

- **Creacionales**: cómo se crean los objetos. Singleton, Factory Method, Abstract Factory, Builder, Prototype.
- **Estructurales**: cómo se componen clases y objetos. Adapter, Decorator, Proxy, Facade, Composite, Bridge, Flyweight.
- **De comportamiento**: cómo se reparten responsabilidades y se comunican los objetos. Strategy, Observer, Template Method, Chain of Responsibility, Command, State, Iterator, Mediator, Memento, Visitor, Interpreter.

Además existen patrones **arquitectónicos** (MVC, capas, hexagonal, CQRS, microservicios) y patrones **empresariales y de integración** (Repository, Unit of Work, patrones EIP de mensajería).

Idea clave para la entrevista: los patrones tienen **coste** (más indirección y clases). Se aplican cuando resuelven un problema real, no por anticipado.

> **Clave para la entrevista.** Si puedes, conecta cada patrón con un ejemplo de Spring: demuestra que los reconoces en código real y no solo en teoría.

## P057 · Explica los principios SOLID con ejemplos en Spring.

*Tema: Principios · Nivel 4 · Intermedio*

- **S · Single Responsibility**: una clase debe tener un único motivo para cambiar. Un `PedidoService` que valida, calcula precios, persiste, envía emails y genera PDFs viola SRP; se divide en colaboradores (`CalculadoraPrecios`, `Notificador`...).
- **O · Open/Closed**: abierto a extensión, cerrado a modificación. Añadir un nuevo método de pago debería consistir en crear una nueva clase `PasarelaPago`, no en añadir otro `else if` a un método existente (patrón Strategy).
- **L · Liskov Substitution**: una subclase debe poder sustituir a su clase base sin romper el comportamiento esperado. Ejemplo de violación: una implementación de un repositorio que lanza `UnsupportedOperationException` en `save`.
- **I · Interface Segregation**: mejor varias interfaces específicas que una genérica enorme. Los clientes no deben depender de métodos que no usan. Spring Data lo aplica: `Repository`, `CrudRepository`, `PagingAndSortingRepository`, `ListCrudRepository`.
- **D · Dependency Inversion**: los módulos de alto nivel no dependen de los de bajo nivel; ambos dependen de abstracciones. El servicio depende de la interfaz `PasarelaPago`, no de `StripeClient`. La inyección de dependencias de Spring es la herramienta que lo hace práctico.

No confundir **Dependency Inversion** (principio de diseño) con **Dependency Injection** (técnica) ni con **IoC** (principio más general).

### Repreguntas frecuentes

**¿Qué principio SOLID consideras más importante en el día a día?**

Muchos desarrolladores responden Single Responsibility, porque la mayoría de problemas de mantenimiento vienen de clases que hacen demasiadas cosas. Lo importante es justificar la respuesta con un ejemplo real de tu experiencia.

## P058 · ¿Qué diferencia hay entre el patrón Singleton y el scope singleton de Spring?

*Tema: Creacionales · Nivel 4 · Intermedio*

El **patrón Singleton** (GoF) garantiza una única instancia **por classloader**, normalmente con constructor privado y un método estático `getInstance()`. Problemas: estado global, acoplamiento oculto (las clases llaman a `getInstance()` en lugar de recibir la dependencia), difícil de mockear en tests y fácil de implementar mal en entornos concurrentes.

```java
public enum ConfiguracionGlobal {   // forma más segura en Java (Effective Java)
    INSTANCE;
    public String valor() { ... }
}
```

El **scope singleton de Spring** garantiza una única instancia **por contenedor** (`ApplicationContext`), no por JVM. La clase es un POJO normal con constructor público: se podrían crear más instancias con `new` (por ejemplo, en un test), y la unicidad la gestiona el contenedor. Se inyecta como dependencia, así que no hay acoplamiento oculto.

Implicación de concurrencia común a ambos: la instancia se comparte entre todos los hilos (cada petición HTTP se atiende en un hilo), así que **no debe guardar estado mutable** en atributos. Estado por petición va en variables locales, parámetros o beans de scope `request`.

## P059 · Explica Factory Method, Abstract Factory y cómo aparecen en Spring.

*Tema: Creacionales · Nivel 4 · Intermedio*

- **Simple Factory** (no es GoF, pero muy común): un método que decide qué implementación crear según un parámetro.
- **Factory Method**: una clase define un método para crear objetos y las subclases deciden qué clase concreta instanciar. Desacopla al cliente de las clases concretas.
- **Abstract Factory**: una interfaz para crear **familias de objetos relacionados** sin especificar sus clases concretas (por ejemplo, una fábrica de componentes de UI para tema claro y otra para tema oscuro).

En Spring aparecen por todas partes:

- El propio contenedor es una gran fábrica: `BeanFactory`.
- Los métodos `@Bean` son factory methods.
- `FactoryBean<T>`: un bean cuyo propósito es fabricar otro objeto. Spring Data lo usa para crear las implementaciones de los repositorios (`JpaRepositoryFactoryBean`), y en versiones antiguas era la forma de crear el `SessionFactory` de Hibernate.
- Clases estáticas de fábrica: `ResponseEntity.ok()`, `ProblemDetail.forStatus()`, `List.of()` en el JDK.

En Spring, muchas veces una factoría clásica con `switch` se sustituye por la inyección de un `Map<String, Implementacion>`, que elimina el acoplamiento del `switch` a todas las implementaciones (ver Strategy).

## P060 · ¿Qué es el patrón Builder y cuándo usarlo?

*Tema: Creacionales · Nivel 4 · Intermedio*

Builder separa la **construcción** de un objeto complejo de su representación. Es útil cuando un objeto tiene muchos parámetros, varios opcionales, y se quiere evitar el antipatrón del **constructor telescópico** (múltiples constructores con distintas combinaciones de parámetros) o un JavaBean mutable a medio construir.

```java
Pedido pedido = Pedido.builder()
    .cliente(cliente)
    .direccionEnvio(direccion)
    .linea(producto1, 2)
    .linea(producto2, 1)
    .cupon("VERANO10")
    .build();   // aquí se validan invariantes
```

Ventajas: legibilidad (parámetros nombrados), inmutabilidad del objeto resultante y un único punto (`build()`) para validar invariantes.

En el ecosistema: `@Builder` de Lombok, `ResponseEntity.status(...).header(...).body(...)`, `UriComponentsBuilder`, `WebClient.builder()`, `RestClient.builder()`, `MockMvcRequestBuilders`, `JsonMapper.builder()`, `HttpRequest.newBuilder()` del JDK. Spring Boot también expone **builders preconfigurados** como beans (`RestClient.Builder`, `WebClient.Builder`) que ya incluyen la configuración de Jackson, trazas y métricas; conviene inyectarlos en lugar de crear clientes desde cero.

Cuidado con `@Builder` de Lombok sobre entidades JPA: JPA necesita un constructor sin argumentos y se pierden fácilmente las validaciones.

## P061 · ¿Qué es el patrón Strategy y cómo se implementa de forma elegante con Spring?

*Tema: Comportamiento · Nivel 4 · Intermedio*

Strategy define una **familia de algoritmos intercambiables**, encapsula cada uno en una clase y permite elegirlos en tiempo de ejecución. Elimina los grandes `if/else` o `switch` y cumple Open/Closed: añadir un algoritmo es añadir una clase.

Con Spring, cada estrategia es un bean y se inyectan todas en un mapa o una lista:

```java
public interface CalculadoraEnvio {
    TipoEnvio tipo();
    BigDecimal calcular(Pedido pedido);
}

@Component class EnvioEstandar implements CalculadoraEnvio { ... }
@Component class EnvioExpress  implements CalculadoraEnvio { ... }
@Component class EnvioRecogida implements CalculadoraEnvio { ... }

@Service
public class EnvioService {
    private final Map<TipoEnvio, CalculadoraEnvio> estrategias;

    public EnvioService(List<CalculadoraEnvio> calculadoras) {
        this.estrategias = calculadoras.stream()
            .collect(Collectors.toMap(CalculadoraEnvio::tipo, Function.identity()));
    }

    public BigDecimal coste(Pedido p) {
        return Optional.ofNullable(estrategias.get(p.getTipoEnvio()))
            .orElseThrow(() -> new IllegalArgumentException("Tipo no soportado"))
            .calcular(p);
    }
}
```

Añadir un tipo nuevo solo requiere crear otro `@Component`; `EnvioService` no cambia. Ejemplos en Spring: `PlatformTransactionManager` (JPA, JDBC, JTA...), `HttpMessageConverter`, `AuthenticationProvider`, `ResourceLoader`, `PasswordEncoder`.

Relación con **State**: estructuralmente es similar, pero en State la implementación cambia según el estado interno del objeto y las propias estrategias provocan transiciones.

> **Clave para la entrevista.** Este ejemplo de List/Map de estrategias es uno de los más útiles para demostrar soltura con Spring en una entrevista práctica o de live coding.

### Repreguntas frecuentes

**¿Cómo validarías al arrancar que existe una estrategia para cada valor del enum?**

En el constructor del servicio, comparando las claves del mapa con los valores del enum y lanzando una excepción si falta alguna. Así el error aparece al arrancar, no cuando llega el primer pedido con ese tipo.

## P062 · ¿Qué es el patrón Template Method? ¿Dónde lo usa Spring?

*Tema: Comportamiento · Nivel 4 · Intermedio*

Template Method define el **esqueleto de un algoritmo** en un método de la clase base y delega algunos pasos a las subclases (o, en la variante moderna, a callbacks). Garantiza que la secuencia se respeta mientras se personalizan los pasos variables.

Spring lo usa de forma muy característica en sus clases `*Template`, con callbacks en lugar de herencia:

- `JdbcTemplate`: se encarga de obtener la conexión, crear el statement, ejecutar, iterar el ResultSet, traducir excepciones y cerrar recursos. Tú solo aportas el SQL y un `RowMapper`.
- `TransactionTemplate`, `RestTemplate`, `JmsTemplate`, `KafkaTemplate`, `RedisTemplate`, `RetryTemplate`.

```java
List<Cliente> clientes = jdbcTemplate.query(
    "select id, nombre from cliente where ciudad = ?",
    (rs, fila) -> new Cliente(rs.getLong("id"), rs.getString("nombre")),
    ciudad);
```

También aparece con herencia clásica en clases abstractas como `OncePerRequestFilter` (tú implementas `doFilterInternal`) o `AbstractRoutingDataSource`.

Ventaja: elimina el código repetitivo propenso a errores (fugas de conexiones por no cerrar recursos). Desventaja de la versión con herencia: acoplamiento fuerte con la clase base; por eso Spring prefiere la composición con callbacks.

## P063 · ¿Qué es el patrón Proxy y cómo lo usa Spring? ¿Qué diferencia hay entre proxies JDK y CGLIB?

*Tema: Estructurales · Nivel 4 · Intermedio*

Proxy proporciona un **sustituto** de otro objeto que controla el acceso a él, añadiendo comportamiento antes o después de delegar: control de acceso, carga perezosa, caché, logging, transacciones.

Es la base de **Spring AOP**: `@Transactional`, `@Cacheable`, `@Async`, `@PreAuthorize`, `@Retryable`, los repositorios de Spring Data, los clientes Feign o las entidades lazy de Hibernate son proxies.

Dos mecanismos de creación:

- **Proxy dinámico de JDK** (`java.lang.reflect.Proxy`): solo puede implementar **interfaces**. El proxy implementa las mismas interfaces que el bean; si inyectas por la clase concreta, falla.
- **CGLIB** (en realidad un fork incluido en Spring): genera en tiempo de ejecución una **subclase** del bean. Funciona sin interfaces, pero no puede interceptar métodos `final` ni `private`, y la clase no puede ser `final`.

**Spring Boot usa CGLIB por defecto** (`spring.aop.proxy-target-class=true`) para evitar sorpresas al inyectar clases concretas.

Diferencia con Decorator: estructuralmente son casi idénticos; la diferencia es la intención. Decorator **añade responsabilidades** funcionales y suele componerse en cadenas explícitas por el cliente; Proxy **controla el acceso** y normalmente es transparente para el cliente.

> **Clave para la entrevista.** Conecta esta respuesta con la auto-invocación: el proxy explica por qué this.metodo() no aplica @Transactional.

### Repreguntas frecuentes

**¿Cómo sabes si un bean inyectado es un proxy?**

Con AopUtils.isAopProxy(bean), o inspeccionando la clase en el depurador (nombres como $$SpringCGLIB$$ o $Proxy). Es útil para diagnosticar por qué una anotación no tiene efecto.

## P064 · ¿Qué es el patrón Observer y cómo se implementa con eventos de Spring?

*Tema: Comportamiento · Nivel 4 · Intermedio*

Observer define una relación uno-a-muchos: cuando un objeto (sujeto) cambia de estado, notifica a sus observadores sin conocerlos. Reduce el acoplamiento entre quien produce un hecho y quienes reaccionan.

Spring lo ofrece con su sistema de eventos:

```java
public record PedidoConfirmado(Long pedidoId, Long clienteId) {}

@Service
public class PedidoService {
    private final ApplicationEventPublisher eventos;

    @Transactional
    public void confirmar(Long id) {
        // ... lógica
        eventos.publishEvent(new PedidoConfirmado(id, clienteId));
    }
}

@Component
class NotificacionListener {
    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    @Async
    void enviarEmail(PedidoConfirmado evento) { ... }
}
```

Puntos clave:

- `@EventListener` es **síncrono** por defecto y se ejecuta en el mismo hilo y la misma transacción. Una excepción en el listener afecta al publicador.
- `@TransactionalEventListener` espera a una fase de la transacción (por defecto `AFTER_COMMIT`): así no se envía un email de un pedido cuya transacción acaba haciendo rollback.
- `@Async` lo hace asíncrono (requiere `@EnableAsync`).
- Estos eventos viven **en memoria**: si la aplicación cae tras el commit y antes de procesar el evento, se pierde. Para garantías entre servicios se necesita un broker y el patrón Outbox. Spring Modulith ofrece un **registro de publicación de eventos** persistente para mitigar este problema dentro de un monolito modular.

### Repreguntas frecuentes

**¿Eventos de Spring o llamada directa entre servicios?**

La llamada directa es más explícita y fácil de seguir cuando el llamante necesita el resultado o la operación es parte de la misma unidad de trabajo. Los eventos son preferibles para efectos secundarios que el emisor no debería conocer (notificaciones, auditoría, estadísticas) y para desacoplar módulos.

## P065 · Explica Adapter, Decorator, Facade y Chain of Responsibility con ejemplos del ecosistema Spring.

*Tema: Estructurales · Nivel 4 · Intermedio*

- **Adapter**: convierte la interfaz de una clase en otra que el cliente espera. Ejemplos: `HandlerAdapter` en Spring MVC (permite que el `DispatcherServlet` invoque distintos tipos de handlers de forma uniforme); los adaptadores de la arquitectura hexagonal que traducen entre tu dominio y una API externa.
- **Decorator**: añade responsabilidades a un objeto dinámicamente envolviéndolo con la misma interfaz. Ejemplos: `BufferedInputStream` en Java IO; `TransactionAwareDataSourceProxy`; `ContentCachingRequestWrapper`; envolver un cliente HTTP con uno que añade reintentos y otro que añade métricas.
- **Facade**: interfaz simplificada sobre un subsistema complejo. Ejemplos: `JdbcTemplate` frente a JDBC puro; un servicio de aplicación que orquesta varios servicios de dominio; un API Gateway es una fachada a nivel de arquitectura.
- **Chain of Responsibility**: la petición recorre una cadena de manejadores; cada uno la procesa y/o la pasa al siguiente. Ejemplos: la **cadena de filtros de Spring Security** (`SecurityFilterChain` con filtros de CORS, CSRF, autenticación, autorización...); los `Filter` de servlets; los `HandlerInterceptor`; los filtros de Spring Cloud Gateway.

```java
@Bean
SecurityFilterChain seguridad(HttpSecurity http) throws Exception {
    return http
        .authorizeHttpRequests(a -> a.requestMatchers("/actuator/health").permitAll()
                                     .anyRequest().authenticated())
        .oauth2ResourceServer(o -> o.jwt(Customizer.withDefaults()))
        .build();
}
```

## P066 · ¿Qué es la arquitectura hexagonal (puertos y adaptadores)? ¿En qué se diferencia de la arquitectura en capas?

*Tema: Arquitectura · Nivel 4 · Intermedio*

En la **arquitectura en capas** clásica (controlador → servicio → repositorio) la lógica de negocio suele depender de la infraestructura: las entidades son entidades JPA y los servicios conocen detalles de persistencia. Cambiar la tecnología o probar el dominio aislado resulta costoso.

La **arquitectura hexagonal** (Alistair Cockburn) sitúa el **dominio en el centro**, sin dependencias de frameworks. Se comunica con el exterior a través de:

- **Puertos**: interfaces definidas por el dominio. Los de **entrada** (driving) representan casos de uso (`ConfirmarPedidoUseCase`); los de **salida** (driven) representan lo que el dominio necesita (`PedidoRepositoryPort`, `PasarelaPagoPort`).
- **Adaptadores**: implementaciones en la periferia. De entrada: controlador REST, consumidor Kafka, job programado. De salida: repositorio JPA, cliente HTTP, productor de mensajes.

La regla fundamental es que **las dependencias apuntan hacia dentro** (inversión de dependencias): la infraestructura depende del dominio, nunca al revés.

Estructura típica de paquetes: `domain` (modelo y puertos), `application` (casos de uso), `infrastructure` o `adapters` (`in/web`, `in/messaging`, `out/persistence`, `out/rest`).

Ventajas: dominio testeable sin Spring ni base de datos, tecnologías intercambiables y lógica protegida. Coste: más clases e interfaces y mapeos entre modelos (dominio, JPA, DTO). Arquitecturas afines: **Onion** y **Clean Architecture**. Se puede hacer cumplir la regla de dependencias con **ArchUnit** o Spring Modulith.

> **Clave para la entrevista.** Sé honesto con el coste: para un CRUD simple es sobreingeniería. Esa madurez es lo que busca un entrevistador senior.

### Repreguntas frecuentes

**¿Las entidades de dominio pueden llevar anotaciones JPA?**

En la versión estricta, no: el dominio no depende de ningún framework y se mapea a entidades JPA separadas en el adaptador. Muchos equipos aceptan anotaciones JPA en el dominio como compromiso pragmático para evitar la duplicación. Lo importante es que sea una decisión consciente.

## P067 · ¿Cuáles son los conceptos principales de Domain-Driven Design?

*Tema: DDD · Nivel 4 · Intermedio*

DDD (Eric Evans) propone modelar el software alrededor del **dominio de negocio**, en estrecha colaboración con los expertos.

**Diseño estratégico**:

- **Lenguaje ubicuo**: el mismo vocabulario en conversaciones, código y documentación.
- **Bounded Context**: frontera explícita dentro de la cual un modelo tiene un significado consistente. «Cliente» significa cosas distintas en Ventas, Facturación y Soporte; cada contexto tiene su modelo. Es la **mejor guía para delimitar microservicios**.
- **Context Map**: relaciones entre contextos (Customer/Supplier, Conformist, Anti-Corruption Layer, Shared Kernel, Open Host Service, Published Language).

**Diseño táctico**:

- **Entidad**: objeto con identidad que persiste a lo largo del tiempo (Pedido #123).
- **Value Object**: definido por sus atributos, sin identidad, inmutable (`Dinero`, `Direccion`, `Email`). Los records de Java encajan muy bien.
- **Agregado**: grupo de entidades y value objects tratado como una unidad de consistencia, con una **raíz** como único punto de acceso. Reglas: las invariantes se cumplen dentro del agregado en cada transacción; otros agregados se referencian **por identificador**; una transacción modifica **un solo agregado**.
- **Repositorio**: uno por agregado, no por tabla.
- **Domain Service**: lógica que no pertenece a ninguna entidad.
- **Domain Event**: algo relevante que ha ocurrido (`PedidoConfirmado`), base para la comunicación entre agregados y contextos.

Un modelo **anémico** (entidades con solo getters/setters y toda la lógica en servicios) es lo contrario del modelo rico que propone DDD.

### Repreguntas frecuentes

**¿Qué tamaño debe tener un agregado?**

El mínimo necesario para proteger sus invariantes en una transacción. Agregados grandes provocan contención y conflictos de concurrencia; es preferible referenciar otros agregados por identificador y coordinar con eventos cuando la consistencia inmediata no es imprescindible.

**¿Qué es Event Storming?**

Un taller colaborativo en el que expertos de negocio y técnicos modelan un dominio colocando eventos de dominio en una línea temporal, junto con comandos, actores, políticas y agregados. Es muy eficaz para descubrir bounded contexts y el lenguaje ubicuo.

## P068 · ¿Qué es el patrón State? Pon un ejemplo con el ciclo de vida de un pedido.

*Tema: Comportamiento · Nivel 4 · Intermedio*

El patrón **State** permite que un objeto cambie su comportamiento cuando cambia su estado interno, como si cambiara de clase. Cada estado se encapsula en su propia clase, que decide qué operaciones están permitidas y a qué estado se transita.

Sin el patrón, la lógica se llena de condicionales repetidos: `if (estado == PENDIENTE) ... else if (estado == PAGADO) ...` en cada método. Añadir un estado obliga a revisar todos esos métodos.

Una implementación moderna en Java puede combinar un `enum` con comportamiento o una **jerarquía sellada**:

```java
public enum EstadoPedido {
    PENDIENTE {
        @Override EstadoPedido pagar()    { return PAGADO; }
        @Override EstadoPedido cancelar() { return CANCELADO; }
    },
    PAGADO {
        @Override EstadoPedido enviar()   { return ENVIADO; }
        @Override EstadoPedido cancelar() { return REEMBOLSO_PENDIENTE; }
    },
    ENVIADO {
        @Override EstadoPedido entregar() { return ENTREGADO; }
    },
    ENTREGADO, CANCELADO, REEMBOLSO_PENDIENTE;

    EstadoPedido pagar()    { throw transicionInvalida("pagar"); }
    EstadoPedido enviar()   { throw transicionInvalida("enviar"); }
    EstadoPedido entregar() { throw transicionInvalida("entregar"); }
    EstadoPedido cancelar() { throw transicionInvalida("cancelar"); }

    private IllegalStateException transicionInvalida(String accion) {
        return new IllegalStateException("No se puede " + accion + " un pedido " + this);
    }
}

@Entity
public class Pedido {
    @Enumerated(EnumType.STRING)
    private EstadoPedido estado = EstadoPedido.PENDIENTE;

    public void pagar() { estado = estado.pagar(); }
    public void cancelar() { estado = estado.cancelar(); }
}
```

Las reglas de transición quedan en un único lugar, son fáciles de probar (un test por transición válida e inválida) y la entidad protege sus invariantes. Esto también ayuda a la idempotencia de los consumidores de mensajes: una transición repetida se detecta y se ignora.

Para flujos más complejos (con guardas, acciones asociadas, eventos, estados jerárquicos o persistencia del estado de la máquina), existe **Spring Statemachine**, aunque para la mayoría de casos una implementación propia como la anterior es más sencilla y legible. Si el flujo es de larga duración y coordina varios servicios, lo adecuado es un orquestador de sagas o un motor de workflows.

Relación con Strategy: estructuralmente parecidos, pero en State las transiciones son parte del propio patrón y el objeto cambia de estado por sí mismo; en Strategy el cliente elige la estrategia y esta no cambia sola.

## P069 · ¿Qué es el patrón Command? ¿Dónde aparece en aplicaciones Spring?

*Tema: Comportamiento · Nivel 4 · Intermedio*

El patrón **Command** encapsula una petición como un objeto, con todos los datos necesarios para ejecutarla. Esto permite parametrizar, encolar, registrar, reintentar o deshacer operaciones, y desacopla a quien la solicita de quien la ejecuta.

Elementos clásicos: el **comando** (qué hacer y con qué datos), el **receptor** (quien sabe hacerlo), el **invocador** (quien lo lanza, sin saber los detalles) y, opcionalmente, la operación de deshacer.

En Java moderno, un comando suele ser un `record` inmutable y su manejador, un bean:

```java
public record ConfirmarPedido(Long pedidoId, String usuario) {}

@Component
class ConfirmarPedidoHandler {
    @Transactional
    public void handle(ConfirmarPedido cmd) {
        Pedido p = pedidos.findById(cmd.pedidoId()).orElseThrow();
        p.confirmar(cmd.usuario());
    }
}
```

Dónde aparece:

- `Runnable` y `Callable` son comandos: se envían a un `ExecutorService` que los ejecuta sin conocerlos.
- **CQRS**: la parte de escritura se modela como comandos con sus manejadores. Algunos proyectos usan un *command bus* (Axon Framework, o una implementación sencilla con un mapa de manejadores por tipo) que añade de forma transversal validación, transacciones, auditoría o métricas.
- **Mensajería**: un mensaje de comando (`ReservarStock`) enviado a otro servicio es un comando serializado; en una saga orquestada, el orquestador emite comandos y los participantes los ejecutan.
- **Spring Batch** y los *jobs*: pasos parametrizados y reejecutables.
- Operaciones con **deshacer** o compensación: cada comando puede tener su compensación asociada, idea que conecta con el patrón Saga.

Ventajas: facilita el registro de auditoría (cada comando es un objeto que se puede serializar y guardar), los reintentos y la ejecución diferida. Inconveniente: más clases; para operaciones sencillas, un método de servicio es suficiente.

## P070 · ¿Qué es el patrón Composite? Pon un ejemplo práctico.

*Tema: Estructurales · Nivel 4 · Intermedio*

**Composite** permite tratar de forma uniforme objetos individuales y composiciones de objetos, organizándolos en estructuras de árbol. Tanto la hoja como el compuesto implementan la misma interfaz, y el compuesto delega en sus hijos.

Ejemplo clásico de negocio: reglas de descuento o de validación que se combinan.

```java
public interface ReglaDescuento {
    BigDecimal aplicar(Carrito carrito);
}

record DescuentoPorcentaje(BigDecimal porcentaje) implements ReglaDescuento {
    public BigDecimal aplicar(Carrito c) { return c.subtotal().multiply(porcentaje); }
}

record DescuentoEnvioGratis(BigDecimal minimo) implements ReglaDescuento {
    public BigDecimal aplicar(Carrito c) {
        return c.subtotal().compareTo(minimo) >= 0 ? c.gastosEnvio() : BigDecimal.ZERO;
    }
}

// Compuesto: aplica todas sus reglas y suma el resultado
record DescuentoCompuesto(List<ReglaDescuento> reglas) implements ReglaDescuento {
    public BigDecimal aplicar(Carrito c) {
        return reglas.stream().map(r -> r.aplicar(c)).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
```

El código que usa las reglas no distingue entre una regla simple y una combinación de veinte: llama a `aplicar` y ya está. Se pueden anidar compuestos (una promoción que agrupa otras promociones).

Ejemplos en el ecosistema:

- `CompositeHealthContributor` de Actuator: la salud global agrega la de la base de datos, el disco, el broker, etc.
- `CompositeMeterRegistry` de Micrometer: publica métricas en varios registros a la vez.
- `CompositeCacheManager`, `CompositePropertySource` y el `Environment` de Spring, compuesto de muchas fuentes de propiedades.
- Estructuras de árbol del dominio: categorías de un catálogo, menús, organigramas.

Combinado con **Specification** (un patrón DDD para expresar reglas de negocio combinables con `and`, `or`, `not`), da lugar a filtros dinámicos muy expresivos; la interfaz `Specification` de Spring Data JPA sigue esta idea.

## P071 · ¿Qué diferencia hay entre los patrones Repository y DAO? ¿Qué es Unit of Work?

*Tema: Persistencia · Nivel 4 · Intermedio*

Los dos encapsulan el acceso a datos, pero parten de perspectivas distintas:

- **DAO** (Data Access Object) es un patrón orientado a la **tabla o la fuente de datos**. Expone operaciones de persistencia (`insert`, `update`, `findByX`) y suele existir uno por tabla. Su vocabulario es técnico.
- **Repository** (Martin Fowler, DDD) es un patrón orientado al **dominio**: se comporta como una colección en memoria de objetos de dominio (`add`, `remove`, `findById`), oculta por completo la persistencia y existe **uno por agregado**, no por tabla. Su interfaz pertenece al dominio y habla su lenguaje (`pedidosPendientesDeEnvio()`).

```java
// Estilo repository: interfaz en el dominio, sin detalles de persistencia
public interface Pedidos {
    Optional<Pedido> porId(PedidoId id);
    List<Pedido> pendientesDeEnvio();
    void guardar(Pedido pedido);
}
```

Los repositorios de Spring Data se sitúan a medio camino: se llaman repositorios, pero con frecuencia se usan como DAOs (uno por entidad, incluidas entidades internas de un agregado) y exponen métodos técnicos. En una arquitectura hexagonal, lo habitual es definir un puerto de dominio como el anterior y un adaptador que lo implementa apoyándose en un repositorio de Spring Data.

**Unit of Work** mantiene la lista de objetos afectados por una transacción de negocio y coordina la escritura de sus cambios de una vez al final, resolviendo el orden de las operaciones y la concurrencia. El **contexto de persistencia de Hibernate** (la `Session` / `EntityManager`) es una implementación de Unit of Work: registra entidades nuevas, modificadas (dirty checking) y eliminadas, y lo vuelca todo en el flush. Su compañero natural es el **Identity Map**: una única instancia en memoria por fila dentro de la sesión (la caché de primer nivel).

## P072 · ¿Qué son los value objects y por qué es importante la inmutabilidad?

*Tema: Diseño · Nivel 4 · Intermedio*

Un **value object** es un objeto definido únicamente por sus atributos, sin identidad propia: dos instancias con los mismos valores son intercambiables. Ejemplos: `Dinero(10.00, EUR)`, `Email`, `Direccion`, `RangoFechas`, `Cantidad`.

Deben ser **inmutables**: para «cambiar» un valor se crea uno nuevo. Esto aporta:

- **Seguridad en concurrencia**: se pueden compartir entre hilos sin sincronización.
- **Ausencia de efectos secundarios**: nadie puede modificar un objeto que se pasó como argumento o se guardó en un mapa.
- **Validez garantizada**: se valida en el constructor; si el objeto existe, es válido. Se acabaron las comprobaciones repetidas de «¿este email es válido?» por todo el código.
- **Expresividad**: `transferir(Dinero importe, Iban destino)` es más claro y seguro que `transferir(BigDecimal importe, String cuenta)`, y evita confundir el orden de parámetros del mismo tipo (la *obsesión por los tipos primitivos*).

Los **records** de Java son la herramienta natural:

```java
public record Dinero(BigDecimal importe, Currency moneda) {

    public Dinero {
        Objects.requireNonNull(importe);
        Objects.requireNonNull(moneda);
        if (importe.scale() > moneda.getDefaultFractionDigits())
            throw new IllegalArgumentException("Demasiados decimales para " + moneda);
    }

    public static Dinero euros(String cantidad) {
        return new Dinero(new BigDecimal(cantidad), Currency.getInstance("EUR"));
    }

    public Dinero sumar(Dinero otro) {
        if (!moneda.equals(otro.moneda)) throw new IllegalArgumentException("Monedas distintas");
        return new Dinero(importe.add(otro.importe), moneda);
    }
}
```

En JPA, los value objects se mapean como `@Embeddable` (Hibernate 6.2+ admite records como embeddables) o con un `AttributeConverter` si se guardan en una sola columna.

Notas sobre inmutabilidad en Java: un `record` es superficialmente inmutable; si contiene una `List`, hay que copiarla defensivamente con `List.copyOf()` en el constructor. Nunca usar `double` ni `float` para dinero: se usa `BigDecimal` (o un entero de céntimos) por los errores de redondeo en coma flotante.

## P073 · ¿Qué anti-patrones y code smells de diseño son habituales en aplicaciones Spring?

*Tema: Diseño · Nivel 4 · Intermedio*

- **Modelo de dominio anémico**: entidades con solo getters y setters y toda la lógica en servicios. Las reglas de negocio se dispersan y se duplican, y cualquier código puede dejar una entidad en estado inválido. Solución: mover comportamiento a las entidades y value objects (`pedido.confirmar()` en lugar de `pedido.setEstado(CONFIRMADO)`).
- **Servicio dios** (*God class*): un `PedidoService` de 3.000 líneas con veinte dependencias inyectadas. Una clase con más de cinco o seis dependencias en el constructor es una señal de alarma.
- **Service Locator**: obtener dependencias pidiéndolas al contexto (`applicationContext.getBean(...)`) en lugar de inyectarlas. Oculta dependencias y complica los tests.
- **Lógica de negocio en los controladores** o, al revés, conocimiento HTTP (`HttpServletRequest`, `ResponseEntity`) en los servicios.
- **Capas «pasamanos»**: servicios que solo delegan en el repositorio sin aportar nada, creados por obligación.
- **Interfaces con una sola implementación** para todo (`PedidoService` + `PedidoServiceImpl`) sin motivo real. Con proxies CGLIB ya no son necesarias para AOP; tienen sentido en fronteras de arquitectura (puertos) o cuando se prevén varias implementaciones.
- **Excepciones genéricas o tragadas**: `catch (Exception e) { log.error(...) }` que continúa como si nada, o usar excepciones para el control de flujo normal.
- **Obsesión por los tipos primitivos**: `String` para emails, IBAN o códigos de país; `BigDecimal` suelto para dinero sin moneda.
- **Configuración mágica**: valores de negocio duros en el código o `@Value` esparcidos por cien clases.
- **Uso de `Optional` como campo o parámetro**: está pensado como tipo de retorno.
- **Transacciones enormes** que incluyen llamadas remotas o esperas, y el patrón contrario: operaciones que deberían ser atómicas repartidas en varias transacciones.
- **Tests que prueban mocks**: tanto `when`/`verify` que el test ya no comprueba ningún comportamiento real.

Herramientas que ayudan a detectarlos: **SonarQube** (complejidad, duplicación, code smells, cobertura), **ArchUnit** (reglas de arquitectura como «los controladores no acceden a repositorios»), **PMD** y **Error Prone**, además de revisiones de código.

> **Clave para la entrevista.** Si te piden revisar código en la entrevista, buscar explícitamente estos smells y proponer refactorizaciones concretas es lo que se espera.

# Nivel 5 · Intermedio-Avanzado · Microservicios: fundamentos, comunicación e infraestructura

Cuándo tiene sentido partir un sistema, cómo se comunican los servicios y qué piezas de infraestructura necesitan (gateway, discovery, configuración, observabilidad, Kubernetes).

Este capítulo contiene 17 preguntas.

## P074 · ¿Qué son los microservicios? ¿Qué ventajas y desventajas tienen frente a un monolito?

*Tema: Microservicios · Nivel 5 · Intermedio-Avanzado*

Una arquitectura de microservicios estructura una aplicación como un conjunto de **servicios pequeños, autónomos y desplegables de forma independiente**, cada uno organizado alrededor de una capacidad de negocio, con su propia base de datos y comunicándose por red (HTTP, gRPC, mensajería).

**Ventajas**:

- Despliegue independiente: cada equipo publica sin coordinarse con el resto.
- Escalado selectivo: se escala solo el servicio con carga.
- Aislamiento de fallos (si se diseña bien la resiliencia).
- Autonomía tecnológica y de equipos (Ley de Conway).
- Bases de código más pequeñas y comprensibles.

**Desventajas**:

- **Complejidad distribuida**: latencia, fallos parciales de red, timeouts, reintentos.
- **Consistencia de datos**: se pierden las transacciones ACID entre servicios; aparece la consistencia eventual.
- Coste operativo: CI/CD por servicio, observabilidad, service discovery, orquestación con Kubernetes.
- Testing de integración más difícil.
- Riesgo de construir un **monolito distribuido**: todo el coste de lo distribuido sin sus beneficios.

Conclusión madura: los microservicios resuelven sobre todo un **problema organizativo** (muchos equipos trabajando en paralelo sobre el mismo sistema). Para equipos pequeños o dominios poco claros, un **monolito modular** suele ser mejor punto de partida, con la posibilidad de extraer servicios más adelante.

> **Clave para la entrevista.** Evita el entusiasmo acrítico. La frase «empezaría con un monolito modular salvo que haya razones organizativas o de escalado claras» suele causar muy buena impresión.

### Repreguntas frecuentes

**¿Qué es la Ley de Conway?**

La observación de que las organizaciones diseñan sistemas que copian su estructura de comunicación. La «maniobra inversa de Conway» consiste en organizar los equipos según la arquitectura deseada: un equipo por dominio o servicio.

## P075 · ¿Cómo se decide qué funcionalidad va en cada microservicio?

*Tema: Microservicios · Nivel 5 · Intermedio-Avanzado*

Criterios principales:

- **Bounded Contexts de DDD**: cada contexto con un modelo coherente es un buen candidato a servicio. Técnicas como **Event Storming** ayudan a descubrirlos.
- **Capacidades de negocio**: Catálogo, Pedidos, Pagos, Envíos, Clientes.
- **Alta cohesión y bajo acoplamiento**: lo que cambia junto debe estar junto. Si cada funcionalidad nueva requiere modificar y desplegar tres servicios a la vez, los límites están mal trazados.
- **Autonomía de datos**: el servicio debe poder cumplir su responsabilidad con sus propios datos la mayor parte del tiempo.
- **Estructura de equipos**: un servicio debería pertenecer a un único equipo.
- **Requisitos no funcionales distintos**: escalado, disponibilidad o seguridad (por ejemplo, aislar el procesamiento de pagos por cumplimiento PCI).

Señales de malos límites: llamadas síncronas en cadena para cualquier operación (servicios «chatty»), bases de datos compartidas, transacciones distribuidas por todas partes o servicios «entidad» (un servicio por tabla: `ClienteService`, `DireccionService`...).

Un buen camino es el **monolito modular**: módulos con límites claros dentro de un único despliegue. **Spring Modulith** permite verificar esos límites con tests, comunicar módulos por eventos y documentarlos; si un módulo necesita escalar o evolucionar por separado, extraerlo después es mucho más sencillo.

### Repreguntas frecuentes

**¿Qué harías si descubres que dos servicios siempre cambian juntos?**

Es una señal de que el límite está mal trazado. Hay que analizar si comparten un concepto de dominio que debería estar en un solo servicio y, en ese caso, fusionarlos o redistribuir responsabilidades. Unir servicios también es una decisión válida.

## P076 · ¿Qué diferencia hay entre comunicación síncrona y asíncrona entre microservicios? ¿Cuándo usar cada una?

*Tema: Comunicación · Nivel 5 · Intermedio-Avanzado*

**Síncrona** (REST, gRPC): el llamante espera la respuesta.

- A favor: modelo simple, respuesta inmediata, fácil de depurar.
- En contra: **acoplamiento temporal** (si B no está disponible, A falla), la latencia se acumula en cadenas de llamadas y la disponibilidad total es el producto de las disponibilidades individuales (cinco servicios al 99,9% dan aproximadamente un 99,5%).

**Asíncrona** (mensajería con Kafka, RabbitMQ...): el emisor publica un mensaje y continúa.

- A favor: desacoplamiento temporal (el consumidor puede estar caído y procesará después), absorbe picos de carga, facilita añadir nuevos consumidores sin tocar al emisor.
- En contra: consistencia eventual, mayor complejidad (duplicados, orden, mensajes envenenados, colas de mensajes muertos), depuración más difícil (requiere trazabilidad distribuida).

**Cuándo usar cada una**:

- Síncrona para **consultas** en las que el usuario necesita la respuesta ahora (consultar el precio o el stock).
- Asíncrona para **propagar hechos** (`PedidoCreado`) y procesos que pueden completarse después (envío de emails, actualización de vistas, integración con otros dominios).

Dentro de la mensajería conviene distinguir entre **comandos** (petición dirigida a un servicio: «ReservaStock») y **eventos** (hecho ya ocurrido, publicado para quien le interese: «StockReservado»).

## P077 · REST, gRPC o mensajería: ¿cómo elegir?

*Tema: Comunicación · Nivel 5 · Intermedio-Avanzado*

- **REST sobre HTTP/JSON**: estándar universal, legible, fácil de probar y de cachear, excelente para APIs públicas y para comunicación con frontends. Contrato con OpenAPI. Menos eficiente (texto, verbosidad).
- **gRPC**: HTTP/2 con Protocol Buffers (binario). Contrato fuerte y generación de código, mucho más eficiente en tamaño y latencia, soporta **streaming** bidireccional. Ideal para comunicación interna de alto rendimiento entre servicios. En contra: no se consume directamente desde el navegador (requiere gRPC-Web o un proxy) y es menos legible al depurar. Spring tiene soporte oficial con **Spring gRPC**.
- **GraphQL**: el cliente decide qué campos pide; útil para frontends con necesidades variadas (Spring for GraphQL). Complica la caché HTTP y el control de coste de consultas.
- **Mensajería** (Kafka, RabbitMQ, Amazon SQS/SNS): para comunicación asíncrona, eventos y desacoplamiento.

Criterio práctico: REST para APIs externas y la mayoría de integraciones internas; gRPC cuando el rendimiento o el streaming entre servicios internos es crítico; mensajería para eventos y procesos asíncronos. Muchas arquitecturas combinan las tres.

## P078 · ¿Qué es el Service Discovery? ¿Qué diferencia hay entre descubrimiento en el cliente y en el servidor?

*Tema: Infraestructura · Nivel 5 · Intermedio-Avanzado*

En un entorno dinámico, las instancias de un servicio aparecen y desaparecen (autoescalado, despliegues, fallos) y sus IP cambian. El service discovery permite localizarlas por **nombre lógico** en lugar de por dirección fija. Se basa en un **registro de servicios** donde cada instancia se registra y envía heartbeats.

- **Client-side discovery**: el cliente consulta el registro, obtiene la lista de instancias y elige una con su propio balanceador de carga. Ejemplo: **Eureka** + **Spring Cloud LoadBalancer** (que sustituyó a Netflix Ribbon). Más control en el cliente, pero lógica repetida en cada lenguaje.
- **Server-side discovery**: el cliente llama a un balanceador o router que consulta el registro y reenvía la petición. Ejemplo: **Kubernetes**, donde un `Service` tiene un nombre DNS estable (`pedidos.mi-namespace.svc.cluster.local`) y kube-proxy reparte el tráfico entre los pods sanos. El cliente no necesita ninguna librería.

En la práctica, si se despliega sobre **Kubernetes**, Eureka suele sobrar: el DNS y los Services de Kubernetes ya resuelven el discovery. Eureka o Consul tienen sentido en entornos sin orquestador o híbridos.

> **Clave para la entrevista.** Decir que en Kubernetes normalmente no necesitas Eureka demuestra criterio actualizado; muchos tutoriales antiguos lo siguen incluyendo por defecto.

### Repreguntas frecuentes

**¿Cómo funciona el balanceo de carga con gRPC en Kubernetes?**

gRPC usa conexiones HTTP/2 persistentes, así que el balanceo por conexión de un Service ClusterIP envía todo el tráfico de un cliente a un único pod. Se resuelve con balanceo en el cliente mediante un Service headless o con un service mesh que balancea por petición.

## P079 · ¿Qué es un API Gateway? ¿Y el patrón Backend for Frontend (BFF)?

*Tema: Infraestructura · Nivel 5 · Intermedio-Avanzado*

Un **API Gateway** es el punto de entrada único para los clientes externos. Encapsula la estructura interna del sistema y centraliza preocupaciones transversales:

- **Enrutamiento** hacia el servicio adecuado.
- **Autenticación** (validación de tokens JWT) y autorización gruesa.
- **Rate limiting** y cuotas.
- Terminación TLS, CORS.
- Reintentos, timeouts y circuit breakers.
- Agregación o composición de respuestas.
- Logging, métricas y generación del identificador de trazas.

En el ecosistema Spring se usa **Spring Cloud Gateway** (sustituto de Netflix Zuul), con variantes reactiva (WebFlux) y basada en Spring MVC. Alternativas: Kong, NGINX, Envoy, AWS API Gateway, Azure API Management, o un Ingress/Gateway API de Kubernetes.

```yaml
spring:
  cloud:
    gateway:
      server:
        webflux:
          routes:
            - id: pedidos
              uri: lb://pedidos-service
              predicates:
                - Path=/api/pedidos/**
              filters:
                - StripPrefix=1
```

**Backend for Frontend (BFF)**: en lugar de un gateway genérico, un backend específico por tipo de cliente (web, móvil, terceros), adaptado a sus necesidades y mantenido por el equipo de ese frontend. También es el patrón recomendado para **seguridad en SPAs**: el BFF guarda los tokens OAuth2 en el servidor y el navegador solo maneja una cookie de sesión segura.

Riesgo: que el gateway acumule lógica de negocio y se convierta en un nuevo monolito.

### Repreguntas frecuentes

**¿Qué diferencia hay entre un API Gateway y un Ingress de Kubernetes?**

El Ingress es un enrutador HTTP básico hacia los servicios del clúster (host, ruta, TLS). Un API Gateway añade funcionalidades de gestión de APIs: autenticación, rate limiting, transformación, agregación, cuotas y analítica. Algunos controladores de Ingress y la Gateway API de Kubernetes cubren parte de esas funciones.

## P080 · ¿Cómo se gestiona la configuración centralizada en microservicios?

*Tema: Infraestructura · Nivel 5 · Intermedio-Avanzado*

Con decenas de servicios y varios entornos, la configuración necesita una gestión centralizada, versionada y segura.

- **Spring Cloud Config Server**: servidor que sirve configuración desde un repositorio Git (o Vault, JDBC...). Los servicios la importan con `spring.config.import=configserver:http://config:8888`. Ventajas: historial y revisión por pull request, configuración por aplicación y perfil. Los cambios pueden recargarse en caliente con `@RefreshScope` y el endpoint `/actuator/refresh`, o de forma masiva con Spring Cloud Bus.
- **Kubernetes ConfigMaps y Secrets**: montados como variables de entorno o ficheros. Es la opción más habitual cuando se despliega en Kubernetes. Spring Boot puede leer ficheros montados con `spring.config.import=configtree:/etc/config/`.
- **Gestores de secretos**: HashiCorp Vault (Spring Cloud Vault), AWS Secrets Manager, Azure Key Vault, GCP Secret Manager.

Buenas prácticas:

- **Nunca** guardar secretos en el repositorio en texto plano (ni en `application.yml`).
- Separar configuración (varía por entorno) de código (igual en todos): principio de la metodología 12-factor.
- Rotación de credenciales y, cuando sea posible, credenciales dinámicas de corta duración (Vault).
- Validar la configuración al arrancar (`@ConfigurationProperties` + `@Validated`) para fallar rápido.

## P081 · ¿Qué opciones hay en Spring para llamar a otros servicios por HTTP?

*Tema: Comunicación · Nivel 5 · Intermedio-Avanzado*

- **RestTemplate**: cliente síncrono clásico basado en Template Method. Está en modo mantenimiento; no se recomienda para código nuevo.
- **WebClient**: cliente reactivo y no bloqueante (WebFlux). Adecuado en aplicaciones reactivas o cuando se necesitan muchas llamadas concurrentes.
- **RestClient** (Spring 6.1 / Boot 3.2+): cliente **síncrono con API fluida** moderna, similar a WebClient. Es la opción recomendada para aplicaciones Spring MVC, especialmente combinado con hilos virtuales.
- **HTTP Interfaces** (`@HttpExchange`): se declara una interfaz y Spring genera la implementación sobre `RestClient` o `WebClient`. Estilo declarativo parecido a Feign, pero nativo del framework.
- **OpenFeign** (Spring Cloud OpenFeign): cliente declarativo muy popular; el propio proyecto recomienda migrar a HTTP Interfaces para código nuevo.

```java
@HttpExchange("/api/clientes")
public interface ClientesClient {
    @GetExchange("/{id}")
    ClienteDto obtener(@PathVariable Long id);
}

@Bean
ClientesClient clientesClient(RestClient.Builder builder) {
    RestClient rc = builder.baseUrl("http://clientes-service").build();
    return HttpServiceProxyFactory.builderFor(RestClientAdapter.create(rc))
        .build().createClient(ClientesClient.class);
}
```

Independientemente del cliente: configurar **siempre timeouts** de conexión y de lectura (los valores por defecto pueden ser infinitos), usar el `Builder` inyectado por Boot (para heredar trazas y métricas) y envolver las llamadas con políticas de resiliencia.

### Repreguntas frecuentes

**¿Qué timeouts configurarías en un cliente HTTP?**

Al menos el de conexión (cuánto esperar para establecer la conexión, normalmente corto: 1-2 segundos) y el de lectura (cuánto esperar la respuesta, según el SLO de la dependencia). Con pools de conexiones, también el tiempo máximo de espera por una conexión libre del pool.

## P082 · ¿Qué diferencias hay entre Kafka y RabbitMQ? ¿Qué garantías de entrega existen?

*Tema: Mensajería · Nivel 5 · Intermedio-Avanzado*

**RabbitMQ** es un **message broker** tradicional (AMQP): exchanges que enrutan mensajes a colas según reglas (direct, topic, fanout, headers). El mensaje se elimina al ser confirmado por el consumidor. Destaca en enrutamiento flexible, colas de trabajo, prioridades y patrones request/reply. Spring: Spring AMQP / `RabbitTemplate` y `@RabbitListener`.

**Apache Kafka** es una **plataforma de log distribuido**: los mensajes se escriben en *topics* divididos en *particiones*, se **conservan** durante un periodo configurable y cada grupo de consumidores lleva su propio *offset*. Permite reprocesar eventos, tener múltiples consumidores independientes y un rendimiento muy alto. El **orden está garantizado solo dentro de una partición**, por lo que se usa una clave (por ejemplo `pedidoId`) para que los eventos de una misma entidad vayan a la misma partición. Spring: Spring for Apache Kafka / `KafkaTemplate` y `@KafkaListener`.

Criterio: Kafka para streaming de eventos, alto volumen, event sourcing, múltiples consumidores y replay. RabbitMQ para colas de tareas, enrutamiento complejo y baja latencia con volúmenes moderados.

**Garantías de entrega**:

- **At-most-once**: puede perderse, nunca se duplica.
- **At-least-once**: nunca se pierde, pero puede duplicarse. Es la opción habitual.
- **Exactly-once**: difícil de lograr de extremo a extremo. Kafka lo ofrece dentro de su ecosistema (productor idempotente + transacciones), pero en cuanto intervienen sistemas externos (una base de datos, una API) la solución práctica es **at-least-once + consumidores idempotentes**.

Otros conceptos: **Dead Letter Queue / Topic** para mensajes que fallan repetidamente, reintentos con backoff y los problemas de mensajes envenenados.

> **Clave para la entrevista.** La frase «exactly-once en la práctica es at-least-once más idempotencia» es exactamente lo que quieren oír.

### Repreguntas frecuentes

**¿Qué es una poison pill?**

Un mensaje que siempre provoca un error al procesarlo (formato inválido, datos inesperados). Si el consumidor lo reintenta indefinidamente, bloquea la cola o la partición. Se detecta limitando los reintentos y enviándolo a una cola de mensajes muertos.

## P083 · ¿Qué es la observabilidad y cómo se implementa en microservicios con Spring Boot?

*Tema: Observabilidad · Nivel 5 · Intermedio-Avanzado*

La observabilidad es la capacidad de entender el estado interno de un sistema a partir de sus salidas. Se apoya en tres pilares:

- **Logs**: eventos discretos. Estructurados (JSON), centralizados (ELK/OpenSearch, Loki) y con identificadores de traza.
- **Métricas**: valores numéricos agregados en el tiempo (latencia, tasa de errores, uso de CPU, tamaño del pool). Con **Micrometer** (fachada de métricas de Spring) se exportan a Prometheus y se visualizan en Grafana. Métodos útiles: **RED** (Rate, Errors, Duration) para servicios y **USE** (Utilization, Saturation, Errors) para recursos.
- **Trazas distribuidas**: siguen una petición a través de varios servicios. Una **traza** está formada por **spans**; el contexto se propaga en cabeceras (estándar **W3C Trace Context**, cabecera `traceparent`). En Spring Boot 3 se usa **Micrometer Tracing** (sucesor de Spring Cloud Sleuth) con puente a OpenTelemetry o Brave, exportando a Jaeger, Zipkin, Tempo...

La **Observation API** de Micrometer permite instrumentar una vez y obtener métrica y traza a la vez:

```java
Observation.createNotStarted("pedido.confirmar", registry)
    .lowCardinalityKeyValue("canal", "web")
    .observe(() -> confirmar(pedido));
```

Además: **health checks**, alertas basadas en **SLO** (objetivos de nivel de servicio) en lugar de umbrales arbitrarios y **correlación**: el `traceId` aparece en logs, métricas (exemplars) y trazas, lo que permite saltar de una alerta al log y a la traza de la petición concreta.

## P084 · ¿Qué hay que tener en cuenta al desplegar un microservicio Spring Boot en Kubernetes?

*Tema: Despliegue · Nivel 5 · Intermedio-Avanzado*

- **Imagen**: construir con capas (`jarmode`) o buildpacks, imagen base mínima (JRE, distroless), usuario no root y versiones fijadas.
- **Sondas**: Spring Boot detecta Kubernetes y expone `/actuator/health/liveness` y `/actuator/health/readiness`.
  - **Liveness**: ¿el proceso está vivo o bloqueado? Si falla, Kubernetes **reinicia** el contenedor. No debe comprobar dependencias externas: si la BD cae, reiniciar todos los pods no arregla nada y empeora la situación.
  - **Readiness**: ¿puede recibir tráfico? Si falla, se **saca del balanceo** sin reiniciar. Aquí sí tiene sentido considerar dependencias críticas.
  - **Startup probe**: para arranques lentos, evita que la liveness mate el pod mientras arranca.
- **Graceful shutdown**: `server.shutdown=graceful` (por defecto desde Boot 3.4) y `spring.lifecycle.timeout-per-shutdown-phase`, para terminar las peticiones en curso al recibir SIGTERM. A veces se añade un `preStop` breve para dar tiempo a que el endpoint se retire del balanceador.
- **Recursos**: definir `requests` y `limits` de CPU y memoria. La JVM moderna respeta los límites del contenedor; se ajusta el heap con `-XX:MaxRAMPercentage=75` en lugar de `-Xmx` fijo.
- **Configuración**: ConfigMaps y Secrets; no recompilar la imagen por entorno.
- **Escalado**: HorizontalPodAutoscaler basado en CPU o métricas propias; PodDisruptionBudget para mantener disponibilidad durante mantenimientos.
- **Aplicación stateless**: sin sesión en memoria ni ficheros locales; el estado va a bases de datos, Redis o almacenamiento de objetos.

> **Clave para la entrevista.** Explicar por qué la liveness no debe depender de la base de datos es un clásico en entrevistas con componente DevOps.

### Repreguntas frecuentes

**¿Qué pasa si la sonda de readiness comprueba la base de datos y esta cae?**

Todas las réplicas dejan de estar listas a la vez y el Service no tiene ningún endpoint: los clientes reciben errores de conexión en lugar de una respuesta controlada. A veces es preferible seguir listo y devolver errores 503 con un mensaje claro, o degradar funcionalidad.

## P085 · ¿Cómo se versiona una API y cómo se mantiene la compatibilidad entre servicios?

*Tema: APIs · Nivel 5 · Intermedio-Avanzado*

Estrategias de versionado:

- **En la URL**: `/api/v1/pedidos`. La más explícita y fácil de enrutar y cachear. La más común.
- **Por cabecera**: `X-API-Version: 2` o por tipo de medio (`Accept: application/vnd.tienda.v2+json`). URLs más limpias, pero menos visibles.
- **Por parámetro**: `?version=2`.

Spring Framework 7 / Boot 4 incorpora **soporte nativo de versionado de APIs** (atributo `version` en los mappings y estrategias de resolución por ruta, cabecera, parámetro o media type).

Lo más importante no es el mecanismo, sino **evitar romper a los consumidores**:

- Cambios **compatibles**: añadir campos opcionales, añadir endpoints, añadir valores con cuidado. No requieren nueva versión.
- Cambios **incompatibles**: eliminar o renombrar campos, cambiar tipos o semántica, hacer obligatorio un campo. Requieren nueva versión o un periodo de transición.
- Seguir la **ley de Postel** (robustez): ser tolerante con lo que se recibe. Los clientes deben ignorar campos desconocidos (`FAIL_ON_UNKNOWN_PROPERTIES = false`, que Spring Boot ya configura por defecto en su `ObjectMapper`).
- Mantener versiones antiguas durante un periodo de **deprecación** comunicado (cabeceras `Deprecation` y `Sunset`).
- Verificar la compatibilidad automáticamente con **contract testing** y con herramientas de comparación de especificaciones OpenAPI en el pipeline.

En mensajería ocurre lo mismo: se usan esquemas versionados (Avro o Protobuf con un **Schema Registry** que aplica reglas de compatibilidad backward/forward).

## P086 · ¿Qué es la metodología Twelve-Factor App?

*Tema: Principios · Nivel 5 · Intermedio-Avanzado*

Es un conjunto de doce buenas prácticas para construir aplicaciones nativas de la nube, publicado por Heroku. Muchas encajan de forma natural con Spring Boot y Kubernetes:

- **Codebase**: un repositorio por aplicación, muchos despliegues.
- **Dependencies**: declaradas explícitamente y aisladas (Maven/Gradle, fat jar).
- **Config**: en el entorno, no en el código (variables de entorno, perfiles).
- **Backing services**: bases de datos, colas y cachés como recursos adjuntos intercambiables por configuración.
- **Build, release, run**: etapas estrictamente separadas; el mismo artefacto se promociona entre entornos.
- **Processes**: procesos **stateless**; el estado vive en servicios de respaldo.
- **Port binding**: la aplicación se autocontiene y expone un puerto (servidor embebido).
- **Concurrency**: se escala horizontalmente añadiendo procesos.
- **Disposability**: arranque rápido y apagado ordenado (graceful shutdown).
- **Dev/prod parity**: entornos lo más parecidos posible (Testcontainers, Docker Compose).
- **Logs**: como flujo de eventos a stdout; la plataforma los recoge.
- **Admin processes**: tareas administrativas como procesos puntuales (migraciones, jobs).

Muchos autores añaden factores modernos como API-first, telemetría y seguridad desde el diseño.

## P087 · ¿Qué es el modelo de madurez de Richardson? ¿Tiene sentido usar HATEOAS?

*Tema: APIs · Nivel 5 · Intermedio-Avanzado*

Leonard Richardson propuso cuatro niveles para medir cuánto aprovecha una API los principios de REST:

- **Nivel 0 · POX (Plain Old XML/JSON)**: un único endpoint al que se envía todo por POST, como si fuera RPC. Ejemplo: `POST /api` con `{"accion": "obtenerCliente", "id": 42}`.
- **Nivel 1 · Recursos**: cada entidad tiene su propia URL (`/clientes/42`), pero se sigue usando un único verbo.
- **Nivel 2 · Verbos HTTP**: se usan correctamente GET, POST, PUT, PATCH y DELETE, y los códigos de estado. **Aquí está la gran mayoría de APIs «REST» del mundo real.**
- **Nivel 3 · Controles hipermedia (HATEOAS)**: las respuestas incluyen enlaces a las acciones y recursos relacionados disponibles, de forma que el cliente navega la API sin construir URLs a mano.

```json
{
  "id": 1001,
  "estado": "PENDIENTE",
  "total": 59.90,
  "_links": {
    "self":     { "href": "/api/pedidos/1001" },
    "pagar":    { "href": "/api/pedidos/1001/pago" },
    "cancelar": { "href": "/api/pedidos/1001/cancelacion" },
    "cliente":  { "href": "/api/clientes/42" }
  }
}
```

En Spring se implementa con **Spring HATEOAS** (`EntityModel`, `CollectionModel`, `WebMvcLinkBuilder`) y formatos como HAL.

Ventajas: el servidor comunica qué acciones son válidas en cada estado (el enlace `pagar` desaparece si el pedido ya está pagado), las URLs pueden cambiar sin romper clientes y la API es autodescriptiva.

¿Por qué se usa poco? Los clientes reales (frontends, otros servicios) casi nunca navegan dinámicamente: están programados contra un contrato conocido (OpenAPI). Añade peso a las respuestas y complejidad, y las herramientas de generación de clientes no lo aprovechan bien.

Posición razonable en una entrevista: conocer el modelo, apuntar al **nivel 2 bien hecho** (recursos con sustantivos, verbos y códigos correctos, errores estandarizados con Problem Details, paginación, versionado) y considerar HATEOAS en APIs públicas de larga vida o cuando comunicar las transiciones de estado disponibles aporta un valor real.

## P088 · ¿Cómo sería un pipeline de CI/CD típico para un microservicio Spring Boot?

*Tema: DevOps · Nivel 5 · Intermedio-Avanzado*

Un pipeline de integración y entrega continuas automatiza el camino desde un commit hasta producción. Una estructura habitual (GitHub Actions, GitLab CI, Jenkins, Azure DevOps...):

**Integración continua** (en cada push y en cada pull request):

- Compilación con el wrapper de Maven o Gradle y caché de dependencias.
- **Tests unitarios** y análisis estático (Checkstyle, SpotBugs, PMD, Error Prone).
- **Tests de integración** con Testcontainers.
- **Tests de contrato**: verificar los contratos de los consumidores (Pact) y publicar los propios.
- **Cobertura** (JaCoCo) y **quality gate** de SonarQube: el pipeline falla si el código nuevo no cumple los umbrales.
- **Seguridad**: análisis de dependencias vulnerables (OWASP Dependency-Check, Snyk, Dependabot o Renovate), análisis de código (SAST) y detección de secretos (gitleaks).

**Entrega continua** (al integrar en la rama principal):

- Construcción de la **imagen** (Dockerfile multi-etapa, Jib o buildpacks), etiquetada con el SHA del commit (nunca solo con `latest`).
- **Escaneo de la imagen** (Trivy, Grype) y generación del SBOM; firma de la imagen (cosign).
- Publicación en el registro de contenedores.
- **Despliegue automático** en un entorno de integración o staging, seguido de smoke tests y pruebas end-to-end o de rendimiento.
- **Promoción a producción**, automática (despliegue continuo) o tras una aprobación, con estrategia canary o blue/green y rollback automático si las métricas empeoran.

**GitOps** es un enfoque cada vez más común para la parte de despliegue: el estado deseado de cada entorno (manifiestos de Kubernetes, charts de Helm o Kustomize) vive en un repositorio Git, y una herramienta como **Argo CD** o **Flux** lo sincroniza con el clúster. El pipeline de CI no despliega directamente: actualiza la versión de la imagen en el repositorio de configuración mediante un commit o pull request. Ventajas: historial auditable de todos los despliegues, rollback con un `git revert` y detección de cambios manuales en el clúster.

Principios importantes: **build once, deploy many** (el mismo artefacto se promociona entre entornos cambiando solo la configuración), pipelines rápidos (paralelizar y dejar lo lento para etapas posteriores), cada microservicio con su propio pipeline independiente y las migraciones de base de datos compatibles hacia atrás.

> **Clave para la entrevista.** Esta pregunta enlaza perfectamente la parte de desarrollo con la de DevOps. Mencionar quality gates, escaneo de imágenes y GitOps muestra una visión completa del ciclo de vida.

## P089 · ¿Monorepo o un repositorio por microservicio? ¿Cómo se gestiona el código compartido?

*Tema: Organización · Nivel 5 · Intermedio-Avanzado*

**Un repositorio por servicio (polyrepo)**:

- A favor: autonomía total de cada equipo, pipelines y permisos independientes, límites claros entre servicios.
- En contra: los cambios transversales (actualizar una versión de Spring Boot en cuarenta servicios) requieren cuarenta pull requests; es más difícil descubrir código y mantener la coherencia.

**Monorepo** (todos los servicios en un repositorio):

- A favor: cambios atómicos entre servicios, refactorizaciones globales, visibilidad completa, herramientas y configuración comunes.
- En contra: requiere herramientas de build capaces de compilar y probar **solo lo afectado** por un cambio (Gradle con caché de build, Bazel, Nx, Maven con `-pl`/`-am`), pipelines más complejos y el riesgo de que la facilidad para tocar todo acople los servicios.

Ninguno es universalmente mejor; depende del tamaño de la organización y de sus herramientas. Algunas empresas muy grandes usan monorepos gigantes y otras, miles de repositorios.

Sobre el **código compartido**, la regla principal es: **compartir código técnico, no el modelo de dominio**.

- Aceptable: librerías de infraestructura estables y versionadas (configuración de seguridad común, logging estructurado, clientes de observabilidad, manejo estándar de errores). La mejor forma de empaquetarlas suele ser un **starter propio** de Spring Boot.
- Un **BOM o parent corporativo** que fije versiones de Spring Boot y de las librerías aprobadas, para mantener la coherencia sin copiar configuración.
- Peligroso: una librería con las entidades o DTOs de todos los servicios. Cada cambio obliga a actualizar y redesplegar a todos los consumidores a la vez, lo que recrea el monolito distribuido. Para los contratos, es mejor compartir la **especificación** (OpenAPI, esquemas Avro o Protobuf) y que cada servicio genere su propio código, o aceptar cierta duplicación de DTOs.

Para actualizar dependencias en muchos repositorios de forma automática se usan **Renovate** o **Dependabot**, y para migraciones más profundas (por ejemplo, subir de versión de Spring Boot) recetas de **OpenRewrite**.

## P090 · ¿Cómo se gestionan y propagan los errores cuando un servicio llama a otro?

*Tema: Comunicación · Nivel 5 · Intermedio-Avanzado*

Un error en una cadena de llamadas puede originarse en muchos sitios: el servicio remoto rechaza la petición (4xx), falla internamente (5xx), no responde (timeout), no se puede conectar o devuelve una respuesta que no se puede interpretar. Cada caso requiere un tratamiento distinto.

Principios:

- **Clasificar los errores** según si son culpa del cliente (4xx: no tiene sentido reintentar), transitorios (timeouts, 503, 429: se puede reintentar con backoff si la operación es idempotente) o permanentes del servidor (500 persistentes: circuit breaker).
- **No filtrar errores internos hacia arriba sin traducirlos**. Si el servicio de Inventario devuelve un 404 porque el producto no existe, para el cliente del servicio de Pedidos eso puede ser un 422 («el pedido contiene un producto inexistente»), no un 404 de la URL de pedidos. Si Inventario responde con un 500, el servicio de Pedidos debería devolver un 502 o 503 con un mensaje controlado, no reenviar el cuerpo del error original, que podría contener detalles internos.
- **Formato de error estándar** en toda la organización (Problem Details, RFC 9457) con un campo `type` que identifique el error de negocio y el `traceId` para correlacionarlo.
- **Traducir en la frontera**: el adaptador del cliente HTTP convierte respuestas HTTP en excepciones del dominio del servicio llamante.

```java
@Bean
RestClient inventarioClient(RestClient.Builder builder, InventarioProperties props) {
    return builder
        .baseUrl(props.url())
        .requestFactory(fabricaConTimeouts(props))
        .defaultStatusHandler(status -> status.value() == 404,
            (req, res) -> { throw new ProductoNoEncontradoException(); })
        .defaultStatusHandler(HttpStatusCode::is5xxServerError,
            (req, res) -> { throw new InventarioNoDisponibleException(res.getStatusCode()); })
        .build();
}
```

- **Timeouts coherentes** en toda la cadena y, si es posible, propagación de un *deadline*: si al cliente original le quedan 200 ms, no tiene sentido que un servicio intermedio espere 5 segundos a otro.
- Decidir la **degradación** de antemano: ¿se puede mostrar la ficha de producto sin las recomendaciones? ¿Se puede aceptar el pedido y validar el stock después?
- Registrar el error una sola vez, con contexto, en el punto donde se gestiona; evitar que cada capa lo registre de nuevo, generando cinco trazas del mismo fallo.

# Nivel 6 · Avanzado · Resiliencia, datos distribuidos y patrones de microservicios

Circuit breaker, Saga, Outbox, CQRS, Event Sourcing, idempotencia, consistencia eventual y seguridad entre servicios.

Este capítulo contiene 18 preguntas.

## P091 · ¿Qué es el patrón Circuit Breaker y cómo funciona?

*Tema: Resiliencia · Nivel 6 · Avanzado*

Evita que un servicio siga llamando a una dependencia que está fallando. Sin él, las llamadas se quedan esperando timeouts, se agotan los hilos y el fallo se **propaga en cascada** por todo el sistema. Además, da a la dependencia tiempo para recuperarse.

Funciona como una máquina de estados:

- **CLOSED** (cerrado): las llamadas pasan con normalidad y se registran éxitos y fallos en una ventana deslizante (por número de llamadas o por tiempo). Si la tasa de fallos o de **llamadas lentas** supera un umbral, pasa a OPEN.
- **OPEN** (abierto): las llamadas fallan **inmediatamente** sin llegar a la dependencia (fail-fast) y se ejecuta un **fallback** (valor por defecto, caché, respuesta degradada o error controlado). Tras un tiempo de espera pasa a HALF_OPEN.
- **HALF_OPEN** (semiabierto): deja pasar un número limitado de llamadas de prueba. Si tienen éxito, vuelve a CLOSED; si fallan, vuelve a OPEN.

En Spring se usa **Resilience4j** (Netflix Hystrix está descontinuado), directamente o a través de la abstracción Spring Cloud Circuit Breaker:

```java
@CircuitBreaker(name = "inventario", fallbackMethod = "stockDesconocido")
public Stock consultarStock(Long productoId) {
    return inventarioClient.stock(productoId);
}

private Stock stockDesconocido(Long productoId, Throwable ex) {
    return Stock.desconocido(productoId);
}
```

```yaml
resilience4j.circuitbreaker.instances.inventario:
  sliding-window-size: 20
  failure-rate-threshold: 50
  slow-call-duration-threshold: 2s
  wait-duration-in-open-state: 30s
  permitted-number-of-calls-in-half-open-state: 5
```

Puntos finos: decidir qué excepciones cuentan como fallo (un 404 o un error de validación no deberían abrir el circuito) y exponer el estado de los circuitos como métricas.

### Repreguntas frecuentes

**¿Circuit breaker por instancia o compartido entre instancias?**

Normalmente cada instancia tiene su propio circuit breaker en memoria, lo cual es suficiente: cada una detecta el fallo de forma independiente en pocos segundos. Compartir el estado añadiría una dependencia más y complejidad sin gran beneficio.

**¿Qué fallback es adecuado para un servicio de precios?**

Depende del negocio: un precio cacheado reciente puede ser aceptable para mostrar un catálogo, pero no para cobrar un pedido. En ese caso es mejor fallar de forma controlada que cobrar un precio incorrecto. El fallback es una decisión de producto, no solo técnica.

## P092 · Además del circuit breaker, ¿qué otros patrones de resiliencia conoces?

*Tema: Resiliencia · Nivel 6 · Avanzado*

- **Timeout**: nunca esperar indefinidamente. Es el patrón más básico y el más olvidado. Los timeouts de cada salto deben ser coherentes: el del llamante mayor que la suma de los que dependen de él, o propagar un **deadline**.
- **Retry**: reintentar fallos **transitorios** (timeouts, 503) con **backoff exponencial y jitter** (aleatoriedad) para no sincronizar a todos los clientes. Solo en operaciones **idempotentes** y nunca ante errores 4xx.
- **Bulkhead** (mamparo): aislar recursos (pools de hilos o semáforos separados por dependencia) para que la saturación de una dependencia no consuma todos los recursos del servicio.
- **Rate Limiter**: limitar la tasa de peticiones, para protegerse o para respetar cuotas de terceros.
- **Fallback / degradación elegante**: devolver datos de caché, un valor por defecto o una funcionalidad reducida.
- **Load shedding**: rechazar peticiones cuando el servicio está saturado (429/503) para proteger a las que ya están en curso.
- **Health checks** y autocuración por el orquestador.

**Peligro: tormentas de reintentos** (*retry storms*). Si cada una de las cinco capas de una cadena reintenta 3 veces, una petición puede convertirse en 3 elevado a 5 = 243 llamadas a la dependencia final, justo cuando esta está sobrecargada. Soluciones: reintentar solo en un nivel (normalmente el más cercano al fallo o el borde), presupuestos de reintento (*retry budgets*) y circuit breakers.

En Resilience4j el orden de los decoradores importa. Por defecto es: Retry ( CircuitBreaker ( RateLimiter ( TimeLimiter ( Bulkhead ( función ) ) ) ) ), es decir, el retry envuelve al circuit breaker.

> **Clave para la entrevista.** La explicación del retry storm con el cálculo multiplicativo impresiona porque muestra que has pensado en fallos reales en producción.

## P093 · ¿Por qué cada microservicio debe tener su propia base de datos? ¿Cómo se consultan datos de varios servicios?

*Tema: Datos · Nivel 6 · Avanzado*

El patrón **Database per Service** establece que cada servicio es el único dueño de sus datos; los demás acceden a ellos solo a través de su API o de sus eventos.

Motivos: si varios servicios comparten tablas, cualquier cambio de esquema requiere coordinarlos (acoplamiento fuerte), se pierde la encapsulación y el despliegue independiente, un servicio puede degradar el rendimiento de otro y no se puede elegir la tecnología más adecuada (**persistencia políglota**: relacional para pedidos, documentos para catálogo, grafo para recomendaciones). No implica necesariamente un servidor por servicio: puede ser un esquema separado con credenciales distintas en el mismo servidor.

El problema es cómo **consultar datos que están repartidos**:

- **API Composition**: un componente (gateway, BFF o servicio) llama a varios servicios y combina los resultados en memoria. Sencillo, pero con más latencia y menor disponibilidad, e ineficiente para joins grandes o filtros que cruzan servicios.
- **CQRS con vistas materializadas**: un servicio de consulta se suscribe a los eventos de otros servicios y mantiene una **réplica de lectura desnormalizada** optimizada para esa consulta. Rápido y disponible, con consistencia eventual.
- **Replicación de datos de referencia**: un servicio guarda una copia local de los datos que necesita de otro (por ejemplo, el nombre del cliente en el pedido), actualizada por eventos.

Qué no hacer: consultar directamente la base de datos de otro servicio.

## P094 · ¿Cómo se gestionan las transacciones entre varios microservicios? Explica el patrón Saga.

*Tema: Datos · Nivel 6 · Avanzado*

No se puede usar una transacción ACID que abarque varias bases de datos de servicios distintos. El **Two-Phase Commit (2PC / XA)** existe, pero bloquea recursos, depende de un coordinador, no escala, reduce la disponibilidad y muchos brokers y bases de datos modernos no lo soportan. En microservicios se evita.

La alternativa es el patrón **Saga**: una secuencia de **transacciones locales**, una por servicio. Cada una publica un evento o mensaje que dispara la siguiente. Si un paso falla, se ejecutan **transacciones compensatorias** que deshacen semánticamente los pasos anteriores (no es un rollback: por ejemplo, «reembolsar el pago» en lugar de «borrar el pago»).

Ejemplo de pedido: Crear pedido (PENDIENTE) → Reservar stock → Cobrar → Confirmar pedido. Si el cobro falla: liberar stock → cancelar pedido.

Dos formas de coordinarla:

- **Coreografía**: no hay coordinador; cada servicio escucha eventos y reacciona publicando otros. Bajo acoplamiento y sencilla para pocos pasos, pero el flujo queda disperso y es difícil de seguir y depurar; hay riesgo de dependencias cíclicas.
- **Orquestación**: un **orquestador** (un servicio o un motor de workflows como Temporal, Camunda o Conductor) indica a cada participante qué hacer mediante comandos y gestiona las compensaciones. Flujo explícito y centralizado, más fácil de monitorizar y de cambiar; el orquestador puede acumular demasiada lógica.

Retos: al no haber aislamiento, otros procesos ven estados intermedios. Se mitiga con **contramedidas semánticas** (estados como `PENDIENTE_PAGO`), bloqueos semánticos y diseño de pasos en orden adecuado (los que pueden fallar antes; los que no se pueden compensar, como enviar un email, al final). Las compensaciones deben ser idempotentes y reintentables.

> **Clave para la entrevista.** Distinguir coreografía y orquestación con sus trade-offs, y mencionar que las compensaciones no son rollbacks, es el núcleo de la respuesta.

### Repreguntas frecuentes

**¿Cómo sabes en qué estado está una saga si un servicio cae a mitad?**

El orquestador (o cada participante en coreografía) persiste el estado de la saga y de cada paso. Al recuperarse, continúa desde el último paso confirmado. Los motores de workflows como Temporal lo gestionan automáticamente y reintentan los pasos pendientes.

**¿Qué es un paso pivote en una saga?**

El punto de no retorno: a partir de él, la saga ya no se compensa y solo puede avanzar (los pasos siguientes se reintentan hasta completarse). Los pasos compensables van antes del pivote y los que no se pueden deshacer, después.

## P095 · ¿Qué es el problema de la doble escritura (dual write) y cómo lo resuelve el patrón Transactional Outbox?

*Tema: Datos · Nivel 6 · Avanzado*

**Dual write**: un servicio necesita guardar en su base de datos **y** publicar un mensaje en el broker. Son dos sistemas distintos sin transacción común:

- Si guarda y luego falla al publicar, el pedido existe pero nadie se entera.
- Si publica y luego falla el commit, los demás servicios reaccionan a un pedido que no existe.
- Publicar dentro de la transacción tampoco lo arregla: el mensaje puede salir y la transacción hacer rollback después.

**Transactional Outbox**: en la **misma transacción local** en la que se modifica el negocio, se inserta el evento en una tabla `outbox` de la propia base de datos. La atomicidad está garantizada por la base de datos. Después, un proceso independiente publica los registros de la outbox en el broker y los marca como enviados.

```java
@Transactional
public void confirmar(Long id) {
    Pedido pedido = pedidos.findById(id).orElseThrow();
    pedido.confirmar();
    outbox.save(new OutboxEvent("Pedido", id, "PedidoConfirmado", toJson(pedido)));
}   // ambas escrituras en la misma transacción
```

Dos formas de publicar la outbox:

- **Polling publisher**: un job consulta periódicamente los eventos pendientes. Sencillo, pero añade carga y latencia.
- **Change Data Capture (CDC)**: una herramienta como **Debezium** lee el log de transacciones de la base de datos (WAL en PostgreSQL, binlog en MySQL) y publica los cambios en Kafka. Baja latencia y sin impacto en las consultas.

La garantía resultante es **at-least-once** (el relay puede publicar y caer antes de marcar el registro), así que los consumidores deben ser **idempotentes**. El patrón simétrico en el lado consumidor es la **Inbox**, que registra los mensajes procesados.

### Repreguntas frecuentes

**¿Qué pasa con la tabla outbox cuando crece mucho?**

Hay que limpiar periódicamente los eventos ya publicados (un job de borrado o particionado por fecha). Con Debezium se puede incluso insertar y borrar el registro en la misma transacción: el CDC captura la inserción del log aunque la fila ya no exista.

## P096 · ¿Qué es un consumidor idempotente y cómo se implementa?

*Tema: Datos · Nivel 6 · Avanzado*

Como la mayoría de sistemas de mensajería garantizan entrega **at-least-once**, y los clientes HTTP reintentan, un mismo mensaje o petición puede llegar varias veces. Un **consumidor idempotente** garantiza que procesar el mismo mensaje N veces tiene el mismo efecto que procesarlo una.

Técnicas:

- **Tabla de mensajes procesados** (inbox / deduplicación): cada mensaje lleva un identificador único. En la **misma transacción** en la que se aplica el efecto de negocio, se inserta el ID en una tabla con restricción `UNIQUE`. Si ya existía, se ignora el mensaje.
- **Operaciones idempotentes por naturaleza**: `UPDATE pedido SET estado = 'PAGADO'` es idempotente; `UPDATE cuenta SET saldo = saldo - 10` no lo es.
- **Máquinas de estado**: rechazar transiciones que ya se han aplicado (si el pedido ya está PAGADO, ignorar un segundo `PagoRecibido`).
- **Control por versión o secuencia**: descartar eventos con versión menor o igual a la ya procesada (también resuelve la llegada desordenada).
- **Upserts** con clave natural en lugar de inserts ciegos.

```java
@KafkaListener(topics = "pagos")
@Transactional
public void onPagoRecibido(PagoRecibido evento) {
    if (!procesados.registrarSiNuevo(evento.eventId())) {   // INSERT con UNIQUE
        return;                                             // duplicado: se ignora
    }
    pedidoService.marcarPagado(evento.pedidoId());
}
```

En APIs HTTP se aplica lo mismo con una **Idempotency-Key** enviada por el cliente, guardando la respuesta asociada para devolverla ante reintentos.

## P097 · ¿Qué es CQRS y cuándo tiene sentido aplicarlo?

*Tema: Patrones · Nivel 6 · Avanzado*

**CQRS** (Command Query Responsibility Segregation) separa el modelo de **escritura** (comandos que cambian el estado y aplican reglas de negocio) del modelo de **lectura** (consultas optimizadas para mostrar datos).

Niveles de aplicación:

- **Lógico**: clases y servicios distintos para comandos y consultas, misma base de datos. Las consultas pueden usar proyecciones DTO o SQL directo sin pasar por el modelo de dominio.
- **Físico**: almacenes separados. Las escrituras van a una BD normalizada; los eventos generados actualizan una o varias **vistas de lectura** (otra tabla desnormalizada, Elasticsearch, Redis...). Cada lado escala y se optimiza de forma independiente.

Cuándo tiene sentido:

- Gran asimetría entre lecturas y escrituras.
- Consultas complejas que combinan datos de varios agregados o servicios (en microservicios, es la solución natural para consultas que cruzan servicios).
- Dominio complejo en el que el modelo de escritura rico no es adecuado para mostrar datos.
- Junto con Event Sourcing, donde es prácticamente obligatorio.

Costes: más complejidad, más infraestructura y **consistencia eventual** entre escritura y lectura (el usuario puede no ver inmediatamente lo que acaba de guardar; se mitiga devolviendo el resultado del comando o leyendo del modelo de escritura en ese caso).

Para un CRUD sencillo, CQRS es sobreingeniería.

### Repreguntas frecuentes

**¿Cómo reconstruirías una vista de lectura corrupta o nueva?**

Reprocesando los eventos desde el principio (si se conservan en Kafka o en un event store) o con una carga inicial desde el servicio origen seguida del procesamiento de eventos desde ese punto. Por eso las proyecciones deben ser idempotentes y reconstruibles.

## P098 · ¿Qué es Event Sourcing? ¿Qué ventajas e inconvenientes tiene?

*Tema: Patrones · Nivel 6 · Avanzado*

En lugar de guardar el **estado actual** de una entidad, se guarda la **secuencia inmutable de eventos** que la han llevado a ese estado. El estado se reconstruye reproduciendo los eventos. Es como un extracto bancario: el saldo es la suma de los movimientos.

```text
Cuenta 42:
  CuentaAbierta(titular=Ana)
  DineroIngresado(100)
  DineroRetirado(30)
  DineroIngresado(50)
  -> saldo actual = 120
```

El **event store** es un log append-only; los eventos se publican para que otros servicios o proyecciones reaccionen.

**Ventajas**:

- **Auditoría completa** e histórico por diseño; se puede responder «¿cuál era el estado el día X?» (consultas temporales).
- Los eventos son la fuente de verdad y se publican de forma natural: resuelve la doble escritura sin outbox.
- Se pueden crear **nuevas proyecciones** a posteriori reprocesando el histórico.
- Encaja con dominios donde los eventos son el negocio (contabilidad, logística, reservas).

**Inconvenientes**:

- Complejidad y curva de aprendizaje elevadas.
- Las consultas requieren **CQRS** con proyecciones.
- **Evolución del esquema de eventos**: los eventos antiguos no se pueden modificar; se necesita *upcasting* o versionado.
- Rendimiento al reconstruir agregados con muchos eventos: se usan **snapshots**.
- Borrado de datos personales (RGPD) en un log inmutable: se usa *crypto-shredding* (cifrar los datos personales con una clave por usuario y destruir la clave).

Herramientas: Axon Framework, EventStoreDB, o implementaciones propias sobre PostgreSQL o Kafka. No debe aplicarse a todo el sistema, solo a los contextos donde aporta valor.

## P099 · ¿Cómo migrarías un monolito a microservicios? Explica el patrón Strangler Fig y la Anti-Corruption Layer.

*Tema: Migración · Nivel 6 · Avanzado*

Reescribir todo de golpe (*big bang*) es muy arriesgado: meses sin entregar valor, requisitos cambiantes y una migración final traumática. La estrategia recomendada es incremental.

**Strangler Fig** (Martin Fowler): se coloca una **fachada o proxy** (normalmente un API Gateway) delante del monolito. Se extrae una funcionalidad a un nuevo servicio y se desvía hacia él el tráfico de esa parte, mientras el resto sigue yendo al monolito. Poco a poco, el nuevo sistema «estrangula» al viejo hasta que puede retirarse.

Pasos habituales:

- Identificar un bounded context con límites claros, valor de negocio y bajo acoplamiento para empezar.
- Modularizar primero dentro del monolito si es necesario.
- Extraer el servicio junto con **sus datos** (lo más difícil): durante la transición puede requerir sincronización, CDC o escritura en ambos lados de forma temporal.
- Enrutar el tráfico gradualmente (canary, feature flags) comparando resultados, a veces en modo sombra (*shadow traffic*).
- Retirar el código antiguo.

**Anti-Corruption Layer (ACL)**: capa de traducción entre el nuevo servicio y el sistema heredado (u otro contexto con un modelo distinto). Impide que los conceptos, nombres y rarezas del modelo antiguo «contaminen» el modelo limpio del nuevo servicio. Se implementa como adaptadores, fachadas y traductores en la frontera.

Otros patrones relacionados: **Branch by Abstraction** (introducir una abstracción en el monolito para cambiar la implementación por debajo) y **Parallel Run** (ejecutar ambas implementaciones y comparar resultados).

## P100 · ¿Qué son el patrón Sidecar y un Service Mesh?

*Tema: Infraestructura · Nivel 6 · Avanzado*

**Sidecar**: se despliega un contenedor auxiliar junto al contenedor principal, en el mismo pod de Kubernetes, compartiendo red y ciclo de vida. Se encarga de funcionalidades transversales sin modificar la aplicación: proxy de red, recogida de logs, gestión de certificados, agentes de observabilidad.

**Service Mesh** (Istio, Linkerd, Consul Connect): una capa de infraestructura que gestiona la comunicación entre servicios, normalmente con un **proxy sidecar** (Envoy en Istio) en cada pod que intercepta todo el tráfico. Un plano de control configura esos proxies. Proporciona:

- **mTLS** automático entre servicios (cifrado y autenticación de identidad de servicio).
- Reintentos, timeouts y circuit breaking configurados de forma declarativa.
- Gestión de tráfico: canary, división por porcentaje, espejado de tráfico.
- Telemetría y trazas uniformes sin cambiar código.
- Políticas de autorización entre servicios.

Ventaja: las capacidades son homogéneas en cualquier lenguaje y salen del código de la aplicación. Inconvenientes: complejidad operativa, latencia y consumo de recursos adicionales. Existen variantes sin sidecar, como el **modo ambient** de Istio, que usa proxies por nodo.

Implicación para Spring: con un mesh, parte de lo que se haría con Spring Cloud o Resilience4j (reintentos, mTLS, discovery) se delega en la plataforma. Hay que evitar duplicar políticas en ambos niveles (por ejemplo, reintentos en la aplicación y en el mesh multiplicándose entre sí).

## P101 · ¿Cómo funciona la caché en Spring y qué patrones de caché conoces?

*Tema: Rendimiento · Nivel 6 · Avanzado*

Spring ofrece una **abstracción de caché** con anotaciones, independiente del proveedor (Caffeine en local, Redis o Hazelcast distribuidos). Se activa con `@EnableCaching`:

- `@Cacheable`: si el resultado está en caché lo devuelve sin ejecutar el método; si no, lo ejecuta y lo guarda.
- `@CachePut`: ejecuta siempre y actualiza la caché.
- `@CacheEvict`: elimina entradas (una o todas).

```java
@Cacheable(cacheNames = "productos", key = "#id", unless = "#result == null")
public ProductoDto obtener(Long id) { ... }

@CacheEvict(cacheNames = "productos", key = "#id")
public void actualizar(Long id, ActualizarProducto cmd) { ... }
```

Como son proxies, también les afecta la auto-invocación.

**Patrones de caché**:

- **Cache-aside** (lazy loading): la aplicación consulta la caché y, si no está, lee de la BD y la rellena. El más común (es lo que hace `@Cacheable`).
- **Read-through**: la propia caché sabe cargar desde la fuente.
- **Write-through**: se escribe en la caché y en la BD de forma síncrona.
- **Write-behind**: se escribe en la caché y se persiste de forma asíncrona (rápido, con riesgo de pérdida).

**Problemas típicos**:

- **Invalidación** y datos obsoletos: usar TTL siempre y, en microservicios, invalidar mediante eventos.
- **Cache stampede**: al expirar una clave muy usada, muchas peticiones van a la vez a la BD. Se mitiga con `@Cacheable(sync = true)`, bloqueos, expiración con jitter o refresco anticipado.
- Caché local con varias instancias: cada una tiene datos distintos. Para consistencia entre réplicas se usa caché distribuida o invalidación por eventos.
- Cachear objetos mutables o entidades JPA gestionadas.

### Repreguntas frecuentes

**¿Caché local o distribuida?**

La local (Caffeine) es extremadamente rápida y sin red, ideal para datos que cambian poco y toleran cierta inconsistencia entre instancias. La distribuida (Redis) comparte datos entre instancias y sobrevive a reinicios, a cambio de latencia de red y otra dependencia. Es común combinarlas en dos niveles.

## P102 · ¿Qué es la consistencia eventual? ¿Qué dicen los teoremas CAP y PACELC?

*Tema: Datos · Nivel 6 · Avanzado*

**Consistencia eventual**: si no hay nuevas actualizaciones, todas las réplicas o servicios acabarán convergiendo al mismo valor, pero durante un tiempo pueden mostrar datos distintos. Es la norma en microservicios con comunicación asíncrona: el pedido ya está confirmado, pero la vista de «mis pedidos» todavía no lo refleja durante unos milisegundos o segundos.

**Teorema CAP**: un sistema distribuido no puede garantizar simultáneamente **Consistencia** (todas las lecturas ven la última escritura), **Disponibilidad** (toda petición recibe respuesta) y **tolerancia a Particiones** (sigue funcionando aunque se pierdan mensajes entre nodos). Como en un sistema distribuido real las particiones de red ocurren, la elección práctica es: **durante una partición**, priorizar consistencia (CP, rechazar peticiones) o disponibilidad (AP, responder con datos posiblemente desactualizados).

**PACELC** amplía CAP: si hay Partición, elegir entre Disponibilidad y Consistencia; **Else** (en funcionamiento normal), elegir entre **Latencia** y Consistencia. Refleja que el coste de la consistencia fuerte (coordinación y réplicas síncronas) se paga siempre en latencia, no solo cuando hay fallos.

Consecuencias de diseño:

- Diseñar la UX para la consistencia eventual (estados «procesando», notificaciones cuando se completa).
- Identificar qué operaciones **sí** necesitan consistencia fuerte (no vender dos veces el último asiento) y resolverlas dentro de un único servicio o agregado.
- Detectar y corregir divergencias: idempotencia, reconciliaciones periódicas y eventos con versión.

## P103 · ¿Cómo se implementa la seguridad en una arquitectura de microservicios con Spring?

*Tema: Seguridad · Nivel 6 · Avanzado*

El estándar es **OAuth 2.0 + OpenID Connect** con **JWT**:

- Un **Authorization Server** o Identity Provider (Keycloak, Okta, Auth0, Entra ID, o **Spring Authorization Server**) autentica al usuario y emite tokens.
- Los clientes (SPA, móvil, BFF) obtienen un **access token** (flujo Authorization Code con PKCE para usuarios; Client Credentials para comunicación máquina a máquina).
- Cada microservicio actúa como **Resource Server**: valida el JWT localmente (firma con las claves públicas del endpoint JWKS, expiración, emisor y audiencia) sin llamar al servidor de identidad en cada petición.

```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: https://auth.miempresa.com/realms/tienda
```

```java
@PreAuthorize("hasAuthority('SCOPE_pedidos:write')")
public void cancelar(Long id) { ... }
```

Consideraciones clave:

- **Defensa en profundidad**: no confiar solo en el gateway. Cada servicio valida el token (modelo **zero trust**).
- **Propagación de identidad**: reenviar el token del usuario a los servicios llamados, o usar *token exchange* para obtener tokens con audiencia y permisos reducidos.
- **Service-to-service**: Client Credentials o **mTLS** (a menudo gestionado por el service mesh).
- Tokens de **vida corta** y refresh tokens; revocación limitada al ser JWT autocontenidos.
- No guardar tokens en `localStorage` en SPAs: mejor patrón **BFF** con cookies `HttpOnly`, `Secure` y `SameSite`.
- Autorización de grano fino (por propietario del recurso) dentro del servicio, no solo por roles.
- Gestión de secretos, validación de entrada, rate limiting y cabeceras de seguridad.

### Repreguntas frecuentes

**¿Cómo revocarías un JWT antes de que expire?**

Los JWT son autocontenidos, así que no se pueden revocar sin estado adicional. Opciones: tokens de vida muy corta con refresh tokens revocables, una lista de revocación consultada por los servicios (pierde parte de la ventaja del JWT) o tokens opacos con introspección para casos de alta seguridad.

## P104 · ¿Cómo se implementa rate limiting en un sistema distribuido? ¿Qué algoritmos existen?

*Tema: Resiliencia · Nivel 6 · Avanzado*

El rate limiting limita el número de peticiones que un cliente puede hacer en un periodo. Protege frente a abusos y picos, garantiza un reparto justo entre clientes y permite ofrecer planes con cuotas distintas.

Algoritmos principales:

- **Ventana fija**: contar peticiones por intervalo (por ejemplo, por minuto natural). Simple, pero permite ráfagas del doble del límite en el cambio de ventana.
- **Ventana deslizante** (log o contador): corrige ese efecto, con más coste de memoria o cálculo.
- **Token bucket** (cubo de fichas): un cubo con capacidad máxima que se rellena a un ritmo constante; cada petición consume una ficha. Permite ráfagas controladas hasta la capacidad del cubo y un ritmo medio sostenido. Es el más usado.
- **Leaky bucket** (cubo con fugas): las peticiones entran en una cola que se vacía a ritmo constante, lo que suaviza el tráfico de salida.

Con varias instancias del servicio, el contador debe ser **compartido**; si cada instancia cuenta por su cuenta, el límite real se multiplica por el número de réplicas. La solución habitual es **Redis**, con operaciones atómicas o scripts Lua.

Opciones en el ecosistema:

- **Spring Cloud Gateway**: filtro `RequestRateLimiter` con `RedisRateLimiter` (token bucket) y un `KeyResolver` que decide por qué se limita (usuario, API key, IP).
- **Bucket4j**: librería Java de token bucket con backends distribuidos (Redis, Hazelcast, bases de datos).
- **Resilience4j RateLimiter**: limita la tasa de llamadas **salientes** de una instancia, útil para respetar la cuota de una API de terceros.
- API gateways comerciales, Envoy o el service mesh.

```yaml
spring.cloud.gateway.server.webflux.routes:
  - id: api-publica
    uri: lb://catalogo-service
    predicates: [ "Path=/api/catalogo/**" ]
    filters:
      - name: RequestRateLimiter
        args:
          redis-rate-limiter.replenishRate: 10     # fichas por segundo
          redis-rate-limiter.burstCapacity: 20     # capacidad del cubo
          key-resolver: "#{@apiKeyResolver}"
```

La respuesta al superar el límite debe ser **429 Too Many Requests**, idealmente con la cabecera `Retry-After` y cabeceras informativas del límite restante, para que los clientes bien diseñados se adapten.

## P105 · ¿Qué es un bloqueo distribuido? ¿Qué riesgos tiene y qué son los fencing tokens?

*Tema: Concurrencia · Nivel 6 · Avanzado*

Un bloqueo distribuido garantiza que, entre varias instancias o procesos, solo uno ejecute una sección crítica a la vez: una tarea programada, el procesamiento de un recurso concreto o una operación que no admite concurrencia.

Implementaciones habituales:

- **Base de datos**: una fila de bloqueo con `SELECT ... FOR UPDATE`, los *advisory locks* de PostgreSQL o la librería **ShedLock** para tareas programadas.
- **Redis**: `SET clave valor NX PX 30000` (solo si no existe, con expiración). **Redisson** ofrece locks de alto nivel con renovación automática.
- **ZooKeeper** o **etcd**: sistemas de coordinación con garantías de consenso, más robustos.
- Spring Integration ofrece la abstracción `LockRegistry` con implementaciones para JDBC, Redis y ZooKeeper.

Los bloqueos distribuidos son mucho más delicados que los locales, porque en un sistema distribuido no se puede distinguir con certeza entre un proceso lento y uno muerto:

- El bloqueo necesita un **tiempo de expiración** para no quedarse bloqueado para siempre si su poseedor muere.
- Pero si el proceso que lo tiene sufre una pausa larga (una pausa de GC, una máquina virtual congelada o un problema de red), el bloqueo expira, otro proceso lo adquiere y **dos procesos creen tener el bloqueo a la vez**. El primero, al despertar, escribe datos obsoletos.

La solución son los **fencing tokens**: cada vez que se concede el bloqueo se entrega un número que crece monótonamente. El proceso incluye ese número en sus escrituras, y el recurso protegido (por ejemplo, la base de datos) **rechaza las escrituras con un token menor** que el último visto. Así, el proceso que despertó tarde es rechazado.

```sql
UPDATE recurso SET datos = :datos, token = :token
WHERE id = :id AND token < :token;
```

Recomendación práctica: antes de introducir un bloqueo distribuido, preguntarse si se puede evitar. A menudo basta con **bloqueo optimista** con `@Version`, restricciones de unicidad en la base de datos, operaciones atómicas o particionar el trabajo (en Kafka, todos los mensajes de una misma clave los procesa un único consumidor, lo que serializa el trabajo por entidad sin necesidad de bloqueos).

## P106 · ¿Qué tipos de eventos existen? ¿Qué diferencia hay entre event notification y event-carried state transfer?

*Tema: Eventos · Nivel 6 · Avanzado*

Conviene distinguir primero dos niveles:

- **Eventos de dominio**: hechos relevantes dentro de un bounded context, con el lenguaje de ese contexto (`LineaAnadidaAlPedido`). Pueden ser internos y cambiar con libertad.
- **Eventos de integración**: los que se publican hacia otros servicios. Forman parte del **contrato público**: deben diseñarse, versionarse y documentarse (AsyncAPI) con el mismo cuidado que una API REST. No conviene publicar sin más los eventos internos ni exponer el modelo de persistencia.

Martin Fowler describe varios estilos de uso de eventos:

- **Event notification**: el evento solo informa de que algo ocurrió, con el mínimo de datos (`PedidoConfirmado { pedidoId: 1001 }`). El consumidor que necesite más información la pide al emisor. Eventos ligeros y bajo acoplamiento de datos, pero se genera tráfico de vuelta al emisor y un acoplamiento temporal (si el emisor no está disponible, el consumidor no puede completar su trabajo).
- **Event-carried state transfer**: el evento incluye todos los datos que los consumidores pueden necesitar (`PedidoConfirmado { pedidoId, cliente, lineas, total, direccion }`). Los consumidores mantienen su propia copia local y no necesitan volver a preguntar, lo que mejora la autonomía y la disponibilidad. A cambio, los eventos son más grandes, hay datos duplicados y el esquema del evento es un contrato más amplio y difícil de evolucionar.
- **Event sourcing**: los eventos son la fuente de verdad del estado (ver la pregunta dedicada).

Otras decisiones de diseño de eventos:

- **Eventos de cambio de estado completo** (*snapshot* o *fat event*, con la entidad entera) frente a **eventos delta** (solo lo que cambió). Los primeros encajan con topics compactados de Kafka, que conservan el último estado por clave.
- Incluir metadatos estándar: identificador único del evento, tipo, versión del esquema, fecha, origen y trazas (el estándar **CloudEvents** define estos atributos).
- Nombrar los eventos en **pasado** y en términos de negocio (`PagoRechazado`, no `ActualizarTablaPagos`).

## P107 · ¿Qué es la multi-tenancy y qué estrategias existen para implementarla con Spring?

*Tema: Arquitectura · Nivel 6 · Avanzado*

Una aplicación **multi-tenant** atiende a varios clientes (*tenants*: empresas u organizaciones) con una misma instancia del software, manteniendo sus datos aislados. Es el modelo típico de las aplicaciones SaaS.

Estrategias de aislamiento de datos, de más a menos aislada:

- **Base de datos por tenant**: máximo aislamiento, copias de seguridad y restauraciones independientes, posibilidad de ubicar datos por región. Mayor coste y complejidad operativa (migraciones en cientos de bases de datos, pools de conexiones).
- **Esquema por tenant**: una base de datos con un esquema por cliente. Aislamiento intermedio.
- **Tabla compartida con columna discriminadora** (`tenant_id` en cada tabla): la más barata y sencilla de operar, pero el aislamiento depende de que **ninguna consulta** olvide filtrar por tenant. Se refuerza con la seguridad a nivel de fila de la base de datos (**Row-Level Security** de PostgreSQL) o con filtros automáticos del ORM.

Implementación en Spring:

- **Resolver el tenant** en cada petición: a partir del token JWT (una *claim* con el tenant), un subdominio o una cabecera, en un filtro que lo guarda en un contexto asociado a la petición.
- **Enrutar la conexión**: para base de datos o esquema por tenant, `AbstractRoutingDataSource` elige el `DataSource` según el tenant actual, o Hibernate con `MultiTenantConnectionProvider` y `CurrentTenantIdentifierResolver`.
- **Filtrar datos**: para tabla compartida, Hibernate 6 ofrece `@TenantId`, que añade automáticamente el filtro por tenant a todas las consultas y asigna el valor al insertar.

```java
@Entity
public class Factura {
    @Id @GeneratedValue Long id;
    @TenantId String tenant;   // Hibernate filtra y rellena automáticamente
    BigDecimal importe;
}
```

Otros aspectos: propagar el tenant a los hilos asíncronos y a los mensajes (como cabecera), claves de caché que incluyan el tenant (un error típico es servir datos cacheados de otro cliente), cuotas y rate limiting por tenant para evitar el problema del *vecino ruidoso*, y métricas y logs etiquetados por tenant.

## P108 · ¿Cómo se diseña una integración fiable con webhooks o con APIs de terceros?

*Tema: Integración · Nivel 6 · Avanzado*

Las integraciones con sistemas externos (pasarelas de pago, proveedores logísticos, CRM) son una fuente habitual de incidentes porque no controlas el otro lado.

**Como receptor de webhooks** (el tercero te avisa de un evento, por ejemplo «pago completado»):

- **Verificar la autenticidad**: comprobar la firma HMAC de la petición con el secreto compartido y rechazar peticiones antiguas (marca de tiempo) para evitar ataques de repetición.
- **Responder rápido**: guardar el evento (en una tabla o en una cola) y responder 2xx de inmediato; procesarlo después de forma asíncrona. Si el procesamiento es lento o falla, el proveedor reintentará y se acumularán duplicados.
- **Idempotencia**: los proveedores reintentan y pueden enviar el mismo evento varias veces. Deduplicar por el identificador del evento.
- **No confiar en el orden**: el evento «pago reembolsado» puede llegar antes que «pago completado». Usar máquinas de estado o marcas de tiempo del proveedor.
- **Reconciliación**: los webhooks pueden perderse. Un proceso periódico que consulta la API del proveedor para contrastar estados es la red de seguridad.

**Como emisor de webhooks** hacia tus clientes: firmar las peticiones, reintentar con backoff exponencial durante un periodo razonable, permitir consultar y reenviar eventos, y desactivar los endpoints que fallan de forma persistente.

**Como cliente de APIs de terceros**:

- Timeouts, reintentos solo en operaciones idempotentes (usando las *idempotency keys* que ofrezca el proveedor) y circuit breaker.
- Respetar los límites de tasa del proveedor (Resilience4j RateLimiter, gestión de 429 con `Retry-After`).
- **Anti-Corruption Layer**: traducir el modelo del proveedor al propio, para que un cambio o un cambio de proveedor no afecte al dominio.
- Guardar las peticiones y respuestas relevantes para auditoría y soporte, sin datos sensibles.
- Probar con **WireMock** simulando los casos de error, y con el entorno sandbox del proveedor en pruebas de extremo a extremo.
- Monitorizar la integración por separado (latencia, tasa de errores y cuotas) y alertar antes de que los clientes lo noten.

# Nivel 7 · Experto · Internals, rendimiento y diseño de sistemas

Preguntas de perfil senior: cómo arranca Spring por dentro, hilos virtuales, native images, diagnóstico en producción y ejercicios de diseño abiertos.

Este capítulo contiene 17 preguntas.

## P109 · ¿Qué ocurre internamente cuando se ejecuta SpringApplication.run()?

*Tema: Internals · Nivel 7 · Experto*

A grandes rasgos:

- **Deducir el tipo de aplicación** (servlet, reactiva o ninguna) según las clases presentes en el classpath.
- Cargar los `ApplicationContextInitializer` y `ApplicationListener` registrados y notificar `ApplicationStartingEvent`.
- **Preparar el `Environment`**: fuentes de propiedades (línea de comandos, variables de entorno, ficheros de configuración, perfiles activos) y notificar `ApplicationEnvironmentPreparedEvent`. Aquí actúan los `EnvironmentPostProcessor`.
- Imprimir el banner.
- **Crear el `ApplicationContext`** adecuado y aplicar los inicializadores.
- **Registrar las definiciones de beans**: la clase principal como fuente; después, procesamiento de `@Configuration`, component scan, `@Import` y la **autoconfiguración** (en ese orden, para que las condiciones `@ConditionalOnMissingBean` vean los beans del usuario).
- **Refresh del contexto**, el núcleo del arranque:
  - Ejecutar los `BeanFactoryPostProcessor` (modifican definiciones antes de crear beans; por ejemplo, la resolución de placeholders o el `ConfigurationClassPostProcessor`).
  - Registrar los `BeanPostProcessor`.
  - Crear el **servidor web embebido** (`onRefresh`).
  - **Instanciar todos los singletons** no perezosos: inyección de dependencias, callbacks de inicialización y creación de proxies AOP.
  - Arrancar los beans `SmartLifecycle` (entre ellos, el servidor web, que empieza a escuchar en el puerto).
- Notificar `ApplicationStartedEvent`, ejecutar los `CommandLineRunner` / `ApplicationRunner` y notificar `ApplicationReadyEvent`; el estado de readiness pasa a aceptar tráfico.

Para analizar arranques lentos: `BufferingApplicationStartup` con el endpoint `/actuator/startup`, que muestra cuánto tarda cada paso y cada bean.

> **Clave para la entrevista.** No hace falta memorizar todos los eventos; lo que importa es la secuencia Environment → definiciones → post-processors → singletons y proxies → servidor → runners → ready.

## P110 · ¿Qué son las dependencias circulares? ¿Por qué Spring Boot las prohíbe por defecto?

*Tema: Internals · Nivel 7 · Experto*

Una dependencia circular aparece cuando el bean A necesita a B y B necesita a A (directa o indirectamente a través de más beans).

- Con **inyección por constructor** es imposible de resolver: para crear A se necesita B ya creado y viceversa. Spring lanza `BeanCurrentlyInCreationException` al arrancar.
- Con inyección por **campo o setter**, Spring históricamente la resolvía mediante una caché de tres niveles que expone referencias «tempranas» a beans aún no inicializados por completo. Funciona, pero los beans se usan a medio construir, y la interacción con proxies AOP puede producir errores sutiles (inyectar el objeto original en lugar del proxy).

Desde **Spring Boot 2.6**, las referencias circulares están **prohibidas por defecto** (`spring.main.allow-circular-references=false`), porque casi siempre indican un **problema de diseño**: dos clases con responsabilidades mal repartidas.

Soluciones correctas:

- **Refactorizar**: extraer la lógica común a un tercer bean del que dependan ambos.
- Sustituir la llamada directa por **eventos** (A publica un evento, B lo escucha).
- Revisar si una de las dependencias realmente pertenece a otro servicio o capa.

Soluciones de emergencia: `@Lazy` en uno de los puntos de inyección (inyecta un proxy que resuelve el bean real en el primer uso) u `ObjectProvider<T>`. Reactivar `allow-circular-references` debería ser el último recurso.

## P111 · ¿Qué es Spring WebFlux? ¿Cuándo elegirlo frente a Spring MVC?

*Tema: Reactivo · Nivel 7 · Experto*

**Spring MVC** usa el modelo **un hilo por petición**: cada petición ocupa un hilo del pool del servidor (Tomcat, 200 hilos por defecto) durante toda su duración, incluidas las esperas de I/O (base de datos, llamadas HTTP). Con muchas peticiones lentas y concurrentes, se agotan los hilos.

**Spring WebFlux** es el stack **reactivo y no bloqueante**, basado en **Project Reactor** (`Mono` para 0..1 elementos, `Flux` para 0..N) y normalmente sobre Netty. Pocos hilos (del orden del número de núcleos, en un *event loop*) atienden muchas peticiones porque nunca se bloquean: registran callbacks y se liberan mientras esperan la I/O. También ofrece **backpressure** (el consumidor controla el ritmo del productor) y streaming (Server-Sent Events).

```java
@GetMapping("/pedidos/{id}")
public Mono<PedidoDto> obtener(@PathVariable Long id) {
    return pedidos.findById(id)                       // R2DBC, no bloqueante
        .zipWith(clientes.obtener(id))                // llamada HTTP en paralelo
        .map(t -> mapper.toDto(t.getT1(), t.getT2()));
}
```

Requisito crítico: **toda la cadena debe ser no bloqueante**. Una sola llamada bloqueante (JDBC, JPA, un cliente HTTP síncrono) en el event loop degrada todo el servidor. Por eso se usa R2DBC en lugar de JPA, WebClient, drivers reactivos de Mongo o Redis, etc. BlockHound ayuda a detectarlo en tests.

**Cuándo elegirlo**: alta concurrencia con mucha I/O, streaming, gateways (Spring Cloud Gateway es reactivo), composición de muchas llamadas remotas.
**Cuándo no**: la mayoría de CRUD con JPA, equipos sin experiencia reactiva (curva de aprendizaje, depuración y stack traces más difíciles). Con la llegada de los **hilos virtuales**, gran parte de las ventajas de escalabilidad se obtienen con el modelo imperativo de MVC, así que WebFlux queda para los casos donde se necesitan streaming y backpressure.

### Repreguntas frecuentes

**¿Qué harías si necesitas llamar a una librería bloqueante desde WebFlux?**

Envolver la llamada con Mono.fromCallable(...).subscribeOn(Schedulers.boundedElastic()), que la ejecuta en un pool de hilos separado para no bloquear el event loop. Si ocurre en muchos sitios, probablemente WebFlux no es la opción adecuada para ese servicio.

## P112 · ¿Qué son los hilos virtuales de Java 21 y cómo se usan en Spring Boot?

*Tema: Concurrencia · Nivel 7 · Experto*

Los **hilos virtuales** (Project Loom, estables desde Java 21) son hilos ligeros gestionados por la JVM, no por el sistema operativo. Cuando un hilo virtual se bloquea en una operación de I/O, la JVM lo **desmonta** de su hilo portador (*carrier*, un hilo de plataforma) y este queda libre para ejecutar otro hilo virtual. Se pueden crear millones; crear uno cuesta muy poco.

Consecuencia: se obtiene la escalabilidad del modelo no bloqueante **manteniendo el código imperativo y bloqueante** de siempre (JDBC, RestClient, stack traces legibles), sin la complejidad reactiva.

En Spring Boot 3.2+ se activan con una propiedad:

```yaml
spring:
  threads:
    virtual:
      enabled: true
```

Así Tomcat atiende cada petición en un hilo virtual y también se usan en `@Async`, listeners de Kafka y RabbitMQ, tareas programadas, etc.

Consideraciones:

- **Pinning**: en Java 21 y anteriores, un hilo virtual que se bloquea dentro de un bloque `synchronized` queda anclado a su portador y no lo libera. Se recomendaba sustituir `synchronized` por `ReentrantLock` en rutas calientes. **Java 24 (JEP 491)** eliminó este problema para `synchronized`. Se diagnostica con JFR (evento `jdk.VirtualThreadPinned`).
- **No son más rápidos**, solo permiten más concurrencia en cargas **limitadas por I/O**. En cargas de CPU no aportan.
- **Los recursos siguen siendo finitos**: si miles de hilos virtuales compiten por un pool de 10 conexiones de base de datos, el cuello de botella se traslada allí. Puede hacer falta limitar la concurrencia con semáforos.
- No se deben agrupar en pools (se crean por tarea) y hay que tener cuidado con `ThreadLocal` de gran tamaño; en Java 25 se estabilizaron los **Scoped Values** como alternativa.

> **Clave para la entrevista.** Mencionar el pinning, su resolución en Java 24 y que el cuello de botella se desplaza al pool de conexiones demuestra conocimiento real y actualizado.

### Repreguntas frecuentes

**¿Los hilos virtuales hacen innecesario WebFlux?**

Para la mayoría de servicios de negocio basados en peticiones y respuestas, en gran medida sí: se obtiene alta concurrencia con código imperativo. WebFlux sigue teniendo sentido para streaming, backpressure y composición reactiva compleja de flujos de datos.

## P113 · ¿Qué son las imágenes nativas con GraalVM y el procesamiento AOT en Spring Boot?

*Tema: Rendimiento · Nivel 7 · Experto*

**GraalVM Native Image** compila la aplicación Java por adelantado (*ahead-of-time*) a un **ejecutable nativo** para una plataforma concreta, sin JVM en tiempo de ejecución. Realiza un análisis estático de alcanzabilidad desde el `main` e incluye solo el código utilizado (asunción de **mundo cerrado**).

Ventajas:

- **Arranque en decenas de milisegundos** frente a segundos.
- Menor consumo de memoria.
- Ideal para serverless, escalado a cero, CLI y escalado muy rápido.

Inconvenientes:

- Compilación **lenta** (minutos) y con mucha memoria.
- Reflexión, proxies dinámicos, recursos y serialización deben conocerse en la compilación (*reachability metadata*); librerías que no los declaran pueden fallar.
- El rendimiento máximo sostenido (*throughput*) puede ser inferior al de la JVM con JIT tras el calentamiento (mejora con PGO).
- Herramientas de depuración y observabilidad de la JVM más limitadas.
- La configuración de beans queda fijada en la compilación: no se pueden cambiar perfiles que alteren beans ni condiciones `@ConditionalOnProperty` en tiempo de ejecución.

Spring Boot 3 incluye soporte de primera clase gracias al **motor AOT de Spring**: en tiempo de build evalúa las condiciones, genera código fuente que registra las definiciones de beans sin reflexión y produce los ficheros de *hints* para GraalVM. Se construye con `mvn -Pnative native:compile` o como imagen con buildpacks.

Alternativas en la JVM para mejorar el arranque: **CDS / AppCDS** (Class Data Sharing), soportado por Boot 3.3+, **Project Leyden** (AOT cache, a partir de Java 24/25) y **CRaC** (checkpoint/restore de una JVM ya caliente).

## P114 · ¿Cómo se dimensiona el pool de conexiones a base de datos? ¿Qué hay que vigilar en HikariCP?

*Tema: Rendimiento · Nivel 7 · Experto*

HikariCP es el pool por defecto en Spring Boot. Un error común es pensar que un pool más grande significa más rendimiento: la base de datos tiene un número limitado de núcleos y discos, y demasiadas conexiones concurrentes provocan cambios de contexto y contención de bloqueos que **reducen** el rendimiento.

La recomendación de partida de la documentación de HikariCP (basada en PostgreSQL) es `conexiones = (núcleos * 2) + discos efectivos`; en la práctica, pools pequeños (10-20) suelen rendir mejor que pools de 100. Además, hay que multiplicar por el **número de instancias**: 20 conexiones × 15 pods = 300 conexiones contra la base de datos, que puede superar su `max_connections`. En ese caso se usa un proxy de conexiones como PgBouncer.

Parámetros clave:

- `maximum-pool-size` y `minimum-idle` (para pools de tamaño fijo se recomiendan iguales).
- `connection-timeout`: cuánto espera un hilo por una conexión libre antes de fallar (30 s por defecto; conviene reducirlo para fallar rápido).
- `max-lifetime`: debe ser **menor** que el timeout de conexión de la base de datos o de firewalls intermedios.
- `leak-detection-threshold`: avisa si una conexión se retiene demasiado tiempo (fugas o transacciones largas).

Métricas a vigilar con Micrometer: `hikaricp.connections.active`, `.pending` (hilos esperando conexión: señal clara de saturación), `.acquire` (tiempo de obtención) y `.usage` (tiempo que se retiene cada conexión).

Causas típicas de agotamiento del pool: transacciones que incluyen llamadas HTTP remotas (la conexión queda retenida mientras se espera a otro servicio), Open Session In View activo, consultas lentas y, con hilos virtuales, un exceso de concurrencia que antes limitaba el pool de hilos de Tomcat.

> **Clave para la entrevista.** La idea de «no hagas llamadas remotas dentro de una transacción» es una de las recomendaciones de rendimiento más valiosas que puedes dar.

### Repreguntas frecuentes

**¿Qué harías si ves conexiones pendientes constantemente en el pool?**

Antes de ampliar el pool, averiguar por qué se retienen las conexiones: consultas lentas, transacciones largas, llamadas remotas dentro de transacciones u Open Session In View. Ampliar el pool sin resolver la causa suele trasladar el problema a la base de datos.

## P115 · ¿Cómo crearías tu propio starter de Spring Boot?

*Tema: Extensibilidad · Nivel 7 · Experto*

Un starter propio sirve para compartir configuración transversal entre los microservicios de una empresa: cliente de auditoría, configuración de seguridad común, logging estructurado, cabeceras de correlación, clientes de APIs internas...

Estructura recomendada en dos módulos:

- `miempresa-auditoria-spring-boot-autoconfigure`: contiene la lógica de autoconfiguración.
- `miempresa-auditoria-spring-boot-starter`: módulo vacío que solo agrega dependencias (el autoconfigure y las librerías necesarias).

La autoconfiguración:

```java
@AutoConfiguration(after = JacksonAutoConfiguration.class)
@ConditionalOnClass(AuditoriaClient.class)
@ConditionalOnProperty(prefix = "miempresa.auditoria", name = "enabled",
                       havingValue = "true", matchIfMissing = true)
@EnableConfigurationProperties(AuditoriaProperties.class)
public class AuditoriaAutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    AuditoriaClient auditoriaClient(AuditoriaProperties props, RestClient.Builder builder) {
        return new AuditoriaClient(builder.baseUrl(props.url()).build());
    }
}
```

Y se registra en `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` con el nombre completo de la clase.

Buenas prácticas:

- Usar siempre `@ConditionalOnMissingBean` para que el usuario pueda sobrescribir cualquier bean.
- Propiedades con prefijo propio y metadatos (`spring-boot-configuration-processor`) para autocompletado.
- No usar component scan dentro de la autoconfiguración.
- Probarla con `ApplicationContextRunner`, que permite verificar rápidamente qué beans se crean según clases, propiedades y beans existentes.

## P116 · Pregunta de diseño: diseña el backend de pedidos de un e-commerce con microservicios.

*Tema: Diseño de sistemas · Nivel 7 · Experto*

En estas preguntas abiertas se valora el **proceso** más que la solución. Un enfoque ordenado:

**1. Aclarar requisitos**: volumen (pedidos por segundo, picos como Black Friday), requisitos de consistencia (¿se puede vender más stock del que hay?), latencia esperada, pasarelas de pago, notificaciones, internacionalización.

**2. Identificar bounded contexts y servicios**: Catálogo, Inventario, Carrito, Pedidos, Pagos, Envíos, Notificaciones, Clientes. Cada uno con su base de datos.

**3. Flujo principal** (Saga orquestada por el servicio de Pedidos):

- El cliente confirma el carrito: `POST /pedidos` con **Idempotency-Key**. Se crea el pedido en estado `PENDIENTE` y se responde `202 Accepted` con el identificador.
- Inventario **reserva stock** (con reserva temporal que expira).
- Pagos autoriza el cobro con la pasarela externa (a menudo asíncrono vía webhook, también idempotente).
- Si todo va bien, el pedido pasa a `CONFIRMADO` y se publica `PedidoConfirmado`; Envíos y Notificaciones reaccionan.
- Si el pago falla o expira: compensación (liberar stock, pedido `CANCELADO`).

**4. Fiabilidad**: Outbox en cada servicio que publica eventos, consumidores idempotentes, DLQ, reintentos con backoff y timeouts en todas las llamadas síncronas.

**5. Datos y consultas**: «Mis pedidos» como vista CQRS alimentada por eventos; el catálogo muy leído detrás de caché y CDN; búsqueda en Elasticsearch/OpenSearch.

**6. Escalabilidad y picos**: servicios stateless con autoescalado, colas para absorber picos, rate limiting en el gateway, particionado de Kafka por `pedidoId`. Para productos muy demandados, gestión de stock con operaciones atómicas o reservas en Redis.

**7. Transversal**: API Gateway con OAuth2, observabilidad completa (trazas por pedido), despliegues canary y pruebas de contrato entre servicios.

**8. Trade-offs explícitos**: consistencia eventual en la visualización del pedido; posibilidad de sobreventa mínima frente a bloquear stock de forma estricta; orquestación frente a coreografía.

> **Clave para la entrevista.** Piensa en voz alta, dibuja, pregunta por los requisitos antes de diseñar y nombra explícitamente los trade-offs. Un diseño «perfecto» sin preguntas previas suele puntuar peor que uno razonado.

## P117 · Un microservicio en producción empieza a responder muy lento. ¿Cómo lo investigas?

*Tema: Operación · Nivel 7 · Experto*

Enfoque sistemático, de lo general a lo concreto:

**1. Acotar el impacto con métricas**: ¿desde cuándo? ¿todas las instancias o solo algunas? ¿todos los endpoints o uno? ¿coincide con un despliegue, un cambio de configuración o un pico de tráfico? Revisar latencias por percentiles (p50, p95, p99), tasa de errores y throughput.

**2. Trazas distribuidas**: localizar peticiones lentas y ver en qué span se va el tiempo: ¿consulta a base de datos, llamada a otro servicio, espera por el pool de conexiones, tiempo en el propio código?

**3. Recursos de la aplicación**:

- **CPU y GC**: métricas de la JVM (`jvm.gc.pause`, uso de heap). Pausas largas o GC continuo pueden indicar fugas de memoria o un heap mal dimensionado; revisar si el contenedor está limitado por *CPU throttling*.
- **Hilos**: un *thread dump* (`/actuator/threaddump` o `jstack`) muestra hilos bloqueados, esperando locks o esperando conexiones del pool. Varios dumps espaciados unos segundos revelan patrones.
- **Pools**: conexiones de BD pendientes (`hikaricp.connections.pending`), pool de hilos del servidor saturado, pools de clientes HTTP.

**4. Dependencias**: base de datos (consultas lentas, planes de ejecución, bloqueos, índices faltantes tras un crecimiento de datos), servicios externos lentos sin timeouts adecuados, broker con lag de consumidores.

**5. Profiling**: **Java Flight Recorder** (bajo overhead, apto para producción) o async-profiler para obtener flame graphs de CPU, asignaciones y locks. Un *heap dump* analizado con Eclipse MAT si se sospecha una fuga.

**6. Mitigar antes de resolver**: rollback del último despliegue, escalar horizontalmente, activar circuit breakers o degradar funcionalidades, y después hacer el análisis de causa raíz con un **postmortem sin culpables**, añadiendo alertas o tests que lo habrían detectado antes.

### Repreguntas frecuentes

**¿Qué información pedirías antes de tocar nada?**

Desde cuándo ocurre, a quién afecta (todos los clientes o algunos, todos los endpoints o uno), qué ha cambiado recientemente (despliegues, configuración, tráfico, datos) y si hay otros servicios afectados. Estas preguntas acotan el problema más rápido que cualquier herramienta.

## P118 · ¿Qué estrategias de despliegue conoces y cómo se gestionan los cambios de base de datos sin downtime?

*Tema: Despliegue · Nivel 7 · Experto*

Estrategias de despliegue:

- **Rolling update**: se sustituyen instancias gradualmente (por defecto en Kubernetes). Durante un tiempo conviven la versión antigua y la nueva, así que **deben ser compatibles**.
- **Blue/Green**: dos entornos completos; se despliega en el inactivo y se conmuta el tráfico de golpe. Rollback inmediato, pero duplica recursos.
- **Canary**: se envía un pequeño porcentaje del tráfico a la nueva versión, se comparan métricas (errores, latencia) y se amplía progresivamente o se revierte automáticamente (Argo Rollouts, Flagger, service mesh).
- **Feature flags**: se despliega el código desactivado y se activa por configuración, para grupos de usuarios concretos (desacopla *deploy* de *release*). Herramientas: Unleash, LaunchDarkly, OpenFeature.
- **Shadow / dark launch**: la nueva versión recibe una copia del tráfico real sin afectar a las respuestas.

**Cambios de base de datos sin downtime**: como conviven dos versiones del código, cada migración debe ser compatible con la versión anterior y con la siguiente. Se usa el patrón **expand/contract** (o *parallel change*). Ejemplo, renombrar la columna `nombre` a `nombre_completo`:

- **Expand**: añadir la nueva columna (nullable) y desplegar código que **escribe en ambas** y lee de la antigua.
- **Migrar datos**: copiar los valores existentes en lotes, sin bloqueos largos.
- Desplegar código que **lee de la nueva** (y sigue escribiendo en ambas).
- Desplegar código que solo usa la nueva.
- **Contract**: en una versión posterior, eliminar la columna antigua.

Precauciones: evitar operaciones que bloquean tablas grandes (crear índices de forma concurrente, añadir columnas con valores por defecto con cuidado según la base de datos) y probar las migraciones con volúmenes de datos realistas.

## P119 · ¿Qué anti-patrones de microservicios conoces?

*Tema: Anti-patrones · Nivel 7 · Experto*

- **Monolito distribuido**: servicios que deben desplegarse juntos, que comparten librerías de dominio o que no funcionan sin los demás. Se paga el coste de lo distribuido sin obtener independencia.
- **Base de datos compartida**: varios servicios leyendo y escribiendo las mismas tablas. Acoplamiento total a nivel de esquema.
- **Servicios demasiado finos** (*nanoservicios*) o **servicios entidad** (uno por tabla): obligan a orquestar decenas de llamadas para cualquier operación.
- **Comunicación excesiva** (*chatty*) y **cadenas síncronas largas**: A llama a B, que llama a C, que llama a D. La latencia se suma y la disponibilidad se multiplica a la baja.
- **Librería compartida de dominio** (el «common.jar» con entidades de todos): acopla los ciclos de despliegue. Compartir solo utilidades técnicas estables, nunca el modelo de dominio.
- **Transacciones distribuidas por todas partes**: señal de límites mal trazados.
- **Falta de observabilidad**: no poder seguir una petición entre servicios convierte cualquier incidente en una búsqueda a ciegas.
- **Sin timeouts ni resiliencia**: un servicio lento tumba a todos en cascada.
- **Entidades JPA en los contratos** o eventos que exponen el modelo interno.
- **Adoptar microservicios por moda**, con un equipo pequeño y un dominio poco conocido.
- **El gateway o el orquestador «dios»**: acumulan lógica de negocio de todos los dominios.
- **Versionar todo a la vez** o romper contratos sin periodo de transición.

Muchos de estos problemas se resumen en una idea: los límites entre servicios deberían seguir los límites del negocio, y cada servicio debería poder evolucionar, desplegarse y fallar de forma independiente.

> **Clave para la entrevista.** Cerrar una entrevista demostrando que conoces los errores (y quizá contando uno que viviste y cómo se resolvió) transmite experiencia más que cualquier definición.

## P120 · ¿Cómo se ajusta la JVM de una aplicación Spring Boot que se ejecuta en contenedores? ¿Qué recolector de basura elegir?

*Tema: JVM · Nivel 7 · Experto*

Desde Java 10 (y backports en Java 8u191), la JVM **detecta los límites del contenedor** (cgroups) para calcular la memoria y el número de CPU disponibles. Aun así, los valores por defecto no siempre son adecuados.

**Memoria**:

- Por defecto, el heap máximo es solo el **25 % de la memoria** del contenedor, demasiado conservador para un contenedor que solo ejecuta la JVM. Se ajusta con `-XX:MaxRAMPercentage=70` o `75`, en lugar de fijar `-Xmx`, para que se adapte si cambia el límite.
- La JVM usa memoria **fuera del heap**: metaspace (clases), code cache (código JIT), pilas de los hilos, buffers directos (Netty, NIO) y el propio GC. Si heap + no-heap superan el límite del contenedor, el kernel mata el proceso (**OOMKilled**, código de salida 137) sin que aparezca ningún `OutOfMemoryError` en el log. De ahí que no se asigne el 100 % de la memoria al heap.
- `-XX:+HeapDumpOnOutOfMemoryError` con una ruta en un volumen persistente para poder analizar los errores de memoria, y `-XX:+ExitOnOutOfMemoryError` para que el orquestador reinicie el contenedor en lugar de dejarlo en un estado degradado.

**CPU**: la JVM dimensiona los hilos del GC, el JIT y el `ForkJoinPool` común según las CPU que detecta. Con límites de CPU muy bajos (menos de 1 CPU), el arranque de Spring Boot es muy lento y aparece *CPU throttling*. Muchas organizaciones fijan `requests` de CPU y evitan `limits` estrictos para servicios Java, o reservan más CPU durante el arranque.

**Recolectores de basura**:

- **G1** (por defecto en la mayoría de configuraciones): buen equilibrio entre rendimiento y pausas, adecuado para la mayoría de servicios. La JVM elige **Serial GC** automáticamente si detecta menos de 2 CPU o menos de 1792 MB, algo habitual en contenedores pequeños y que puede sorprender.
- **ZGC** (generacional desde Java 21): pausas por debajo del milisegundo independientemente del tamaño del heap, a cambio de algo más de consumo de CPU y memoria. Adecuado para servicios sensibles a la latencia o heaps grandes.
- **Shenandoah**: objetivo similar a ZGC (baja latencia).
- **Parallel GC**: máximo throughput, pausas más largas; útil en procesos batch.

Lo importante es **medir** antes de ajustar: métricas de GC de Micrometer (`jvm.gc.pause`), logs de GC (`-Xlog:gc*`) y Java Flight Recorder. La mayoría de problemas de memoria son fugas en el código (cachés sin límite, colecciones que crecen) y no se arreglan cambiando parámetros.

> **Clave para la entrevista.** Explicar por qué un contenedor Java puede morir por OOMKilled sin ningún OutOfMemoryError en los logs es un clásico en entrevistas de perfil con componente DevOps.

## P121 · ¿Qué es Spring Modulith y cómo ayuda a construir un monolito modular?

*Tema: Arquitectura · Nivel 7 · Experto*

Un **monolito modular** es una aplicación desplegada como una sola unidad, pero organizada internamente en módulos con **límites claros**, cada uno con su API pública y sus detalles internos ocultos, que se comunican preferentemente mediante eventos. Ofrece gran parte de los beneficios de diseño de los microservicios (cohesión, bajo acoplamiento, equipos por módulo) sin la complejidad distribuida, y deja preparado el camino para extraer servicios si alguna vez hace falta.

El problema es que, sin herramientas, los límites se erosionan: cualquier clase pública puede usarse desde cualquier sitio. **Spring Modulith** aporta:

- **Convención de módulos**: cada paquete directo bajo el paquete de la aplicación es un módulo. Las clases del paquete raíz del módulo son su API; los subpaquetes son internos.
- **Verificación de la estructura** con un test que falla si un módulo accede a detalles internos de otro o si existen dependencias cíclicas entre módulos:

```java
class ModularidadTest {
    ApplicationModules modules = ApplicationModules.of(TiendaApplication.class);

    @Test
    void verificaLaEstructura() {
        modules.verify();
    }

    @Test
    void generaDocumentacion() {
        new Documenter(modules).writeDocumentation();   // diagramas C4 / PlantUML
    }
}
```

- **Comunicación por eventos** entre módulos con `@ApplicationModuleListener` (un listener transaccional y asíncrono que se ejecuta tras el commit), junto con un **registro de publicación de eventos** persistente: los eventos se guardan en la base de datos dentro de la transacción y se marcan como completados al procesarse, de modo que si la aplicación cae se pueden reprocesar al arrancar (un outbox integrado).
- **Externalización de eventos**: con `@Externalized`, un evento interno se publica también en Kafka, RabbitMQ u otros brokers, el primer paso para que un módulo pueda convertirse en servicio.
- **Tests de integración por módulo** con `@ApplicationModuleTest`, que arrancan solo un módulo (y opcionalmente sus dependencias), y la API `Scenario` para probar flujos basados en eventos.
- **Observabilidad por módulo**: trazas que muestran las interacciones entre módulos.

Es una respuesta muy sólida a la pregunta «¿microservicios desde el principio?»: se puede empezar con un monolito modular bien delimitado y verificado, y extraer un módulo a un servicio cuando haya una razón concreta (escalado independiente, otro equipo, requisitos distintos).

## P122 · Pregunta de diseño: un sistema de venta de entradas para conciertos con picos de demanda extremos.

*Tema: Diseño de sistemas · Nivel 7 · Experto*

Es una pregunta clásica porque combina **alta concurrencia sobre un recurso escaso** con **picos de tráfico** de miles de veces el nivel normal en el momento en que se abre la venta.

**Requisitos a aclarar**: número de localidades (¿50.000 asientos numerados o entrada general?), usuarios concurrentes esperados, tiempo máximo para completar la compra, límite de entradas por persona, y la regla de oro: **no vender la misma localidad dos veces**.

**Componentes principales**:

- **Sala de espera virtual** (*waiting room*): cuando se abre la venta, los usuarios entran en una cola y se les da acceso por turnos a un ritmo que el sistema puede absorber. Es la clave para transformar un pico imposible en un flujo controlado. Puede implementarse en el borde (CDN) o con Redis (conjuntos ordenados por turno y un token de acceso firmado).
- **Catálogo y disponibilidad**: la información del evento y del recinto es casi estática y se sirve desde caché y CDN. El mapa de disponibilidad se muestra con datos ligeramente desactualizados (consistencia eventual aceptable para mostrar).
- **Reserva temporal de localidades**: al elegir asientos, se crea una **retención** con expiración (por ejemplo, 10 minutos) mientras el usuario paga. La operación debe ser atómica. Opciones: una actualización condicional en la base de datos (`UPDATE asiento SET estado='RETENIDO', hasta=... WHERE id=? AND estado='LIBRE'`, comprobando las filas afectadas), una restricción de unicidad o, para rendimiento extremo, operaciones atómicas en Redis (scripts Lua) con persistencia posterior.
- **Pago**: saga con la pasarela externa; confirmación de la entrada solo tras el pago; idempotencia en el webhook de la pasarela; si la retención expira sin pago, las localidades vuelven a estar disponibles.
- **Emisión y envío** de entradas de forma asíncrona (colas), con códigos QR firmados para evitar falsificaciones.

**Escalabilidad y protección**:

- Servicios stateless con autoescalado **programado con antelación** (el pico es predecible: se sabe cuándo se abre la venta), pruebas de carga previas al evento.
- Rate limiting por usuario e IP, protección anti-bots (CAPTCHA, detección de comportamiento), límite de entradas por cuenta.
- Aislamiento: que el pico de un evento no degrade el resto de la plataforma (bulkheads, recursos dedicados).

**Trade-offs a explicitar**: equidad (orden de llegada) frente a rendimiento; bloqueo estricto por asiento frente a entrada general con contador atómico (mucho más sencillo); consistencia fuerte solo en la reserva y consistencia eventual en todo lo demás.

> **Clave para la entrevista.** Lo que se valora es identificar el punto crítico (la reserva atómica) y proteger el sistema del pico (la sala de espera), no dibujar muchas cajas.

## P123 · Pregunta de diseño: un servicio de notificaciones multicanal (email, SMS, push).

*Tema: Diseño de sistemas · Nivel 7 · Experto*

Muchos servicios necesitan notificar a los usuarios (pedido confirmado, envío en camino, restablecimiento de contraseña). Centralizarlo en un servicio evita duplicar integraciones y permite gestionar preferencias, plantillas y límites en un único sitio.

**Requisitos**: canales (email, SMS, push, in-app), volumen (picos de campañas masivas frente a notificaciones transaccionales), prioridades (un código de verificación no puede esperar detrás de un millón de emails de marketing), preferencias de usuario y consentimiento, plantillas multiidioma, seguimiento del estado de entrega.

**Diseño**:

- **Entrada asíncrona**: los servicios publican eventos (`PedidoConfirmado`) o comandos (`EnviarNotificacion`) en Kafka o una cola. Opcionalmente, una API REST para envíos directos, que responde 202 y encola.
- **Procesado**: el servicio resuelve el destinatario, consulta sus **preferencias** (canales activos, horario de no molestar, idioma, bajas de marketing), renderiza la **plantilla** y genera una notificación por canal.
- **Colas separadas por canal y por prioridad**: la saturación de un proveedor de SMS no afecta al email, y lo transaccional no queda detrás de las campañas. Es un ejemplo del patrón bulkhead.
- **Workers por canal** que llaman a los proveedores externos (servicios de email transaccional, SMS, APNs y FCM para push), cada uno con su circuit breaker, límites de tasa, reintentos con backoff y, si es crítico, un **proveedor alternativo** (*failover*).
- **Idempotencia**: una clave de deduplicación por notificación para no enviar dos veces el mismo SMS cuando hay reintentos (muy visible y molesto para el usuario).
- **Estado y trazabilidad**: registrar cada notificación con sus estados (pendiente, enviada, entregada, rebotada, fallida), actualizados mediante los webhooks de los proveedores. Útil para soporte («¿le llegó el email al cliente?»), para detectar direcciones inválidas y para métricas.
- **Dead letter queue** para las notificaciones que agotan los reintentos, con alertas y posibilidad de reprocesarlas.

**Aspectos transversales**: cumplimiento normativo (consentimiento, bajas, datos personales en los registros), control de costes por canal (el SMS es caro), límites por usuario para no saturarlo, y observabilidad por canal y proveedor (tasa de entrega, latencia, errores).

## P124 · ¿Cómo garantizarías la calidad de un sistema de microservicios a lo largo de todo su ciclo de vida?

*Tema: Calidad · Nivel 7 · Experto*

La calidad en un sistema distribuido no se consigue solo con tests al final: se construye en cada fase (*shift-left*) y se verifica también en producción (*shift-right*).

**Durante el desarrollo**:

- Criterios de aceptación claros y verificables antes de programar; ejemplos concretos con **BDD** (escenarios Given/When/Then con Cucumber u otras herramientas) cuando negocio y desarrollo necesitan un lenguaje común.
- TDD o, como mínimo, tests escritos junto al código.
- Revisiones de código con foco en diseño, seguridad y testabilidad.

**En el pipeline** (automatizado y rápido):

- Pirámide de tests: unitarios, integración con Testcontainers, contrato (Pact o Spring Cloud Contract) y unos pocos end-to-end sobre flujos críticos.
- **Quality gates**: cobertura del código nuevo, análisis estático, duplicación y deuda técnica (SonarQube), reglas de arquitectura (ArchUnit), vulnerabilidades en dependencias e imágenes.
- **Mutation testing** (PIT): modifica el código y comprueba si algún test falla. Mide la calidad real de los tests, no solo si se ejecutan las líneas.
- Tests de rendimiento automatizados para detectar regresiones.

**Antes y durante el despliegue**:

- Entornos efímeros por pull request para validar cambios de forma aislada.
- Smoke tests tras cada despliegue y despliegues canary con análisis automático de métricas.
- Feature flags para activar funcionalidad de forma gradual.

**En producción**:

- Observabilidad con **SLO** y alertas basadas en la experiencia del usuario (tasa de errores y latencia de los endpoints importantes).
- **Monitorización sintética**: pruebas automáticas que ejecutan flujos críticos contra producción periódicamente.
- **Chaos engineering**: introducir fallos controlados (latencia, caída de instancias o de dependencias) para verificar que la resiliencia funciona realmente.
- Postmortems sin culpables y acciones de mejora: cada incidente debería traducirse en un test, una alerta o un cambio de diseño.

**Gestión de datos de prueba**: datos sintéticos o anonimizados (nunca datos personales reales de producción), generados de forma reproducible, y aislamiento entre tests para evitar dependencias de orden.

Métricas del conjunto: las **métricas DORA** (frecuencia de despliegue, tiempo de entrega de cambios, tasa de fallos de los cambios y tiempo de recuperación) relacionan la calidad con la capacidad de entrega del equipo.

> **Clave para la entrevista.** Si la posición combina desarrollo y QA, esta es la pregunta donde puedes demostrar una visión completa: calidad como proceso, no como una fase al final.

## P125 · ¿Cómo planificarías y ejecutarías pruebas de rendimiento para un microservicio?

*Tema: Rendimiento · Nivel 7 · Experto*

**1. Definir objetivos** antes de ejecutar nada: sin objetivos, una prueba de rendimiento solo produce números. Por ejemplo: «el endpoint de búsqueda debe responder en menos de 300 ms en el percentil 95 con 500 peticiones por segundo, con una tasa de errores inferior al 0,1 %». Idealmente, derivados de los SLO y del tráfico real (y de su crecimiento previsto).

**2. Elegir el tipo de prueba**:

- **Carga**: tráfico esperado durante un tiempo; verifica que se cumplen los objetivos.
- **Estrés**: aumentar la carga hasta el punto de rotura; averigua el límite y **cómo falla** (¿se degrada ordenadamente o colapsa?).
- **Picos** (*spike*): aumentos bruscos; verifica el autoescalado y la protección.
- **Resistencia** (*soak*): carga moderada durante horas; revela fugas de memoria, conexiones que no se liberan o degradación progresiva.

**3. Herramientas**: **Gatling** (escenarios en Java, Scala o Kotlin, excelentes informes), **k6** (JavaScript, muy integrable en CI), **JMeter** (veterana, con interfaz gráfica), Locust (Python).

```java
public class BusquedaSimulation extends Simulation {
    HttpProtocolBuilder http = http.baseUrl("https://staging.tienda.com");

    ScenarioBuilder buscar = scenario("Búsqueda de productos")
        .exec(http("buscar").get("/api/productos?q=zapatillas")
            .check(status().is(200)));

    {
        setUp(buscar.injectOpen(rampUsersPerSec(10).to(500).during(Duration.ofMinutes(5))))
            .protocols(http)
            .assertions(global().responseTime().percentile(95).lt(300),
                        global().failedRequests().percent().lt(0.1));
    }
}
```

**4. Entorno y datos**: lo más parecido a producción posible (tamaño de instancias, volumen de datos, configuración), con dependencias externas simuladas (WireMock) para no probar sistemas ajenos, y datos variados para no medir solo aciertos de caché.

**5. Medir e interpretar**: fijarse en **percentiles** (p95, p99), no en la media, que oculta a los usuarios que sufren; correlacionar con las métricas del servicio (CPU, GC, pool de conexiones, hilos, base de datos) para encontrar el cuello de botella; tener en cuenta el calentamiento de la JVM (el JIT tarda en optimizar) y descartar los primeros minutos.

**6. Automatizar**: una prueba de rendimiento reducida en el pipeline detecta regresiones en cada versión; las pruebas grandes se programan periódicamente o antes de eventos de tráfico conocidos.

Un error clásico al usar herramientas de modelo cerrado (un número fijo de usuarios virtuales que esperan cada respuesta) es la **omisión coordinada**: cuando el sistema se ralentiza, el generador envía menos peticiones y los resultados parecen mejores de lo que son. Los modelos abiertos (llegadas por segundo), como el del ejemplo, lo evitan.

# Parte II · Monográficos

Tres capítulos dedicados a tecnologías presentes en la mayoría de puestos de desarrollo con microservicios. Dentro de cada capítulo, las preguntas van de menor a mayor dificultad.

# Monográfico A · Apache Kafka en profundidad

Conceptos, productores y consumidores, integración con Spring, gestión de errores, diseño de topics, garantías de entrega, esquemas, ecosistema y operación.

Este capítulo contiene 12 preguntas.

## P126 · ¿Cuáles son los conceptos fundamentales de Apache Kafka?

*Tema: Kafka · Conceptos · Monográfico A*

Kafka es una plataforma de **streaming de eventos** distribuida. Su abstracción central es un **log**: una secuencia ordenada, inmutable y persistente de registros a la que solo se añade al final.

- **Registro (record)**: la unidad de datos. Tiene **clave** (opcional), **valor**, cabeceras y marca de tiempo.
- **Topic**: categoría lógica de registros (`pedidos`, `pagos`). Es el equivalente a una tabla o a una cola con nombre.
- **Partición**: cada topic se divide en particiones, que son los logs reales. Son la unidad de **paralelismo** (más particiones, más consumidores en paralelo) y de **orden** (el orden solo está garantizado dentro de una partición).
- **Offset**: posición de un registro dentro de su partición. Cada grupo de consumidores guarda hasta qué offset ha procesado.
- **Broker**: un servidor de Kafka. Un **clúster** tiene varios brokers, entre los que se reparten las particiones.
- **Réplicas**: cada partición se replica en varios brokers (factor de replicación, habitualmente 3). Una réplica es el **líder**, que atiende las escrituras y lecturas; las demás son **seguidoras**. El conjunto de réplicas sincronizadas con el líder es el **ISR** (*in-sync replicas*). Si cae el líder, se elige otro del ISR.
- **Productor**: publica registros. Con clave, la partición se elige por hash de la clave: todos los registros de la misma clave van a la misma partición y conservan su orden.
- **Consumidor** y **grupo de consumidores**: los consumidores de un mismo grupo se reparten las particiones (cada partición la lee un único consumidor del grupo). Grupos distintos leen el topic de forma independiente, cada uno con sus offsets: así varios servicios consumen los mismos eventos sin interferir.
- **Retención**: los registros se conservan durante un tiempo o tamaño configurado, **aunque ya se hayan leído**. Eso permite reprocesar (*replay*) y que se incorporen consumidores nuevos.

Sobre la coordinación del clúster: históricamente Kafka dependía de **ZooKeeper** para los metadatos. El modo **KRaft** (consenso Raft integrado en Kafka) lo sustituye, y desde **Kafka 4.0** ZooKeeper se ha eliminado por completo.

Diferencia clave con una cola tradicional: en una cola, el mensaje desaparece al consumirse y se reparte entre consumidores; en Kafka, el mensaje permanece y cada grupo lleva su propia posición de lectura.

> **Clave para la entrevista.** Dominar la relación entre particiones, orden y paralelismo es la base de todas las preguntas de Kafka que vienen después.

## P127 · ¿Qué configuraciones del productor de Kafka son importantes para la fiabilidad y el rendimiento?

*Tema: Kafka · Productor · Monográfico A*

**Fiabilidad**:

- `acks`: cuántas confirmaciones espera el productor. `0` (ninguna: rápido, puede perder datos), `1` (solo el líder: se pierde si el líder cae antes de replicar) o `all` (todas las réplicas del ISR). Desde Kafka 3.0, el valor por defecto es `all`.
- `min.insync.replicas` (configuración del topic o del broker): con `acks=all`, número mínimo de réplicas sincronizadas para aceptar escrituras. La combinación habitual es **factor de replicación 3, `min.insync.replicas=2` y `acks=all`**: tolera la caída de un broker sin perder datos ni disponibilidad.
- `enable.idempotence=true` (por defecto desde Kafka 3.0): el broker descarta duplicados causados por reintentos del productor, usando un identificador de productor y números de secuencia. Garantiza además el orden dentro de la partición aunque haya reintentos.
- `retries` y `delivery.timeout.ms`: el productor reintenta automáticamente los errores transitorios hasta agotar el tiempo total de entrega.

**Rendimiento**:

- `linger.ms`: cuánto espera el productor para agrupar registros en un lote. Un valor pequeño (5-20 ms) aumenta mucho el rendimiento a cambio de una latencia mínima.
- `batch.size`: tamaño máximo del lote por partición.
- `compression.type`: `lz4`, `zstd`, `snappy` o `gzip`. Comprime lotes completos; reduce red y disco.
- `buffer.memory`: memoria para los registros pendientes de envío.

**Clave y particionado**: la elección de la clave es una decisión de diseño. Con `pedidoId` como clave, todos los eventos de un pedido se procesan en orden. Una clave con mala distribución (por ejemplo, el país, si el 80 % del tráfico es de un país) crea **particiones calientes**. Sin clave, los registros se reparten entre particiones (con el particionador *sticky*, por lotes).

En Spring Kafka, el envío es asíncrono y devuelve un `CompletableFuture`:

```java
kafkaTemplate.send("pedidos", pedido.id().toString(), evento)
    .whenComplete((resultado, error) -> {
        if (error != null) {
            log.error("No se pudo publicar el evento del pedido {}", pedido.id(), error);
        } else {
            log.debug("Publicado en partición {} offset {}",
                resultado.getRecordMetadata().partition(),
                resultado.getRecordMetadata().offset());
        }
    });
```

Un error clásico es ignorar el resultado del envío: si falla tras agotar los reintentos, el evento se pierde silenciosamente. Para garantías fuertes junto con la base de datos, se usa el patrón Outbox.

## P128 · ¿Cómo funciona el consumidor de Kafka? ¿Qué es el commit de offsets y qué es un rebalanceo?

*Tema: Kafka · Consumidor · Monográfico A*

El consumidor funciona con un **bucle de poll**: pide registros al broker (`poll()`), los procesa y confirma (**commit**) hasta qué offset ha llegado. Si el consumidor se reinicia, continúa desde el último offset confirmado.

El momento del commit determina la garantía de entrega:

- **Commit antes de procesar**: si el consumidor cae durante el procesamiento, esos registros no se vuelven a leer → *at-most-once* (se pueden perder).
- **Commit después de procesar**: si cae tras procesar y antes del commit, esos registros se vuelven a leer → *at-least-once* (se pueden duplicar). **Es la opción habitual**, combinada con consumidores idempotentes.

El commit automático de Kafka (`enable.auto.commit=true`) confirma periódicamente lo último recibido en `poll`, independientemente de si se ha procesado, lo que puede perder mensajes. **Spring Kafka desactiva el auto-commit** y gestiona el commit él mismo según el `AckMode` del contenedor: por defecto `BATCH` (confirma tras procesar todos los registros de un `poll`); también `RECORD`, `MANUAL` o `MANUAL_IMMEDIATE` (el listener confirma explícitamente con un `Acknowledgment`).

`auto.offset.reset` decide qué hacer cuando un grupo no tiene offset guardado (primera vez): `earliest` (leer desde el principio) o `latest` (solo registros nuevos, el valor por defecto de Kafka). Spring Boot no cambia este valor, así que un servicio nuevo que debería procesar el histórico necesita `earliest`.

**Rebalanceo**: cuando un consumidor entra o sale del grupo (despliegues, escalado, fallos), las particiones se reasignan entre los consumidores activos. Durante el rebalanceo clásico, el grupo deja de consumir brevemente. Causas de rebalanceos no deseados:

- `max.poll.interval.ms` (5 minutos por defecto): si el procesamiento de un lote tarda más que esto entre dos `poll`, Kafka considera muerto al consumidor y lo expulsa del grupo. Sus registros se reasignan y se reprocesan, lo que puede provocar un ciclo infinito. Solución: lotes más pequeños (`max.poll.records`) o procesamiento más rápido.
- `session.timeout.ms` y *heartbeats*: si el consumidor no envía latidos (por ejemplo, por una pausa de GC muy larga), también se le expulsa.

Mejoras para reducir el impacto: asignación **cooperativa** (`CooperativeStickyAssignor`, que solo mueve las particiones necesarias), **membresía estática** (`group.instance.id`, que evita rebalanceos en reinicios rápidos) y el **nuevo protocolo de grupos de consumidores** (KIP-848), disponible de forma general desde Kafka 4.0, que traslada la coordinación al broker y hace los rebalanceos incrementales.

## P129 · ¿Cómo se integra Kafka en una aplicación Spring Boot?

*Tema: Kafka · Spring · Monográfico A*

Con la dependencia `spring-kafka`, Spring Boot autoconfigura el `ProducerFactory`, el `ConsumerFactory`, el `KafkaTemplate` y la infraestructura de listeners a partir de propiedades:

```yaml
spring:
  kafka:
    bootstrap-servers: kafka:9092
    producer:
      key-serializer: org.apache.kafka.common.serialization.StringSerializer
      value-serializer: org.springframework.kafka.support.serializer.JsonSerializer
      properties:
        linger.ms: 10
    consumer:
      group-id: servicio-envios
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.springframework.kafka.support.serializer.ErrorHandlingDeserializer
      properties:
        spring.deserializer.value.delegate.class: org.springframework.kafka.support.serializer.JsonDeserializer
        spring.json.trusted.packages: "com.miempresa.eventos"
    listener:
      concurrency: 3
```

**Producir**:

```java
@Service
@RequiredArgsConstructor
public class PublicadorEventos {
    private final KafkaTemplate<String, Object> kafka;

    public void pedidoConfirmado(PedidoConfirmado evento) {
        kafka.send("pedidos.eventos", evento.pedidoId().toString(), evento);
    }
}
```

**Consumir**:

```java
@Component
public class PedidosListener {

    @KafkaListener(topics = "pedidos.eventos", groupId = "servicio-envios")
    public void onEvento(PedidoConfirmado evento,
                         @Header(KafkaHeaders.RECEIVED_PARTITION) int particion,
                         @Header(KafkaHeaders.OFFSET) long offset) {
        envios.prepararEnvio(evento);
    }
}
```

Detalles importantes:

- **`ErrorHandlingDeserializer`**: envuelve al deserializador real. Sin él, un mensaje que no se puede deserializar (una *poison pill*) provoca una excepción antes de llegar al listener, en bucle infinito, bloqueando la partición. Con él, el error llega al manejador de errores y el mensaje puede enviarse a la DLT.
- **Paquetes de confianza** del `JsonDeserializer`: por seguridad, solo deserializa clases de paquetes autorizados.
- **Información de tipo**: por defecto, `JsonSerializer` añade una cabecera con el nombre de la clase Java. Eso acopla al consumidor con la clase del productor; entre servicios distintos es preferible desactivarlo y que cada consumidor indique su tipo por defecto o use mapeos de tipos, o bien usar Avro o Protobuf con Schema Registry.
- **`concurrency`**: número de hilos consumidores por listener. No tiene sentido superar el número de particiones del topic: los consumidores sobrantes quedan ociosos.
- La creación de topics se puede declarar como beans `NewTopic` (útil en desarrollo), aunque en producción suele gestionarse con infraestructura como código.
- Spring Boot también ofrece integración con Kafka en **Spring Cloud Stream**, un modelo más abstracto basado en funciones (`Consumer<T>`, `Function<T, R>`) independiente del broker.

## P130 · ¿Cómo se gestionan los errores y los reintentos al consumir de Kafka con Spring? ¿Qué es una Dead Letter Topic?

*Tema: Kafka · Errores · Monográfico A*

Si un listener lanza una excepción, Spring Kafka delega en el **`DefaultErrorHandler`** del contenedor. Por defecto reintenta el registro **9 veces sin espera** (10 intentos en total) y, si sigue fallando, lo registra en el log y **continúa con el siguiente**, es decir, el mensaje se descarta.

Estos reintentos son **bloqueantes**: mientras se reintenta, la partición no avanza. Para errores transitorios breves es aceptable; para errores largos, retrasa todos los mensajes de la partición.

**Configuración habitual**: reintentos con backoff exponencial y, al agotarlos, envío a una **Dead Letter Topic (DLT)**, un topic donde se guardan los mensajes que no se han podido procesar para analizarlos y reprocesarlos más adelante sin bloquear el flujo principal.

```java
@Bean
DefaultErrorHandler errorHandler(KafkaTemplate<Object, Object> template) {
    var recoverer = new DeadLetterPublishingRecoverer(template);   // publica en <topic>-dlt
    var backoff = new ExponentialBackOffWithMaxRetries(4);
    backoff.setInitialInterval(1_000);
    backoff.setMultiplier(2.0);
    var handler = new DefaultErrorHandler(recoverer, backoff);
    handler.addNotRetryableExceptions(ValidacionException.class,
                                      DeserializationException.class);
    return handler;
}
```

Clasificar las excepciones es fundamental: un error de validación o de deserialización **nunca** se arreglará reintentando, así que debe ir directamente a la DLT.

**Reintentos no bloqueantes** con `@RetryableTopic`: el mensaje fallido se publica en topics de reintento con retardos crecientes (`pedidos-retry-1000`, `pedidos-retry-2000`...) y finalmente en la DLT. La partición principal sigue avanzando mientras tanto.

```java
@RetryableTopic(attempts = "4",
                backoff = @Backoff(delay = 1000, multiplier = 2.0),
                exclude = ValidacionException.class)
@KafkaListener(topics = "pedidos")
public void procesar(PedidoConfirmado evento) { ... }

@DltHandler
public void enDlt(PedidoConfirmado evento, @Header(KafkaHeaders.EXCEPTION_MESSAGE) String error) {
    alertas.mensajeFallido(evento, error);
}
```

Contrapartida: con reintentos no bloqueantes **se pierde el orden**, porque los mensajes posteriores del mismo pedido pueden procesarse antes que el que se está reintentando. Si el orden por clave es crítico, hay que usar reintentos bloqueantes o una lógica que detecte y aparque los mensajes siguientes de la misma clave.

Operación de la DLT: monitorizar su tamaño y alertar, conservar en cabeceras el topic, partición, offset y excepción de origen (el `DeadLetterPublishingRecoverer` lo hace automáticamente) y disponer de una herramienta o procedimiento para reprocesar los mensajes una vez corregido el problema.

> **Clave para la entrevista.** Mencionar que los reintentos no bloqueantes rompen el orden por clave demuestra que entiendes las consecuencias, no solo la configuración.

## P131 · ¿Cómo se diseñan los topics? ¿Cuántas particiones? ¿Un topic por evento o por entidad?

*Tema: Kafka · Diseño · Monográfico A*

**Número de particiones**: determina el paralelismo máximo de consumo (un consumidor por partición en cada grupo). Criterio habitual: estimar el rendimiento necesario y el que puede procesar un consumidor, y añadir margen para el crecimiento, porque **aumentar particiones más tarde cambia la asignación de claves** (el hash de la clave módulo el número de particiones) y rompe el orden por clave durante la transición. Tampoco conviene exagerar: muchas particiones aumentan el consumo de recursos de los brokers, el tiempo de recuperación y la duración de los rebalanceos. Para muchos servicios de negocio, entre 6 y 24 particiones es un rango razonable; se ajusta con mediciones.

**Factor de replicación**: 3 en producción, con `min.insync.replicas=2`.

**Organización de los eventos**:

- **Un topic por tipo de evento** (`pedido-creado`, `pedido-pagado`, `pedido-cancelado`): esquemas simples y consumidores que se suscriben solo a lo que les interesa, pero **no hay orden entre tipos de evento** de la misma entidad: el consumidor podría ver `pedido-cancelado` antes que `pedido-creado`.
- **Un topic por entidad o agregado** (`pedidos` con todos sus eventos, clave `pedidoId`): se conserva el **orden de todos los eventos de cada pedido**, que es lo que normalmente se necesita. Los consumidores reciben eventos que quizá no les interesan y los ignoran. El topic contiene varios esquemas (se gestiona con uniones en Avro o con el tipo en una cabecera).

La regla práctica: **los eventos que necesitan un orden relativo deben ir al mismo topic con la misma clave**.

**Nombres**: seguir una convención homogénea, por ejemplo `<dominio>.<entidad>.<tipo>.v<versión>` (`ventas.pedidos.eventos.v1`), y evitar mezclar puntos y guiones bajos (Kafka los trata como equivalentes en los nombres de métricas).

**Otras decisiones**:

- Retención según el uso: días para eventos de integración, indefinida con compactación para topics de estado.
- Separar **eventos** (hechos publicados para cualquiera) de **comandos** (dirigidos a un servicio concreto), habitualmente en topics distintos.
- Definir la **propiedad** de cada topic: un único servicio productor por topic de eventos, que es el dueño de su esquema.
- Gestionar los topics como código (Terraform, operadores como Strimzi en Kubernetes, o scripts versionados) en lugar de dejar que las aplicaciones los creen en producción.

## P132 · ¿Qué es exactly-once en Kafka y cómo funcionan las transacciones?

*Tema: Kafka · Garantías · Monográfico A*

Kafka ofrece **exactly-once semantics (EOS)** para el patrón **consumir → procesar → producir** dentro de Kafka. Se apoya en dos mecanismos:

- **Productor idempotente**: elimina los duplicados causados por reintentos del propio productor.
- **Transacciones**: permiten escribir en varios topics y particiones **y confirmar los offsets consumidos** de forma atómica. O se publican todos los registros y se avanzan los offsets, o no ocurre nada. Los consumidores con `isolation.level=read_committed` solo ven registros de transacciones confirmadas.

Así, si un servicio lee un registro de `pedidos`, publica un registro en `facturas` y falla antes de terminar, la transacción se aborta: el registro en `facturas` nunca será visible para consumidores `read_committed` y el registro de `pedidos` se volverá a procesar.

En Spring Kafka se activa configurando un prefijo de identificador transaccional:

```yaml
spring:
  kafka:
    producer:
      transaction-id-prefix: facturacion-tx-
    consumer:
      isolation-level: read_committed
```

Con esto, el contenedor del listener inicia una transacción de Kafka por cada lote consumido y confirma los offsets dentro de ella. Todo lo que el listener publique con el `KafkaTemplate` forma parte de la misma transacción.

**La limitación fundamental**: la garantía solo cubre operaciones **dentro de Kafka**. Si el listener también escribe en una base de datos o llama a una API, no hay transacción atómica entre Kafka y esos sistemas. Intentar coordinar una transacción de base de datos y una de Kafka (sincronización de transacciones) solo ofrece *best effort*: puede fallar el commit de una después de confirmar la otra.

Por eso la recomendación práctica para servicios de negocio es:

- Para **Kafka → base de datos**: consumidor **idempotente** (deduplicar por identificador del evento en la misma transacción de base de datos) con entrega *at-least-once*.
- Para **base de datos → Kafka**: patrón **Transactional Outbox** con CDC o un publicador.
- Reservar las transacciones de Kafka para procesamientos puramente Kafka → Kafka, como los de **Kafka Streams** (que activa EOS con `processing.guarantee=exactly_once_v2`).

## P133 · ¿Qué es un Schema Registry y por qué usar Avro o Protobuf en lugar de JSON?

*Tema: Kafka · Esquemas · Monográfico A*

Con JSON sin esquema, el contrato entre productor y consumidores es implícito: si el productor renombra un campo, los consumidores fallan en producción, y nada lo impide. Además, JSON es verboso (el nombre de cada campo se repite en cada mensaje).

Un **Schema Registry** (Confluent Schema Registry, Apicurio, AWS Glue Schema Registry) es un servicio que almacena y versiona los esquemas de los mensajes:

- El productor registra (o busca) el esquema y envía en cada mensaje solo un **identificador de esquema** junto con los datos en binario.
- El consumidor obtiene el esquema por su identificador (y lo cachea) para deserializar.
- El registro **valida la compatibilidad** de cada nueva versión del esquema según una política configurada, **rechazando cambios que romperían a los consumidores** antes de que lleguen a producción.

Modos de compatibilidad:

- **BACKWARD** (por defecto en Confluent): los consumidores con el esquema nuevo pueden leer datos escritos con el anterior. Permite eliminar campos y añadir campos **con valor por defecto**. Se actualizan primero los consumidores.
- **FORWARD**: los consumidores con el esquema anterior pueden leer datos del nuevo. Se actualizan primero los productores.
- **FULL**: ambas cosas a la vez.
- Variantes **TRANSITIVE**: la compatibilidad se comprueba contra todas las versiones anteriores, no solo la última.

Formatos:

- **Avro**: el más extendido en el ecosistema Kafka; esquemas en JSON, binario compacto, reglas de evolución bien definidas (valores por defecto, uniones con `null` para campos opcionales). Generación de clases Java con el plugin de Maven o Gradle.
- **Protobuf**: muy eficiente, excelente tooling multilenguaje, encaja si ya se usa gRPC. La evolución se basa en los números de campo, que nunca se reutilizan.
- **JSON Schema**: mantiene JSON legible y añade validación, con menos eficiencia.

```json
{
  "type": "record",
  "name": "PedidoConfirmado",
  "namespace": "com.miempresa.eventos",
  "fields": [
    { "name": "pedidoId", "type": "long" },
    { "name": "total",    "type": { "type": "bytes", "logicalType": "decimal", "precision": 12, "scale": 2 } },
    { "name": "canal",    "type": ["null", "string"], "default": null }
  ]
}
```

Integración en el pipeline: los esquemas viven en el repositorio y se comprueba su compatibilidad contra el registro en la CI (plugins de Maven y Gradle), de modo que un cambio incompatible falla en la pull request, no en producción.

## P134 · ¿Qué son la retención y la compactación de logs en Kafka? ¿Qué es un tombstone?

*Tema: Kafka · Almacenamiento · Monográfico A*

Kafka ofrece dos políticas de limpieza (`cleanup.policy`) para cada topic:

**delete** (por defecto): los registros se eliminan cuando superan la antigüedad (`retention.ms`, 7 días por defecto) o cuando la partición supera un tamaño (`retention.bytes`). La eliminación se hace por **segmentos** completos de log, no registro a registro, así que los datos pueden permanecer algo más de lo configurado. Adecuado para flujos de eventos donde lo antiguo deja de interesar.

**compact**: Kafka garantiza conservar **al menos el último valor de cada clave**. Un proceso en segundo plano (el *log cleaner*) elimina los registros antiguos de claves que tienen valores más recientes. El topic se convierte en una especie de tabla con el estado actual de cada entidad, que además conserva el historial reciente.

```text
Antes de compactar:     Después de compactar:
offset 0  k=A  v=1
offset 1  k=B  v=1
offset 2  k=A  v=2
offset 3  k=C  v=1      offset 3  k=C  v=1
offset 4  k=B  v=2      offset 4  k=B  v=2
offset 5  k=A  v=3      offset 5  k=A  v=3
```

Los offsets no cambian; simplemente desaparecen los registros superados.

Usos de la compactación: **event-carried state transfer** (un servicio nuevo reconstruye su copia local de, por ejemplo, el catálogo leyendo el topic compactado desde el principio), los topics internos de Kafka (`__consumer_offsets`), las tablas de estado de Kafka Streams (`KTable`) y la configuración y offsets de Kafka Connect.

Un **tombstone** es un registro con una clave y **valor nulo**. Indica que la entidad se ha eliminado: tras la compactación, la clave desaparece por completo (el tombstone se conserva un tiempo, `delete.retention.ms`, para que los consumidores tengan ocasión de verlo). Es la forma de borrar datos en un topic compactado, importante por ejemplo para atender solicitudes de borrado de datos personales.

Se pueden combinar ambas políticas (`compact,delete`): compacta y, además, elimina lo que supere la retención.

Relacionado: **tiered storage** (almacenamiento por niveles, disponible de forma general en versiones recientes de Kafka) mueve los segmentos antiguos a almacenamiento de objetos más barato, lo que permite retenciones muy largas sin ampliar los discos de los brokers.

## P135 · ¿Qué son Kafka Connect, Kafka Streams y Debezium? ¿Cuándo usarías cada uno?

*Tema: Kafka · Ecosistema · Monográfico A*

**Kafka Connect** es un framework para **mover datos entre Kafka y otros sistemas** sin escribir código, mediante conectores configurables:

- **Source connectors**: leen de un sistema externo y publican en Kafka (bases de datos, ficheros, colas, APIs).
- **Sink connectors**: leen de Kafka y escriben en un sistema externo (Elasticsearch, almacenamiento de objetos, data warehouses, bases de datos).

Se ejecuta como un clúster de *workers* que gestiona el paralelismo, los offsets y la tolerancia a fallos, y admite transformaciones sencillas por registro (SMT). Casos de uso: alimentar un índice de búsqueda, volcar eventos a un data lake para analítica, integrar sistemas heredados.

**Debezium** es un conjunto de conectores de origen de Kafka Connect especializados en **Change Data Capture (CDC)**: leen el log de transacciones de la base de datos (WAL de PostgreSQL, binlog de MySQL, redo log de Oracle...) y publican cada inserción, actualización y borrado como un evento. Captura los cambios de forma fiable, en orden y sin modificar la aplicación ni añadir carga de consultas. Incluye un **router de outbox** que publica los registros de la tabla outbox en los topics adecuados. Es la pieza habitual para implementar el Transactional Outbox, y también se usa para migraciones (Strangler Fig) y replicación de datos.

**Kafka Streams** es una **librería Java** (no un clúster aparte) para construir aplicaciones que procesan flujos: filtrar, transformar, enriquecer, agregar por ventanas de tiempo y unir streams y tablas. Gestiona el estado local (RocksDB, respaldado en topics de Kafka para recuperarse tras fallos), escala añadiendo instancias y ofrece exactly-once. Se integra con Spring Boot mediante `@EnableKafkaStreams` o Spring Cloud Stream.

```java
@Bean
KStream<String, Pedido> ventasPorProducto(StreamsBuilder builder) {
    KStream<String, Pedido> pedidos = builder.stream("pedidos");
    pedidos
        .flatMapValues(Pedido::lineas)
        .groupBy((clave, linea) -> linea.productoId())
        .windowedBy(TimeWindows.ofSizeWithNoGrace(Duration.ofMinutes(5)))
        .aggregate(() -> 0L, (producto, linea, total) -> total + linea.cantidad())
        .toStream()
        .to("ventas-por-producto-5m");
    return pedidos;
}
```

Casos de uso: detección de fraude en tiempo real, métricas de negocio en vivo, vistas materializadas para CQRS, enriquecimiento de eventos.

**Cuándo usar cada uno**: Connect/Debezium para **integrar datos** con sistemas externos sin código; Streams para **lógica de procesamiento continuo** sobre los flujos; un `@KafkaListener` normal para **reaccionar a eventos** con lógica de negocio que interactúa con la base de datos o APIs de un servicio. Alternativas de procesamiento a mayor escala: Apache Flink.

## P136 · ¿Cómo se monitoriza Kafka? ¿Qué es el consumer lag y por qué es la métrica más importante?

*Tema: Kafka · Operación · Monográfico A*

El **consumer lag** es la diferencia, por partición, entre el último offset escrito en el topic y el último offset confirmado por un grupo de consumidores. Indica **cuántos mensajes tiene pendientes** un consumidor.

Es la métrica más importante desde el punto de vista de un servicio porque:

- Un lag creciente de forma sostenida significa que el consumidor **no da abasto** (procesamiento lento, pocos consumidores, una dependencia lenta) o que está **atascado** (una poison pill, un error que se reintenta sin fin, un consumidor que se rebalancea constantemente).
- Se traduce directamente en **retraso de negocio**: los pedidos tardan más en enviarse, las notificaciones llegan tarde.
- Es mejor alertar sobre el **tiempo de retraso** (antigüedad del mensaje más antiguo sin procesar) que sobre el número de mensajes, porque 10.000 mensajes pueden ser un segundo en un topic y una hora en otro.

Formas de obtenerlo: métricas del propio cliente consumidor expuestas por Micrometer (`kafka.consumer.fetch.manager.records.lag.max` y similares), herramientas externas que consultan el clúster como **kafka-lag-exporter**, **Burrow** o **kminion**, o los paneles de las plataformas gestionadas.

Otras métricas relevantes:

- **Del clúster**: particiones sub-replicadas (*under-replicated partitions*, deberían ser 0), particiones offline, número de controladores activos (exactamente 1), tasa de elección de líderes, uso de disco, latencia de peticiones de producción y lectura.
- **Del productor**: tasa de errores y reintentos, latencia de envío, tamaño medio de lote.
- **Del consumidor**: frecuencia de rebalanceos, tiempo de procesamiento por registro, registros enviados a la DLT.

Herramientas de interfaz para explorar topics, mensajes y grupos: **Kafka UI** (Provectus), **AKHQ**, **Redpanda Console**, **Conduktor**; en plataformas gestionadas (Confluent Cloud, Amazon MSK, Aiven), sus propias consolas. Para despliegues sobre Kubernetes, el operador **Strimzi** gestiona el clúster y expone métricas para Prometheus.

**Escalar consumidores** en función del lag, en lugar de por CPU, es un uso muy acertado de **KEDA** en Kubernetes (con el límite del número de particiones).

## P137 · ¿Cuándo no usarías Kafka? ¿Qué alternativas existen?

*Tema: Kafka · Comparativa · Monográfico A*

Kafka es muy potente, pero no es la respuesta a todo:

- **Colas de trabajo clásicas** (repartir tareas entre trabajadores, con reintentos y retrasos por mensaje, prioridades, mensajes individuales que se confirman o rechazan): **RabbitMQ**, Amazon SQS o las colas del proveedor cloud encajan de forma más natural. Kafka confirma offsets por partición, no mensajes individuales, y un mensaje lento bloquea la partición. Kafka está incorporando semántica de colas (**share groups**, KIP-932, introducida en versiones 4.x) para cubrir parte de este caso, pero conviene verificar su madurez en la versión concreta.
- **Petición-respuesta síncrona**: si el llamante necesita la respuesta inmediatamente, HTTP o gRPC son más simples. Montar request/reply sobre Kafka es posible (`ReplyingKafkaTemplate`) pero añade latencia y complejidad.
- **Volúmenes bajos y equipos pequeños**: operar un clúster de Kafka tiene un coste real. Para pocos eventos, un outbox con una tabla y un publicador, o un servicio gestionado sencillo, puede bastar. Si se usa Kafka, la versión gestionada (Confluent Cloud, Amazon MSK, Aiven) elimina gran parte de la carga operativa.
- **Enrutamiento complejo por contenido** o prioridades por mensaje: RabbitMQ lo hace de forma nativa con exchanges.
- **Mensajes muy grandes** (ficheros, vídeos): se guardan en almacenamiento de objetos y se envía por Kafka solo la referencia (*claim check pattern*).

Alternativas y complementos:

- **RabbitMQ**: broker AMQP maduro, con enrutamiento flexible; sus *streams* (desde la versión 3.9) ofrecen un log persistente al estilo Kafka.
- **Apache Pulsar**: separa cómputo y almacenamiento (BookKeeper), multi-tenancy nativa, soporta colas y streams; más complejo de operar.
- **Redpanda**: compatible con la API de Kafka, implementado en C++ sin JVM, con énfasis en baja latencia y sencillez operativa.
- **NATS / JetStream**: ligero y muy rápido, popular en entornos cloud native y edge.
- **Servicios cloud**: Amazon SQS/SNS/EventBridge/Kinesis, Google Pub/Sub, Azure Service Bus/Event Hubs.

La respuesta madura en una entrevista es elegir en función de los requisitos (volumen, orden, retención, replay, patrones de consumo, capacidad operativa del equipo), no por moda.

# Monográfico B · Docker y Kubernetes para desarrolladores Spring Boot

Contenedores e imágenes, construcción de imágenes para Spring Boot, desarrollo local con Compose, objetos de Kubernetes, despliegue, escalado, diagnóstico y seguridad.

Este capítulo contiene 10 preguntas.

## P138 · ¿Qué es un contenedor y en qué se diferencia de una máquina virtual? ¿Qué son las imágenes y sus capas?

*Tema: Docker · Conceptos · Monográfico B*

Una **máquina virtual** virtualiza el hardware: cada VM ejecuta su propio sistema operativo completo sobre un hipervisor. Aislamiento fuerte, pero arranques de minutos y un consumo de recursos considerable.

Un **contenedor** virtualiza el sistema operativo: es un proceso normal del host aislado mediante características del kernel de Linux:

- **Namespaces**: aíslan lo que el proceso ve (procesos, red, sistema de ficheros, usuarios, hostname).
- **cgroups**: limitan lo que el proceso puede usar (CPU, memoria, E/S).

Todos los contenedores comparten el kernel del host, así que arrancan en milisegundos o segundos y ocupan mucho menos. El aislamiento es menor que el de una VM, lo que importa en entornos multi-tenant hostiles (para eso existen runtimes con más aislamiento, como gVisor o Kata Containers).

Una **imagen** es la plantilla de solo lectura a partir de la que se crean contenedores. Está formada por **capas** apiladas: cada instrucción del Dockerfile que modifica el sistema de ficheros (`RUN`, `COPY`, `ADD`) crea una capa nueva que registra solo las diferencias. Al ejecutar un contenedor, se añade encima una capa fina de escritura que desaparece con el contenedor.

Consecuencias prácticas de las capas:

- **Caché de construcción**: si una capa no ha cambiado (ni ninguna anterior), Docker la reutiliza. Por eso se copian primero las cosas que cambian poco (dependencias) y al final las que cambian mucho (el código). Si se copia el jar completo en una sola capa, cualquier cambio de una línea obliga a volver a subir las decenas de megas de dependencias.
- **Compartición**: varias imágenes con la misma imagen base comparten esas capas en disco y en el registro.
- Borrar un fichero en una capa posterior **no reduce** el tamaño de la imagen (sigue en la capa anterior); por eso se limpia en la misma instrucción `RUN` o se usan construcciones multietapa.

Las imágenes siguen el estándar **OCI** y se identifican por nombre y etiqueta (`registro/tienda/pedidos:1.4.2`) o, de forma inmutable, por su *digest* (`@sha256:...`). En producción conviene desplegar por etiqueta inmutable o por digest, nunca por `latest`.

## P139 · ¿Cómo escribirías un Dockerfile para una aplicación Spring Boot siguiendo buenas prácticas?

*Tema: Docker · Imágenes · Monográfico B*

Un Dockerfile multietapa que aprovecha las capas del jar de Spring Boot:

```dockerfile
# ---------- Etapa 1: construcción ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace
COPY mvnw pom.xml ./
COPY .mvn .mvn
RUN ./mvnw -B dependency:go-offline          # capa cacheable de dependencias
COPY src src
RUN ./mvnw -B package -DskipTests

# ---------- Etapa 2: extracción de capas ----------
FROM eclipse-temurin:21-jre AS layers
WORKDIR /app
COPY --from=build /workspace/target/*.jar app.jar
RUN java -Djarmode=tools -jar app.jar extract --layers --launcher --destination extracted

# ---------- Etapa 3: imagen final ----------
FROM eclipse-temurin:21-jre
RUN groupadd --system app && useradd --system --gid app app
USER app
WORKDIR /app
COPY --from=layers /app/extracted/dependencies/ ./
COPY --from=layers /app/extracted/spring-boot-loader/ ./
COPY --from=layers /app/extracted/snapshot-dependencies/ ./
COPY --from=layers /app/extracted/application/ ./
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75 -XX:+ExitOnOutOfMemoryError"
EXPOSE 8080
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
```

Buenas prácticas que refleja:

- **Multietapa**: la imagen final no contiene el JDK, Maven ni el código fuente; solo un **JRE** y la aplicación. Menor tamaño y menor superficie de ataque.
- **Capas ordenadas por frecuencia de cambio**: dependencias (casi nunca cambian), loader, snapshots y, al final, el código de la aplicación. Una nueva versión solo sube unos pocos kilobytes o megas.
- **Usuario no root**: si alguien compromete la aplicación, no obtiene privilegios de root dentro del contenedor.
- **ENTRYPOINT en forma exec** (array JSON): Java se ejecuta como **PID 1** y recibe directamente las señales (`SIGTERM`), lo que permite el apagado ordenado. En la forma shell (`ENTRYPOINT java -jar ...` sin corchetes), el PID 1 es `sh`, que no reenvía las señales, y el contenedor acaba matado a la fuerza tras el periodo de gracia.
- Opciones de JVM por variable de entorno (`JAVA_TOOL_OPTIONS`), que se pueden sobrescribir en cada entorno.
- **Versiones de imagen base fijadas** (idealmente por digest) y actualizadas regularmente para recibir parches de seguridad.
- Un fichero **`.dockerignore`** para no enviar `target/`, `.git` ni ficheros locales al contexto de construcción.

Muchos equipos construyen el jar en el pipeline de CI y usan solo las dos últimas etapas, para no compilar dos veces. Otras opciones sin Dockerfile: **buildpacks** (`spring-boot:build-image`) y **Jib**.

Para reducir aún más la imagen: imágenes base **distroless** o *chiseled* (sin shell ni gestor de paquetes) y un JRE a medida con `jlink` que incluya solo los módulos del JDK necesarios.

> **Clave para la entrevista.** Explicar por qué el ENTRYPOINT debe ir en forma exec (señales y PID 1) es un detalle que casi nadie menciona y que demuestra experiencia real con contenedores.

## P140 · ¿Qué alternativas hay al Dockerfile para construir imágenes de Spring Boot? Buildpacks y Jib.

*Tema: Docker · Imágenes · Monográfico B*

**Cloud Native Buildpacks** (Paketo en el caso de Spring Boot): analizan la aplicación y construyen la imagen siguiendo buenas prácticas sin necesidad de Dockerfile.

```bash
./mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=registro/tienda/pedidos:1.4.2
```

- Detectan la versión de Java, añaden un JRE, separan el jar en capas, calculan automáticamente la configuración de memoria de la JVM según el límite del contenedor y ejecutan como usuario no root.
- Permiten **rebase**: actualizar la imagen base (por ejemplo, para un parche de seguridad del sistema operativo) sin reconstruir la aplicación.
- Admiten CDS y compilación nativa con GraalVM mediante opciones.
- Contrapartidas: menos control fino, dependencia del *builder* elegido y necesitan un demonio Docker (o compatible) durante la construcción.

**Jib** (de Google): plugin de Maven y Gradle que construye la imagen **sin Docker** y sin Dockerfile, directamente desde el build.

```bash
./mvnw compile jib:build -Dimage=registro/tienda/pedidos:1.4.2
```

- Separa automáticamente dependencias, recursos y clases en capas distintas.
- No necesita un demonio Docker, lo que simplifica el pipeline de CI (no hace falta Docker-in-Docker ni privilegios).
- Construcciones **reproducibles**: mismo código, mismo digest de imagen.
- Contrapartidas: pensado específicamente para aplicaciones Java; personalizaciones del sistema operativo más limitadas.

**Criterio de elección**:

- Dockerfile: máximo control y transparencia, válido para cualquier stack; requiere mantener buenas prácticas manualmente.
- Buildpacks: buenas prácticas por defecto y parches de base cómodos; muy integrado con Spring Boot.
- Jib: construcción rápida y sin Docker en la CI.

En todos los casos conviene completar el proceso con **escaneo de vulnerabilidades** (Trivy, Grype), generación de **SBOM** (lista de componentes de la imagen) y **firma** de la imagen (Sigstore cosign) para poder verificar su procedencia antes de desplegar.

## P141 · ¿Cómo usarías Docker Compose en el desarrollo de microservicios con Spring Boot?

*Tema: Docker · Desarrollo · Monográfico B*

**Docker Compose** define y ejecuta aplicaciones de varios contenedores con un fichero YAML. En desarrollo es ideal para levantar la infraestructura que necesita un servicio (base de datos, Kafka, Redis, un Keycloak, un stack de observabilidad) con un solo comando.

```yaml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: pedidos
      POSTGRES_USER: app
      POSTGRES_PASSWORD: app
    ports: ["5432:5432"]
    volumes: ["pgdata:/var/lib/postgresql/data"]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app"]
      interval: 5s
      retries: 10

  kafka:
    image: apache/kafka:3.8.0
    ports: ["9092:9092"]

  pedidos:
    build: .
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/pedidos
      SPRING_KAFKA_BOOTSTRAP_SERVERS: kafka:9092
    depends_on:
      postgres:
        condition: service_healthy
    ports: ["8080:8080"]

volumes:
  pgdata:
```

Detalles importantes:

- Los servicios se comunican por **nombre de servicio** en la red interna de Compose (`postgres:5432`), no por `localhost`: dentro de un contenedor, `localhost` es el propio contenedor.
- `depends_on` por sí solo espera a que el contenedor **arranque**, no a que esté **listo**. Con `condition: service_healthy` y un `healthcheck` se espera a que la dependencia responda.
- Los **volúmenes con nombre** conservan los datos entre reinicios; `docker compose down -v` los elimina.
- Kafka es un caso especial: los clientes reciben del broker las direcciones anunciadas (`advertised.listeners`), que deben ser alcanzables desde donde se ejecuta el cliente (host o red de Compose). Es una fuente clásica de errores de conexión.

**Integración con Spring Boot** (3.1+): con la dependencia `spring-boot-docker-compose`, al arrancar la aplicación desde el IDE, Boot detecta el `compose.yaml`, levanta los contenedores, espera a que estén listos y **configura automáticamente las conexiones** (URL, usuario y contraseña de la base de datos, servidores de Kafka...), sin propiedades manuales. Al parar la aplicación, puede detenerlos.

Alternativa en la misma línea: usar **Testcontainers en tiempo de desarrollo** (`SpringApplication.from(App::main).with(ContenedoresConfig.class).run(args)`), reutilizando la misma definición de contenedores que en los tests.

Compose también sirve para entornos de demostración o pruebas locales de extremo a extremo con varios servicios, pero en producción lo habitual es Kubernetes o una plataforma gestionada.

## P142 · ¿Cuáles son los objetos básicos de Kubernetes que necesita conocer un desarrollador?

*Tema: Kubernetes · Conceptos · Monográfico B*

Kubernetes es un orquestador de contenedores: se le declara el **estado deseado** y sus controladores trabajan continuamente para que el estado real coincida (reconciliación).

- **Pod**: la unidad mínima de despliegue. Uno o varios contenedores que comparten red (misma IP) y volúmenes. Son efímeros: pueden desaparecer y ser sustituidos por otros con otra IP. Casi nunca se crean directamente.
- **Deployment**: gestiona un conjunto de pods idénticos sin estado (número de réplicas, plantilla de pod, estrategia de actualización). Crea por debajo **ReplicaSets**; cada versión del despliegue tiene el suyo, lo que permite el rollback.
- **Service**: nombre DNS y dirección estable que balancea el tráfico entre los pods que coinciden con un selector de etiquetas. Tipos: `ClusterIP` (interno, el más común), `NodePort`, `LoadBalancer` (expone con un balanceador del proveedor cloud) y `Headless` (sin IP virtual, resuelve a las IP de los pods).
- **Ingress** (y su evolución, la **Gateway API**): reglas de enrutamiento HTTP desde fuera del clúster hacia los Services (por host y ruta), con terminación TLS. Requiere un controlador (NGINX, Traefik, el del proveedor cloud...).
- **ConfigMap** y **Secret**: configuración y datos sensibles inyectados como variables de entorno o ficheros. Los Secrets solo están codificados en base64, no cifrados, salvo que se active el cifrado en reposo; en la práctica se integran con gestores externos (External Secrets Operator, Vault).
- **Namespace**: agrupación lógica para separar equipos, aplicaciones o entornos, con cuotas y permisos propios.
- **StatefulSet**: para aplicaciones con estado (bases de datos, Kafka) que necesitan identidad estable (`kafka-0`, `kafka-1`) y almacenamiento persistente propio por réplica.
- **PersistentVolume** y **PersistentVolumeClaim**: almacenamiento que sobrevive a los pods.
- **Job** y **CronJob**: tareas que se ejecutan hasta completarse, puntualmente o de forma programada (buena alternativa a `@Scheduled` con varias réplicas).
- **DaemonSet**: un pod por nodo (agentes de logs o monitorización).
- **HorizontalPodAutoscaler**: ajusta el número de réplicas según métricas.
- **ServiceAccount**, **Role** y **RoleBinding**: identidad y permisos (RBAC) dentro del clúster.

Comandos básicos: `kubectl get pods`, `kubectl describe pod <nombre>`, `kubectl logs -f <pod>`, `kubectl apply -f <fichero>`, `kubectl rollout status deployment/<nombre>`, `kubectl rollout undo deployment/<nombre>`, `kubectl port-forward svc/<nombre> 8080:80`.

## P143 · ¿Cómo sería el manifiesto de Kubernetes de un microservicio Spring Boot preparado para producción?

*Tema: Kubernetes · Despliegue · Monográfico B*

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pedidos
  labels: { app: pedidos }
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate: { maxSurge: 1, maxUnavailable: 0 }
  selector:
    matchLabels: { app: pedidos }
  template:
    metadata:
      labels: { app: pedidos }
    spec:
      terminationGracePeriodSeconds: 45
      securityContext:
        runAsNonRoot: true
      containers:
        - name: pedidos
          image: registro.miempresa.com/tienda/pedidos:1.4.2
          ports:
            - containerPort: 8080
          env:
            - name: SPRING_PROFILES_ACTIVE
              value: prod
            - name: SPRING_DATASOURCE_PASSWORD
              valueFrom:
                secretKeyRef: { name: pedidos-db, key: password }
          envFrom:
            - configMapRef: { name: pedidos-config }
          resources:
            requests: { cpu: "500m", memory: "768Mi" }
            limits:   { memory: "768Mi" }
          startupProbe:
            httpGet: { path: /actuator/health/liveness, port: 8080 }
            periodSeconds: 5
            failureThreshold: 30
          livenessProbe:
            httpGet: { path: /actuator/health/liveness, port: 8080 }
            periodSeconds: 10
          readinessProbe:
            httpGet: { path: /actuator/health/readiness, port: 8080 }
            periodSeconds: 5
          lifecycle:
            preStop:
              sleep: { seconds: 10 }
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
          volumeMounts:
            - { name: tmp, mountPath: /tmp }
      volumes:
        - { name: tmp, emptyDir: {} }
---
apiVersion: v1
kind: Service
metadata:
  name: pedidos
spec:
  selector: { app: pedidos }
  ports:
    - port: 80
      targetPort: 8080
```

Decisiones que conviene saber justificar:

- **`maxUnavailable: 0`**: durante el despliegue nunca hay menos réplicas listas que las deseadas.
- **Tres sondas**: `startupProbe` protege el arranque (hasta 150 segundos aquí) sin tener que poner una liveness muy permisiva; la **liveness** reinicia el contenedor si se bloquea; la **readiness** lo retira del Service mientras no puede atender.
- **Apagado ordenado**: cuando Kubernetes elimina un pod, en paralelo lo retira de los endpoints del Service y le envía `SIGTERM`. El `preStop` de unos segundos da tiempo a que los balanceadores dejen de enviarle tráfico antes de que la aplicación empiece a cerrarse; después, el graceful shutdown de Spring Boot termina las peticiones en curso. El `terminationGracePeriodSeconds` debe cubrir ambas cosas. (La acción `sleep` en `preStop` es nativa en versiones recientes de Kubernetes; antes se usaba un `exec` con `sleep`, que requiere tener ese binario en la imagen).
- **Recursos**: `requests` de memoria igual al límite para un comportamiento predecible de la JVM; límite de CPU omitido para evitar el *throttling*, una práctica habitual (aunque depende de la política de cada organización).
- **Secretos** desde un `Secret`, no en el ConfigMap ni en la imagen.
- **Seguridad**: usuario no root, sin escalada de privilegios y sistema de ficheros de solo lectura, con un `emptyDir` en `/tmp` porque Tomcat y otras librerías necesitan escribir ficheros temporales.

Complementos habituales: un **PodDisruptionBudget** (`minAvailable: 2`) para que el mantenimiento de nodos no tire todas las réplicas, reglas de **anti-afinidad** o `topologySpreadConstraints` para repartir las réplicas entre nodos y zonas, un **HorizontalPodAutoscaler** y **NetworkPolicies** para limitar qué servicios pueden hablar con cuáles.

## P144 · ¿Qué son Helm y Kustomize? ¿Cómo se gestionan las diferencias entre entornos?

*Tema: Kubernetes · Herramientas · Monográfico B*

Mantener manifiestos YAML casi idénticos para desarrollo, staging y producción por separado lleva a duplicación y a diferencias accidentales. Dos herramientas resuelven el problema con enfoques distintos:

**Helm** es un gestor de paquetes para Kubernetes basado en **plantillas**. Un *chart* contiene plantillas de manifiestos con variables (sintaxis de Go templates) y un fichero `values.yaml` con los valores por defecto. Cada entorno aporta su propio fichero de valores.

```yaml
# templates/deployment.yaml (fragmento)
spec:
  replicas: {{ .Values.replicas }}
  template:
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
```

```bash
helm upgrade --install pedidos ./chart -f values-prod.yaml --set image.tag=1.4.2
```

- A favor: muy potente, gestiona versiones de lanzamientos (*releases*) y rollback, y existe un enorme ecosistema de charts públicos para instalar infraestructura (Kafka, PostgreSQL, Prometheus, ingress controllers...).
- En contra: las plantillas complejas son difíciles de leer y depurar; se mezcla lógica de plantillas con YAML.

**Kustomize** (integrado en `kubectl apply -k`) usa **superposiciones** sin plantillas: una **base** con manifiestos YAML válidos y **overlays** por entorno que aplican parches.

```text
k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── overlays/
    ├── staging/kustomization.yaml    (1 réplica, imagen de staging)
    └── prod/
        ├── kustomization.yaml        (3 réplicas, recursos mayores)
        └── patch-recursos.yaml
```

- A favor: YAML puro y legible, sin lenguaje de plantillas; muy adecuado para las aplicaciones propias.
- En contra: menos expresivo para parametrizaciones complejas; no gestiona el ciclo de vida de releases.

En la práctica es frecuente usar **Helm para instalar software de terceros** y **Kustomize (o Helm sencillo) para los servicios propios**. Ambos encajan con **GitOps**: Argo CD y Flux saben renderizar charts de Helm y overlays de Kustomize desde un repositorio Git y aplicarlos al clúster.

Buena práctica: que la diferencia entre entornos sea **solo de configuración** (réplicas, recursos, URLs, secretos), nunca de imagen: la misma imagen probada en staging es la que llega a producción.

## P145 · ¿Cómo se escala automáticamente un microservicio en Kubernetes? HPA, VPA y KEDA.

*Tema: Kubernetes · Escalado · Monográfico B*

**HorizontalPodAutoscaler (HPA)**: ajusta el número de réplicas de un Deployment según métricas. Por defecto usa CPU o memoria (a través del Metrics Server), comparando el uso con los `requests` del contenedor.

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: pedidos
spec:
  scaleTargetRef: { apiVersion: apps/v1, kind: Deployment, name: pedidos }
  minReplicas: 3
  maxReplicas: 20
  metrics:
    - type: Resource
      resource:
        name: cpu
        target: { type: Utilization, averageUtilization: 65 }
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300    # evita subir y bajar continuamente
```

Consideraciones para servicios Java:

- **La memoria no es buena métrica de escalado** para la JVM: el heap tiende a crecer hasta su límite y el GC no lo devuelve necesariamente al sistema, así que el uso de memoria no refleja la carga.
- La CPU durante el **arranque** es muy alta (compilación JIT, inicialización de Spring), lo que puede provocar escalados en cascada si se crean pods nuevos a la vez. Las ventanas de estabilización y un buen `startupProbe` ayudan.
- El escalado tarda: detección, programación del pod, descarga de la imagen y arranque de la aplicación. Para picos predecibles es mejor escalar de forma anticipada o programada.

**Métricas personalizadas o externas**: el HPA puede usar métricas de negocio (peticiones por segundo, latencia, longitud de una cola) mediante adaptadores como Prometheus Adapter.

**KEDA** (Kubernetes Event-Driven Autoscaling) simplifica el escalado basado en eventos con *scalers* para decenas de fuentes: **lag de consumidores de Kafka**, longitud de colas de RabbitMQ o SQS, consultas de Prometheus, cron. También permite **escalar a cero** réplicas cuando no hay trabajo. Para un consumidor de Kafka es la forma más natural de escalar: más lag, más consumidores (hasta el número de particiones).

**VerticalPodAutoscaler (VPA)**: ajusta los `requests` y `limits` de los contenedores según el uso histórico. Útil sobre todo en modo recomendación para dimensionar correctamente; en modo automático recrea los pods para aplicar cambios y no se debe combinar con un HPA basado en la misma métrica.

**Cluster Autoscaler** o **Karpenter**: añaden o eliminan **nodos** del clúster cuando hay pods que no caben o nodos infrautilizados. El escalado de pods sin escalado de nodos acaba en pods pendientes.

## P146 · Un pod está en CrashLoopBackOff. ¿Cómo lo diagnosticas? ¿Qué otros estados problemáticos conoces?

*Tema: Kubernetes · Operación · Monográfico B*

**CrashLoopBackOff** significa que el contenedor arranca, termina (con error) y Kubernetes lo reinicia una y otra vez, con esperas crecientes entre intentos.

Proceso de diagnóstico:

- `kubectl describe pod <pod>`: muestra los **eventos** (fallos de sondas, falta de recursos, problemas al montar volúmenes) y en `Last State` el **motivo y código de salida** de la última terminación.
- `kubectl logs <pod> --previous`: los logs del contenedor **anterior**, el que falló (sin `--previous` se ven los del intento actual, que quizá aún no ha escrito nada).
- Interpretar el código de salida: `1` suele ser un error de la aplicación (excepción en el arranque: configuración ausente, base de datos inaccesible, bean que no se puede crear); **`137`** indica que el proceso fue matado con `SIGKILL`, normalmente por **OOMKilled** (superó el límite de memoria) o por no terminar a tiempo; `143` es una terminación con `SIGTERM`.

Causas típicas en Spring Boot: propiedades o secretos que faltan, errores de conexión con dependencias al arrancar, migraciones de Flyway que fallan, **sondas de liveness demasiado agresivas** que matan la aplicación antes de que termine de arrancar, y límites de memoria insuficientes para la JVM.

Otros estados habituales:

- **ImagePullBackOff / ErrImagePull**: no se puede descargar la imagen: nombre o etiqueta incorrectos, registro privado sin credenciales (`imagePullSecrets`) o sin acceso de red.
- **Pending**: el pod no se puede programar en ningún nodo: recursos solicitados que no caben, restricciones de afinidad imposibles o un volumen persistente que no se puede enlazar. `kubectl describe` indica el motivo.
- **OOMKilled**: el contenedor superó su límite de memoria. Revisar la configuración de heap frente al límite, el consumo fuera del heap o fugas de memoria.
- **Running pero sin estar listo** (`READY 0/1`): la sonda de readiness falla; el pod no recibe tráfico.
- **CreateContainerConfigError**: suele indicar que falta un ConfigMap o un Secret referenciado.
- **Evicted**: el nodo se quedó sin recursos (memoria, disco) y expulsó el pod.

Herramientas útiles: `kubectl get events --sort-by=.lastTimestamp`, `kubectl exec -it <pod> -- sh` (si la imagen tiene shell), **contenedores efímeros de depuración** (`kubectl debug -it <pod> --image=busybox --target=<contenedor>`, imprescindibles con imágenes distroless), `kubectl top pod` para el consumo real, e interfaces como **k9s** o Lens.

> **Clave para la entrevista.** Recordar el --previous en kubectl logs y el significado del código 137 es exactamente el tipo de detalle práctico que buscan en entrevistas con componente de plataforma.

## P147 · ¿Qué buenas prácticas de seguridad aplicarías a contenedores y a despliegues en Kubernetes?

*Tema: Kubernetes · Seguridad · Monográfico B*

**En la imagen**:

- Imágenes base mínimas (JRE, distroless) y actualizadas; menos paquetes significa menos vulnerabilidades.
- **Escaneo** de vulnerabilidades en la CI (Trivy, Grype, el escáner del registro) y política de corrección según gravedad.
- Nunca incluir secretos en la imagen (tampoco en capas intermedias ni en variables `ENV` del Dockerfile): cualquiera con acceso a la imagen puede extraerlos.
- Firmar las imágenes y generar el SBOM; en el clúster, admitir solo imágenes firmadas procedentes de registros de confianza (políticas de admisión con Kyverno u OPA Gatekeeper).

**En el pod** (`securityContext`):

- `runAsNonRoot: true` y un usuario sin privilegios.
- `allowPrivilegeEscalation: false`, eliminar las *capabilities* de Linux innecesarias (`drop: ["ALL"]`).
- `readOnlyRootFilesystem: true`, con volúmenes `emptyDir` solo donde se necesite escribir.
- Nunca contenedores `privileged` para aplicaciones.
- Los **Pod Security Standards** (`restricted`) aplicados por namespace imponen estas reglas.

**En el clúster**:

- **RBAC** con mínimo privilegio; las aplicaciones normalmente no necesitan acceso a la API de Kubernetes, así que se desactiva el montaje automático del token de la ServiceAccount (`automountServiceAccountToken: false`).
- **NetworkPolicies**: por defecto, cualquier pod puede comunicarse con cualquier otro. Con una política de denegación por defecto y reglas explícitas, un servicio comprometido no puede alcanzar la base de datos de otro.
- **Secretos**: cifrado en reposo en etcd e integración con gestores externos (Vault, Secrets Manager, Key Vault) mediante External Secrets Operator o el CSI Secrets Store driver; rotación periódica.
- **mTLS** entre servicios con un service mesh cuando se requiere cifrado interno e identidad de servicio.
- Identidad de carga de trabajo (*workload identity*) para acceder a servicios cloud sin credenciales estáticas.

**En la aplicación**: dependencias actualizadas y analizadas, validación de entrada, Actuator no expuesto públicamente, cabeceras de seguridad y logs sin datos sensibles.

El principio que lo resume todo es **defensa en profundidad**: asumir que alguna capa fallará y que las demás deben limitar el daño.

# Monográfico C · Observabilidad y monitorización

Señales doradas, Prometheus, Micrometer, Grafana, alertas y SLO, logs centralizados, trazas distribuidas, OpenTelemetry, plataformas comerciales y correlación de señales.

Este capítulo contiene 11 preguntas.

## P148 · ¿Qué diferencia hay entre monitorización y observabilidad? ¿Qué son las señales doradas?

*Tema: Observabilidad · Conceptos · Monográfico C*

**Monitorización** es vigilar indicadores conocidos de antemano para detectar problemas conocidos: «avísame si la CPU supera el 90 %» o «si el endpoint de salud falla». Responde a preguntas que ya sabías que tenías que hacer.

**Observabilidad** es la capacidad de entender **qué está pasando dentro del sistema a partir de sus salidas**, incluso ante problemas nuevos que nadie anticipó: «¿por qué los pagos de clientes de un país con tarjetas de un banco concreto tardan 4 segundos desde el martes?». Requiere telemetría rica, correlacionada y con suficiente contexto (logs, métricas y trazas con atributos útiles) para poder formular preguntas nuevas sin desplegar código nuevo.

En microservicios, la observabilidad es imprescindible: una petición atraviesa muchos servicios y un fallo en cualquiera se manifiesta como síntoma en otro.

Las **cuatro señales doradas** (*golden signals*), popularizadas por el libro de SRE de Google, son el punto de partida para vigilar cualquier servicio orientado al usuario:

- **Latencia**: cuánto tardan las peticiones, en percentiles (p50, p95, p99), distinguiendo entre las correctas y las erróneas (un error rápido puede enmascarar una latencia mala).
- **Tráfico**: cuánta demanda recibe el servicio (peticiones por segundo, mensajes por segundo).
- **Errores**: tasa de peticiones fallidas, tanto explícitas (5xx) como implícitas (respuestas incorrectas o demasiado lentas según el acuerdo de servicio).
- **Saturación**: cuánto se acerca el servicio a su capacidad (uso del pool de conexiones, colas internas, hilos ocupados, CPU, memoria). Suele anticipar los problemas.

Métodos equivalentes: **RED** (Rate, Errors, Duration) para servicios, y **USE** (Utilization, Saturation, Errors) para recursos como CPU, memoria, disco o pools.

Con Spring Boot Actuator y Micrometer, la mayoría de estas métricas se obtienen sin código: `http.server.requests` (con etiquetas de URI, método, estado y resultado) da tráfico, errores y latencia de cada endpoint; las métricas de HikariCP, Tomcat y la JVM cubren la saturación.

## P149 · ¿Cómo funciona Prometheus y qué tipos de métricas existen?

*Tema: Observabilidad · Prometheus · Monográfico C*

**Prometheus** es el sistema de monitorización de referencia en el ecosistema cloud native. Características principales:

- **Modelo pull**: Prometheus consulta (*scrapea*) periódicamente un endpoint HTTP de cada aplicación que expone sus métricas en formato de texto. En Spring Boot, `/actuator/prometheus` con la dependencia `micrometer-registry-prometheus`.
- **Descubrimiento de objetivos**: en Kubernetes descubre automáticamente los pods y servicios a consultar (a menudo mediante el **Prometheus Operator** y recursos `ServiceMonitor` o `PodMonitor`).
- **Base de datos de series temporales**: cada serie se identifica por el nombre de la métrica y un conjunto de **etiquetas** (*labels*): `http_server_requests_seconds_count{uri="/api/pedidos", method="GET", status="200"}`.
- **PromQL** para consultar y agregar, reglas de **alerta** evaluadas por Prometheus y enviadas a **Alertmanager**, que las agrupa, silencia y enruta (email, Slack, PagerDuty, Opsgenie).

Tipos de métricas:

- **Counter**: valor que solo crece (se reinicia al reiniciar el proceso). Peticiones totales, errores totales, bytes enviados. Nunca se usa su valor absoluto, sino su tasa de cambio con `rate()`.
- **Gauge**: valor que sube y baja. Conexiones activas, memoria usada, tamaño de una cola, temperatura.
- **Histogram**: cuenta las observaciones en **cubos** (*buckets*) predefinidos, además de su suma y su número. Permite calcular percentiles **agregando entre instancias** con `histogram_quantile()`. Es el tipo adecuado para latencias.
- **Summary**: calcula los percentiles en la propia aplicación. Más preciso para una instancia, pero **los percentiles no se pueden agregar** entre instancias (la media de los p99 de tres pods no es el p99 global). Por eso en microservicios se prefieren los histogramas.

En Micrometer, para que un `Timer` publique histogramas hay que activarlo:

```yaml
management:
  endpoints.web.exposure.include: health,info,prometheus
  metrics:
    distribution:
      percentiles-histogram:
        http.server.requests: true
    tags:
      application: ${spring.application.name}
      entorno: ${ENTORNO:local}
```

Limitaciones de Prometheus: está pensado para retención local de corto o medio plazo y una sola instancia. Para alta disponibilidad, retención larga y vista global de varios clústeres se usan **Thanos**, **Grafana Mimir**, **Cortex** o **VictoriaMetrics**. Para procesos de vida corta (jobs) que no viven lo bastante para ser consultados existe el **Pushgateway**, o se envían las métricas por OTLP.

## P150 · ¿Cómo se crean métricas de negocio propias con Micrometer? ¿Qué es la cardinalidad y por qué importa?

*Tema: Observabilidad · Micrometer · Monográfico C*

**Micrometer** es la fachada de métricas de Spring (el «SLF4J de las métricas»): el código instrumenta una vez y las métricas se exportan al sistema que se configure (Prometheus, Datadog, New Relic, OTLP, CloudWatch...).

Las métricas técnicas vienen de serie, pero las más valiosas suelen ser las **de negocio**: pedidos creados, importe facturado, pagos rechazados por motivo, tiempo hasta la confirmación.

```java
@Service
public class PedidoService {
    private final Counter pedidosCreados;
    private final Timer tiempoConfirmacion;
    private final MeterRegistry registry;

    public PedidoService(MeterRegistry registry) {
        this.registry = registry;
        this.pedidosCreados = Counter.builder("tienda.pedidos.creados")
            .description("Pedidos creados")
            .register(registry);
        this.tiempoConfirmacion = Timer.builder("tienda.pedidos.confirmacion")
            .publishPercentileHistogram()
            .register(registry);
    }

    public void pagoRechazado(String motivo) {
        registry.counter("tienda.pagos.rechazados", "motivo", motivo).increment();
    }

    public Pedido confirmar(Long id) {
        return tiempoConfirmacion.record(() -> confirmarInterno(id));
    }
}
```

Alternativas más declarativas: `@Timed` y `@Counted` (requieren registrar el aspecto correspondiente) o la **Observation API** con `@Observed`, que genera a la vez métrica y span de traza.

Para gauges, se registra una función que Micrometer consulta al publicar: `Gauge.builder("tienda.cola.pendientes", cola, Queue::size).register(registry)`. Micrometer guarda una referencia débil al objeto observado: si nadie más lo referencia, el gauge desaparece, un error sorprendente y frecuente.

**Cardinalidad**: cada combinación distinta de valores de etiquetas crea una **serie temporal nueva**. Con las etiquetas `metodo` (5 valores) × `uri` (40) × `estado` (10) ya hay 2.000 series por instancia. Si se añade una etiqueta con **valores ilimitados** (identificador de usuario, de pedido, email, URL con parámetros), el número de series crece sin control:

- Prometheus consume mucha memoria y se vuelve lento o cae.
- En plataformas comerciales, el coste se dispara (se factura por serie).

Reglas prácticas:

- Las etiquetas solo pueden tomar un **conjunto pequeño y acotado** de valores (motivo de rechazo, país, canal, tipo de cliente).
- Los identificadores concretos van en **logs y trazas**, que están hechos para eso, nunca en métricas.
- Spring ya normaliza la URI de `http.server.requests` a la plantilla (`/api/pedidos/{id}`), pero un filtro propio mal hecho puede romperlo; en clientes HTTP, usar siempre plantillas de URI.
- Se pueden limitar o eliminar etiquetas con un `MeterFilter` (por ejemplo, `MeterFilter.maximumAllowableTags`).

> **Clave para la entrevista.** La cardinalidad es probablemente el error más caro en observabilidad. Mencionarlo espontáneamente al hablar de métricas propias demuestra experiencia en producción.

## P151 · ¿Qué consultas PromQL y qué paneles de Grafana usarías para vigilar un microservicio?

*Tema: Observabilidad · Grafana · Monográfico C*

**Grafana** es la herramienta de visualización más utilizada: construye paneles (*dashboards*) sobre múltiples fuentes de datos (Prometheus, Loki, Tempo, Elasticsearch, bases de datos, plataformas cloud) y también gestiona alertas.

Consultas PromQL fundamentales para un servicio Spring Boot:

```text
# Tráfico: peticiones por segundo por endpoint
sum by (uri) (rate(http_server_requests_seconds_count{application="pedidos"}[5m]))

# Tasa de errores (porcentaje de 5xx)
sum(rate(http_server_requests_seconds_count{application="pedidos", status=~"5.."}[5m]))
  / sum(rate(http_server_requests_seconds_count{application="pedidos"}[5m]))

# Latencia p95 por endpoint (requiere histogramas activados)
histogram_quantile(0.95,
  sum by (le, uri) (rate(http_server_requests_seconds_bucket{application="pedidos"}[5m])))

# Saturación del pool de conexiones: hilos esperando conexión
max by (pod) (hikaricp_connections_pending{application="pedidos"})

# Pausas de GC por segundo
sum by (pod) (rate(jvm_gc_pause_seconds_sum{application="pedidos"}[5m]))

# Uso de heap sobre el máximo
sum by (pod) (jvm_memory_used_bytes{area="heap"}) / sum by (pod) (jvm_memory_max_bytes{area="heap"})
```

Conceptos clave de PromQL: `rate()` calcula la tasa por segundo de un counter en una ventana (y maneja los reinicios del contador), `sum by (...)` agrega manteniendo solo las etiquetas indicadas, `histogram_quantile()` calcula percentiles a partir de los cubos y el sufijo `_bucket` identifica esos cubos.

Estructura recomendada de un dashboard de servicio:

- **Fila de resumen** con las señales doradas: tráfico, tasa de errores, latencia p50/p95/p99 y estado del SLO.
- **Fila por endpoint**: los más usados y los más lentos.
- **Dependencias**: latencia y errores de las llamadas salientes (clientes HTTP, base de datos, Kafka, lag de consumidores).
- **Recursos**: CPU, memoria heap y no heap, GC, hilos, pool de conexiones.
- **Negocio**: pedidos por minuto, pagos rechazados, importe.

Buenas prácticas: variables de plantilla (entorno, servicio, pod) para reutilizar el mismo dashboard en todos los servicios, anotaciones con los **despliegues** para correlacionar cambios de comportamiento con versiones, dashboards gestionados como código (JSON en Git, Grafonnet o el provisionamiento de Grafana) y enlaces que permitan saltar de una métrica a los logs y trazas del mismo periodo. Existen dashboards de la comunidad para la JVM y Spring Boot que sirven como punto de partida.

## P152 · ¿Cómo se diseñan buenas alertas? ¿Qué son los SLI, SLO, SLA y el error budget?

*Tema: Observabilidad · Alertas · Monográfico C*

Un mal sistema de alertas genera **fatiga**: tantas alertas irrelevantes que el equipo deja de prestarles atención y la importante pasa desapercibida.

Principios de una buena alerta:

- **Alertar por síntomas, no por causas**: lo importante es que los usuarios sufren errores o lentitud, no que un pod tenga la CPU al 90 % (que puede ser completamente normal). Las causas son útiles en los dashboards para diagnosticar.
- **Cada alerta debe ser accionable**: si al recibirla no hay nada que hacer, no debe despertar a nadie. Cada alerta enlaza a un **runbook** con los pasos de diagnóstico.
- **Distinguir urgencia**: lo que requiere atención inmediata (página a la persona de guardia) de lo que puede esperar al horario laboral (ticket).

Terminología:

- **SLI** (*Service Level Indicator*): una medida de la calidad del servicio desde el punto de vista del usuario. Por ejemplo, la proporción de peticiones de pago que terminan con éxito en menos de 500 ms.
- **SLO** (*Service Level Objective*): el objetivo interno para un SLI en una ventana de tiempo. Por ejemplo, el 99,9 % de las peticiones de pago correctas y rápidas en 30 días.
- **SLA** (*Service Level Agreement*): el compromiso contractual con los clientes, con consecuencias (penalizaciones) si se incumple. Siempre menos exigente que el SLO interno, para tener margen.
- **Error budget** (presupuesto de errores): lo que el SLO permite fallar. Un SLO del 99,9 % en 30 días permite unos 43 minutos de indisponibilidad o el 0,1 % de peticiones fallidas. Si el presupuesto se agota, se prioriza la fiabilidad sobre las nuevas funcionalidades; si sobra, se puede asumir más riesgo (desplegar más a menudo, experimentar).

**Alertas por tasa de consumo** (*burn rate*): en lugar de alertar ante cualquier error, se alerta cuando el presupuesto se consume demasiado rápido. Por ejemplo, un consumo 14 veces superior al sostenible durante una hora agotaría el presupuesto mensual en dos días: requiere acción inmediata. Un consumo 3 veces superior durante seis horas merece un ticket. Combinar ventanas largas y cortas reduce tanto los falsos positivos como el tiempo de detección.

```yaml
groups:
  - name: pedidos-slo
    rules:
      - alert: PedidosErrorBudgetBurnRapido
        expr: |
          (sum(rate(http_server_requests_seconds_count{application="pedidos",status=~"5.."}[1h]))
            / sum(rate(http_server_requests_seconds_count{application="pedidos"}[1h]))) > (14 * 0.001)
        for: 2m
        labels: { severity: page }
        annotations:
          summary: "Pedidos está consumiendo el error budget a gran velocidad"
          runbook_url: "https://wiki.miempresa.com/runbooks/pedidos-errores"
```

Herramientas como **Sloth** o **Pyrra** generan automáticamente estas reglas a partir de la definición de un SLO.

## P153 · ¿Cómo se centralizan y explotan los logs en microservicios? ELK, EFK y Loki.

*Tema: Observabilidad · Logs · Monográfico C*

Con decenas de servicios y réplicas efímeras, entrar en cada máquina a leer ficheros es inviable: los logs deben **centralizarse**.

Arquitectura habitual:

- La aplicación escribe logs **estructurados en JSON a stdout** (principio 12-factor).
- Un **agente recolector** en cada nodo (DaemonSet en Kubernetes) lee los logs de los contenedores, añade metadatos (namespace, pod, contenedor, etiquetas) y los envía al almacenamiento: **Fluent Bit**, **Fluentd**, **Vector**, **Filebeat**, **Promtail/Alloy** o el **OpenTelemetry Collector**.
- Un **almacenamiento con búsqueda** y una interfaz de consulta.

Stacks más comunes:

- **ELK** (Elasticsearch, Logstash, Kibana) o **EFK** (con Fluentd/Fluent Bit en lugar de Logstash), o su bifurcación **OpenSearch**. Indexa el contenido completo de los logs: búsquedas de texto libre muy potentes y analítica, a cambio de un coste alto de almacenamiento y operación.
- **Grafana Loki**: solo indexa las **etiquetas** (servicio, namespace, nivel), no el contenido; el texto se filtra en el momento de consultar. Mucho más barato de operar a gran escala y perfectamente integrado con Grafana, Prometheus y Tempo. Consultas con LogQL: `{app="pedidos", nivel="ERROR"} |= "timeout" | json | duracion > 2000`.
- **Plataformas comerciales** (Datadog, Splunk, New Relic, Elastic Cloud) y servicios cloud (CloudWatch Logs, Azure Monitor, Google Cloud Logging).

Qué loguear y cómo:

- **Formato estructurado** con campos consistentes entre servicios: marca de tiempo, nivel, servicio, versión, `traceId`, `spanId`, mensaje y atributos de contexto (identificador de pedido, de usuario en su forma pseudonimizada). Spring Boot 3.4+ genera JSON estructurado de forma nativa.
- **Niveles con criterio**: `ERROR` para lo que requiere atención, `WARN` para anomalías recuperables, `INFO` para eventos de negocio relevantes y ciclo de vida, `DEBUG` desactivado en producción (activable en caliente con `/actuator/loggers` durante una investigación).
- **Correlación**: que cada línea lleve el `traceId` permite pasar de una traza lenta a todos sus logs en todos los servicios.
- **Nunca** contraseñas, tokens, números de tarjeta ni datos personales innecesarios (cumplimiento normativo); aplicar enmascaramiento.
- **Un error, un log**: registrar la excepción con su stack trace una sola vez, donde se gestiona.
- Controlar el **volumen**: los logs son una de las partidas más caras de la observabilidad. Muestrear logs muy repetitivos, definir retenciones por tipo y no loguear cada petición exitosa si ya existen métricas y trazas.

## P154 · ¿Cómo funciona el tracing distribuido? ¿Qué son el muestreo y la propagación de contexto?

*Tema: Observabilidad · Trazas · Monográfico C*

Una **traza** representa el recorrido completo de una petición por el sistema. Está formada por **spans**: cada span es una operación con nombre, inicio, duración, estado y atributos (una petición HTTP recibida, una llamada a otro servicio, una consulta a la base de datos, la publicación de un mensaje). Los spans forman un árbol mediante relaciones padre-hijo, y todos comparten el mismo `traceId`.

**Propagación de contexto**: para que el servicio B sepa que su trabajo forma parte de la traza iniciada en A, A envía el contexto en cabeceras. El estándar es **W3C Trace Context**:

```text
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
             versión-traceId (16 bytes)-spanId padre (8 bytes)-flags (muestreado)
```

También existe la cabecera `baggage` para propagar pares clave-valor de negocio a lo largo de la traza (por ejemplo, el tenant). En mensajería, el contexto viaja en las cabeceras del mensaje.

En Spring Boot 3 se usa **Micrometer Tracing** con un puente a **OpenTelemetry** (o a Brave) y un exportador:

```xml
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-tracing-bridge-otel</artifactId>
</dependency>
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-exporter-otlp</artifactId>
</dependency>
```

```yaml
management:
  tracing:
    sampling:
      probability: 0.1
  otlp:
    tracing:
      endpoint: http://otel-collector:4318/v1/traces
```

Con esto se instrumentan automáticamente las peticiones entrantes, los clientes HTTP creados a partir de los *builders* inyectados, JDBC (con la librería adecuada), Kafka y RabbitMQ, y el `traceId` se añade al MDC de los logs. Spring Boot 4 ofrece además un starter dedicado de OpenTelemetry.

**Muestreo** (*sampling*): guardar todas las trazas de un sistema con mucho tráfico es muy caro.

- **Head-based**: se decide al inicio de la traza (por ejemplo, el 10 %) y la decisión se propaga. Simple y barato, pero puede descartar precisamente la traza del error interesante.
- **Tail-based**: se decide al final, cuando ya se sabe si la traza tuvo errores o fue lenta. Permite conservar el 100 % de las trazas con error o latencia alta y una muestra del resto. Requiere almacenar temporalmente todos los spans, normalmente en el **OpenTelemetry Collector** (procesador `tail_sampling`).

Backends de trazas: **Jaeger**, **Zipkin**, **Grafana Tempo**, y las plataformas APM comerciales. La vista de una traza (diagrama de cascada o *waterfall*) muestra inmediatamente dónde se va el tiempo y qué llamada falló.

Un detalle importante: la propagación de contexto se pierde fácilmente al cambiar de hilo (`@Async`, `CompletableFuture`, ejecutores propios). Spring Boot configura la propagación en sus ejecutores gestionados, pero un `Executors.newFixedThreadPool()` creado a mano necesita envolverse (`ContextExecutorService` de la librería Context Propagation).

## P155 · ¿Qué es OpenTelemetry? ¿Qué papel juega el OpenTelemetry Collector? ¿Agente Java o Micrometer?

*Tema: Observabilidad · OpenTelemetry · Monográfico C*

**OpenTelemetry** (OTel) es un proyecto de la CNCF que define un **estándar abierto** para generar, recoger y exportar telemetría (trazas, métricas y logs), con APIs y SDKs para muchos lenguajes, convenciones semánticas comunes (nombres estándar de atributos como `http.request.method` o `db.system`) y el protocolo **OTLP**. Su gran ventaja es la **independencia del proveedor**: se instrumenta una vez y se envía a cualquier backend compatible (prácticamente todos lo son hoy).

El **OpenTelemetry Collector** es un proceso intermedio entre las aplicaciones y los backends. Se despliega como agente (en cada nodo) o como servicio central (*gateway*), o ambos. Su pipeline tiene tres partes:

- **Receivers**: reciben telemetría (OTLP, Prometheus, Jaeger, Zipkin, logs de ficheros...).
- **Processors**: la transforman: agrupan en lotes, añaden metadatos de Kubernetes, eliminan atributos sensibles, aplican **muestreo tail-based**, limitan memoria.
- **Exporters**: la envían a uno o varios destinos a la vez (Tempo y Datadog, por ejemplo).

Ventajas de usarlo: las aplicaciones solo conocen el Collector (cambiar de proveedor no requiere tocarlas), centraliza el procesamiento, reintenta ante fallos del backend y permite enviar a varios destinos durante una migración.

**Dos formas de instrumentar una aplicación Spring Boot**:

- **Agente Java de OpenTelemetry** (`-javaagent:opentelemetry-javaagent.jar`): instrumenta automáticamente, mediante manipulación de bytecode, cientos de librerías sin cambiar el código ni las dependencias. Muy cómodo, especialmente para aplicaciones heredadas o muchos servicios heterogéneos. Contrapartidas: aumenta el tiempo de arranque, es menos transparente al depurar, puede entrar en conflicto con otros agentes y no es compatible con imágenes nativas de GraalVM.
- **Micrometer (Observation API, Micrometer Tracing) o el starter de OpenTelemetry para Spring Boot**: instrumentación integrada en el propio framework mediante dependencias y configuración. Más ligera, se controla desde la configuración de Spring y funciona con imágenes nativas; cubre las librerías que Spring integra, y el resto necesita instrumentación manual o librerías específicas.

Ambas opciones exportan en OTLP, así que desde el Collector en adelante el resultado es el mismo. La elección suele depender de la estandarización de la organización: muchas empresas usan el agente como norma común para todos los lenguajes, mientras que los equipos centrados en Spring prefieren la integración nativa.

Los **logs** en OpenTelemetry funcionan como un puente: el SDK recoge los eventos de Logback o Log4j2 (mediante un *appender*) y los envía por OTLP con el contexto de traza ya incluido, como alternativa a leer los ficheros de stdout.

## P156 · ¿Qué plataformas y herramientas de monitorización conoces? ¿Cómo elegirías entre opciones open source y comerciales?

*Tema: Observabilidad · Herramientas · Monográfico C*

**Stack open source** (autogestionado o en versión gestionada):

- **Prometheus** + **Alertmanager** para métricas y alertas; **Thanos**, **Mimir** o **VictoriaMetrics** para escalarlo.
- **Grafana** para visualización. El conjunto de Grafana Labs (**Loki** para logs, **Tempo** para trazas, **Mimir** para métricas, **Pyroscope** para profiling y **Alloy** como recolector) se conoce como stack LGTM y ofrece una experiencia muy integrada.
- **ELK/OpenSearch** para logs con búsqueda completa.
- **Jaeger** o **Zipkin** para trazas.
- **OpenTelemetry Collector** como pieza común de recogida.
- **Kiali** (con Istio) para visualizar el tráfico del service mesh.

**Plataformas comerciales de observabilidad y APM**:

- **Datadog**: plataforma muy completa (infraestructura, APM, logs, RUM, seguridad), gran cantidad de integraciones y experiencia muy pulida. Coste que puede crecer mucho (por host, por serie de métricas personalizadas, por volumen de logs).
- **Dynatrace**: fuerte en detección automática de dependencias y análisis de causa raíz con IA, con un agente único (OneAgent); muy presente en grandes empresas.
- **New Relic**: APM veterano con modelo de precios por volumen de datos y usuarios.
- **Elastic Observability**: sobre el stack de Elastic, apoyado en OpenTelemetry.
- **Splunk Observability** y **Honeycomb** (este último muy orientado a eventos de alta cardinalidad y exploración de trazas).
- **Servicios de los proveedores cloud**: Amazon CloudWatch y X-Ray, Azure Monitor y Application Insights, Google Cloud Operations.
- Gestión de incidentes y guardias: **PagerDuty**, **Opsgenie**, **incident.io**.

**Criterios de elección**:

- **Coste total**: la licencia comercial frente al coste de personas y máquinas para operar el stack propio. A pequeña escala, lo gestionado suele salir más barato; a gran escala, el coste de las plataformas comerciales se convierte en un tema importante.
- **Capacidad del equipo** para operar infraestructura de observabilidad (que también necesita alta disponibilidad: la observabilidad no puede caerse junto con el sistema que vigila).
- **Correlación** entre señales y experiencia de investigación.
- **Requisitos de soberanía y cumplimiento** sobre dónde se almacenan los datos.
- **Evitar el bloqueo con un proveedor**: instrumentar con **OpenTelemetry** mantiene la libertad de cambiar de backend sin reinstrumentar las aplicaciones.

En una entrevista, más importante que conocer todas las herramientas es explicar **qué harías con ellas**: qué señales recoger, cómo correlacionarlas y cómo investigar un incidente de principio a fin.

## P157 · ¿Cómo se correlacionan métricas, logs y trazas para investigar un incidente? ¿Qué son los exemplars?

*Tema: Observabilidad · Correlación · Monográfico C*

La observabilidad aporta todo su valor cuando las tres señales están **conectadas** y se puede navegar de una a otra:

- **De la alerta a la métrica**: una alerta de SLO lleva al dashboard del servicio; se ve que el p99 de un endpoint se ha disparado desde las 10:42, coincidiendo con un despliegue (anotación en el panel).
- **De la métrica a la traza**: gracias a los **exemplars**, junto a los puntos del histograma de latencia se guardan identificadores de trazas concretas que cayeron en ese cubo. Desde el pico del gráfico se hace clic en un exemplar y se abre una traza lenta real.
- **De la traza a los logs**: la traza muestra que el tiempo se va en una consulta a la base de datos del servicio de inventario; como todos los logs llevan el `traceId`, se consultan todos los logs de esa petición en todos los servicios.
- **De los logs a la causa**: los logs muestran un aviso de que el pool de conexiones está agotado y reintentos contra una réplica de base de datos degradada.
- **Profiling**: si el tiempo se va en CPU de la propia aplicación, un perfil continuo (Pyroscope, JFR, perfiles de las plataformas APM) enlazado con los spans muestra qué métodos consumen la CPU.

Micrometer admite **exemplars** con Prometheus cuando el tracing está activado: al observar una latencia, adjunta el `traceId` de la traza actual. Grafana los muestra como puntos sobre los paneles de histogramas, enlazados con Tempo o Jaeger. Para almacenarlos, Prometheus debe arrancarse con la funcionalidad de exemplars habilitada.

Requisitos para que esta correlación funcione:

- **Identificadores comunes**: el mismo nombre de servicio, entorno y versión en las tres señales (en OpenTelemetry, los *resource attributes* `service.name`, `deployment.environment`, `service.version`).
- **`traceId` en todos los logs**, también en los de los consumidores de mensajes y tareas asíncronas.
- **Marcas de despliegue** y de cambios de configuración en los dashboards.
- Herramientas que enlacen entre sí (Grafana con Prometheus, Loki y Tempo; o una plataforma APM integrada).

Cerrar el ciclo: tras resolver el incidente, un **postmortem** documenta la línea temporal, la causa raíz y las acciones (una alerta que habría avisado antes, un test, un timeout mal configurado, un límite de recursos). Las métricas **MTTD** (tiempo hasta detectar) y **MTTR** (tiempo hasta recuperar) miden la eficacia de todo este sistema.

> **Clave para la entrevista.** Contar un incidente real siguiendo este recorrido (alerta → métrica → traza → log → causa → acción) es una de las respuestas más convincentes que puedes dar en una entrevista senior.

## P158 · ¿Qué tipos de health checks existen y qué es la monitorización sintética?

*Tema: Observabilidad · Salud · Monográfico C*

**Health checks internos** (los que expone la aplicación, como `/actuator/health`):

- **Liveness**: el proceso está vivo y no bloqueado. Debe ser muy simple y no depender de sistemas externos.
- **Readiness**: la instancia puede atender tráfico ahora mismo (ha terminado de arrancar, no está saturada, tiene acceso a sus dependencias imprescindibles).
- **Health detallado**: estado de cada componente (base de datos, disco, broker, servicios externos) para diagnóstico. Spring Boot agrega los `HealthIndicator` y se pueden configurar **grupos** para decidir qué indicadores cuentan en cada sonda:

```yaml
management:
  endpoint:
    health:
      probes.enabled: true
      show-details: when-authorized
      group:
        readiness:
          include: readinessState, db, redis
```

Precauciones: un indicador de salud que llama a un servicio externo lento puede hacer que el propio endpoint de salud sea lento y falle; y marcar como no disponible una instancia por una dependencia **no crítica** puede sacar del balanceo a todas las réplicas a la vez por un problema ajeno. Se recomienda que los health checks de dependencias sean rápidos, con timeouts, y que solo afecten a la readiness las dependencias sin las que realmente no se puede atender ninguna petición.

**Monitorización sintética**: pruebas automáticas que **simulan a un usuario** desde fuera del sistema, de forma periódica y desde distintas ubicaciones:

- **Comprobaciones de disponibilidad** (*uptime checks*): una petición a un endpoint público cada minuto, verificando código, contenido y tiempo de respuesta.
- **Transacciones sintéticas**: flujos completos de varios pasos (buscar producto, añadir al carrito, iniciar el pago con una cuenta de prueba), con navegadores automatizados (Playwright) o scripts de API.

Detectan problemas que la monitorización interna no ve: DNS, certificados caducados, CDN, balanceadores o un despliegue que rompió el flujo aunque cada servicio responda «sano». También funcionan cuando no hay tráfico real (de madrugada), lo que permite detectar fallos antes que los usuarios.

Herramientas: **Prometheus Blackbox Exporter**, **Grafana Synthetic Monitoring**, **Checkly**, **Uptime Kuma**, y las funcionalidades sintéticas de Datadog, New Relic o Dynatrace. Complemento natural: **RUM** (*Real User Monitoring*), que mide la experiencia de los usuarios reales en el navegador o la aplicación móvil.

# Apéndices

## Apéndice A · Preguntas relámpago

Preguntas breves que suelen aparecer al principio de una entrevista para calibrar el nivel, o como batería rápida al final. La respuesta esperada cabe en una o dos frases.

**¿Cuál es el scope por defecto de un bean?**
Singleton: una instancia por contexto de aplicación.

**¿Qué servidor embebido usa Spring Boot por defecto?**
Tomcat en aplicaciones Spring MVC; Netty en aplicaciones WebFlux.

**¿Qué librería usa Spring Boot por defecto para JSON?**
Jackson.

**¿Qué pool de conexiones usa Spring Boot por defecto?**
HikariCP.

**¿Qué versión mínima de Java necesita Spring Boot 3?**
Java 17.

**¿Qué diferencia hay entre `@Controller` y `@RestController`?**
`@RestController` añade `@ResponseBody` a todos los métodos: lo devuelto se serializa en el cuerpo en lugar de interpretarse como nombre de vista.

**¿Qué hace `@Transactional(readOnly = true)`?**
Marca la transacción como de solo lectura: Hibernate omite el dirty checking y el flush, y algunos drivers o routers pueden enviar la consulta a réplicas.

**¿Hace rollback `@Transactional` ante una `IOException`?**
No, por defecto solo ante excepciones no comprobadas y errores, salvo que se configure `rollbackFor`.

**¿Qué devuelve `findById` en Spring Data?**
Un `Optional<T>`.

**¿Qué anotación marca un campo de versión para bloqueo optimista?**
`@Version`.

**¿Qué código HTTP corresponde a un recurso creado?**
`201 Created`, idealmente con la cabecera `Location`.

**¿Qué código indica que el cliente ha superado el límite de peticiones?**
`429 Too Many Requests`.

**¿Qué verbo HTTP no es idempotente: PUT o POST?**
POST.

**¿Qué endpoint de Actuator expone métricas para Prometheus?**
`/actuator/prometheus`.

**¿Qué librería sustituyó a Hystrix para circuit breakers en Spring?**
Resilience4j.

**¿Qué sustituyó a Spring Cloud Sleuth en Spring Boot 3?**
Micrometer Tracing.

**¿Qué sustituyó a Netflix Zuul como gateway en Spring Cloud?**
Spring Cloud Gateway.

**¿Qué sustituyó a Ribbon para balanceo en el cliente?**
Spring Cloud LoadBalancer.

**¿Qué cliente HTTP síncrono se recomienda en Spring moderno?**
`RestClient`, directamente o a través de interfaces `@HttpExchange`.

**¿Qué garantiza el orden en Kafka?**
El orden solo se garantiza dentro de una partición; se usa la misma clave para que los mensajes relacionados vayan a la misma partición.

**¿Cuántos consumidores de un mismo grupo pueden leer una partición a la vez?**
Uno.

**¿Qué es el consumer lag?**
La diferencia entre el último offset escrito y el último confirmado por un grupo: los mensajes pendientes de procesar.

**¿Qué combinación de configuración evita perder datos en Kafka ante la caída de un broker?**
Factor de replicación 3, `min.insync.replicas=2` y `acks=all`.

**¿Qué es un tombstone en Kafka?**
Un registro con valor nulo que marca la eliminación de una clave en un topic compactado.

**¿Qué significa el código de salida 137 en un contenedor?**
El proceso fue terminado con SIGKILL, normalmente por superar el límite de memoria (OOMKilled).

**¿Qué diferencia hay entre liveness y readiness?**
Liveness decide si reiniciar el contenedor; readiness decide si enviarle tráfico.

**¿Qué objeto de Kubernetes da una dirección estable a un conjunto de pods?**
Un Service.

**¿Qué objeto de Kubernetes usarías para una tarea programada?**
Un CronJob.

**¿Por qué no usar `latest` como etiqueta de imagen en producción?**
Porque no es inmutable ni trazable: no se sabe qué versión está desplegada y el rollback es imposible de garantizar.

**¿Qué tipo de métrica de Prometheus usarías para latencias?**
Un histograma, porque sus percentiles se pueden agregar entre instancias.

**¿Qué función de PromQL calcula la tasa por segundo de un counter?**
`rate()`.

**¿Qué es la cardinalidad de una métrica?**
El número de series temporales distintas que genera, determinado por las combinaciones de valores de sus etiquetas.

**¿Qué estándar define la cabecera `traceparent`?**
W3C Trace Context.

**¿Qué es un SLO?**
Un objetivo interno de fiabilidad para un indicador de servicio en una ventana de tiempo, por ejemplo el 99,9 % de peticiones correctas en 30 días.

**¿Qué patrón resuelve la doble escritura entre base de datos y broker?**
Transactional Outbox.

**¿Qué patrón gestiona transacciones de negocio entre varios servicios?**
Saga, con transacciones locales y compensaciones.

**¿Qué patrón separa los modelos de lectura y escritura?**
CQRS.

**¿Qué patrón permite migrar un monolito de forma incremental?**
Strangler Fig.

**¿Qué patrón aísla recursos para que el fallo de una dependencia no agote todos los hilos?**
Bulkhead.

**¿Qué patrón GoF usa Spring para `@Transactional`?**
Proxy.

**¿Qué patrón GoF representan `JdbcTemplate` y `RestTemplate`?**
Template Method (con callbacks).

**¿Qué patrón GoF representa la cadena de filtros de Spring Security?**
Chain of Responsibility.

## Apéndice B · Chuleta de anotaciones

### Núcleo y configuración

| Anotación | Uso |
|---|---|
| `@SpringBootApplication` | Clase principal: configuración, autoconfiguración y escaneo de componentes. |
| `@Component`, `@Service`, `@Repository`, `@Controller`, `@RestController` | Estereotipos que registran beans por escaneo. |
| `@Configuration` / `@Bean` | Clase de configuración y métodos que fabrican beans. |
| `@Autowired`, `@Qualifier`, `@Primary` | Inyección y desambiguación de candidatos. |
| `@Value` | Inyección de una propiedad suelta o expresión SpEL. |
| `@ConfigurationProperties` | Enlace tipado de un grupo de propiedades. |
| `@Profile` | Registra el bean solo con ciertos perfiles activos. |
| `@ConditionalOnClass`, `@ConditionalOnMissingBean`, `@ConditionalOnProperty` | Condiciones de las autoconfiguraciones. |
| `@Lazy` | Inicialización perezosa o inyección de un proxy diferido. |
| `@Scope` | Cambia el scope del bean (prototype, request, session...). |
| `@PostConstruct` / `@PreDestroy` | Callbacks de inicialización y destrucción. |
| `@EventListener` / `@TransactionalEventListener` | Escucha de eventos de aplicación. |
| `@Async` / `@EnableAsync` | Ejecución asíncrona. |
| `@Scheduled` / `@EnableScheduling` | Tareas programadas. |
| `@Cacheable`, `@CachePut`, `@CacheEvict` / `@EnableCaching` | Abstracción de caché. |

### Web

| Anotación | Uso |
|---|---|
| `@RequestMapping`, `@GetMapping`, `@PostMapping`, `@PutMapping`, `@PatchMapping`, `@DeleteMapping` | Mapeo de peticiones a métodos. |
| `@PathVariable`, `@RequestParam`, `@RequestHeader`, `@RequestBody` | Extracción de datos de la petición. |
| `@ResponseStatus` | Código de estado fijo para un método o una excepción. |
| `@RestControllerAdvice`, `@ExceptionHandler` | Manejo global de excepciones. |
| `@Valid`, `@Validated` | Activación de la validación. |
| `@CrossOrigin` | Configuración de CORS local. |
| `@HttpExchange`, `@GetExchange`... | Clientes HTTP declarativos. |

### Datos y transacciones

| Anotación | Uso |
|---|---|
| `@Entity`, `@Table`, `@Id`, `@GeneratedValue`, `@Column` | Mapeo JPA básico. |
| `@OneToMany`, `@ManyToOne`, `@OneToOne`, `@ManyToMany`, `@JoinColumn` | Relaciones. |
| `@Embeddable` / `@Embedded` | Value objects embebidos. |
| `@Version` | Bloqueo optimista. |
| `@Query`, `@Modifying`, `@EntityGraph`, `@Lock` | Consultas en repositorios de Spring Data. |
| `@Transactional` | Demarcación de transacciones. |

### Testing

| Anotación | Uso |
|---|---|
| `@SpringBootTest` | Contexto completo. |
| `@WebMvcTest`, `@DataJpaTest`, `@JsonTest`, `@RestClientTest` | Test slices. |
| `@MockitoBean`, `@MockitoSpyBean` | Sustituir beans por mocks o spies en el contexto. |
| `@Testcontainers`, `@Container`, `@ServiceConnection` | Contenedores para tests con conexión automática. |
| `@DynamicPropertySource` | Propiedades calculadas en tiempo de ejecución. |
| `@ActiveProfiles`, `@TestPropertySource` | Perfiles y propiedades de test. |
| `@WithMockUser` | Usuario simulado para tests de seguridad. |

### Seguridad, resiliencia y mensajería

| Anotación | Uso |
|---|---|
| `@EnableMethodSecurity`, `@PreAuthorize` | Autorización a nivel de método. |
| `@CircuitBreaker`, `@Retry`, `@RateLimiter`, `@Bulkhead`, `@TimeLimiter` | Resilience4j. |
| `@KafkaListener`, `@RetryableTopic`, `@DltHandler` | Consumo de Kafka, reintentos no bloqueantes y DLT. |
| `@RabbitListener` | Consumo de RabbitMQ. |
| `@Observed` | Observación (métrica y traza) de un método con Micrometer. |

## Apéndice C · Propiedades de configuración esenciales

| Propiedad | Para qué sirve |
|---|---|
| `server.port` | Puerto HTTP de la aplicación. |
| `server.shutdown=graceful` | Apagado ordenado, esperando a las peticiones en curso. |
| `spring.lifecycle.timeout-per-shutdown-phase` | Tiempo máximo de cada fase del apagado. |
| `spring.profiles.active` | Perfiles activos. |
| `spring.application.name` | Nombre del servicio (usado en trazas, métricas y descubrimiento). |
| `spring.datasource.url` / `username` / `password` | Conexión a la base de datos. |
| `spring.datasource.hikari.maximum-pool-size` | Tamaño máximo del pool de conexiones. |
| `spring.jpa.open-in-view=false` | Desactivar Open Session In View. |
| `spring.jpa.hibernate.ddl-auto=validate` | Validar el esquema en lugar de generarlo. |
| `spring.jpa.properties.hibernate.default_batch_fetch_size` | Batch fetching para mitigar N+1. |
| `spring.threads.virtual.enabled=true` | Hilos virtuales (Java 21+). |
| `spring.mvc.problemdetails.enabled=true` | Respuestas de error en formato Problem Details. |
| `management.endpoints.web.exposure.include` | Endpoints de Actuator expuestos por HTTP. |
| `management.server.port` | Puerto separado para Actuator. |
| `management.endpoint.health.probes.enabled` | Grupos de liveness y readiness. |
| `management.tracing.sampling.probability` | Proporción de trazas muestreadas. |
| `management.metrics.distribution.percentiles-histogram.*` | Publicar histogramas de latencia. |
| `logging.level.<paquete>` | Nivel de log por paquete. |
| `logging.structured.format.console` | Logs estructurados en JSON (ecs, logstash, gelf). |
| `spring.kafka.bootstrap-servers` | Brokers de Kafka. |
| `spring.kafka.consumer.group-id` / `auto-offset-reset` | Grupo de consumidores y comportamiento sin offset previo. |
| `spring.kafka.listener.concurrency` | Hilos consumidores por listener. |
| `spring.config.import` | Importar configuración adicional (Config Server, ficheros, config trees). |

## Apéndice D · Glosario

**ACID**: propiedades de las transacciones de bases de datos: atomicidad, consistencia, aislamiento y durabilidad.

**Agregado**: en DDD, grupo de entidades y value objects que se trata como una unidad de consistencia, con una raíz como único punto de acceso.

**AOP (programación orientada a aspectos)**: técnica para aplicar lógica transversal (transacciones, seguridad, métricas) sin mezclarla con la lógica de negocio.

**AOT (ahead-of-time)**: procesamiento o compilación en tiempo de construcción en lugar de en tiempo de ejecución.

**API Gateway**: punto de entrada único que enruta peticiones externas a los servicios internos y aplica políticas transversales.

**At-least-once**: garantía de entrega en la que ningún mensaje se pierde, pero puede entregarse más de una vez.

**Backpressure**: mecanismo por el que un consumidor indica al productor el ritmo al que puede procesar.

**BFF (Backend for Frontend)**: backend específico para un tipo de cliente.

**BOM (Bill of Materials)**: POM que fija versiones compatibles de un conjunto de dependencias.

**Bounded Context**: frontera explícita dentro de la cual un modelo de dominio es coherente.

**Bulkhead**: aislamiento de recursos para que el fallo de una parte no agote los recursos de todo el sistema.

**Canary**: despliegue que envía un pequeño porcentaje del tráfico a la nueva versión antes de generalizarla.

**CAP**: teorema que establece que, ante una partición de red, un sistema distribuido debe elegir entre consistencia y disponibilidad.

**Cardinalidad**: número de series temporales distintas que genera una métrica.

**CDC (Change Data Capture)**: captura de cambios de una base de datos leyendo su log de transacciones.

**Circuit Breaker**: patrón que corta las llamadas a una dependencia que falla para evitar fallos en cascada.

**Consumer group**: conjunto de consumidores de Kafka que se reparten las particiones de un topic.

**Consumer lag**: mensajes pendientes de procesar por un grupo de consumidores.

**Consistencia eventual**: garantía de que, sin nuevas escrituras, todas las réplicas acabarán convergiendo al mismo valor.

**CQRS**: separación de los modelos de escritura (comandos) y lectura (consultas).

**DLQ / DLT**: cola o topic de mensajes muertos, donde se envían los mensajes que no se han podido procesar.

**DTO**: objeto de transferencia de datos que define el contrato de una API.

**Error budget**: margen de fallo que permite un SLO en una ventana de tiempo.

**Event Sourcing**: persistencia del estado como secuencia inmutable de eventos.

**Exemplar**: referencia a una traza concreta asociada a un punto de una métrica.

**Fat jar**: jar ejecutable que contiene la aplicación y todas sus dependencias.

**Feature flag**: interruptor de configuración para activar o desactivar funcionalidades sin desplegar.

**Fencing token**: número creciente que acompaña a un bloqueo distribuido para rechazar escrituras de poseedores obsoletos.

**GitOps**: práctica de gestionar el estado de la infraestructura y los despliegues desde un repositorio Git.

**Graceful shutdown**: apagado ordenado que termina las peticiones en curso antes de cerrar.

**HPA**: HorizontalPodAutoscaler, escalado automático del número de réplicas en Kubernetes.

**Idempotencia**: propiedad de una operación que produce el mismo efecto se ejecute una o varias veces.

**IoC (Inversión de Control)**: principio por el que un framework controla la creación y el ciclo de vida de los objetos.

**ISR (In-Sync Replicas)**: réplicas de una partición de Kafka sincronizadas con el líder.

**JWT**: token firmado y autocontenido con información (claims) sobre el usuario o el cliente.

**KRaft**: modo de consenso integrado de Kafka que sustituye a ZooKeeper.

**Liveness / Readiness**: sondas que indican si un contenedor debe reiniciarse o puede recibir tráfico.

**mTLS**: TLS mutuo, en el que cliente y servidor se autentican con certificados.

**N+1**: problema de rendimiento en el que se ejecuta una consulta adicional por cada elemento de una lista.

**Observabilidad**: capacidad de entender el estado interno de un sistema a partir de sus salidas (logs, métricas y trazas).

**OSIV (Open Session In View)**: patrón que mantiene abierta la sesión de Hibernate durante toda la petición HTTP.

**OTLP**: protocolo de OpenTelemetry para transmitir telemetría.

**Outbox**: patrón que guarda los eventos en una tabla dentro de la misma transacción de negocio para publicarlos después.

**Partición**: subdivisión de un topic de Kafka; unidad de paralelismo y de orden.

**Poison pill**: mensaje que provoca un error cada vez que se intenta procesar.

**Proxy**: objeto que sustituye a otro para controlar el acceso y añadir comportamiento.

**Rate limiting**: limitación del número de peticiones permitidas en un intervalo.

**Saga**: secuencia de transacciones locales con compensaciones para mantener la consistencia entre servicios.

**Schema Registry**: servicio que almacena y valida la compatibilidad de los esquemas de los mensajes.

**Service Mesh**: capa de infraestructura que gestiona la comunicación entre servicios mediante proxies.

**Sidecar**: contenedor auxiliar desplegado junto al principal en el mismo pod.

**SLI / SLO / SLA**: indicador, objetivo y acuerdo contractual de nivel de servicio.

**Span**: unidad de trabajo dentro de una traza distribuida.

**Starter**: dependencia agregada de Spring Boot para un caso de uso.

**Strangler Fig**: patrón de migración incremental de un sistema heredado.

**Test slice**: test que carga solo una parte del contexto de Spring.

**Tombstone**: registro con valor nulo que marca un borrado en un topic compactado.

**Traza**: recorrido completo de una petición a través de varios servicios, formado por spans.

**Twelve-Factor**: metodología de doce principios para aplicaciones nativas de la nube.

**Value Object**: objeto inmutable definido por sus atributos, sin identidad propia.

**Virtual threads (hilos virtuales)**: hilos ligeros gestionados por la JVM que permiten alta concurrencia con código bloqueante.

## Apéndice E · Plan de estudio de cuatro semanas

**Semana 1 · Fundamentos sólidos.** Capítulos de los niveles 1 a 3. Crear desde cero con Spring Initializr una API pequeña (por ejemplo, gestión de pedidos) con validación, manejo de errores con Problem Details, persistencia con JPA y Flyway, y tests con `@WebMvcTest`, `@DataJpaTest` y Testcontainers. Provocar a propósito un N+1 y resolverlo; provocar el problema de auto-invocación y comprobarlo con un test.

**Semana 2 · Diseño.** Nivel 4. Refactorizar la API anterior hacia una organización por funcionalidad o una arquitectura hexagonal ligera; introducir value objects con records, una máquina de estados para el pedido y una estrategia intercambiable (por ejemplo, cálculo de envío). Añadir reglas de ArchUnit o Spring Modulith que verifiquen la estructura.

**Semana 3 · Distribución.** Niveles 5 y 6 y el monográfico de Kafka. Dividir el ejemplo en dos o tres servicios que se comuniquen con REST y Kafka; implementar un Outbox sencillo, un consumidor idempotente, una DLT y un circuit breaker con Resilience4j. Probar los fallos: parar un servicio, introducir latencia con WireMock, enviar mensajes duplicados o malformados.

**Semana 4 · Operación y repaso.** Monográficos de Docker y Kubernetes y de observabilidad, y nivel 7. Contenerizar los servicios, levantarlos con Docker Compose junto a Prometheus, Grafana y un backend de trazas, y desplegarlos en un clúster local (kind, k3d o minikube) con sondas y recursos. Construir un dashboard con las señales doradas y una alerta. Terminar con simulacros: responder en voz alta preguntas al azar, practicar dos preguntas de diseño de sistemas con cronómetro (45 minutos) y repasar el apéndice de preguntas relámpago.

Consejo general: tener un proyecto propio en un repositorio público con todo lo anterior vale más que cualquier respuesta memorizada, porque permite responder muchas preguntas con «en mi proyecto lo hice así, por este motivo».

## Apéndice F · Cómo afrontar la entrevista

**Entrevista conceptual.** Responde de lo general a lo particular: primero la idea en una frase, después el detalle y, si procede, un ejemplo de tu experiencia. Si no sabes algo, dilo con naturalidad y razona en voz alta cómo lo averiguarías o qué supones; es mucho mejor valorado que inventar.

**Live coding o ejercicio práctico.** Antes de escribir, repite el enunciado con tus palabras y pregunta por los casos límite. Empieza por una solución sencilla que funcione y mejórala después. Escribe tests aunque no te los pidan: dicen mucho de tu forma de trabajar. Nombra bien las cosas y comenta en voz alta las decisiones.

**Revisión de código.** Busca por capas: corrección (errores, casos límite, concurrencia), seguridad (inyección, datos sensibles, autorización), rendimiento (N+1, transacciones largas, llamadas remotas en bucles), diseño (responsabilidades, acoplamiento, testabilidad) y estilo. Prioriza los hallazgos: no es lo mismo un posible bug que un nombre mejorable.

**Diseño de sistemas.** Sigue una estructura: requisitos funcionales y no funcionales, estimaciones de volumen, API, modelo de datos, arquitectura de alto nivel, profundización en el punto crítico, y trade-offs y riesgos. Dibuja, pregunta y no te enamores de la primera solución.

**Preguntas de comportamiento.** Prepara tres o cuatro historias reales con el formato situación, tarea, acción y resultado: un incidente en producción que resolviste, una decisión técnica que defendiste o que resultó ser errónea, una mejora que propusiste y un conflicto en el equipo. Las historias sobre errores propios y lo que aprendiste suelen ser las más convincentes.

**Preguntas que puedes hacer tú al final:**

- ¿Cómo es el ciclo desde que se integra un cambio hasta que llega a producción? ¿Con qué frecuencia se despliega?
- ¿Cómo se gestionan los incidentes y las guardias?
- ¿Qué estrategia de testing sigue el equipo y quién se encarga de la calidad?
- ¿Cuál es el mayor reto técnico del equipo en los próximos meses?
- ¿Cómo se toman las decisiones de arquitectura?
- ¿Qué haría que alguien tuviera éxito en este puesto durante el primer año?

Estas preguntas no solo te dan información para decidir: muestran interés real y una visión profesional del desarrollo de software.
