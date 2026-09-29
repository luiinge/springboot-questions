---
title: "Java Technical Interview: Spring Boot and Microservices"
subtitle: "158 questions with explained answers, from junior to senior"
author: "Luis Iñesta Gelabert"
rights: "© 2026 Luis Iñesta Gelabert. Licensed under CC BY-SA 4.0 (text) and MIT (code examples)."
lang: en-US
toc: true
toc-depth: 2
---

# Introduction

There is a scene that repeats itself in almost every backend technical interview. The candidate confidently answers the first question: what dependency injection is, what `@Transactional` is for, what a microservice is. The interviewer nods and, without changing their tone, asks: *and why?* Or worse: *and what happens if you call that method from another method in the same class?* That is the moment that separates those who have used a tool from those who understand it.

This book was written to prepare you for that second moment.

## Why another book of questions

For years, Spring Boot has been the default choice for building backend services in Java. Its great virtue is also its trap: it works so well without having to think that you can use it for a long time without knowing what happens underneath. Auto-configuration, proxies, declarative transactions and bean management do their job silently… until they stop doing it, in production or in an interview.

On top of that, a modern backend position asks for much more than Spring. You are expected to design a REST API, reason about consistency in distributed systems, choose between synchronous and asynchronous communication, deploy to containers and explain what you would do if a service starts responding slowly at three in the morning. All of that comes up in interviews, often mixed together in the same conversation.

The question lists circulating on the internet tend to stay on the surface: a two-line definition that is enough to recognise the concept, but not to defend it. Here I have tried to do the opposite. Each answer is framed the way someone who has been through the problem would give it: first the core idea, then the nuances, the common mistakes and the *trade-offs*, and code when code explains better than words.

## How this book was made

The questions in this book and their answers were collected and drafted with the help of artificial intelligence tools, based on the topics that come up most often in technical interviews for Java backend positions.

That material was only the starting point. Afterwards, every question and every answer was reviewed and validated to correct inaccuracies and to check that the explanations are correct. Even so, no technical book is free of errors; if you find one, check it against the documentation for the version you use.

## Who this book is for

Any developer preparing an interview for a Java backend position, whether it is their first or their fifth. The early levels serve those who are starting out and need to consolidate the fundamentals; the later ones, those aiming for a senior position who have to talk about performance, architecture and system design with their own judgement.

It is also for those on the other side of the table. If you are the one interviewing, you will find questions with depth, hints about what separates a good answer from an excellent one, and follow-up questions to go beyond what has been memorised.

And, finally, for anyone who simply wants to understand better the tool they work with every day. Preparing for an interview is an excellent excuse to fill gaps that have been there for years.

## What this book is not

It is not a Spring Boot manual or a step-by-step course; it assumes you have written some Java code and know what a web application is. Nor is it a collection of answers to recite. A good interviewer immediately spots an answer learned by heart, and a single follow-up question is enough to take it apart. The idea is that you understand each topic well enough to explain it in your own words and relate it to your experience.

## One last recommendation

Read with an editor open. Many of the questions in this book only truly make sense when you reproduce the problem: you trigger an N+1, you see how a self-invocation with `@Transactional` fails, or you check which beans auto-configuration creates. Ten minutes of experimenting are worth more than any explanation.

And remember that a technical interview is not an exam, but a conversation. What is valued is not having every answer, but reasoning out loud, admitting what you don't know and being able to reach a reasonable solution. I hope this book helps you walk into that conversation with confidence.

# How to use this book

This book gathers **158 questions** that are common in technical interviews for backend development positions with Java, Spring Boot and microservices, each with an answer explained the way you would give it in a well-prepared interview: first the core idea, then the nuances and, when it helps, code.

## How it is organised

The **first part** covers seven levels of increasing difficulty, from Spring fundamentals to senior-level questions and system design exercises. It is meant to be read in order: each level builds on the previous ones.

The **second part** contains three deep dives on technologies that appear in almost every microservices job posting: **Apache Kafka**, **Docker and Kubernetes**, and **observability**. Within each deep dive, the questions also go from easier to harder, and they can be read independently.

The **appendices** include a set of rapid-fire questions, cheat sheets of annotations and properties, a glossary, a study plan and advice for each type of interview.

## How to read each question

Each question states its topic and level. Many end with two additional elements:

- **Interview tip**: what the interviewer is usually looking for, or which detail separates a correct answer from an excellent one.
- **Common follow-up questions**: the follow-up questions that usually come next, with a short answer. In a real interview, the first answer is rarely the last.

Recommendations: try to answer out loud before reading the answer; relate each concept to your own experience; and at the advanced levels, focus on the *trade-offs*, because there is rarely a single correct answer.

Version references correspond to the current ecosystem (Java 21 or later, Spring Boot 3.x and 4.x). When a feature depends on the version, this is stated explicitly.

## Contents

| Part | Chapter | Questions |
|---|---|---|
| I | Level 1 · Basic: Spring and Spring Boot fundamentals | Q001 – Q017 |
| I | Level 2 · Basic-Intermediate: Spring Boot in practice | Q018 – Q036 |
| I | Level 3 · Intermediate: Persistence, transactions and testing | Q037 – Q055 |
| I | Level 4 · Intermediate: Design patterns applied to Java and Spring | Q056 – Q073 |
| I | Level 5 · Intermediate-Advanced: Microservices: fundamentals, communication and infrastructure | Q074 – Q090 |
| I | Level 6 · Advanced: Resilience, distributed data and microservice patterns | Q091 – Q108 |
| I | Level 7 · Expert: Internals, performance and system design | Q109 – Q125 |
| II | Deep Dive A: Apache Kafka in depth | Q126 – Q137 |
| II | Deep Dive B: Docker and Kubernetes for Spring Boot developers | Q138 – Q147 |
| II | Deep Dive C: Observability and monitoring | Q148 – Q158 |

# Part I · Questions by difficulty level

Seven chapters ordered from easiest to hardest. Each one builds on the concepts of the previous ones.

# Level 1 · Basic · Spring and Spring Boot fundamentals

Concepts that any interviewer takes for granted: IoC, dependency injection, beans, essential annotations and what Spring Boot adds on top of Spring.

This chapter contains 17 questions.

## Q001 · What is Spring Framework and what problem does it solve?

*Topic: Spring Core · Level 1 · Basic*

Spring is a Java framework whose core is an **Inversion of Control (IoC) container**. Its original goal was to simplify enterprise development in the face of J2EE/EJB complexity: instead of each class creating and looking up its dependencies, the container creates the objects (beans), wires them together and manages their lifecycle.

A broad ecosystem is built on top of that core:

- **Spring MVC / WebFlux** for web applications and REST APIs.
- **Spring Data** for data access (JPA, MongoDB, Redis...).
- **Spring Security** for authentication and authorisation.
- **Spring AOP** for aspect-oriented programming (transactions, security, cross-cutting logging).
- **Spring Cloud** for distributed systems.

The main benefit is **loose coupling**: code depends on interfaces and the container decides which implementation to inject, which makes testing easier (dependencies can be replaced with mocks) and helps the code evolve.

> **Interview tip.** Don't stop at "it's a framework for building websites". Mention IoC/DI as the core and loose coupling as the key benefit.

### Common follow-up questions

**Is Spring only for web applications?**

No. The IoC container works for any kind of application: batch processes (Spring Batch), message consumers, command-line applications or integrations (Spring Integration). The web part is just one of its modules.

**What alternatives to Spring exist in the Java ecosystem?**

Jakarta EE (with servers such as WildFly, Payara or Open Liberty), Quarkus and Micronaut. The last two resolve much of the dependency injection at compile time, which reduces startup time and memory. Spring responded with its AOT engine and native image support. Knowing the alternatives and their trade-offs shows perspective.

## Q002 · What is Spring Boot and how does it differ from Spring?

*Topic: Spring Boot · Level 1 · Basic*

Spring Boot does not replace Spring: it is an **opinionated** layer on top of Spring that removes repetitive configuration. Its pillars are:

- **Auto-configuration**: it detects what is on the classpath and configures sensible default beans. If you add `spring-boot-starter-data-jpa` and a database driver, it automatically creates the `DataSource`, the `EntityManagerFactory` and the transaction manager.
- **Starters**: aggregated dependencies that bring in a coherent, tested set of libraries with compatible versions.
- **Embedded server**: Tomcat (by default), Jetty or Undertow inside the application itself; it runs with `java -jar`.
- Unified **external configuration** (properties, YAML, environment variables, profiles).
- **Production-ready**: Actuator with health checks, metrics and application information.

With "classic" Spring you had to declare configuration manually (XML or `@Configuration` classes), deploy a WAR to an application server and manage dependency versions by hand. Spring Boot applies the principle of **convention over configuration**, but everything it auto-configures can be overridden.

> **Interview tip.** Make it clear that Boot is Spring + conventions, not a different framework. Mentioning that everything can be overridden shows you understand it isn't magic.

### Common follow-up questions

**What does it mean that Spring Boot is "opinionated"?**

That it makes sensible default decisions (Tomcat as the server, Jackson for JSON, HikariCP as the pool, Logback for logging) so you can start without configuring anything. The opinions are replaceable: adding another library or declaring your own bean makes Boot back off.

**How do you know what Spring Boot has configured automatically?**

By starting with --debug to see the conditions report, querying /actuator/conditions and /actuator/beans, or reviewing Spring Boot's common application properties documentation, which lists all the default values.

## Q003 · What are Inversion of Control and Dependency Injection? What types of injection exist?

*Topic: Spring Core · Level 1 · Basic*

**Inversion of Control (IoC)** is the principle by which control over the creation and lifecycle of objects moves from the application code to a framework. **Dependency Injection (DI)** is the concrete way of applying IoC: dependencies are "injected" from outside instead of the object creating them with `new`.

Spring supports three types of injection:

- **Constructor** (recommended): dependencies are mandatory, they can be `final` (immutability), the object is never left half-built and it can be instantiated in a unit test without Spring. Since Spring 4.3, if there is a single constructor `@Autowired` is not needed.
- **Setter**: useful for optional dependencies or ones that can change.
- **Field** (`@Autowired` on the attribute): convenient but discouraged; it hides dependencies, prevents `final`, forces you to use reflection or Spring in tests and makes it easy for a class to accumulate too many dependencies without anyone noticing.

```java
@Service
public class OrderService {
    private final OrderRepository repo;
    private final NotifierClient notifier;

    public OrderService(OrderRepository repo, NotifierClient notifier) {
        this.repo = repo;
        this.notifier = notifier;
    }
}
```

With Lombok it is usually shortened with `@RequiredArgsConstructor`.

> **Interview tip.** You are almost certain to be asked "why constructor?". The three strong reasons: immutability, testability without Spring and early detection of classes with too many dependencies.

### Common follow-up questions

**Do you need to put @Autowired on the constructor?**

Not since Spring 4.3 if the class has a single constructor. If it has several, you must mark the one Spring should use with @Autowired.

**How would you inject an optional dependency?**

With `ObjectProvider<T>` (`getIfAvailable`), with `Optional<T>` as a constructor parameter or with @Autowired(required = false) on a setter. ObjectProvider is the most flexible option because it also allows lazy resolution.

## Q004 · What does the @SpringBootApplication annotation do?

*Topic: Spring Boot · Level 1 · Basic*

It is a meta-annotation that combines three:

- `@SpringBootConfiguration`: a specialisation of `@Configuration`; it marks the class as a source of bean definitions.
- `@EnableAutoConfiguration`: enables Spring Boot's auto-configuration mechanism.
- `@ComponentScan`: scans the package of the annotated class **and its sub-packages** looking for `@Component`, `@Service`, `@Repository`, `@Controller`, etc.

```java
@SpringBootApplication
public class StoreApplication {
    public static void main(String[] args) {
        SpringApplication.run(StoreApplication.class, args);
    }
}
```

An important practical consequence: the main class must be in the **root package**. If a component is in a "sibling" package (outside the tree), it will not be detected. Specific auto-configurations can be excluded with `@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)`.

> **Interview tip.** Mention the root-package detail: it is a classic source of "No qualifying bean found" errors in real projects.

### Common follow-up questions

**Can I have several classes with @SpringBootApplication in the same project?**

Technically yes, but it's a bad idea: each would scan its own package tree and they could overlap. A legitimate case is tests with their own configurations, where @SpringBootConfiguration or @TestConfiguration is used instead.

**How would you scan components from a package outside the main tree?**

With @SpringBootApplication(scanBasePackages = {...}) or @ComponentScan, or by explicitly importing a configuration with @Import. For shared libraries, the right approach is an auto-configuration, not widening the scan.

## Q005 · What is the difference between @Component, @Service, @Repository, @Controller and @RestController?

*Topic: Spring Core · Level 1 · Basic*

They are all **stereotypes** that register the class as a bean during component scanning. `@Service`, `@Repository` and `@Controller` are meta-annotated with `@Component`, but each one adds semantics and, in some cases, behaviour:

- `@Component`: generic, for any managed bean.
- `@Service`: business logic. It adds no behaviour, only intent (useful for readability and for AOP pointcuts).
- `@Repository`: data access. **It does add behaviour**: it enables translation of technology-specific exceptions (SQLException, Hibernate exceptions) into Spring's `DataAccessException` hierarchy.
- `@Controller`: MVC controller; its methods normally return view names.
- `@RestController`: `@Controller` + `@ResponseBody`; whatever the methods return is serialised directly into the response body (JSON by default, via Jackson).

> **Interview tip.** The detail that makes the difference is @Repository's exception translation.

### Common follow-up questions

**What happens if I annotate a service with @Component instead of @Service?**

It works the same: the bean is registered. You only lose the semantic intent, which is useful for readability and for aspects or architecture rules that select by stereotype (for example, ArchUnit rules on @Service classes).

**Can I create my own stereotypes?**

Yes: a custom annotation meta-annotated with @Component (for example @UseCase or @Adapter in a hexagonal architecture). Spring will detect it during scanning, and the name expresses the architecture better.

## Q006 · What are Spring Boot starters?

*Topic: Spring Boot · Level 1 · Basic*

A starter is a POM (or Gradle module) of aggregated dependencies for a use case. It usually contains no code of its own; its value lies in bringing together a coherent set of libraries with **compatible versions** managed by the Spring Boot BOM (`spring-boot-dependencies`).

Common examples:

- `spring-boot-starter-web`: Spring MVC, embedded Tomcat, Jackson.
- `spring-boot-starter-webflux`: reactive stack with Netty.
- `spring-boot-starter-data-jpa`: Spring Data JPA, Hibernate, HikariCP.
- `spring-boot-starter-security`, `-actuator`, `-validation`, `-test`.

Thanks to the BOM, the `pom.xml` normally does not specify a version for managed dependencies: it is inherited from `spring-boot-starter-parent` or the BOM is imported. This avoids "version hell" (for example, incompatibilities between Hibernate and Spring Data).

The naming convention is `spring-boot-starter-*` for official starters and `*-spring-boot-starter` for third-party ones.

## Q007 · What is a bean and what scopes exist?

*Topic: Spring Core · Level 1 · Basic*

A **bean** is an object whose creation, configuration and lifecycle are managed by the Spring container. Scopes determine how many instances are created and how long they live:

- **singleton** (default): a single instance per `ApplicationContext`. Every injection receives the same one.
- **prototype**: a new instance every time the bean is requested. Spring does not manage its destruction (it does not call `@PreDestroy`).
- **request**: one instance per HTTP request (web contexts only).
- **session**: one instance per HTTP session.
- **application**: one per `ServletContext`.
- **websocket**: one per WebSocket session.

Classic trap: injecting a **prototype bean into a singleton**. Injection happens only once, when the singleton is created, so the same prototype instance is always used. Solutions: inject an `ObjectProvider<T>` and call `getObject()`, use `@Lookup` or a scoped proxy (`proxyMode = ScopedProxyMode.TARGET_CLASS`).

Since singletons are shared between threads, **they must be stateless** or thread-safe.

> **Interview tip.** The prototype-in-singleton trap and "singletons must be stateless" are the two points interviewers usually look for.

### Common follow-up questions

**How do you check that a singleton is really thread-safe?**

By checking that it has no shared mutable state: only final attributes with dependencies that are also stateless or thread-safe. If it needs state, use concurrent structures (ConcurrentHashMap, AtomicLong) or reconsider the design. Concurrency tests are hard; design review is the main defence.

**When would you use a request-scoped bean?**

To hold request information accessible from several layers without passing it as a parameter, for example the tenant or user context. Spring injects a proxy that resolves the instance for the current request. Nowadays it is often preferable to pass the context explicitly or use the SecurityContext.

## Q008 · What is the difference between @Bean and @Component?

*Topic: Spring Core · Level 1 · Basic*

Both register beans, but in different ways:

- `@Component` (and its stereotypes) goes **on the class**. Spring discovers it through component scanning and instantiates it itself. It only works for classes you control.
- `@Bean` goes **on a method** inside a `@Configuration` class. You write the creation code and Spring registers the returned object. It is the option for third-party classes (which you cannot annotate) or when construction requires logic.

```java
@Configuration
public class ClientsConfig {
    @Bean
    public ObjectMapper objectMapper() {
        return JsonMapper.builder()
            .addModule(new JavaTimeModule())
            .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
            .build();
    }
}
```

Advanced detail: `@Configuration` classes are processed with a CGLIB proxy ("full" mode), so that if one `@Bean` method calls another, the existing singleton is returned instead of creating a new one. With `@Configuration(proxyBeanMethods = false)` ("lite" mode) the proxy is avoided and startup is slightly faster, at the cost of not being able to call between `@Bean` methods.

### Common follow-up questions

**What happens if I define two @Bean methods that return the same type?**

Two beans are registered and injection points of that type will be ambiguous. You have to mark one as @Primary, name them and use @Qualifier, or inject them all as a list.

**Can a @Bean method take parameters?**

Yes, and it is the recommended way to express dependencies between beans: Spring resolves each parameter as an injection. This avoids calls between @Bean methods and also works in lite mode (proxyBeanMethods = false).

## Q009 · What is the difference between application.properties and application.yml? What are profiles?

*Topic: Configuration · Level 1 · Basic*

Both files serve the same purpose; only the syntax changes. Properties is flat (`key=value`); YAML is hierarchical, more readable for nested configuration and supports lists naturally. If both exist, both are loaded (properties takes precedence over yml in the same location).

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/store
    username: app
server:
  port: 8081
```

**Profiles** let you have different configuration per environment. You create `application-{profile}.yml` files (for example `application-dev.yml`, `application-prod.yml`) that override the base configuration. They are activated with `spring.profiles.active=prod`, with the `SPRING_PROFILES_ACTIVE` environment variable or from the command line.

Profiles also condition beans: `@Profile("dev")` on a `@Component` or `@Bean` means it is only registered when that profile is active (for example, a stub of an external service for development). Profiles can also be grouped with `spring.profiles.group`.

> **Interview tip.** Add that secrets must never go in the file: they are injected through environment variables or a secrets manager (Vault, Kubernetes Secrets).

### Common follow-up questions

**Can I activate several profiles at once?**

Yes, separated by commas (spring.profiles.active=prod,aws). If they define the same property, the last profile in the list wins.

**How would you put configuration for several profiles in a single YAML file?**

With documents separated by three dashes and the spring.config.activate.on-profile property in each document. It is convenient for small configurations, although with many differences separate files are more readable.

## Q010 · What is the ApplicationContext? How does it differ from BeanFactory?

*Topic: Spring Core · Level 1 · Basic*

`BeanFactory` is the root interface of the container: it knows how to create beans and resolve dependencies, with **lazy** initialisation (it creates each bean when it is requested).

`ApplicationContext` extends `BeanFactory` and adds enterprise features:

- **Eager** initialisation of singletons at startup (configuration errors show up at startup, not in production at 3 a.m.).
- Event publishing (`ApplicationEventPublisher`).
- Internationalisation (`MessageSource`).
- Access to resources (`ResourceLoader`) and to the `Environment` (properties and profiles).
- Automatic registration of `BeanPostProcessor` and `BeanFactoryPostProcessor`, which are the foundation of AOP, `@Transactional`, `@Autowired`, etc.

In practice `ApplicationContext` is always used; in Spring Boot the concrete implementation depends on the type of application (for example, `AnnotationConfigServletWebServerApplicationContext` for a servlet web app). Global lazy initialisation can be enabled with `spring.main.lazy-initialization=true`, useful in development but risky in production because it delays errors.

### Common follow-up questions

**Can there be several ApplicationContexts in an application?**

Yes, in a parent-child hierarchy: beans in the child see those in the parent but not the other way round. It was common in classic Spring MVC applications (root context and DispatcherServlet context) and appears in Spring Cloud (child contexts per client). In a typical Boot application there is only one.

**Why shouldn't you call applicationContext.getBean() in your business code?**

Because it is the Service Locator anti-pattern: it hides dependencies, couples the code to the container and makes testing harder. Dependency injection exists precisely to avoid it.

## Q011 · What happens if there are two beans of the same type? How are @Qualifier and @Primary used?

*Topic: Spring Core · Level 1 · Basic*

If an injection point accepts several candidates, Spring throws `NoUniqueBeanDefinitionException`. There are several ways to resolve it:

- `@Primary`: marks one bean as the default preferred one.
- `@Qualifier("name")`: at the injection point, explicitly chooses one. It takes priority over `@Primary`.
- **Parameter name**: if it matches the name of a bean, Spring uses it as a tie-breaker.
- **Inject them all**: `List<Interface>` (orderable with `@Order`) or `Map<String, Interface>` (key = bean name). This is the basis of the Strategy pattern in Spring.

```java
@Service
public class PaymentService {
    private final PaymentGateway gateway;

    public PaymentService(@Qualifier("stripe") PaymentGateway gateway) {
        this.gateway = gateway;
    }
}
```

To avoid "magic strings", you can create your own qualifier annotations meta-annotated with `@Qualifier`.

### Common follow-up questions

**In what order are beans injected into a `List<Interface>`?**

According to @Order or the Ordered interface if present; otherwise, in registration order, which should not be taken as guaranteed. If order matters (a chain of validators, for example), it must be declared explicitly.

**@Primary or @Qualifier?**

@Primary when there is a clear default implementation and others that are only used in specific cases. @Qualifier when each injection point must choose explicitly. Overusing @Primary on many beans creates confusion.

## Q012 · How do you package and run a Spring Boot application? What is a fat jar?

*Topic: Spring Boot · Level 1 · Basic*

The Spring Boot Maven or Gradle plugin generates an executable **fat jar** (or "uber jar") containing the application classes, **all its dependencies** in `BOOT-INF/lib` and an embedded server. It runs with `java -jar app.jar`.

Since Java cannot load nested jars natively, Spring Boot includes its own launcher (`JarLauncher`), declared as `Main-Class` in the manifest; it creates a classloader able to read the inner jars and then invokes your `main` class (declared as `Start-Class`).

Advantages: a single self-contained artefact, ideal for containers and for the "build once, run anywhere" model. You can also generate a WAR for traditional application servers by extending `SpringBootServletInitializer`.

For Docker, it is good practice to use **layers** (`layertools` / `-Djarmode=tools extract`), separating dependencies (which change rarely) from your own code (which changes often), so that Docker's cache is reused and images are rebuilt faster. There are also buildpacks: `mvn spring-boot:build-image` generates the OCI image without a Dockerfile.

> **Interview tip.** If you are applying for roles with a DevOps component, Docker layers and buildpacks are a highly valued plus.

### Common follow-up questions

**Can I pass configuration when running the jar?**

Yes: arguments (--server.port=9090), system properties (-Dspring.profiles.active=prod), environment variables or an application.yml file next to the jar or in ./config. Everything follows the precedence order of external configuration.

**What is CDS and how does it improve startup?**

Class Data Sharing stores in a file the classes already loaded and processed by the JVM so they can be reused in subsequent startups. Spring Boot 3.3+ makes it easy to create the CDS archive from the extracted jar, noticeably reducing startup time without the drawbacks of a native image.

## Q013 · How do you create a Spring Boot project and how should its packages be organised?

*Topic: Project · Level 1 · Basic*

The usual way is **Spring Initializr** (start.spring.io, integrated in IntelliJ IDEA, VS Code and Eclipse): you choose the build tool (Maven or Gradle), language, Spring Boot and Java versions, and the starters you need. It generates a skeleton with the main class, the `pom.xml` or `build.gradle`, `application.properties` and a test that checks the context starts.

```text
store/
├── pom.xml
├── src/main/java/com/mycompany/store/
│   └── StoreApplication.java
├── src/main/resources/
│   ├── application.yml
│   └── db/migration/
└── src/test/java/com/mycompany/store/
    └── StoreApplicationTests.java
```

There are two main strategies for organising packages:

- **By layer** (package by layer): `controller`, `service`, `repository`, `model`. It is simple and very common in tutorials, but in medium-sized projects each feature ends up spread across the whole tree, and every class has to be public to be visible between packages.
- **By feature** (package by feature): `orders`, `customers`, `catalog`, and inside each one its controllers, services and repositories. It increases cohesion, lets you use package visibility to hide internal details and makes it easier to extract a module into an independent service in the future.

```text
com.mycompany.store
├── orders
│   ├── OrderController.java
│   ├── OrderService.java        (public: module API)
│   ├── OrderRepository.java     (package-private)
│   └── Order.java
├── customers
└── shared
```

For projects that are going to grow, organising by feature is the most defensible option. It is also the starting requirement for tools such as Spring Modulith, which treat each top-level package as a module.

> **Interview tip.** If you are asked about structure, justifying organisation by feature with the arguments of cohesion and package visibility usually makes a good impression.

## Q014 · What Java requirements does Spring Boot 3 have and what did the move from javax to jakarta involve?

*Topic: Platform · Level 1 · Basic*

Spring Boot 3 (and Spring Framework 6) requires **Java 17 as a minimum** and aligns with **Jakarta EE 9+**. The most visible change is the namespace: all enterprise APIs moved from `javax.*` to `jakarta.*`.

Why did it happen? Oracle transferred Java EE to the Eclipse Foundation, which renamed it Jakarta EE, but did not grant the use of the "java" trademark in package names. To be able to evolve the specifications, they had to move to a new namespace.

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

Implications of migrating from Boot 2 to Boot 3:

- Change the imports (tools such as **OpenRewrite** automate this with specific recipes).
- Upgrade third-party libraries to Jakarta-compatible versions (Hibernate 6, Tomcat 10, Jetty 11+...).
- Review related changes: Hibernate 6 modifies some behaviours and identifier generation; Spring Security 6 removes `WebSecurityConfigurerAdapter` in favour of `SecurityFilterChain` beans; Spring Cloud Sleuth is replaced by Micrometer Tracing.
- It is recommended to go through the latest 2.7 version first, resolve its deprecation warnings, and then jump to 3.x.

Ecosystem note: Spring Boot 4 (on Spring Framework 7) keeps Java 17 as the baseline, recommends more recent versions and aligns with Jakarta EE 11.

Besides being a requirement, working with Java 17+ lets you take advantage of **records**, **sealed classes**, *pattern matching* for `instanceof` and `switch`, *text blocks* and, with Java 21, **virtual threads**.

## Q015 · What are Spring Boot DevTools and what are they for?

*Topic: Tooling · Level 1 · Basic*

`spring-boot-devtools` is a module intended only for **development** that improves the work cycle:

- **Automatic restart**: when classes on the classpath change (on recompilation), it restarts the application. It is faster than a cold start because it uses two classloaders: a *base* one for dependencies, which don't change, and a *restart* one for your code, which is discarded and recreated.
- **LiveReload**: automatically refreshes the browser when static resources or templates change.
- **Development defaults**: disables template caching (Thymeleaf, FreeMarker) and enables more detailed web logging.
- **Global configuration** in `~/.config/spring-boot/` for personal preferences.
- Remote development support (rarely used today).

It is declared as an optional or `developmentOnly` dependency so that it does not end up in the final artefact:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

DevTools is **automatically disabled** when the application runs as a packaged jar (`java -jar`), to avoid surprises in production.

A common problem: since there are two classloaders, some libraries that cache classes or use serialisation can produce a `ClassCastException` of the "X cannot be cast to X" kind. It is solved by excluding or including jars in the restart classloader through `META-INF/spring-devtools.properties`.

## Q016 · What is Lombok? What risks does it carry, especially with JPA entities?

*Topic: Tooling · Level 1 · Basic*

Lombok is an annotation processor that generates boilerplate code at compile time: getters and setters, constructors, `equals`/`hashCode`, `toString`, builders and loggers.

- `@Getter`, `@Setter`
- `@RequiredArgsConstructor`: a constructor for the `final` fields (very useful for constructor injection).
- `@Builder`, `@Value` (immutable class), `@Data` (all of the above, mutable, together), `@Slf4j`.

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {
    private final OrderRepository repo;
    private final ApplicationEventPublisher events;
}
```

Risks and bad practices:

- **`@Data` on JPA entities** is the best-known trap. It generates `equals` and `hashCode` using all fields, including relationships: if you put an entity in a `HashSet` and it is then assigned an ID when persisted, its hash changes and it "disappears" from the set. In addition, traversing lazy relationships in `equals`, `hashCode` or `toString` triggers unexpected queries, `LazyInitializationException` or even `StackOverflowError` with bidirectional relationships.
- `@ToString` with relationships: the same recursion and lazy-loading problem.
- Public setters for everything, which pushes towards an **anaemic model** and breaks encapsulation.
- Dependence on a tool that hooks into internal compiler details; each new Java version requires updating Lombok.

Recommendations: on entities use only `@Getter` (and selected setters) and write `equals`/`hashCode` by hand; for DTOs and value objects, prefer Java **records**, which are already immutable and generate `equals`, `hashCode` and `toString` without external tools.

> **Interview tip.** Many interviewers ask "do you use Lombok?" expecting you to mention the problem of @Data with JPA entities.

## Q017 · What role do Maven and Gradle play in a Spring Boot project? What is spring-boot-starter-parent?

*Topic: Build · Level 1 · Basic*

Both tools manage dependencies, compile, run tests and package. Spring Boot provides plugins for both.

**Maven**: declarative configuration in XML (`pom.xml`) with a fixed lifecycle (`validate`, `compile`, `test`, `package`, `verify`, `install`, `deploy`). It is very predictable and standard in corporate environments.

`spring-boot-starter-parent` is a parent POM that provides:

- Version management for hundreds of dependencies (it inherits from the `spring-boot-dependencies` BOM).
- The Java version and UTF-8 encoding by default.
- Sensible plugin configuration (surefire, failsafe, resources with filtering).
- Configuration of the `spring-boot-maven-plugin` to build the executable jar.

If the project already has its own corporate parent, you can import the BOM in `dependencyManagement` instead of inheriting:

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

**Gradle**: configuration as code (Groovy or Kotlin DSL), incremental builds and build cache, which makes it faster in large, multi-module projects. The `org.springframework.boot` plugin is used together with dependency management (the `io.spring.dependency-management` plugin or the `platform(SpringBootPlugin.BOM_COORDINATES)` platform).

Useful commands:

- `./mvnw spring-boot:run` / `./gradlew bootRun`: run in development.
- `./mvnw package` / `./gradlew bootJar`: build the executable jar.
- `./mvnw spring-boot:build-image` / `./gradlew bootBuildImage`: build the OCI image with buildpacks.
- `./mvnw dependency:tree`: diagnose version conflicts.

Always use the **wrapper** (`mvnw`, `gradlew`) so that all developers and the CI pipeline build with the same version of the tool.

# Level 2 · Basic-Intermediate · Spring Boot in practice

REST APIs, external configuration, validation, error handling, Actuator and how auto-configuration works.

This chapter contains 19 questions.

## Q018 · How do you create a REST endpoint? What is the difference between @PathVariable, @RequestParam and @RequestBody?

*Topic: REST · Level 2 · Basic-Intermediate*

You annotate a class with `@RestController` and its methods with `@GetMapping`, `@PostMapping`, `@PutMapping`, `@PatchMapping` or `@DeleteMapping` (shortcuts for `@RequestMapping`).

- `@PathVariable`: extracts a segment of the URL. It identifies **a specific resource**: `/customers/42`.
- `@RequestParam`: extracts query string parameters. For **filters, sorting or pagination**: `/customers?city=Valencia&page=0`. They can be optional (`required = false` or `Optional`) or have a `defaultValue`.
- `@RequestBody`: deserialises the request body (JSON) into an object, using the `HttpMessageConverter`s (Jackson).
- `@RequestHeader`: reads headers.

```java
@RestController
@RequestMapping("/api/v1/customers")
public class CustomerController {

    @GetMapping("/{id}")
    public CustomerDto get(@PathVariable Long id) { ... }

    @GetMapping
    public List<CustomerDto> search(@RequestParam(required = false) String city) { ... }

    @PostMapping
    public ResponseEntity<CustomerDto> create(@Valid @RequestBody CreateCustomerRequest req) {
        CustomerDto created = service.create(req);
        URI location = URI.create("/api/v1/customers/" + created.id());
        return ResponseEntity.created(location).body(created);
    }
}
```

### Common follow-up questions

**How would you design the URL for an action that isn't CRUD, such as cancelling an order?**

There are two accepted styles: modelling the action as a sub-resource (POST /orders/42/cancellation) or as a state change (PATCH /orders/42 with the new state). Verbs in the URL such as /cancelOrder are discouraged. What matters is consistency across the whole API.

**Synchronous controllers returning entities or ResponseEntity?**

Returning the DTO directly is cleaner when the response is always 200. ResponseEntity is used when you need to control the status or headers (201 with Location, 204, ETag, caching).

## Q019 · Which HTTP status codes and what semantics should the verbs have in a REST API? What is idempotency?

*Topic: REST · Level 2 · Basic-Intermediate*

Semantics of the main verbs:

- **GET**: reads. Safe (does not modify state) and idempotent.
- **POST**: creates or executes an action. **Not idempotent**: repeating it can create two resources.
- **PUT**: replaces the whole resource. Idempotent.
- **PATCH**: partial modification. Not idempotent by definition (it depends on the implementation).
- **DELETE**: deletes. Idempotent (deleting twice leaves the same state).

**Idempotent** means that executing the operation N times produces the same effect on the server as executing it once. It is crucial in distributed systems because clients retry on timeouts.

Common codes: `200 OK`, `201 Created` (with a `Location` header), `204 No Content`, `400 Bad Request` (validation), `401 Unauthorized` (not authenticated), `403 Forbidden` (authenticated without permission), `404 Not Found`, `409 Conflict` (state or version conflict), `422 Unprocessable Content` (semantically invalid), `429 Too Many Requests`, `500 Internal Server Error`, `502/503/504` (problems with dependencies or overload).

To make a POST idempotent, the client sends an **Idempotency-Key**: the server stores the key and, if it arrives again, returns the original response instead of executing the operation again.

> **Interview tip.** Clearly distinguishing 401 from 403 and knowing about the Idempotency-Key are usually the differentiating points.

### Common follow-up questions

**What code would you return for a resource that exists but the user cannot see?**

Technically 403, but many APIs return 404 so as not to reveal the existence of the resource (for example, other customers' orders). It is a security decision that must be consistent across the whole API.

**What is the difference between 400 and 422?**

400 indicates a malformed request (invalid JSON, wrong types). 422 indicates a syntactically correct request that cannot be processed because of business rules (an end date before the start date). Many APIs use 400 for both cases; what matters is documenting it.

## Q020 · How do you handle exceptions globally in a Spring Boot API?

*Topic: REST · Level 2 · Basic-Intermediate*

With a class annotated with `@RestControllerAdvice` (or `@ControllerAdvice`) containing `@ExceptionHandler` methods. It centralises the translation of exceptions into HTTP responses, avoiding repeated try/catch blocks in every controller.

Since Spring 6 / Boot 3 the recommendation is to return `ProblemDetail`, which implements the **RFC 9457** standard (formerly RFC 7807) for errors in HTTP APIs (`type`, `title`, `status`, `detail`, `instance` and extra properties). Automatic support can be enabled with `spring.mvc.problemdetails.enabled=true`.

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ProblemDetail notFound(ResourceNotFoundException ex) {
        ProblemDetail pd = ProblemDetail.forStatusAndDetail(HttpStatus.NOT_FOUND, ex.getMessage());
        pd.setTitle("Resource not found");
        return pd;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ProblemDetail validation(MethodArgumentNotValidException ex) {
        ProblemDetail pd = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        pd.setTitle("Invalid data");
        pd.setProperty("errors", ex.getBindingResult().getFieldErrors().stream()
            .map(e -> e.getField() + ": " + e.getDefaultMessage()).toList());
        return pd;
    }
}
```

Good practices: don't expose stack traces or internal messages to the client, log the error with a correlation identifier and have a generic handler for `Exception` that returns 500.

### Common follow-up questions

**Checked or unchecked custom exceptions?**

In Spring applications unchecked ones are preferred (extending RuntimeException): they don't pollute signatures, they trigger rollback by default and they are translated to HTTP in the advice. A small hierarchy with business meaning is advisable (ResourceNotFound, BusinessRuleViolated, VersionConflict).

**How would you add an error identifier for support?**

By including the traceId in the ProblemDetail (as an extra property or in instance). The client displays or reports it, and with it you can locate all the logs and the trace of that request.

## Q021 · How does input data validation work? What is the difference between @Valid and @Validated?

*Topic: Validation · Level 2 · Basic-Intermediate*

Spring Boot integrates **Jakarta Bean Validation** (Hibernate Validator implementation) when you add `spring-boot-starter-validation`. You annotate the DTO fields with constraints and trigger validation with `@Valid`:

```java
public record CreateCustomerRequest(
    @NotBlank @Size(max = 100) String name,
    @Email @NotNull String email,
    @Past LocalDate birthDate,
    @Valid @NotNull AddressDto address   // cascading validation
) {}
```

If it fails on a `@RequestBody`, a `MethodArgumentNotValidException` (400) is thrown.

Differences:

- `@Valid` is the Jakarta standard; it enables validation and **cascading** into nested objects.
- `@Validated` is Spring's; it supports **validation groups** (for example, different rules on creation and update) and, placed **on a class**, it enables validation of method parameters through an AOP proxy (useful for validating `@PathVariable`, `@RequestParam` or service parameters, which throw `ConstraintViolationException`).

For complex rules you create custom validators implementing `ConstraintValidator` with your own annotation (for example, `@ValidTaxId`).

### Common follow-up questions

**Where should business rules live: in validation annotations or in the domain?**

Annotations cover format and structure validations at the boundary (mandatory fields, lengths, formats). Business rules that depend on state (a shipped order cannot be cancelled) belong in the domain, inside the entities or services.

**How would you validate a rule involving several fields, such as endDate > startDate?**

With a class-level validation annotation and its ConstraintValidator, or with a method annotated with @AssertTrue in the DTO. In records you can also validate in the compact constructor.

## Q022 · What is the difference between @Value and @ConfigurationProperties?

*Topic: Configuration · Level 2 · Basic-Intermediate*

- `@Value("${app.timeout:5s}")` injects **a single property**, supports default values and SpEL expressions. Suitable for one or two values.
- `@ConfigurationProperties(prefix = "app.payments")` binds **a group of properties** to a typed object. It is the recommended option for structured configuration.

```java
@ConfigurationProperties(prefix = "app.payments")
@Validated
public record PaymentsProperties(
    @NotBlank String gatewayUrl,
    Duration timeout,
    int maxRetries,
    Map<String, String> merchants
) {}
```

Advantages of `@ConfigurationProperties`: strong typing (it converts `Duration`, `DataSize`, lists, maps), validation with `@Validated` at startup (it fails fast if configuration is missing), **relaxed binding** (`gateway-url`, `GATEWAY_URL` and `gatewayUrl` bind the same way, which fits environment variables), IDE autocompletion with `spring-boot-configuration-processor` and logical grouping. They are registered with `@EnableConfigurationProperties` or `@ConfigurationPropertiesScan`.

### Common follow-up questions

**Can I use @ConfigurationProperties on a @Bean method?**

Yes: it binds the properties onto the returned object. It is useful for configuring third-party classes, for example an additional DataSource with its own prefix.

**What is relaxed binding and why does it matter in containers?**

It is the ability to bind the same property written in different ways. Thanks to it, app.payments.gateway-url can be configured with the environment variable APP_PAYMENTS_GATEWAYURL, which is the natural way in Kubernetes and Docker.

## Q023 · What is the precedence order of external configuration in Spring Boot?

*Topic: Configuration · Level 2 · Basic-Intermediate*

Spring Boot reads properties from many sources, and those with higher precedence override those with lower. Simplifying, from **highest to lowest** priority:

- Test properties (`@TestPropertySource`, `@SpringBootTest(properties = ...)`, `@DynamicPropertySource`).
- Command-line arguments (`--server.port=9000`).
- `SPRING_APPLICATION_JSON`.
- Java system properties (`-Dserver.port=9000`).
- Operating system environment variables (`SERVER_PORT=9000`).
- Configuration files: first the profile-specific ones (`application-prod.yml`) and then the generic one; those **outside the jar** (next to the jar or in `./config/`) take priority over those packaged inside.
- `@PropertySource` on configuration classes.
- Default values (`SpringApplication.setDefaultProperties`).

The practical consequence is that the same Docker image is configured per environment through **environment variables**, without rebuilding it, which fits the 12-factor methodology. With `spring.config.import` you can add additional sources (for example, `configserver:` or `optional:file:`).

> **Interview tip.** You don't need to recite the full list: the broad order is enough (tests > command line > environment variables > external files > internal files) together with the consequence for containers.

### Common follow-up questions

**How would you override a single property in a Kubernetes pod without touching the image?**

With an environment variable in the manifest (for example, SPRING_DATASOURCE_HIKARI_MAXIMUMPOOLSIZE=15), which has higher precedence than the packaged files.

## Q024 · What is Spring Boot Actuator and which endpoints are the most important?

*Topic: Actuator · Level 2 · Basic-Intermediate*

Actuator adds production-ready **operations and monitoring** endpoints. The most used ones:

- `/actuator/health`: the status of the application and its dependencies (DB, disk, broker...). It supports groups such as `liveness` and `readiness` for Kubernetes probes.
- `/actuator/metrics` and `/actuator/prometheus`: metrics via Micrometer (JVM, HTTP, connection pool, custom metrics).
- `/actuator/info`: build and git information.
- `/actuator/env` and `/actuator/configprops`: effective properties (sensitive; values are masked).
- `/actuator/loggers`: query and **change the log level on the fly**.
- `/actuator/threaddump` and `/actuator/heapdump`: diagnostics.
- `/actuator/mappings`, `/actuator/beans`, `/actuator/conditions`: introspection (the last one explains which auto-configurations were applied and why).

By default, only `health` is exposed over HTTP. It is widened with `management.endpoints.web.exposure.include=health,info,prometheus`.

**Security**: never expose `env`, `heapdump` or `threaddump` publicly. Good practices: a separate management port (`management.server.port`), protecting them with Spring Security and exposing only what is necessary. You can create your own indicators by implementing `HealthIndicator`.

### Common follow-up questions

**How would you add information about the deployed version to the info endpoint?**

With the build-info goal of the Spring Boot plugin (it generates META-INF/build-info.properties) and the git-commit-id plugin for Git information. Actuator publishes them automatically; it is very useful for confirming which version runs in each environment.

**How would you create your own Actuator endpoint?**

With a class annotated with @Endpoint(id = "...") and @ReadOperation, @WriteOperation or @DeleteOperation methods. It is exposed over HTTP and JMX with the same security and configuration as the standard endpoints.

## Q025 · How does Spring Boot auto-configuration work internally?

*Topic: Auto-configuration · Level 2 · Basic-Intermediate*

`@EnableAutoConfiguration` imports an `ImportSelector` that loads the list of auto-configuration classes declared in `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` in each jar (before Boot 2.7/3, `spring.factories` was used).

Each auto-configuration is an `@AutoConfiguration` class guarded by **conditional annotations** that decide whether it applies:

- `@ConditionalOnClass` / `@ConditionalOnMissingClass`: depending on whether a class exists on the classpath.
- `@ConditionalOnBean` / `@ConditionalOnMissingBean`: depending on whether a bean already exists. This is the key to overriding: **if you define your own bean, the auto-configuration backs off**.
- `@ConditionalOnProperty`: depending on the value of a property.
- `@ConditionalOnWebApplication`, `@ConditionalOnResource`, etc.

```java
@AutoConfiguration
@ConditionalOnClass(DataSource.class)
@EnableConfigurationProperties(DataSourceProperties.class)
public class MyDataSourceAutoConfiguration {
    @Bean
    @ConditionalOnMissingBean
    DataSource dataSource(DataSourceProperties props) { ... }
}
```

Auto-configurations are processed **after** the user's configuration, precisely so that the `OnMissingBean` conditions see your beans. To debug: starting with `--debug` generates the **Condition Evaluation Report**, or you can query `/actuator/conditions`.

> **Interview tip.** Mentioning @ConditionalOnMissingBean as the "back-off" mechanism and the conditions report for debugging is what separates someone who has used it from someone who has read about it.

### Common follow-up questions

**How would you disable a specific auto-configuration?**

With exclude in @SpringBootApplication or with the spring.autoconfigure.exclude property, which lets you do it per environment without recompiling.

**Why shouldn't an auto-configuration use @ComponentScan?**

Because it would register beans without the conditions that let the user override them, and it could scan the application's packages. Everything must be declared explicitly with @Bean and conditions.

## Q026 · How does logging work in Spring Boot?

*Topic: Operations · Level 2 · Basic-Intermediate*

Spring Boot uses **SLF4J** as the facade and **Logback** as the default implementation (it can be switched to Log4j2 with its starter). It is configured in properties or YAML:

```yaml
logging:
  level:
    root: INFO
    com.mycompany.orders: DEBUG
    org.hibernate.SQL: DEBUG
  file:
    name: logs/app.log
```

For advanced configurations, `logback-spring.xml` is used (the `-spring` suffix lets you use `<springProfile>` and Spring properties). Since Boot 3.4 there is native support for **structured logging** in JSON (ECS, GELF, Logstash formats) with `logging.structured.format.console=ecs`, ideal for aggregators such as ELK or Loki.

Good practices:

- Use placeholders (`log.info("Order {} created", id)`) instead of concatenating strings.
- Include trace and correlation identifiers in the **MDC** (with Micrometer Tracing, `traceId` and `spanId` are added automatically).
- Don't log personal data, passwords or tokens.
- In containers, log to stdout and leave collection to the platform.

### Common follow-up questions

**How would you change the log level in production without restarting?**

With the /actuator/loggers endpoint (POST with the new level for a package) or, on platforms with centralised configuration, by updating the property and refreshing. It must be protected, and it is advisable to go back to the normal level after the investigation.

**Why is concatenating strings in logs expensive?**

Because the concatenation and the toString calls run even if the level is disabled. With placeholders, the message is only built if it is going to be written. For expensive computations, use the SLF4J 2 fluent API (log.atDebug().addArgument(() -> ...)) or check isDebugEnabled.

## Q027 · What is the lifecycle of a bean?

*Topic: Spring Core · Level 2 · Basic-Intermediate*

Simplified, for a singleton:

- **Instantiation**: the constructor is invoked (with constructor injection).
- **Property population**: setter and field injection.
- **Aware callbacks**: `BeanNameAware`, `ApplicationContextAware`...
- `BeanPostProcessor.postProcessBeforeInitialization`.
- **Initialisation**: `@PostConstruct`, then `InitializingBean.afterPropertiesSet()`, then the `initMethod` declared in `@Bean`.
- `BeanPostProcessor.postProcessAfterInitialization`: **this is where AOP proxies are created** (transactions, caching, security...). What gets injected into other beans is the proxy, not the original object.
- The bean is ready and used.
- **Destruction** when the context closes: `@PreDestroy`, `DisposableBean.destroy()`, `destroyMethod`.

Practical implications: in the constructor the proxy doesn't exist yet, so calling a `@Transactional` method from the constructor or from `@PostConstruct` doesn't open a transaction. For tasks after the full startup, it is better to listen to `ApplicationReadyEvent`.

> **Interview tip.** The point that adds the most value: proxies are created in postProcessAfterInitialization. It connects with later questions about @Transactional.

### Common follow-up questions

**What is the difference between @PostConstruct and listening to ApplicationReadyEvent?**

@PostConstruct runs when that particular bean is initialised, when other beans may not be ready and the context has not finished starting. ApplicationReadyEvent arrives when the whole application has started, which is the right moment for tasks that depend on the whole context or that take time.

## Q028 · Why use DTOs instead of exposing JPA entities directly?

*Topic: Architecture · Level 2 · Basic-Intermediate*

Exposing entities in the API couples the **public contract** to the **persistence model**, and causes several problems:

- **Security / mass assignment**: a client could send fields it shouldn't modify (for example `role` or `balance`).
- **Information leaks**: internal or sensitive fields are serialised.
- **Lazy loading problems**: Jackson accesses lazy relationships outside the transaction (`LazyInitializationException`) or triggers N+1 queries.
- **Infinite recursion** in bidirectional relationships.
- **Evolution**: changing a column breaks the API for all consumers.

DTOs (ideally immutable `record`s) define a stable contract adapted to each use case (creation request, detail response, list response). Mapping is done by hand or with **MapStruct**, which generates the code at compile time (no reflection, fast and verifiable), as opposed to ModelMapper, which uses reflection at runtime.

```java
@Mapper(componentModel = "spring")
public interface CustomerMapper {
    CustomerDto toDto(Customer entity);
    Customer toEntity(CreateCustomerRequest req);
}
```

### Common follow-up questions

**Isn't having entities, DTOs and mappers too much duplicated code?**

It is a real cost, but it pays off as soon as the API is public or the model evolves. Records and MapStruct reduce it a lot. In very small internal services you can be pragmatic, while being aware of the coupling you are accepting.

## Q029 · What are CommandLineRunner, ApplicationRunner and the application lifecycle events?

*Topic: Spring Boot · Level 2 · Basic-Intermediate*

`CommandLineRunner` and `ApplicationRunner` are interfaces whose beans run **right after the context starts**, before the application is considered ready. The difference is that `ApplicationRunner` receives the already-parsed arguments (`ApplicationArguments`), and `CommandLineRunner` receives them as `String[]`. They are ordered with `@Order`. Use cases: loading initial data, warming up caches, one-off tasks.

Spring Boot also publishes **events** throughout startup, in this approximate order: `ApplicationStartingEvent`, `ApplicationEnvironmentPreparedEvent`, `ApplicationContextInitializedEvent`, `ApplicationPreparedEvent`, `ContextRefreshedEvent`, `WebServerInitializedEvent`, `ApplicationStartedEvent`, `AvailabilityChangeEvent` (liveness), execution of runners, `ApplicationReadyEvent`, `AvailabilityChangeEvent` (readiness) and, if something fails, `ApplicationFailedEvent`.

```java
@EventListener(ApplicationReadyEvent.class)
public void onStartup() {
    log.info("Application ready to receive traffic");
}
```

Relationship with Kubernetes: the readiness probe does not switch to `ACCEPTING_TRAFFIC` until after the runners, so a slow initial load correctly delays incoming traffic.

### Common follow-up questions

**Would you use a CommandLineRunner to load test data?**

In development, yes, protected with @Profile("dev"). In production, initial data should be loaded with versioned migrations (Flyway), which are idempotent and recorded.

## Q030 · What is the DispatcherServlet and how does an HTTP request flow in Spring MVC?

*Topic: Spring MVC · Level 2 · Basic-Intermediate*

The `DispatcherServlet` implements the **Front Controller** pattern: it is a single servlet that receives all requests and delegates them to the right components. Spring Boot registers it automatically and maps it to `/`.

The path of a request to a `@RestController`:

- The request first goes through the chain of **servlet filters** (including the Spring Security chain, CORS filters, tracing filters, etc.).
- It reaches the `DispatcherServlet`, which consults the **`HandlerMapping`s** to find which method of which controller handles that URL and verb (`RequestMappingHandlerMapping` for methods annotated with `@GetMapping`, etc.).
- The `preHandle` methods of the registered **`HandlerInterceptor`s** run.
- A **`HandlerAdapter`** invokes the controller method. Before that, the **`HandlerMethodArgumentResolver`s** build each argument: they read path variables, parameters or headers, and deserialise the body with an **`HttpMessageConverter`** (Jackson for JSON). If there is `@Valid`, validation happens here.
- The method runs and returns a value. The **`HandlerMethodReturnValueHandler`s** process it: in a `@RestController`, the value is serialised with an `HttpMessageConverter` chosen through **content negotiation** (the `Accept` header).
- The interceptors' `postHandle` and, at the end, `afterCompletion` run.
- If an exception is thrown at any point, the **`HandlerExceptionResolver`s** handle it; among them is the one that invokes the `@ExceptionHandler` methods of your `@ControllerAdvice`.
- The response travels back through the filters in reverse order.

In the case of a `@Controller` that returns a view, the view name is resolved by a `ViewResolver` (Thymeleaf, for example), which generates the HTML.

Knowing this flow helps answer questions such as where to put cross-cutting logic, why a deserialisation error never reaches the controller, or why an exception thrown in a filter is not caught by the `@ControllerAdvice` (filters run outside the `DispatcherServlet`).

> **Interview tip.** The final detail (exceptions thrown in filters don't reach the @ControllerAdvice) is an excellent example of practical understanding of the flow.

## Q031 · What is the difference between a Filter, a HandlerInterceptor and an AOP aspect? When should you use each?

*Topic: Spring MVC · Level 2 · Basic-Intermediate*

All three let you run cross-cutting logic, but they act at different levels:

- **Filter** (`jakarta.servlet.Filter`, or Spring's `OncePerRequestFilter`): part of the Servlet specification, it acts **before reaching Spring MVC**. It sees the "raw" HTTP request and response, can wrap them or cut the chain. It doesn't know which controller will handle the request. Suitable for: security, CORS, compression, request logging, adding or propagating correlation identifiers.
- **HandlerInterceptor**: part of Spring MVC, it acts **inside the `DispatcherServlet`**, when the handler (the controller method and its annotations) is already known. It has three points: `preHandle`, `postHandle` and `afterCompletion`. Suitable for logic that depends on the controller: checking a custom annotation, per-endpoint metrics, localisation.
- **AOP aspect** (`@Aspect`): acts on **method calls on beans** in any layer, not just the web layer. Suitable for cross-cutting business logic: auditing service methods, measuring timings, retries, method-level permission checks.

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
public class ExecutionTimeAspect {
    @Around("@annotation(com.mycompany.Timed)")
    public Object measure(ProceedingJoinPoint pjp) throws Throwable {
        long start = System.nanoTime();
        try {
            return pjp.proceed();
        } finally {
            log.info("{} took {} ms", pjp.getSignature().toShortString(),
                     (System.nanoTime() - start) / 1_000_000);
        }
    }
}
```

Note the `finally` to clean up the MDC: server threads are reused, and a forgotten value would "contaminate" the next request handled by that thread.

## Q032 · How do you document a REST API in Spring Boot? Contract-first or code-first?

*Topic: Documentation · Level 2 · Basic-Intermediate*

The de facto standard is **OpenAPI** (formerly Swagger): a YAML or JSON specification that describes endpoints, parameters, schemas, response codes and security. It is used to generate interactive documentation, clients and servers, mocks and tests.

In Spring Boot, the most used library is **springdoc-openapi**, which generates the specification by inspecting the controllers:

```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
</dependency>
```

With that, `/v3/api-docs` (the specification) and `/swagger-ui.html` (the interactive interface) are already served. It is enriched with annotations:

```java
@Operation(summary = "Gets a customer by its identifier")
@ApiResponse(responseCode = "404", description = "The customer does not exist")
@GetMapping("/{id}")
public CustomerDto get(@Parameter(description = "Customer ID") @PathVariable Long id) { ... }
```

Two approaches:

- **Code-first**: you write the code and the specification is generated from it. Quick to start with, always in sync with the implementation. The risk is that the API design ends up shaped by the implementation and that incompatible changes go unnoticed.
- **Contract-first** (API-first): you design the OpenAPI file first, review it with the consumers and generate the server interfaces and the clients with **OpenAPI Generator**. The contract is the source of truth, teams can work in parallel (the frontend uses a generated mock) and changes are explicit in reviews. It requires more discipline and tooling.

In organisations with many teams or public APIs, contract-first is usually preferable. In both cases it is advisable to publish the specification in the pipeline and **automatically detect incompatible changes** by comparing versions (tools such as openapi-diff or oasdiff).

Security: in production, disable Swagger UI or protect it (`springdoc.swagger-ui.enabled=false`) if the API is not public.

## Q033 · What is CORS and how is it configured in Spring Boot?

*Topic: Web · Level 2 · Basic-Intermediate*

**CORS** (Cross-Origin Resource Sharing) is a **browser** mechanism. Because of the same-origin policy, the JavaScript of a page served from `https://app.store.com` cannot read responses from `https://api.store.com` (a different origin: scheme, domain or port) unless the server explicitly allows it with headers such as `Access-Control-Allow-Origin`.

For "non-simple" requests (for example, with `Content-Type: application/json`, an `Authorization` header or verbs such as PUT and DELETE), the browser first sends a **preflight** `OPTIONS` request to ask whether the real request is allowed.

Important points:

- CORS **is not a server security measure**: it protects browser users. Clients such as curl, Postman or a backend service ignore it completely.
- A CORS error shows up in the browser console even if the server has processed the request.

Global configuration in Spring MVC:

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("https://app.store.com")
            .allowedMethods("GET", "POST", "PUT", "DELETE")
            .allowedHeaders("*")
            .allowCredentials(true)
            .maxAge(3600);
    }
}
```

You can also use `@CrossOrigin` on specific controllers. If you use **Spring Security**, you must also enable CORS in the security chain (`http.cors(Customizer.withDefaults())`); otherwise, the preflight request may be rejected for lack of authentication before reaching the MVC configuration.

Common mistakes: using `allowedOrigins("*")` together with `allowCredentials(true)` (not allowed; you must list the origins or use `allowedOriginPatterns`) and configuring CORS in several places at once (gateway and services), which duplicates headers and confuses the browser. In microservices, it is usually handled only in the API Gateway.

## Q034 · How do you customise JSON serialisation with Jackson in Spring Boot?

*Topic: Serialisation · Level 2 · Basic-Intermediate*

Spring Boot automatically configures a Jackson `ObjectMapper` and uses it in the `HttpMessageConverter`s. There are several ways to customise it, from most global to most local:

- **Properties**: `spring.jackson.property-naming-strategy=SNAKE_CASE`, `spring.jackson.default-property-inclusion=non_null`, `spring.jackson.serialization.write-dates-as-timestamps=false`, `spring.jackson.time-zone`.
- A **`Jackson2ObjectMapperBuilderCustomizer`** bean (or the Jackson 3 equivalent in Boot 4), which modifies Boot's configuration without replacing it. It is preferable to declaring your own `ObjectMapper` from scratch, which would cancel the auto-configuration.
- **Annotations** on the classes: `@JsonProperty("full_name")`, `@JsonIgnore`, `@JsonInclude(NON_NULL)`, `@JsonFormat(pattern = "yyyy-MM-dd")`, `@JsonCreator`, `@JsonView`.
- **Custom serialisers** with `JsonSerializer` / `JsonDeserializer`, registered as `@JsonComponent`.

```java
public record ProductDto(
    Long id,
    String name,
    @JsonFormat(shape = JsonFormat.Shape.STRING) BigDecimal price,
    @JsonInclude(JsonInclude.Include.NON_EMPTY) List<String> tags,
    LocalDate availableFrom    // serialised as "2026-10-01"
) {}
```

Aspects that often come up in interviews:

- **Dates**: Boot registers the `java.time` module and, by default, writes them as ISO-8601 strings. It is advisable to use `Instant` or `OffsetDateTime` for instants and `LocalDate` for dates without a time zone.
- **Large numbers and money**: `BigDecimal`s and `long`s can lose precision in JavaScript; they are sometimes serialised as strings.
- **Unknown fields**: Boot disables `FAIL_ON_UNKNOWN_PROPERTIES`, which makes clients tolerant of new fields (forward compatibility).
- **Security**: never enable default polymorphic typing (`enableDefaultTyping`) with untrusted data; it has been the source of deserialisation vulnerabilities.
- **Recursion** in bidirectional relationships: solved with DTOs or with `@JsonManagedReference` / `@JsonBackReference`.

Version note: Spring Boot 4 adopts **Jackson 3**, whose base package changes to `tools.jackson` and whose `ObjectMapper` is immutable (configured with `JsonMapper.builder()`), while keeping compatibility support for Jackson 2.

## Q035 · How do you run scheduled and asynchronous tasks in Spring Boot? What problems do they have in environments with several instances?

*Topic: Tasks · Level 2 · Basic-Intermediate*

**Scheduled tasks**: enabled with `@EnableScheduling`, with methods annotated with `@Scheduled`:

```java
@Scheduled(cron = "0 0 3 * * *", zone = "Europe/Madrid")   // every day at 3:00
public void purgeAbandonedCarts() { ... }

@Scheduled(fixedDelayString = "PT30S")   // 30 s after the previous execution finishes
public void syncStock() { ... }
```

`fixedRate` measures from the start of the previous execution; `fixedDelay`, from its end. By default, Spring uses **a single thread** for all scheduled tasks: a slow task delays the others. It is widened with `spring.task.scheduling.pool.size`, or virtual threads can be used.

**Asynchronous execution**: with `@EnableAsync`, an `@Async` method runs in another thread and the caller continues. It can return `void` or `CompletableFuture<T>`.

```java
@Async
public CompletableFuture<Report> generateReport(Long id) {
    return CompletableFuture.completedFuture(generator.generate(id));
}
```

Things to watch with `@Async`: it is a proxy, so it suffers from the self-invocation problem; exceptions in `void` methods are lost unless an `AsyncUncaughtExceptionHandler` is configured; the security context, the MDC and the transaction **are not propagated** to the new thread by default (use a `TaskDecorator` or Micrometer's Context Propagation library); and it is advisable to configure the pool (`spring.task.execution.pool.*`) so as not to create unlimited threads.

**Problem with several instances**: if there are three replicas of the service, each will run the scheduled task, so three emails will be sent or the same batch will be processed three times. Solutions:

- **ShedLock**: a distributed lock on the database, Redis or ZooKeeper so that only one instance runs the task (`@SchedulerLock(name = "purge", lockAtMostFor = "10m")`).
- Take the task out of the service: a **Kubernetes CronJob** or an external scheduler.
- Design the task to be **idempotent** and share out the work with `SELECT ... FOR UPDATE SKIP LOCKED` so that several instances process different batches without stepping on each other.
- For complex batch processes (reading, processing and writing in chunks, restarting from the point of failure), **Spring Batch**.

> **Interview tip.** The problem of duplicated scheduled tasks with several replicas and the ShedLock solution is a very common practical question.

## Q036 · How does Spring Security work at a high level?

*Topic: Security · Level 2 · Basic-Intermediate*

Spring Security plugs in as a **chain of servlet filters**. A delegating filter (`DelegatingFilterProxy` → `FilterChainProxy`) chooses, based on the URL, which `SecurityFilterChain` to apply; each chain contains specialised filters in order: security header management, CSRF, CORS, credential extraction (form, HTTP Basic, Bearer token), exception handling and authorisation.

Main components:

- **`Authentication`**: represents the authenticated user (or the authentication attempt), with its *principal* and its *authorities* (roles or permissions).
- **`SecurityContextHolder`**: stores the current user's authentication, by default in a `ThreadLocal`, so that any layer can query it.
- **`AuthenticationManager`** and its **`AuthenticationProvider`s**: validate the credentials (username and password against a `UserDetailsService`, a JWT token, LDAP...). It is an application of the Strategy pattern.
- **`PasswordEncoder`**: passwords are stored with an adaptive hash (**BCrypt**, Argon2, SCrypt), never in plain text or with plain MD5/SHA.
- **Authorisation**: by URL in the chain (`authorizeHttpRequests`) or by method with `@PreAuthorize` (enabled with `@EnableMethodSecurity`).

```java
@Configuration
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    SecurityFilterChain api(HttpSecurity http) throws Exception {
        return http
            .csrf(csrf -> csrf.disable())          // stateless API with tokens, no cookies
            .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(a -> a
                .requestMatchers(HttpMethod.GET, "/api/products/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated())
            .oauth2ResourceServer(o -> o.jwt(Customizer.withDefaults()))
            .build();
    }
}
```

`401` versus `403`: the `AuthenticationEntryPoint` responds when there is no valid authentication (401) and the `AccessDeniedHandler` when the authenticated user lacks permissions (403).

About **CSRF**: it is needed when the browser sends credentials automatically (session cookies). In stateless APIs that receive the token in the `Authorization` header, it can be disabled; if the API uses cookies (for example, behind a BFF), it must be kept.

When you add the starter without configuration, Spring Boot protects all endpoints and generates a `user` user with a random password that it prints in the log: useful for discovering it, never for production.

# Level 3 · Intermediate · Persistence, transactions and testing

Spring Data JPA, classic performance problems, @Transactional under the hood and how a Spring Boot application is really tested.

This chapter contains 19 questions.

## Q037 · How do Spring Data JPA repositories work?

*Topic: Spring Data · Level 3 · Intermediate*

You declare an **interface** that extends `JpaRepository<Entity, Id>` and Spring Data generates an implementation at runtime (a proxy backed by `SimpleJpaRepository`) with CRUD, pagination and sorting.

Ways to define queries:

- **Query methods derived from the name**: `findByEmailAndActiveTrue(String email)`, `countByCity(String city)`, `existsByTaxId(String taxId)`. They are validated at startup.
- `@Query` with **JPQL** or native SQL (`nativeQuery = true`), for complex queries. Modifications require `@Modifying`.
- **Projections**: returning interfaces or records with only the fields you need, which generate a lighter SELECT.
- **Specifications** / Criteria API or **Querydsl** for dynamic filters.
- **Query by Example**.

```java
public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByCustomerIdAndStatus(Long customerId, OrderStatus status);

    @Query("select o from Order o join fetch o.lines where o.id = :id")
    Optional<Order> findWithLines(@Param("id") Long id);

    @Modifying
    @Query("update Order o set o.status = :status where o.date < :limit")
    int cancelOld(@Param("status") OrderStatus status, @Param("limit") LocalDate limit);
}
```

Watch out: repository methods are transactional by default (`readOnly = true` for reads), but operations involving several repository calls need their own `@Transactional` in the service.

### Common follow-up questions

**What is the difference between findById and getReferenceById?**

findById runs the query and returns an Optional with the entity. getReferenceById returns a proxy without querying the database; it only queries when an attribute is accessed. It is useful for assigning relationships without loading the entity (order.setCustomer(customers.getReferenceById(id))), but it throws an exception when used if the record doesn't exist.

**How would you implement a search with optional, combinable filters?**

With Specifications (JpaSpecificationExecutor) composing only the criteria present, with Querydsl or with Query by Example. Writing one query method per combination of filters doesn't scale.

## Q038 · What is the N+1 problem and how is it solved?

*Topic: JPA · Level 3 · Intermediate*

It happens when a list of N entities is loaded with one query and then, when accessing a relationship of each one, **one additional query per element** is fired: 1 + N queries. With 500 orders and their customers, 501 queries where one would have been enough. It is the most frequent cause of performance problems in JPA applications.

```java
List<Order> orders = repo.findAll();              // 1 query
orders.forEach(o -> o.getCustomer().getName());   // N queries
```

Solutions:

- **JOIN FETCH** in JPQL: `select o from Order o join fetch o.customer`.
- **@EntityGraph** on the repository: `@EntityGraph(attributePaths = {"customer", "lines"})`.
- **Batch fetching**: `@BatchSize(size = 50)` or `hibernate.default_batch_fetch_size=50`, which groups lazy loads into `IN (...)` queries: from N+1 to 1 + N/50.
- **DTO projections**: query directly only the data you need.

Caution: a `JOIN FETCH` of **two collections** at once causes a Cartesian product (or `MultipleBagFetchException` with `List`). In that case, fetch one collection and use batch fetching for the other, or split into two queries. Paginating with `JOIN FETCH` of collections makes Hibernate paginate in memory (warning `HHH90003004`).

To detect it: enable SQL logging in development, Hibernate statistics or tools such as Hypersistence Optimizer or datasource-proxy in tests.

> **Interview tip.** Explaining the cause, giving at least two solutions and mentioning the Cartesian product problem shows real experience.

### Common follow-up questions

**How would you automatically detect N+1 in tests?**

By counting the SQL statements executed in an integration test with libraries such as datasource-proxy or Hibernate statistics, and failing if the expected number is exceeded. That way a regression is caught in CI.

**Does N+1 only happen with LAZY relationships?**

No. With EAGER relationships on @ManyToOne, when loading a list with JPQL Hibernate fires an additional query for each EAGER relationship not included in a fetch join. EAGER doesn't prevent the problem: it hides it.

## Q039 · What is the difference between LAZY and EAGER loading? What are LazyInitializationException and Open Session In View?

*Topic: JPA · Level 3 · Intermediate*

- **EAGER**: the relationship is loaded together with the entity. The default for `@ManyToOne` and `@OneToOne`.
- **LAZY**: it is loaded the first time it is accessed, through a proxy. The default for `@OneToMany` and `@ManyToMany`.

General recommendation: **everything LAZY** (including `@ManyToOne`) and decide what to load in each query with fetch joins or entity graphs. EAGER cannot be "switched off" per query and causes unnecessary loads or hidden N+1s.

`LazyInitializationException` appears when a lazy relationship is accessed **after the Hibernate session has been closed** (outside the transaction), for example when serialising the entity in the controller.

**Open Session In View (OSIV)** keeps the session open during the whole HTTP request, including the serialisation of the view. Spring Boot enables it **by default** (`spring.jpa.open-in-view=true`) and warns about it in the log at startup. It avoids the exception but is considered an **anti-pattern**: it holds a pool connection for the whole request and hides N+1 queries fired from the web layer.

The recommendation is `spring.jpa.open-in-view=false` and to decide in the service layer which data is needed, returning DTOs.

### Common follow-up questions

**Why does Spring Boot keep Open Session In View enabled by default if it is an anti-pattern?**

For compatibility and so that simple applications work without lazy-loading errors. That is why it shows a warning at startup: it invites you to disable it consciously.

## Q040 · How does @Transactional work? What types of propagation exist?

*Topic: Transactions · Level 3 · Intermediate*

`@Transactional` is implemented with **AOP**: Spring wraps the bean in a **proxy** that, before invoking the method, obtains or creates a transaction through the `PlatformTransactionManager` and, when it finishes, commits or rolls back. The transaction state is bound to the thread through a `ThreadLocal` (`TransactionSynchronizationManager`).

Types of **propagation** (what happens if a transaction already exists):

- `REQUIRED` (default): joins the existing one or creates a new one.
- `REQUIRES_NEW`: suspends the existing one and creates an **independent** one (useful for auditing that must persist even if the main operation fails). It consumes a second connection.
- `SUPPORTS`: uses the existing one if there is one; otherwise, runs without a transaction.
- `MANDATORY`: requires an existing one; otherwise, throws an exception.
- `NOT_SUPPORTED`: suspends the existing one and runs without a transaction.
- `NEVER`: throws an exception if one exists.
- `NESTED`: creates a **savepoint** within the existing one (partial rollback); it requires JDBC savepoint support.

Other attributes: `readOnly` (optimisations: Hibernate skips dirty checking and it can route to replicas), `timeout`, `isolation`, `rollbackFor` / `noRollbackFor`.

A trap with `REQUIRED`: if an inner method marks the transaction as rollback-only (because of an exception caught further up), the commit of the outer one will fail with `UnexpectedRollbackException`.

### Common follow-up questions

**Where would you put @Transactional: in the controller, the service or the repository?**

In the service (or use case) layer, which defines the business unit of work. In the controller it would lengthen the transaction unnecessarily and couple it to the web; in the repository it would be too fine-grained for operations involving several accesses.

**What does @Transactional do on the class instead of on the method?**

It applies the configuration to all public methods. A common pattern is @Transactional(readOnly = true) at class level and @Transactional on the methods that write.

## Q041 · When does @Transactional roll back? What isolation levels exist?

*Topic: Transactions · Level 3 · Intermediate*

**Default rollback rule**: it rolls back on **unchecked** exceptions (`RuntimeException` and `Error`), but **not** on checked exceptions. It is an EJB legacy that surprises many people: if a method throws `IOException`, the transaction commits. It is changed with `@Transactional(rollbackFor = Exception.class)`. And if you catch the exception inside the method and don't rethrow it, there is no rollback.

**Isolation levels** (which concurrency anomalies are allowed):

- `READ_UNCOMMITTED`: allows **dirty reads** (seeing uncommitted data from another transaction).
- `READ_COMMITTED`: prevents dirty reads, but allows **non-repeatable reads** (reading the same row twice with different results). The default in PostgreSQL, Oracle and SQL Server.
- `REPEATABLE_READ`: prevents non-repeatable reads; in theory it allows **phantom reads** (new rows appear in a range). The default in MySQL/InnoDB.
- `SERIALIZABLE`: maximum isolation, as if transactions ran serially; more locking or serialisation failures that require retrying.

`Isolation.DEFAULT` uses the database's. Besides these anomalies, there are **lost updates** (two transactions read, modify and write the same row), which are prevented with optimistic or pessimistic locking.

> **Interview tip.** The checked-exceptions rule is a very common trick question.

### Common follow-up questions

**What isolation level would you choose for a booking system?**

Normally READ_COMMITTED is kept and critical operations are protected with optimistic or pessimistic locking or atomic conditional updates. Raising global isolation to SERIALIZABLE penalises the whole application and forces you to retry serialisation failures.

## Q042 · What is the self-invocation problem with @Transactional?

*Topic: Transactions · Level 3 · Intermediate*

Since `@Transactional` works through a proxy, it only applies when the call **goes through the proxy**, that is, when it comes from another bean. If a method of a class calls another `@Transactional` method **of the same class** (`this.method()`), the call doesn't go through the proxy and the annotation is silently **ignored**.

```java
@Service
public class ReportService {
    public void generateAll() {
        for (var id : ids) {
            generate(id);          // this.generate(): does NOT go through the proxy
        }
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void generate(Long id) { ... }  // the annotation has no effect
}
```

The same happens with `@Async`, `@Cacheable`, `@Retryable` or `@PreAuthorize`. Other proxy limitations: with CGLIB proxies, `private` or `final` methods are not intercepted.

Solutions:

- **Move the method to another bean** (the cleanest and most common).
- Use `TransactionTemplate` to manage the transaction programmatically.
- Self-inject the bean (`@Lazy` on the service itself) or use `AopContext.currentProxy()`, solutions that work but are considered inelegant.
- Use AspectJ with compile-time or load-time weaving, which doesn't depend on proxies.

> **Interview tip.** It is probably the most repeated Spring question in mid-level interviews. Mastering it, with the example, is a must.

### Common follow-up questions

**How would you check in a test that a method really runs in a transaction?**

By querying TransactionSynchronizationManager.isActualTransactionActive() inside the method in an integration test, or by verifying the effect: causing an exception after a write and checking that it has been rolled back.

## Q043 · What is the difference between optimistic and pessimistic locking?

*Topic: JPA · Level 3 · Intermediate*

Both prevent **lost updates** when several transactions modify the same record.

**Optimistic locking**: assumes conflicts are rare. A version column is added with `@Version`. On update, Hibernate executes `UPDATE ... SET ..., version = 6 WHERE id = ? AND version = 5`. If another transaction has already changed it, 0 rows are updated and an `OptimisticLockException` is thrown (in Spring, `ObjectOptimisticLockingFailureException`). It locks nothing in the database, scales well and even works across different HTTP requests (by sending the version to the client, for example with ETag / `If-Match`). The application decides what to do: retry or return a 409 Conflict.

```java
@Entity
public class Product {
    @Id Long id;
    int stock;
    @Version Long version;
}
```

**Pessimistic locking**: assumes there will be conflicts and locks the row in the database (`SELECT ... FOR UPDATE`) until the end of the transaction. In Spring Data: `@Lock(LockModeType.PESSIMISTIC_WRITE)`. It guarantees exclusion, but reduces concurrency and can cause **deadlocks**; it is advisable to configure a lock timeout.

Criterion: optimistic for most cases (low contention); pessimistic when contention is high and retrying is expensive (for example, reserving the last units of stock of a product in high demand). For simple counters, an atomic update (`UPDATE ... SET stock = stock - 1 WHERE stock > 0`) is usually the best option.

### Common follow-up questions

**How would you expose optimistic locking in a REST API?**

By returning the version as an ETag in GET responses and requiring the If-Match header on PUT or PATCH. If the version doesn't match, respond with 412 Precondition Failed (or 409), and the client knows it must reload the resource before modifying it.

**What would you do on receiving an OptimisticLockException in an automated process?**

Retry the whole operation (read again, apply the logic and save) a limited number of times, for example with @Retryable. Retrying only the save with the old entity would fail again.

## Q044 · How are database schema changes managed? Why not use ddl-auto in production?

*Topic: Persistence · Level 3 · Intermediate*

`spring.jpa.hibernate.ddl-auto` (`create`, `create-drop`, `update`, `validate`, `none`) lets Hibernate generate the schema. In production it is dangerous: `update` doesn't drop columns, doesn't migrate data, isn't versionable or reproducible and can apply unexpected changes. The right setting in production is `validate` or `none`.

**Versioned migration** tools are used:

- **Flyway**: numbered SQL scripts (`V1__create_tables.sql`, `V2__add_email.sql`) in `db/migration`. It records in the `flyway_schema_history` table which migrations have been applied and their checksum. Simple and explicit.
- **Liquibase**: changelogs in XML, YAML, JSON or SQL, with more abstraction across databases, preconditions and declarative rollbacks.

Spring Boot runs the migrations automatically at startup if it detects the dependency.

Good practices: never modify a migration that has already been applied (the checksum will fail); small, reversible migrations; for zero-downtime deployments, apply the **expand/contract** pattern (first add without breaking anything, deploy compatible code and, in a later version, remove the old parts); test the migrations in CI against the real database with Testcontainers.

### Common follow-up questions

**What would you do if a migration fails halfway in production?**

In PostgreSQL, DDL is transactional and Flyway rolls back the whole migration. In MySQL it isn't, and the migration can be left half-done: you have to manually repair the schema and the history table (flyway repair). That is why migrations must be small and tested against the same database as production.

## Q045 · What is the difference between @SpringBootTest and test slices such as @WebMvcTest or @DataJpaTest?

*Topic: Testing · Level 3 · Intermediate*

- `@SpringBootTest` starts the application's **full context**. It is an integration test: faithful to reality, but slow. With `webEnvironment = RANDOM_PORT` it starts the real server and you can test with `TestRestTemplate`, `WebTestClient` or `RestTestClient` (Boot 4).
- **Test slices** load only a "slice" of the context, and are much faster:
  - `@WebMvcTest(CustomerController.class)`: the web layer (controllers, advice, filters, Jackson converters, validation) with `MockMvc`; services are replaced by mocks.
  - `@DataJpaTest`: entities, repositories and `EntityManager`; each test is transactional with rollback. By default it tries to use an embedded DB.
  - `@JsonTest`, `@RestClientTest`, `@WebFluxTest`, `@DataMongoTest`...

```java
@WebMvcTest(CustomerController.class)
class CustomerControllerTest {
    @Autowired MockMvc mvc;
    @MockitoBean CustomerService service;

    @Test
    void returns404IfNotFound() throws Exception {
        when(service.get(99L)).thenThrow(new ResourceNotFoundException("99"));
        mvc.perform(get("/api/v1/customers/99"))
           .andExpect(status().isNotFound())
           .andExpect(jsonPath("$.title").value("Resource not found"));
    }
}
```

Version note: since Spring Boot 3.4, `@MockBean` and `@SpyBean` are deprecated in favour of `@MockitoBean` and `@MockitoSpyBean` (from Spring Framework).

Performance: Spring **caches the context** between tests with the same configuration. Each different `@MockitoBean` or each change of properties creates a new context; it is advisable to standardise configurations so that the suite doesn't become slow.

> **Interview tip.** Talking about the context cache and how different mocks break it is a highly valued detail, especially for QA Automation roles.

### Common follow-up questions

**How would you test an endpoint protected with Spring Security in @WebMvcTest?**

With spring-security-test: @WithMockUser to simulate a user with roles, or MockMvc post-processors such as jwt() to simulate a token with specific scopes. That way you test both the allowed accesses and the 401s and 403s.

## Q046 · What is Testcontainers and why is it preferable to an in-memory database such as H2?

*Topic: Testing · Level 3 · Intermediate*

**Testcontainers** is a library that starts disposable Docker containers during tests: PostgreSQL, Kafka, Redis, RabbitMQ, LocalStack, WireMock, etc.

Problems with H2 as a substitute: a different SQL dialect, types (JSONB, arrays), functions, and different locking and constraint behaviour. Tests pass with H2 and the application fails in production. In addition, it doesn't let you test Flyway migrations written in native SQL.

With Testcontainers you test against **the same technology and version** as in production. Spring Boot 3.1+ simplifies its use with `@ServiceConnection`, which configures the connection automatically without `@DynamicPropertySource`:

```java
@SpringBootTest
@Testcontainers
class OrderRepositoryIT {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired OrderRepository repo;

    @Test
    void savesAndRetrieves() { ... }
}
```

Good practices: shared `static` containers (or the singleton container pattern) so as not to start one per class, reuse locally (`testcontainers.reuse.enable=true`) and pin the image versions. Boot also lets you use Testcontainers in **local development** (`SpringApplication.from(App::main).with(TestConfig.class)`) or Docker Compose (`spring-boot-docker-compose`).

### Common follow-up questions

**What are the drawbacks of Testcontainers?**

It requires Docker on the development machines and in CI, and the first start of the containers takes time. It is mitigated by reusing containers across test classes and with lightweight images. In CI without Docker you can use Testcontainers Cloud or runners with Docker available.

## Q047 · How do you structure the testing strategy in microservices? What is contract testing?

*Topic: Testing · Level 3 · Intermediate*

The classic pyramid (many unit tests, fewer integration tests, few end-to-end tests) is still valid, but in microservices **service integration tests** and **contract tests** gain weight:

- **Unit**: isolated domain logic, without Spring. Fast.
- **Integration / component**: the whole service with its real infrastructure dependencies (Testcontainers) and the dependencies on other services simulated (WireMock).
- **Contract**: they verify that provider and consumer agree on the API, **without deploying both at the same time**.
- **End-to-end**: few, on critical flows, because they are slow, brittle and expensive to maintain.

**Contract testing**: the problem it solves is that service A has mocks of B that can become outdated; A's tests pass but the integration fails in production.

- **Pact** (consumer-driven): the consumer defines in its tests what it expects from the provider and generates a contract (a "pact"). It is published to a **Pact Broker** and the provider verifies it in its pipeline. With `can-i-deploy` you decide whether a version is compatible with what is deployed.
- **Spring Cloud Contract**: the contract is written on the provider side (Groovy/YAML), which generates tests for the provider and WireMock **stubs** for the consumers.

For asynchronous messaging there are also message contracts (Pact message pacts). Other techniques: performance tests (Gatling, k6), chaos engineering and smoke tests after each deployment.

> **Interview tip.** Very relevant if the position has a QA component: knowing Pact, WireMock and Testcontainers and when to use each one is a strong differentiator.

### Common follow-up questions

**What is the "honeycomb" testing shape?**

It is a proposal for microservices that puts the weight on service integration tests (testing the whole service through its API with real or simulated dependencies), with fewer unit tests of implementation details and very few integration tests between services. It reflects that, in small services, most of the risk lies in the integrations.

**Who should write the contract tests?**

In the consumer-driven approach, the consumer team writes the expectations and the provider verifies them in its pipeline. The key is that the failure shows up in the provider's pipeline before a change that breaks a consumer is deployed.

## Q048 · How are pagination and sorting implemented? What problems does offset pagination have?

*Topic: Spring Data · Level 3 · Intermediate*

Spring Data accepts a `Pageable` and returns `Page<T>` (with the total number of elements, which implies an extra `count` query) or `Slice<T>` (it only knows whether there is a next page, which is cheaper). In controllers it is resolved directly from the query string: `?page=0&size=20&sort=date,desc`.

```java
@GetMapping
public Page<OrderDto> list(@PageableDefault(size = 20, sort = "date",
        direction = Sort.Direction.DESC) Pageable pageable) {
    return repo.findAll(pageable).map(mapper::toDto);
}
```

Good practices: limit the maximum size (`spring.data.web.pageable.max-page-size`), validate the allowed sort fields and don't serialise `PageImpl` directly (Boot 3.3+ warns about it; use `PagedModel` or your own DTO with `@EnableSpringDataWebSupport(pageSerializationMode = VIA_DTO)`).

The problem with **offset** pagination (`LIMIT 20 OFFSET 100000`): the database has to go through and discard all the previous rows, so deep pages are slow; also, if rows are inserted while the user is paging, duplicates appear or elements are skipped.

Alternative: **cursor / keyset pagination** (`WHERE date < :lastDate ORDER BY date DESC LIMIT 20`), which uses the index and has constant cost. Spring Data 3.1+ supports it with `ScrollPosition` and `Window<T>`.

### Common follow-up questions

**How would you prevent a client from sorting by a field that has no index?**

By validating the sort fields against an allow-list before building the Pageable, and returning 400 if it is not valid. Besides performance, it avoids exposing internal names or causing errors due to non-existent fields.

## Q049 · What is the lifecycle of a JPA entity? What is the difference between persist and merge? What is dirty checking?

*Topic: JPA · Level 3 · Intermediate*

An entity goes through four states with respect to the **persistence context** (the `EntityManager`, which in Spring normally lives as long as the transaction):

- **Transient** (new): created with `new`, with no relation to the context and no row in the database.
- **Managed**: associated with the context. Hibernate watches its changes.
- **Detached**: it was related to a context that has since been closed (for example, outside the transaction). Its changes are no longer watched.
- **Removed**: marked to be deleted at flush.

**persist** turns a *transient* entity into a *managed* one; the row is inserted at the next flush. **merge** copies the state of an entity (normally *detached*) onto a *managed* instance, loading it from the database if needed, and **returns that managed instance**; the object passed as the argument remains detached. A typical mistake: continuing to modify the original object after `merge` and expecting it to be saved.

Spring Data's `save()` decides: if the entity is new (null ID or null version) it calls `persist`, and otherwise `merge`. With manually assigned IDs (for example, UUIDs generated in the constructor), Spring Data believes the entity already exists and does a `merge`, which causes an unnecessary `SELECT` before the `INSERT`. It is solved by implementing `Persistable<ID>` with your own `isNew()`.

**Dirty checking**: at flush time, Hibernate compares the current state of each managed entity with a copy (snapshot) taken when it was loaded, and automatically generates the necessary `UPDATE`s. That is why, inside a transaction, **there is no need to call `save()`** to persist changes to a loaded entity:

```java
@Transactional
public void changeEmail(Long id, String email) {
    Customer c = repo.findById(id).orElseThrow();
    c.changeEmail(email);   // on commit, Hibernate generates the UPDATE
}
```

The **flush** (synchronising the context with the database) happens before the commit, before running JPQL queries that may be affected by pending changes (`AUTO` mode) or when calling `flush()` explicitly. With `@Transactional(readOnly = true)`, Hibernate skips the snapshot and dirty checking, which saves memory and CPU on reads.

> **Interview tip.** Knowing that there is no need to call save() inside a transaction, and why, is a clear sign that you understand JPA beyond the tutorials.

## Q050 · How do you implement equals and hashCode correctly in a JPA entity?

*Topic: JPA · Level 3 · Intermediate*

It is a subtle problem because an entity's identity changes over its life: before it is persisted, if the ID is generated by the database, it is `null`.

Options and their problems:

- **Not overriding them** (Java object identity): it works within a single persistence context, because Hibernate guarantees a single instance per row, but it fails when comparing entities from different contexts (for example, a detached one with one just loaded).
- **Using all fields** (what Lombok's `@Data` does): the hash changes every time an attribute changes and it traverses lazy relationships. Incorrect.
- **Using only the generated ID**: the hash changes on persist (from `null` to a value), so an entity added to a `HashSet` before saving it can no longer be found afterwards.

Correct solutions:

- An immutable, unique **natural key** (tax ID, ISBN, product code), if one exists. It is annotated with `@NaturalId` in Hibernate.
- An **application-generated ID** (UUID, ideally UUIDv7 for time ordering, or TSID) assigned in the constructor: the identity exists from the start and doesn't change.
- A **database-generated ID** with a constant `hashCode`:

```java
@Entity
public class Order {
    @Id @GeneratedValue
    private Long id;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Order other)) return false;
        return id != null && id.equals(other.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();   // constant: doesn't change on persist
    }
}
```

A constant `hashCode` makes all entities of that class fall into the same bucket of a `HashSet`, which is inefficient for huge collections, but in-memory entity collections are usually small and correctness is the priority.

There is another detail: with Hibernate proxies, the proxy's `getClass()` doesn't match the entity's, so instead of comparing classes you use `instanceof` and access the fields through getters, or unwrap the proxy with `Hibernate.getClass()`.

## Q051 · How are relationships modelled in JPA? What are the owning side, cascade and orphanRemoval?

*Topic: JPA · Level 3 · Intermediate*

Relationship types: `@OneToOne`, `@ManyToOne`, `@OneToMany` and `@ManyToMany`. They can be unidirectional or bidirectional.

In a bidirectional relationship, **one of the sides is the owner** (*owning side*): the one that holds the foreign key and whose changes determine what is written to the database. The other side is marked with `mappedBy` and is only an in-memory reflection. In `@OneToMany` / `@ManyToOne`, the owner is always the `@ManyToOne` side.

```java
@Entity
public class Order {
    @Id @GeneratedValue Long id;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderLine> lines = new ArrayList<>();

    public void addLine(OrderLine line) {   // keeps both sides in sync
        lines.add(line);
        line.setOrder(this);
    }

    public void removeLine(OrderLine line) {
        lines.remove(line);
        line.setOrder(null);
    }
}

@Entity
public class OrderLine {
    @Id @GeneratedValue Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "order_id")
    private Order order;
}
```

A classic mistake: adding the line only to the `lines` list without assigning `line.setOrder(order)`. Since the owning side doesn't change, the foreign key is left `null`. Helper methods such as `addLine` avoid the problem.

**Cascade** propagates operations from the parent to the children (`PERSIST`, `MERGE`, `REMOVE`, `ALL`...). It makes sense in **composition** relationships, where the child doesn't exist without the parent (the lines of an order: within the same aggregate in DDD terms). `CascadeType.REMOVE` must not be used on `@ManyToOne` or `@ManyToMany` relationships: deleting an order must not delete the customer.

**orphanRemoval = true** deletes the child when it is removed from the parent's collection, without needing to call `delete`.

Other recommendations: prefer `Set` or `List` depending on the semantics and the multiple-fetch problem; avoid `@ManyToMany` when the relationship has its own attributes (model an explicit intermediate entity instead); and in a unidirectional `@OneToMany` without `@JoinColumn`, Hibernate creates an unnecessary join table.

## Q052 · When would you use JDBC (JdbcClient) or jOOQ instead of JPA?

*Topic: Persistence · Level 3 · Intermediate*

JPA/Hibernate is excellent when working with a **rich domain model** and aggregate-centred operations: load an entity, modify it applying business rules and save it. It provides dirty checking, a first-level cache, relationship management and optimistic locking.

Its costs: a considerable learning curve (states, lazy loading, N+1, flush), generated queries that are not always optimal, and little convenience for advanced SQL (window functions, CTEs, `UPSERT`, bulk operations).

Alternatives in the Spring ecosystem:

- **JdbcClient** (Spring 6.1+): a fluent API on top of `JdbcTemplate`. Explicit SQL, no magic, ideal for read queries, reports and bulk operations.

```java
List<MonthlySales> sales = jdbcClient.sql("""
        SELECT date_trunc('month', order_date) AS month, sum(total) AS amount
        FROM orders
        WHERE order_date >= :from
        GROUP BY 1 ORDER BY 1
        """)
    .param("from", from)
    .query(MonthlySales.class)
    .list();
```

- **Spring Data JDBC**: Spring Data-style repositories but without a persistence context, lazy loading or dirty checking. Each `save` writes explicitly. It fits very well with small DDD aggregates and a more predictable model.
- **jOOQ**: generates classes from the schema and lets you write **type-safe** SQL in Java, with errors caught at compile time. Very powerful for complex queries.
- **MyBatis**: mapping of hand-written SQL in XML or annotations; common in legacy projects.

It is perfectly valid to **combine** approaches in the same service: JPA for the write side (commands on aggregates) and JdbcClient or jOOQ for the read side (queries and reports), a natural small-scale application of CQRS.

## Q053 · How do you write unit tests with JUnit 5 and Mockito? What is the difference between a mock, a spy and a stub?

*Topic: Testing · Level 3 · Intermediate*

A unit test tests a class in isolation from its dependencies, which are replaced by **test doubles**. With constructor injection, Spring isn't needed: creating the object is enough.

- **Stub**: a double that returns predefined answers (`when(...).thenReturn(...)`). It is used to control indirect inputs.
- **Mock**: a double on which **interactions are also verified** (`verify(...)`). It is used to check indirect outputs (that a notification was sent, for example). In Mockito, the same `mock()` object serves both purposes.
- **Spy**: wraps a **real** object; by default it calls the real methods, except those that are redefined. Useful with legacy code; if you need it often, it usually indicates a design problem.
- **Fake**: a simplified working implementation (an in-memory repository).

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock OrderRepository repo;
    @Mock Notifier notifier;
    @InjectMocks OrderService service;

    @Captor ArgumentCaptor<Order> orderCaptor;

    @Test
    void confirmingPendingOrderSavesAndNotifies() {
        Order order = Order.pending(1L, List.of(line("PROD-1", 2)));
        when(repo.findById(1L)).thenReturn(Optional.of(order));

        service.confirm(1L);

        verify(repo).save(orderCaptor.capture());
        assertThat(orderCaptor.getValue().getStatus()).isEqualTo(OrderStatus.CONFIRMED);
        verify(notifier).orderConfirmed(1L);
    }

    @Test
    void confirmingNonExistentOrderThrowsException() {
        when(repo.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.confirm(99L))
            .isInstanceOf(ResourceNotFoundException.class);
        verifyNoInteractions(notifier);
    }
}
```

Good practices:

- **Arrange / Act / Assert** (or *Given / When / Then*) structure and test names that describe the behaviour.
- Expressive assertions with **AssertJ**.
- **Don't mock what you don't own** (for example, `RestClient` or `EntityManager`): wrap it in your own adapter and mock the adapter, or test it with an integration test.
- Don't mock value objects or domain entities: use real instances.
- Avoid verifying every interaction; verify only what is relevant to the behaviour. Too many `verify` calls produce brittle tests that break with any refactoring.
- Mockito in strict mode (the default with the extension) fails if there are unused stubs, which helps keep tests clean.
- Parameterised tests with `@ParameterizedTest` and `@CsvSource` or `@MethodSource` to cover many cases without duplicating code.

> **Interview tip.** For roles with a QA component, explaining the difference between verifying state and verifying behaviour, and the danger of tests coupled to the implementation, earns a lot of points.

## Q054 · How do you test HTTP clients that call other services? What is WireMock?

*Topic: Testing · Level 3 · Intermediate*

Testing an HTTP client against the real service is slow, brittle and doesn't let you simulate errors. Mocking the `RestClient` with Mockito verifies nothing useful: not the URL, not the serialisation, not the handling of error codes.

**WireMock** starts a configurable **fake HTTP server**: you define responses for specific requests and then verify which requests were received. It lets you simulate delays, 500 errors, malformed responses or dropped connections, which is ideal for testing timeouts, retries and circuit breakers.

```java
@SpringBootTest
@EnableWireMock(@ConfigureWireMock(name = "customers", baseUrlProperties = "customers.url"))
class CustomersClientIT {

    @InjectWireMock("customers") WireMockServer wiremock;
    @Autowired CustomersClient client;

    @Test
    void getsExistingCustomer() {
        wiremock.stubFor(get("/api/customers/42")
            .willReturn(okJson("""
                {"id": 42, "name": "Ana", "email": "ana@example.com"}
                """)));

        CustomerDto customer = client.get(42L);

        assertThat(customer.name()).isEqualTo("Ana");
        wiremock.verify(getRequestedFor(urlEqualTo("/api/customers/42"))
            .withHeader("Accept", containing("application/json")));
    }

    @Test
    void propagatesTimeoutAsControlledException() {
        wiremock.stubFor(get(anyUrl()).willReturn(ok().withFixedDelay(5_000)));

        assertThatThrownBy(() -> client.get(1L))
            .isInstanceOf(ServiceUnavailableException.class);
    }
}
```

(The example uses WireMock's Spring integration; it can also be started with JUnit's `WireMockExtension` or as a container with Testcontainers.)

Alternatives: `@RestClientTest` with `MockRestServiceServer` (no real network, it intercepts Spring's client; fast but less realistic), and **MockServer**. WireMock stubs can be generated from contracts (Spring Cloud Contract) to make sure they match the real provider.

WireMock is also very useful outside automated tests: for local development without depending on other teams, and in performance testing environments, simulating external providers.

## Q055 · How do you test asynchronous or message-based code, for example a Kafka consumer?

*Topic: Testing · Level 3 · Intermediate*

The challenge is that the result isn't available right after the action: the message is processed in another thread a few milliseconds later. Using `Thread.sleep()` produces slow tests (if you wait too long) or flaky ones (if you wait too little).

The standard solution is **Awaitility**: it retries an assertion until it holds or a maximum time runs out.

```java
@SpringBootTest
@Testcontainers
class PaymentReceivedListenerIT {

    @Container @ServiceConnection
    static KafkaContainer kafka = new KafkaContainer("apache/kafka-native:3.8.0");

    @Container @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired KafkaTemplate<String, Object> kafkaTemplate;
    @Autowired OrderRepository orders;

    @Test
    void marksOrderAsPaidWhenEventReceived() {
        Long id = orders.save(Order.pending(...)).getId();

        kafkaTemplate.send("payments", id.toString(), new PaymentReceived(UUID.randomUUID(), id));

        await().atMost(Duration.ofSeconds(10))
               .untilAsserted(() -> assertThat(orders.findById(id))
                   .get().extracting(Order::getStatus).isEqualTo(OrderStatus.PAID));
    }

    @Test
    void ignoresDuplicateEvents() {
        // send the same eventId twice and check that the effect is applied only once
    }
}
```

Options for the broker in tests:

- **Testcontainers** with the real Kafka image (the most faithful option).
- `@EmbeddedKafka` from spring-kafka-test: an in-memory broker inside the JVM, quick to start, no Docker.

What is worth testing in a consumer: correct processing (the happy path), **idempotency** (duplicate messages), malformed messages (they must not block the partition: they must go to the DLT), transient failures (retries) and, on the producer side, that the event is published with the right key and format. It is advisable to extract the listener's business logic into a service and test it with unit tests; the integration test focuses on configuration and wiring.

# Level 4 · Intermediate · Design patterns applied to Java and Spring

GoF patterns, SOLID, hexagonal architecture and DDD, always connected to how Spring uses them internally.

This chapter contains 18 questions.

## Q056 · What are design patterns and how are they classified?

*Topic: Patterns · Level 4 · Intermediate*

A design pattern is a **reusable, proven solution to a recurring software design problem**, described at a level that lets you adapt it to each context. It is not code to copy, but a shared vocabulary among developers.

The classic catalogue is the one in the book *Design Patterns* (1994) by the "Gang of Four" (GoF), with 23 patterns in three categories:

- **Creational**: how objects are created. Singleton, Factory Method, Abstract Factory, Builder, Prototype.
- **Structural**: how classes and objects are composed. Adapter, Decorator, Proxy, Facade, Composite, Bridge, Flyweight.
- **Behavioural**: how responsibilities are distributed and objects communicate. Strategy, Observer, Template Method, Chain of Responsibility, Command, State, Iterator, Mediator, Memento, Visitor, Interpreter.

There are also **architectural** patterns (MVC, layers, hexagonal, CQRS, microservices) and **enterprise and integration** patterns (Repository, Unit of Work, EIP messaging patterns).

Key idea for the interview: patterns have a **cost** (more indirection and more classes). They are applied when they solve a real problem, not in advance.

> **Interview tip.** If you can, connect each pattern with a Spring example: it shows you recognise them in real code and not just in theory.

## Q057 · Explain the SOLID principles with examples in Spring.

*Topic: Principles · Level 4 · Intermediate*

- **S · Single Responsibility**: a class should have only one reason to change. An `OrderService` that validates, calculates prices, persists, sends emails and generates PDFs violates SRP; it is split into collaborators (`PriceCalculator`, `Notifier`...).
- **O · Open/Closed**: open for extension, closed for modification. Adding a new payment method should consist of creating a new `PaymentGateway` class, not adding another `else if` to an existing method (Strategy pattern).
- **L · Liskov Substitution**: a subclass must be able to replace its base class without breaking the expected behaviour. An example of a violation: a repository implementation that throws `UnsupportedOperationException` in `save`.
- **I · Interface Segregation**: several specific interfaces are better than one huge generic one. Clients should not depend on methods they don't use. Spring Data applies it: `Repository`, `CrudRepository`, `PagingAndSortingRepository`, `ListCrudRepository`.
- **D · Dependency Inversion**: high-level modules don't depend on low-level ones; both depend on abstractions. The service depends on the `PaymentGateway` interface, not on `StripeClient`. Spring's dependency injection is the tool that makes it practical.

Don't confuse **Dependency Inversion** (a design principle) with **Dependency Injection** (a technique) or with **IoC** (a more general principle).

### Common follow-up questions

**Which SOLID principle do you consider most important day to day?**

Many developers answer Single Responsibility, because most maintenance problems come from classes that do too many things. What matters is justifying the answer with a real example from your experience.

## Q058 · What is the difference between the Singleton pattern and Spring's singleton scope?

*Topic: Creational · Level 4 · Intermediate*

The **Singleton pattern** (GoF) guarantees a single instance **per classloader**, normally with a private constructor and a static `getInstance()` method. Problems: global state, hidden coupling (classes call `getInstance()` instead of receiving the dependency), hard to mock in tests and easy to implement incorrectly in concurrent environments.

```java
public enum GlobalConfiguration {   // the safest form in Java (Effective Java)
    INSTANCE;
    public String value() { ... }
}
```

**Spring's singleton scope** guarantees a single instance **per container** (`ApplicationContext`), not per JVM. The class is a normal POJO with a public constructor: more instances could be created with `new` (for example, in a test), and uniqueness is managed by the container. It is injected as a dependency, so there is no hidden coupling.

A concurrency implication common to both: the instance is shared by all threads (each HTTP request is handled in a thread), so it **must not keep mutable state** in attributes. Per-request state goes in local variables, parameters or `request`-scoped beans.

## Q059 · Explain Factory Method and Abstract Factory, and how they appear in Spring.

*Topic: Creational · Level 4 · Intermediate*

- **Simple Factory** (not GoF, but very common): a method that decides which implementation to create based on a parameter.
- **Factory Method**: a class defines a method for creating objects and subclasses decide which concrete class to instantiate. It decouples the client from the concrete classes.
- **Abstract Factory**: an interface for creating **families of related objects** without specifying their concrete classes (for example, a factory of UI components for a light theme and another for a dark theme).

In Spring they appear everywhere:

- The container itself is one big factory: `BeanFactory`.
- `@Bean` methods are factory methods.
- `FactoryBean<T>`: a bean whose purpose is to build another object. Spring Data uses it to create the repository implementations (`JpaRepositoryFactoryBean`), and in older versions it was the way to create Hibernate's `SessionFactory`.
- Static factory classes and methods: `ResponseEntity.ok()`, `ProblemDetail.forStatus()`, `List.of()` in the JDK.

In Spring, a classic factory with a `switch` is often replaced by injecting a `Map<String, Implementation>`, which removes the coupling of the `switch` to every implementation (see Strategy).

## Q060 · What is the Builder pattern and when should you use it?

*Topic: Creational · Level 4 · Intermediate*

Builder separates the **construction** of a complex object from its representation. It is useful when an object has many parameters, several of them optional, and you want to avoid the **telescoping constructor** anti-pattern (multiple constructors with different combinations of parameters) or a half-built mutable JavaBean.

```java
Order order = Order.builder()
    .customer(customer)
    .shippingAddress(address)
    .line(product1, 2)
    .line(product2, 1)
    .coupon("SUMMER10")
    .build();   // invariants are validated here
```

Advantages: readability (named parameters), immutability of the resulting object and a single point (`build()`) for validating invariants.

In the ecosystem: Lombok's `@Builder`, `ResponseEntity.status(...).header(...).body(...)`, `UriComponentsBuilder`, `WebClient.builder()`, `RestClient.builder()`, `MockMvcRequestBuilders`, `JsonMapper.builder()`, the JDK's `HttpRequest.newBuilder()`. Spring Boot also exposes **preconfigured builders** as beans (`RestClient.Builder`, `WebClient.Builder`) that already include the Jackson, tracing and metrics configuration; it is advisable to inject them instead of creating clients from scratch.

Beware of Lombok's `@Builder` on JPA entities: JPA needs a no-arguments constructor and validations are easily lost.

## Q061 · What is the Strategy pattern and how is it implemented elegantly with Spring?

*Topic: Behavioural · Level 4 · Intermediate*

Strategy defines a **family of interchangeable algorithms**, encapsulates each one in a class and lets you choose between them at runtime. It removes large `if/else` or `switch` blocks and satisfies Open/Closed: adding an algorithm means adding a class.

With Spring, each strategy is a bean and they are all injected into a map or a list:

```java
public interface ShippingCalculator {
    ShippingType type();
    BigDecimal calculate(Order order);
}

@Component class StandardShipping implements ShippingCalculator { ... }
@Component class ExpressShipping  implements ShippingCalculator { ... }
@Component class PickupShipping   implements ShippingCalculator { ... }

@Service
public class ShippingService {
    private final Map<ShippingType, ShippingCalculator> strategies;

    public ShippingService(List<ShippingCalculator> calculators) {
        this.strategies = calculators.stream()
            .collect(Collectors.toMap(ShippingCalculator::type, Function.identity()));
    }

    public BigDecimal cost(Order o) {
        return Optional.ofNullable(strategies.get(o.getShippingType()))
            .orElseThrow(() -> new IllegalArgumentException("Unsupported type"))
            .calculate(o);
    }
}
```

Adding a new type only requires creating another `@Component`; `ShippingService` doesn't change. Examples in Spring: `PlatformTransactionManager` (JPA, JDBC, JTA...), `HttpMessageConverter`, `AuthenticationProvider`, `ResourceLoader`, `PasswordEncoder`.

Relationship with **State**: structurally it is similar, but in State the implementation changes according to the object's internal state, and the strategies themselves trigger transitions.

> **Interview tip.** This List/Map-of-strategies example is one of the most useful for showing fluency with Spring in a practical or live-coding interview.

### Common follow-up questions

**How would you validate at startup that there is a strategy for every value of the enum?**

In the service constructor, by comparing the map keys with the enum values and throwing an exception if any is missing. That way the error appears at startup, not when the first order of that type arrives.

## Q062 · What is the Template Method pattern? Where does Spring use it?

*Topic: Behavioural · Level 4 · Intermediate*

Template Method defines the **skeleton of an algorithm** in a method of the base class and delegates some steps to subclasses (or, in the modern variant, to callbacks). It guarantees that the sequence is respected while the variable steps are customised.

Spring uses it very characteristically in its `*Template` classes, with callbacks instead of inheritance:

- `JdbcTemplate`: takes care of obtaining the connection, creating the statement, executing, iterating the ResultSet, translating exceptions and closing resources. You only provide the SQL and a `RowMapper`.
- `TransactionTemplate`, `RestTemplate`, `JmsTemplate`, `KafkaTemplate`, `RedisTemplate`, `RetryTemplate`.

```java
List<Customer> customers = jdbcTemplate.query(
    "select id, name from customer where city = ?",
    (rs, row) -> new Customer(rs.getLong("id"), rs.getString("name")),
    city);
```

It also appears with classic inheritance in abstract classes such as `OncePerRequestFilter` (you implement `doFilterInternal`) or `AbstractRoutingDataSource`.

Advantage: it removes error-prone boilerplate code (connection leaks from not closing resources). Disadvantage of the inheritance-based version: strong coupling to the base class; that is why Spring prefers composition with callbacks.

## Q063 · What is the Proxy pattern and how does Spring use it? What is the difference between JDK and CGLIB proxies?

*Topic: Structural · Level 4 · Intermediate*

Proxy provides a **stand-in** for another object that controls access to it, adding behaviour before or after delegating: access control, lazy loading, caching, logging, transactions.

It is the foundation of **Spring AOP**: `@Transactional`, `@Cacheable`, `@Async`, `@PreAuthorize`, `@Retryable`, Spring Data repositories, Feign clients and Hibernate's lazy entities are all proxies.

Two creation mechanisms:

- **JDK dynamic proxy** (`java.lang.reflect.Proxy`): it can only implement **interfaces**. The proxy implements the same interfaces as the bean; if you inject by the concrete class, it fails.
- **CGLIB** (actually a fork included in Spring): it generates a **subclass** of the bean at runtime. It works without interfaces, but it cannot intercept `final` or `private` methods, and the class cannot be `final`.

**Spring Boot uses CGLIB by default** (`spring.aop.proxy-target-class=true`) to avoid surprises when injecting concrete classes.

Difference from Decorator: structurally they are almost identical; the difference is the intent. Decorator **adds** functional **responsibilities** and is usually composed into explicit chains by the client; Proxy **controls access** and is normally transparent to the client.

> **Interview tip.** Connect this answer with self-invocation: the proxy explains why this.method() doesn't apply @Transactional.

### Common follow-up questions

**How do you know whether an injected bean is a proxy?**

With AopUtils.isAopProxy(bean), or by inspecting the class in the debugger (names such as $$SpringCGLIB$$ or $Proxy). It is useful for diagnosing why an annotation has no effect.

## Q064 · What is the Observer pattern and how is it implemented with Spring events?

*Topic: Behavioural · Level 4 · Intermediate*

Observer defines a one-to-many relationship: when an object (the subject) changes state, it notifies its observers without knowing them. It reduces the coupling between whoever produces a fact and those who react to it.

Spring offers it through its event system:

```java
public record OrderConfirmed(Long orderId, Long customerId) {}

@Service
public class OrderService {
    private final ApplicationEventPublisher events;

    @Transactional
    public void confirm(Long id) {
        // ... logic
        events.publishEvent(new OrderConfirmed(id, customerId));
    }
}

@Component
class NotificationListener {
    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    @Async
    void sendEmail(OrderConfirmed event) { ... }
}
```

Key points:

- `@EventListener` is **synchronous** by default and runs in the same thread and the same transaction. An exception in the listener affects the publisher.
- `@TransactionalEventListener` waits for a phase of the transaction (by default `AFTER_COMMIT`): that way no email is sent for an order whose transaction ends up rolling back.
- `@Async` makes it asynchronous (it requires `@EnableAsync`).
- These events live **in memory**: if the application goes down after the commit and before the event is processed, it is lost. For guarantees between services you need a broker and the Outbox pattern. Spring Modulith offers a persistent **event publication registry** to mitigate this problem within a modular monolith.

### Common follow-up questions

**Spring events or a direct call between services?**

A direct call is more explicit and easier to follow when the caller needs the result or the operation is part of the same unit of work. Events are preferable for side effects the emitter shouldn't know about (notifications, auditing, statistics) and for decoupling modules.

## Q065 · Explain Adapter, Decorator, Facade and Chain of Responsibility with examples from the Spring ecosystem.

*Topic: Structural · Level 4 · Intermediate*

- **Adapter**: converts the interface of a class into another one the client expects. Examples: `HandlerAdapter` in Spring MVC (it lets the `DispatcherServlet` invoke different types of handlers uniformly); the adapters of hexagonal architecture that translate between your domain and an external API.
- **Decorator**: adds responsibilities to an object dynamically by wrapping it with the same interface. Examples: `BufferedInputStream` in Java IO; `TransactionAwareDataSourceProxy`; `ContentCachingRequestWrapper`; wrapping an HTTP client with one that adds retries and another that adds metrics.
- **Facade**: a simplified interface over a complex subsystem. Examples: `JdbcTemplate` versus plain JDBC; an application service that orchestrates several domain services; an API Gateway is a facade at the architecture level.
- **Chain of Responsibility**: the request goes through a chain of handlers; each one processes it and/or passes it on to the next. Examples: the **Spring Security filter chain** (`SecurityFilterChain` with CORS, CSRF, authentication, authorisation filters...); servlet `Filter`s; `HandlerInterceptor`s; Spring Cloud Gateway filters.

```java
@Bean
SecurityFilterChain security(HttpSecurity http) throws Exception {
    return http
        .authorizeHttpRequests(a -> a.requestMatchers("/actuator/health").permitAll()
                                     .anyRequest().authenticated())
        .oauth2ResourceServer(o -> o.jwt(Customizer.withDefaults()))
        .build();
}
```

## Q066 · What is hexagonal architecture (ports and adapters)? How does it differ from layered architecture?

*Topic: Architecture · Level 4 · Intermediate*

In the classic **layered architecture** (controller → service → repository) business logic usually depends on infrastructure: entities are JPA entities and services know persistence details. Changing the technology or testing the domain in isolation is costly.

**Hexagonal architecture** (Alistair Cockburn) places the **domain at the centre**, with no dependencies on frameworks. It communicates with the outside through:

- **Ports**: interfaces defined by the domain. **Inbound** (driving) ports represent use cases (`ConfirmOrderUseCase`); **outbound** (driven) ports represent what the domain needs (`OrderRepositoryPort`, `PaymentGatewayPort`).
- **Adapters**: implementations on the periphery. Inbound: REST controller, Kafka consumer, scheduled job. Outbound: JPA repository, HTTP client, message producer.

The fundamental rule is that **dependencies point inwards** (dependency inversion): infrastructure depends on the domain, never the other way round.

Typical package structure: `domain` (model and ports), `application` (use cases), `infrastructure` or `adapters` (`in/web`, `in/messaging`, `out/persistence`, `out/rest`).

Advantages: a domain that can be tested without Spring or a database, interchangeable technologies and protected logic. Cost: more classes and interfaces, and mappings between models (domain, JPA, DTO). Related architectures: **Onion** and **Clean Architecture**. The dependency rule can be enforced with **ArchUnit** or Spring Modulith.

> **Interview tip.** Be honest about the cost: for a simple CRUD it is over-engineering. That maturity is what a senior interviewer is looking for.

### Common follow-up questions

**Can domain entities carry JPA annotations?**

In the strict version, no: the domain doesn't depend on any framework and is mapped to separate JPA entities in the adapter. Many teams accept JPA annotations in the domain as a pragmatic compromise to avoid duplication. What matters is that it is a conscious decision.

## Q067 · What are the main concepts of Domain-Driven Design?

*Topic: DDD · Level 4 · Intermediate*

DDD (Eric Evans) proposes modelling software around the **business domain**, in close collaboration with the domain experts.

**Strategic design**:

- **Ubiquitous language**: the same vocabulary in conversations, code and documentation.
- **Bounded Context**: an explicit boundary within which a model has a consistent meaning. "Customer" means different things in Sales, Billing and Support; each context has its own model. It is the **best guide for drawing microservice boundaries**.
- **Context Map**: the relationships between contexts (Customer/Supplier, Conformist, Anti-Corruption Layer, Shared Kernel, Open Host Service, Published Language).

**Tactical design**:

- **Entity**: an object with an identity that persists over time (Order #123).
- **Value Object**: defined by its attributes, with no identity, immutable (`Money`, `Address`, `Email`). Java records fit very well.
- **Aggregate**: a group of entities and value objects treated as a unit of consistency, with a **root** as the only access point. Rules: invariants hold within the aggregate in every transaction; other aggregates are referenced **by identifier**; a transaction modifies **a single aggregate**.
- **Repository**: one per aggregate, not per table.
- **Domain Service**: logic that doesn't belong to any entity.
- **Domain Event**: something relevant that has happened (`OrderConfirmed`), the basis for communication between aggregates and contexts.

An **anaemic** model (entities with only getters/setters and all the logic in services) is the opposite of the rich model DDD proposes.

### Common follow-up questions

**How big should an aggregate be?**

The minimum needed to protect its invariants in a transaction. Large aggregates cause contention and concurrency conflicts; it is preferable to reference other aggregates by identifier and coordinate with events when immediate consistency is not essential.

**What is Event Storming?**

A collaborative workshop in which business experts and technical people model a domain by placing domain events on a timeline, together with commands, actors, policies and aggregates. It is very effective for discovering bounded contexts and the ubiquitous language.

## Q068 · What is the State pattern? Give an example with the lifecycle of an order.

*Topic: Behavioural · Level 4 · Intermediate*

The **State** pattern lets an object change its behaviour when its internal state changes, as if it changed class. Each state is encapsulated in its own class, which decides which operations are allowed and which state to transition to.

Without the pattern, the logic fills up with repeated conditionals: `if (status == PENDING) ... else if (status == PAID) ...` in every method. Adding a state forces you to review all those methods.

A modern Java implementation can combine an `enum` with behaviour or a **sealed hierarchy**:

```java
public enum OrderStatus {
    PENDING {
        @Override OrderStatus pay()    { return PAID; }
        @Override OrderStatus cancel() { return CANCELLED; }
    },
    PAID {
        @Override OrderStatus ship()   { return SHIPPED; }
        @Override OrderStatus cancel() { return REFUND_PENDING; }
    },
    SHIPPED {
        @Override OrderStatus deliver() { return DELIVERED; }
    },
    DELIVERED, CANCELLED, REFUND_PENDING;

    OrderStatus pay()     { throw invalidTransition("pay"); }
    OrderStatus ship()    { throw invalidTransition("ship"); }
    OrderStatus deliver() { throw invalidTransition("deliver"); }
    OrderStatus cancel()  { throw invalidTransition("cancel"); }

    private IllegalStateException invalidTransition(String action) {
        return new IllegalStateException("Cannot " + action + " an order in status " + this);
    }
}

@Entity
public class Order {
    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PENDING;

    public void pay() { status = status.pay(); }
    public void cancel() { status = status.cancel(); }
}
```

The transition rules live in a single place, they are easy to test (one test per valid and invalid transition) and the entity protects its invariants. This also helps with the idempotency of message consumers: a repeated transition is detected and ignored.

For more complex flows (with guards, associated actions, events, hierarchical states or persistence of the machine's state), there is **Spring Statemachine**, although for most cases a home-grown implementation like the one above is simpler and more readable. If the flow is long-running and coordinates several services, the right tool is a saga orchestrator or a workflow engine.

Relationship with Strategy: structurally similar, but in State the transitions are part of the pattern itself and the object changes state on its own; in Strategy the client chooses the strategy and it doesn't change by itself.

## Q069 · What is the Command pattern? Where does it appear in Spring applications?

*Topic: Behavioural · Level 4 · Intermediate*

The **Command** pattern encapsulates a request as an object, with all the data needed to execute it. This lets you parameterise, queue, log, retry or undo operations, and it decouples whoever requests the operation from whoever executes it.

Classic elements: the **command** (what to do and with what data), the **receiver** (who knows how to do it), the **invoker** (who launches it, without knowing the details) and, optionally, the undo operation.

In modern Java, a command is usually an immutable `record` and its handler, a bean:

```java
public record ConfirmOrder(Long orderId, String user) {}

@Component
class ConfirmOrderHandler {
    @Transactional
    public void handle(ConfirmOrder cmd) {
        Order o = orders.findById(cmd.orderId()).orElseThrow();
        o.confirm(cmd.user());
    }
}
```

Where it appears:

- `Runnable` and `Callable` are commands: they are submitted to an `ExecutorService` that runs them without knowing what they do.
- **CQRS**: the write side is modelled as commands with their handlers. Some projects use a *command bus* (Axon Framework, or a simple implementation with a map of handlers by type) that adds validation, transactions, auditing or metrics in a cross-cutting way.
- **Messaging**: a command message (`ReserveStock`) sent to another service is a serialised command; in an orchestrated saga, the orchestrator issues commands and the participants execute them.
- **Spring Batch** and *jobs*: parameterised, re-runnable steps.
- Operations with **undo** or compensation: each command can have its associated compensation, an idea that connects with the Saga pattern.

Advantages: it makes audit logging easier (each command is an object that can be serialised and stored), as well as retries and deferred execution. Drawback: more classes; for simple operations, a service method is enough.

## Q070 · What is the Composite pattern? Give a practical example.

*Topic: Structural · Level 4 · Intermediate*

**Composite** lets you treat individual objects and compositions of objects uniformly, organising them in tree structures. Both the leaf and the composite implement the same interface, and the composite delegates to its children.

A classic business example: discount or validation rules that are combined.

```java
public interface DiscountRule {
    BigDecimal apply(Cart cart);
}

record PercentageDiscount(BigDecimal percentage) implements DiscountRule {
    public BigDecimal apply(Cart c) { return c.subtotal().multiply(percentage); }
}

record FreeShippingDiscount(BigDecimal minimum) implements DiscountRule {
    public BigDecimal apply(Cart c) {
        return c.subtotal().compareTo(minimum) >= 0 ? c.shippingCost() : BigDecimal.ZERO;
    }
}

// Composite: applies all its rules and adds up the result
record CompositeDiscount(List<DiscountRule> rules) implements DiscountRule {
    public BigDecimal apply(Cart c) {
        return rules.stream().map(r -> r.apply(c)).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
```

The code that uses the rules doesn't distinguish between a simple rule and a combination of twenty: it calls `apply` and that's it. Composites can be nested (a promotion that groups other promotions).

Examples in the ecosystem:

- Actuator's `CompositeHealthContributor`: the overall health aggregates that of the database, the disk, the broker, etc.
- Micrometer's `CompositeMeterRegistry`: publishes metrics to several registries at once.
- `CompositeCacheManager`, `CompositePropertySource` and Spring's `Environment`, composed of many property sources.
- Domain tree structures: catalogue categories, menus, organisation charts.

Combined with **Specification** (a DDD pattern for expressing business rules that can be combined with `and`, `or`, `not`), it produces very expressive dynamic filters; Spring Data JPA's `Specification` interface follows this idea.

## Q071 · What is the difference between the Repository and DAO patterns? What is Unit of Work?

*Topic: Persistence · Level 4 · Intermediate*

Both encapsulate data access, but they start from different perspectives:

- **DAO** (Data Access Object) is a pattern oriented to the **table or data source**. It exposes persistence operations (`insert`, `update`, `findByX`) and there is usually one per table. Its vocabulary is technical.
- **Repository** (Martin Fowler, DDD) is a pattern oriented to the **domain**: it behaves like an in-memory collection of domain objects (`add`, `remove`, `findById`), completely hides persistence and there is **one per aggregate**, not per table. Its interface belongs to the domain and speaks its language (`ordersPendingShipment()`).

```java
// Repository style: interface in the domain, with no persistence details
public interface Orders {
    Optional<Order> byId(OrderId id);
    List<Order> pendingShipment();
    void save(Order order);
}
```

Spring Data repositories sit halfway: they are called repositories, but they are often used as DAOs (one per entity, including entities internal to an aggregate) and expose technical methods. In a hexagonal architecture, it is common to define a domain port like the one above and an adapter that implements it by relying on a Spring Data repository.

**Unit of Work** keeps the list of objects affected by a business transaction and coordinates writing their changes all at once at the end, resolving the order of operations and concurrency. **Hibernate's persistence context** (the `Session` / `EntityManager`) is an implementation of Unit of Work: it registers new, modified (dirty checking) and removed entities, and flushes everything at once. Its natural companion is the **Identity Map**: a single in-memory instance per row within the session (the first-level cache).

## Q072 · What are value objects and why is immutability important?

*Topic: Design · Level 4 · Intermediate*

A **value object** is an object defined solely by its attributes, with no identity of its own: two instances with the same values are interchangeable. Examples: `Money(10.00, EUR)`, `Email`, `Address`, `DateRange`, `Quantity`.

They must be **immutable**: to "change" a value you create a new one. This provides:

- **Concurrency safety**: they can be shared between threads without synchronisation.
- **No side effects**: nobody can modify an object that was passed as an argument or stored in a map.
- **Guaranteed validity**: it is validated in the constructor; if the object exists, it is valid. No more repeated "is this email valid?" checks all over the code.
- **Expressiveness**: `transfer(Money amount, Iban destination)` is clearer and safer than `transfer(BigDecimal amount, String account)`, and it avoids mixing up the order of parameters of the same type (*primitive obsession*).

Java **records** are the natural tool:

```java
public record Money(BigDecimal amount, Currency currency) {

    public Money {
        Objects.requireNonNull(amount);
        Objects.requireNonNull(currency);
        if (amount.scale() > currency.getDefaultFractionDigits())
            throw new IllegalArgumentException("Too many decimals for " + currency);
    }

    public static Money euros(String quantity) {
        return new Money(new BigDecimal(quantity), Currency.getInstance("EUR"));
    }

    public Money add(Money other) {
        if (!currency.equals(other.currency)) throw new IllegalArgumentException("Different currencies");
        return new Money(amount.add(other.amount), currency);
    }
}
```

In JPA, value objects are mapped as `@Embeddable` (Hibernate 6.2+ supports records as embeddables) or with an `AttributeConverter` if they are stored in a single column.

Notes on immutability in Java: a `record` is shallowly immutable; if it contains a `List`, you have to copy it defensively with `List.copyOf()` in the constructor. Never use `double` or `float` for money: use `BigDecimal` (or an integer number of cents) because of floating-point rounding errors.

## Q073 · What design anti-patterns and code smells are common in Spring applications?

*Topic: Design · Level 4 · Intermediate*

- **Anaemic domain model**: entities with only getters and setters and all the logic in services. Business rules get scattered and duplicated, and any code can leave an entity in an invalid state. Solution: move behaviour into entities and value objects (`order.confirm()` instead of `order.setStatus(CONFIRMED)`).
- **God service** (*God class*): a 3,000-line `OrderService` with twenty injected dependencies. A class with more than five or six constructor dependencies is a warning sign.
- **Service Locator**: obtaining dependencies by asking the context for them (`applicationContext.getBean(...)`) instead of injecting them. It hides dependencies and complicates tests.
- **Business logic in controllers** or, the other way round, HTTP knowledge (`HttpServletRequest`, `ResponseEntity`) in services.
- **"Pass-through" layers**: services that only delegate to the repository without adding anything, created out of obligation.
- **Single-implementation interfaces** for everything (`OrderService` + `OrderServiceImpl`) with no real reason. With CGLIB proxies they are no longer needed for AOP; they make sense at architectural boundaries (ports) or when several implementations are foreseen.
- **Generic or swallowed exceptions**: `catch (Exception e) { log.error(...) }` that carries on as if nothing had happened, or using exceptions for normal control flow.
- **Primitive obsession**: `String` for emails, IBANs or country codes; a bare `BigDecimal` for money without a currency.
- **Magic configuration**: business values hard-coded, or `@Value` scattered across a hundred classes.
- **Using `Optional` as a field or parameter**: it is intended as a return type.
- **Huge transactions** that include remote calls or waits, and the opposite pattern: operations that should be atomic spread over several transactions.
- **Tests that test mocks**: so much `when`/`verify` that the test no longer checks any real behaviour.

Tools that help detect them: **SonarQube** (complexity, duplication, code smells, coverage), **ArchUnit** (architecture rules such as "controllers don't access repositories"), **PMD** and **Error Prone**, as well as code reviews.

> **Interview tip.** If you are asked to review code in the interview, explicitly looking for these smells and proposing concrete refactorings is what is expected.

# Level 5 · Intermediate-Advanced · Microservices: fundamentals, communication and infrastructure

When it makes sense to split a system, how services communicate and which pieces of infrastructure they need (gateway, discovery, configuration, observability, Kubernetes).

This chapter contains 17 questions.

## Q074 · What are microservices? What advantages and disadvantages do they have compared to a monolith?

*Topic: Microservices · Level 5 · Intermediate-Advanced*

A microservices architecture structures an application as a set of **small, autonomous, independently deployable services**, each organised around a business capability, with its own database and communicating over the network (HTTP, gRPC, messaging).

**Advantages**:

- Independent deployment: each team releases without coordinating with the rest.
- Selective scaling: only the service under load is scaled.
- Fault isolation (if resilience is well designed).
- Technological and team autonomy (Conway's Law).
- Smaller, more understandable codebases.

**Disadvantages**:

- **Distributed complexity**: latency, partial network failures, timeouts, retries.
- **Data consistency**: ACID transactions between services are lost; eventual consistency appears.
- Operational cost: CI/CD per service, observability, service discovery, orchestration with Kubernetes.
- Harder integration testing.
- The risk of building a **distributed monolith**: all the cost of distribution without its benefits.

Mature conclusion: microservices mainly solve an **organisational problem** (many teams working in parallel on the same system). For small teams or unclear domains, a **modular monolith** is usually a better starting point, with the possibility of extracting services later.

> **Interview tip.** Avoid uncritical enthusiasm. The sentence "I would start with a modular monolith unless there are clear organisational or scaling reasons" usually makes a very good impression.

### Common follow-up questions

**What is Conway's Law?**

The observation that organisations design systems that mirror their communication structure. The "inverse Conway manoeuvre" consists of organising teams according to the desired architecture: one team per domain or service.

## Q075 · How do you decide which functionality goes into each microservice?

*Topic: Microservices · Level 5 · Intermediate-Advanced*

Main criteria:

- **DDD Bounded Contexts**: each context with a coherent model is a good candidate for a service. Techniques such as **Event Storming** help discover them.
- **Business capabilities**: Catalogue, Orders, Payments, Shipping, Customers.
- **High cohesion and low coupling**: what changes together should live together. If every new feature requires modifying and deploying three services at once, the boundaries are drawn wrong.
- **Data autonomy**: the service should be able to fulfil its responsibility with its own data most of the time.
- **Team structure**: a service should belong to a single team.
- **Different non-functional requirements**: scaling, availability or security (for example, isolating payment processing for PCI compliance).

Signs of bad boundaries: chains of synchronous calls for any operation ("chatty" services), shared databases, distributed transactions everywhere or "entity" services (one service per table: `CustomerService`, `AddressService`...).

A good path is the **modular monolith**: modules with clear boundaries within a single deployment. **Spring Modulith** lets you verify those boundaries with tests, have modules communicate through events and document them; if a module needs to scale or evolve separately, extracting it later is much easier.

### Common follow-up questions

**What would you do if you discovered that two services always change together?**

It is a sign that the boundary is drawn wrong. You need to analyse whether they share a domain concept that should be in a single service and, if so, merge them or redistribute responsibilities. Merging services is also a valid decision.

## Q076 · What is the difference between synchronous and asynchronous communication between microservices? When should each be used?

*Topic: Communication · Level 5 · Intermediate-Advanced*

**Synchronous** (REST, gRPC): the caller waits for the response.

- For: a simple model, immediate response, easy to debug.
- Against: **temporal coupling** (if B is unavailable, A fails), latency accumulates in chains of calls and total availability is the product of the individual availabilities (five services at 99.9% give roughly 99.5%).

**Asynchronous** (messaging with Kafka, RabbitMQ...): the sender publishes a message and carries on.

- For: temporal decoupling (the consumer can be down and will process later), it absorbs load peaks and makes it easy to add new consumers without touching the sender.
- Against: eventual consistency, greater complexity (duplicates, ordering, poison messages, dead-letter queues), harder debugging (it requires distributed tracing).

**When to use each**:

- Synchronous for **queries** where the user needs the answer now (checking the price or stock).
- Asynchronous for **propagating facts** (`OrderCreated`) and processes that can be completed later (sending emails, updating views, integration with other domains).

Within messaging it is worth distinguishing between **commands** (a request directed at a service: "ReserveStock") and **events** (a fact that has already happened, published for whoever is interested: "StockReserved").

## Q077 · REST, gRPC or messaging: how do you choose?

*Topic: Communication · Level 5 · Intermediate-Advanced*

- **REST over HTTP/JSON**: a universal standard, readable, easy to test and cache, excellent for public APIs and for communication with frontends. Contract with OpenAPI. Less efficient (text, verbosity).
- **gRPC**: HTTP/2 with Protocol Buffers (binary). A strong contract and code generation, much more efficient in size and latency, it supports bidirectional **streaming**. Ideal for high-performance internal communication between services. Against: it can't be consumed directly from the browser (it requires gRPC-Web or a proxy) and it is less readable when debugging. Spring has official support with **Spring gRPC**.
- **GraphQL**: the client decides which fields it requests; useful for frontends with varied needs (Spring for GraphQL). It complicates HTTP caching and controlling query cost.
- **Messaging** (Kafka, RabbitMQ, Amazon SQS/SNS): for asynchronous communication, events and decoupling.

Practical criterion: REST for external APIs and most internal integrations; gRPC when performance or streaming between internal services is critical; messaging for events and asynchronous processes. Many architectures combine all three.

## Q078 · What is Service Discovery? What is the difference between client-side and server-side discovery?

*Topic: Infrastructure · Level 5 · Intermediate-Advanced*

In a dynamic environment, a service's instances appear and disappear (autoscaling, deployments, failures) and their IPs change. Service discovery lets you locate them by **logical name** instead of by a fixed address. It relies on a **service registry** where each instance registers and sends heartbeats.

- **Client-side discovery**: the client queries the registry, gets the list of instances and chooses one with its own load balancer. Example: **Eureka** + **Spring Cloud LoadBalancer** (which replaced Netflix Ribbon). More control in the client, but logic repeated in every language.
- **Server-side discovery**: the client calls a load balancer or router that queries the registry and forwards the request. Example: **Kubernetes**, where a `Service` has a stable DNS name (`orders.my-namespace.svc.cluster.local`) and kube-proxy distributes the traffic among the healthy pods. The client doesn't need any library.

In practice, if you deploy on **Kubernetes**, Eureka is usually unnecessary: Kubernetes DNS and Services already solve discovery. Eureka or Consul make sense in environments without an orchestrator or hybrid ones.

> **Interview tip.** Saying that on Kubernetes you normally don't need Eureka shows up-to-date judgement; many old tutorials still include it by default.

### Common follow-up questions

**How does load balancing work with gRPC in Kubernetes?**

gRPC uses persistent HTTP/2 connections, so the per-connection balancing of a ClusterIP Service sends all of a client's traffic to a single pod. It is solved with client-side balancing through a headless Service or with a service mesh that balances per request.

## Q079 · What is an API Gateway? And the Backend for Frontend (BFF) pattern?

*Topic: Infrastructure · Level 5 · Intermediate-Advanced*

An **API Gateway** is the single entry point for external clients. It encapsulates the internal structure of the system and centralises cross-cutting concerns:

- **Routing** to the right service.
- **Authentication** (JWT token validation) and coarse-grained authorisation.
- **Rate limiting** and quotas.
- TLS termination, CORS.
- Retries, timeouts and circuit breakers.
- Aggregation or composition of responses.
- Logging, metrics and generation of the trace identifier.

In the Spring ecosystem, **Spring Cloud Gateway** is used (the replacement for Netflix Zuul), with a reactive (WebFlux) variant and one based on Spring MVC. Alternatives: Kong, NGINX, Envoy, AWS API Gateway, Azure API Management, or a Kubernetes Ingress/Gateway API.

```yaml
spring:
  cloud:
    gateway:
      server:
        webflux:
          routes:
            - id: orders
              uri: lb://orders-service
              predicates:
                - Path=/api/orders/**
              filters:
                - StripPrefix=1
```

**Backend for Frontend (BFF)**: instead of a generic gateway, a specific backend for each type of client (web, mobile, third parties), adapted to its needs and maintained by that frontend's team. It is also the recommended pattern for **security in SPAs**: the BFF keeps the OAuth2 tokens on the server and the browser only handles a secure session cookie.

Risk: the gateway accumulating business logic and becoming a new monolith.

### Common follow-up questions

**What is the difference between an API Gateway and a Kubernetes Ingress?**

The Ingress is a basic HTTP router to the cluster's services (host, path, TLS). An API Gateway adds API management features: authentication, rate limiting, transformation, aggregation, quotas and analytics. Some Ingress controllers and the Kubernetes Gateway API cover part of those functions.

## Q080 · How is centralised configuration managed in microservices?

*Topic: Infrastructure · Level 5 · Intermediate-Advanced*

With dozens of services and several environments, configuration needs centralised, versioned and secure management.

- **Spring Cloud Config Server**: a server that serves configuration from a Git repository (or Vault, JDBC...). Services import it with `spring.config.import=configserver:http://config:8888`. Advantages: history and review via pull request, configuration per application and profile. Changes can be reloaded on the fly with `@RefreshScope` and the `/actuator/refresh` endpoint, or en masse with Spring Cloud Bus.
- **Kubernetes ConfigMaps and Secrets**: mounted as environment variables or files. It is the most common option when deploying on Kubernetes. Spring Boot can read mounted files with `spring.config.import=configtree:/etc/config/`.
- **Secrets managers**: HashiCorp Vault (Spring Cloud Vault), AWS Secrets Manager, Azure Key Vault, GCP Secret Manager.

Good practices:

- **Never** store secrets in the repository in plain text (not even in `application.yml`).
- Separate configuration (varies by environment) from code (the same in all): a principle of the 12-factor methodology.
- Credential rotation and, where possible, short-lived dynamic credentials (Vault).
- Validate the configuration at startup (`@ConfigurationProperties` + `@Validated`) to fail fast.

## Q081 · What options does Spring offer for calling other services over HTTP?

*Topic: Communication · Level 5 · Intermediate-Advanced*

- **RestTemplate**: the classic synchronous client based on Template Method. It is in maintenance mode; not recommended for new code.
- **WebClient**: a reactive, non-blocking client (WebFlux). Suitable in reactive applications or when many concurrent calls are needed.
- **RestClient** (Spring 6.1 / Boot 3.2+): a **synchronous client with a modern fluent API**, similar to WebClient. It is the recommended option for Spring MVC applications, especially combined with virtual threads.
- **HTTP Interfaces** (`@HttpExchange`): you declare an interface and Spring generates the implementation on top of `RestClient` or `WebClient`. A declarative style similar to Feign, but native to the framework.
- **OpenFeign** (Spring Cloud OpenFeign): a very popular declarative client; the project itself recommends migrating to HTTP Interfaces for new code.

```java
@HttpExchange("/api/customers")
public interface CustomersClient {
    @GetExchange("/{id}")
    CustomerDto get(@PathVariable Long id);
}

@Bean
CustomersClient customersClient(RestClient.Builder builder) {
    RestClient rc = builder.baseUrl("http://customers-service").build();
    return HttpServiceProxyFactory.builderFor(RestClientAdapter.create(rc))
        .build().createClient(CustomersClient.class);
}
```

Whatever the client: **always configure** connection and read **timeouts** (the defaults may be infinite), use the `Builder` injected by Boot (to inherit tracing and metrics) and wrap the calls in resilience policies.

### Common follow-up questions

**Which timeouts would you configure on an HTTP client?**

At least the connection timeout (how long to wait to establish the connection, normally short: 1-2 seconds) and the read timeout (how long to wait for the response, according to the dependency's SLO). With connection pools, also the maximum time to wait for a free connection from the pool.

## Q082 · What are the differences between Kafka and RabbitMQ? What delivery guarantees exist?

*Topic: Messaging · Level 5 · Intermediate-Advanced*

**RabbitMQ** is a traditional **message broker** (AMQP): exchanges that route messages to queues according to rules (direct, topic, fanout, headers). The message is removed once the consumer acknowledges it. It stands out for flexible routing, work queues, priorities and request/reply patterns. Spring: Spring AMQP / `RabbitTemplate` and `@RabbitListener`.

**Apache Kafka** is a **distributed log platform**: messages are written to *topics* divided into *partitions*, they are **retained** for a configurable period and each consumer group keeps its own *offset*. It allows reprocessing events, multiple independent consumers and very high throughput. **Ordering is only guaranteed within a partition**, so a key is used (for example `orderId`) so that events for the same entity go to the same partition. Spring: Spring for Apache Kafka / `KafkaTemplate` and `@KafkaListener`.

Criterion: Kafka for event streaming, high volume, event sourcing, multiple consumers and replay. RabbitMQ for task queues, complex routing and low latency with moderate volumes.

**Delivery guarantees**:

- **At-most-once**: may be lost, never duplicated.
- **At-least-once**: never lost, but may be duplicated. It is the usual option.
- **Exactly-once**: hard to achieve end to end. Kafka offers it within its ecosystem (idempotent producer + transactions), but as soon as external systems are involved (a database, an API) the practical solution is **at-least-once + idempotent consumers**.

Other concepts: a **Dead Letter Queue / Topic** for messages that fail repeatedly, retries with backoff and the problem of poison messages.

> **Interview tip.** The sentence "exactly-once in practice is at-least-once plus idempotency" is exactly what they want to hear.

### Common follow-up questions

**What is a poison pill?**

A message that always causes an error when processed (invalid format, unexpected data). If the consumer retries it indefinitely, it blocks the queue or partition. It is handled by limiting retries and sending it to a dead-letter queue.

## Q083 · What is observability and how is it implemented in microservices with Spring Boot?

*Topic: Observability · Level 5 · Intermediate-Advanced*

Observability is the ability to understand the internal state of a system from its outputs. It rests on three pillars:

- **Logs**: discrete events. Structured (JSON), centralised (ELK/OpenSearch, Loki) and with trace identifiers.
- **Metrics**: numerical values aggregated over time (latency, error rate, CPU usage, pool size). With **Micrometer** (Spring's metrics facade) they are exported to Prometheus and visualised in Grafana. Useful methods: **RED** (Rate, Errors, Duration) for services and **USE** (Utilization, Saturation, Errors) for resources.
- **Distributed traces**: they follow a request across several services. A **trace** is made up of **spans**; the context is propagated in headers (the **W3C Trace Context** standard, `traceparent` header). In Spring Boot 3, **Micrometer Tracing** (the successor to Spring Cloud Sleuth) is used with a bridge to OpenTelemetry or Brave, exporting to Jaeger, Zipkin, Tempo...

Micrometer's **Observation API** lets you instrument once and get both a metric and a trace:

```java
Observation.createNotStarted("order.confirm", registry)
    .lowCardinalityKeyValue("channel", "web")
    .observe(() -> confirm(order));
```

In addition: **health checks**, alerts based on **SLOs** (service level objectives) instead of arbitrary thresholds, and **correlation**: the `traceId` appears in logs, metrics (exemplars) and traces, which lets you jump from an alert to the log and the trace of the specific request.

## Q084 · What should you take into account when deploying a Spring Boot microservice on Kubernetes?

*Topic: Deployment · Level 5 · Intermediate-Advanced*

- **Image**: build with layers (`jarmode`) or buildpacks, a minimal base image (JRE, distroless), a non-root user and pinned versions.
- **Probes**: Spring Boot detects Kubernetes and exposes `/actuator/health/liveness` and `/actuator/health/readiness`.
  - **Liveness**: is the process alive or stuck? If it fails, Kubernetes **restarts** the container. It must not check external dependencies: if the DB goes down, restarting all the pods fixes nothing and makes the situation worse.
  - **Readiness**: can it receive traffic? If it fails, the pod is **taken out of load balancing** without restarting. Here it does make sense to consider critical dependencies.
  - **Startup probe**: for slow startups, it prevents the liveness probe from killing the pod while it starts.
- **Graceful shutdown**: `server.shutdown=graceful` (the default since Boot 3.4) and `spring.lifecycle.timeout-per-shutdown-phase`, to finish in-flight requests on receiving SIGTERM. Sometimes a short `preStop` is added to give the endpoint time to be removed from the load balancer.
- **Resources**: define CPU and memory `requests` and `limits`. The modern JVM respects container limits; the heap is sized with `-XX:MaxRAMPercentage=75` instead of a fixed `-Xmx`.
- **Configuration**: ConfigMaps and Secrets; don't rebuild the image per environment.
- **Scaling**: a HorizontalPodAutoscaler based on CPU or custom metrics; a PodDisruptionBudget to maintain availability during maintenance.
- **Stateless application**: no in-memory session or local files; state goes to databases, Redis or object storage.

> **Interview tip.** Explaining why liveness must not depend on the database is a classic in interviews with a DevOps component.

### Common follow-up questions

**What happens if the readiness probe checks the database and it goes down?**

All the replicas stop being ready at the same time and the Service has no endpoints: clients get connection errors instead of a controlled response. Sometimes it is preferable to stay ready and return 503 errors with a clear message, or to degrade functionality.

## Q085 · How do you version an API and how do you maintain compatibility between services?

*Topic: APIs · Level 5 · Intermediate-Advanced*

Versioning strategies:

- **In the URL**: `/api/v1/orders`. The most explicit and easiest to route and cache. The most common.
- **By header**: `X-API-Version: 2` or by media type (`Accept: application/vnd.store.v2+json`). Cleaner URLs, but less visible.
- **By parameter**: `?version=2`.

Spring Framework 7 / Boot 4 includes **native API versioning support** (a `version` attribute on mappings and resolution strategies by path, header, parameter or media type).

The most important thing is not the mechanism, but **avoiding breaking consumers**:

- **Compatible** changes: adding optional fields, adding endpoints, adding values carefully. They don't require a new version.
- **Incompatible** changes: removing or renaming fields, changing types or semantics, making a field mandatory. They require a new version or a transition period.
- Follow **Postel's law** (robustness): be tolerant of what you receive. Clients must ignore unknown fields (`FAIL_ON_UNKNOWN_PROPERTIES = false`, which Spring Boot already configures by default in its `ObjectMapper`).
- Keep old versions during a communicated **deprecation** period (`Deprecation` and `Sunset` headers).
- Verify compatibility automatically with **contract testing** and with OpenAPI specification comparison tools in the pipeline.

The same happens in messaging: versioned schemas are used (Avro or Protobuf with a **Schema Registry** that enforces backward/forward compatibility rules).

## Q086 · What is the Twelve-Factor App methodology?

*Topic: Principles · Level 5 · Intermediate-Advanced*

It is a set of twelve good practices for building cloud-native applications, published by Heroku. Many of them fit naturally with Spring Boot and Kubernetes:

- **Codebase**: one repository per application, many deployments.
- **Dependencies**: explicitly declared and isolated (Maven/Gradle, fat jar).
- **Config**: in the environment, not in the code (environment variables, profiles).
- **Backing services**: databases, queues and caches as attached resources, interchangeable through configuration.
- **Build, release, run**: strictly separate stages; the same artefact is promoted between environments.
- **Processes**: **stateless** processes; state lives in backing services.
- **Port binding**: the application is self-contained and exposes a port (embedded server).
- **Concurrency**: scale horizontally by adding processes.
- **Disposability**: fast startup and orderly shutdown (graceful shutdown).
- **Dev/prod parity**: environments as similar as possible (Testcontainers, Docker Compose).
- **Logs**: as a stream of events to stdout; the platform collects them.
- **Admin processes**: administrative tasks as one-off processes (migrations, jobs).

Many authors add modern factors such as API-first, telemetry and security by design.

## Q087 · What is the Richardson maturity model? Does it make sense to use HATEOAS?

*Topic: APIs · Level 5 · Intermediate-Advanced*

Leonard Richardson proposed four levels to measure how much an API takes advantage of REST principles:

- **Level 0 · POX (Plain Old XML/JSON)**: a single endpoint to which everything is sent via POST, as if it were RPC. Example: `POST /api` with `{"action": "getCustomer", "id": 42}`.
- **Level 1 · Resources**: each entity has its own URL (`/customers/42`), but a single verb is still used.
- **Level 2 · HTTP verbs**: GET, POST, PUT, PATCH and DELETE, and status codes, are used correctly. **The vast majority of real-world "REST" APIs are here.**
- **Level 3 · Hypermedia controls (HATEOAS)**: responses include links to the available actions and related resources, so that the client navigates the API without building URLs by hand.

```json
{
  "id": 1001,
  "status": "PENDING",
  "total": 59.90,
  "_links": {
    "self":     { "href": "/api/orders/1001" },
    "pay":      { "href": "/api/orders/1001/payment" },
    "cancel":   { "href": "/api/orders/1001/cancellation" },
    "customer": { "href": "/api/customers/42" }
  }
}
```

In Spring it is implemented with **Spring HATEOAS** (`EntityModel`, `CollectionModel`, `WebMvcLinkBuilder`) and formats such as HAL.

Advantages: the server communicates which actions are valid in each state (the `pay` link disappears if the order has already been paid), URLs can change without breaking clients and the API is self-describing.

Why is it rarely used? Real clients (frontends, other services) almost never navigate dynamically: they are programmed against a known contract (OpenAPI). It adds weight to responses and complexity, and client generation tools don't make good use of it.

A reasonable position in an interview: know the model, aim for **level 2 done well** (resources named with nouns, correct verbs and codes, standardised errors with Problem Details, pagination, versioning) and consider HATEOAS for long-lived public APIs or when communicating the available state transitions adds real value.

## Q088 · What would a typical CI/CD pipeline look like for a Spring Boot microservice?

*Topic: DevOps · Level 5 · Intermediate-Advanced*

A continuous integration and delivery pipeline automates the path from a commit to production. A common structure (GitHub Actions, GitLab CI, Jenkins, Azure DevOps...):

**Continuous integration** (on every push and every pull request):

- Compilation with the Maven or Gradle wrapper and dependency caching.
- **Unit tests** and static analysis (Checkstyle, SpotBugs, PMD, Error Prone).
- **Integration tests** with Testcontainers.
- **Contract tests**: verify the consumers' contracts (Pact) and publish your own.
- **Coverage** (JaCoCo) and a SonarQube **quality gate**: the pipeline fails if new code doesn't meet the thresholds.
- **Security**: analysis of vulnerable dependencies (OWASP Dependency-Check, Snyk, Dependabot or Renovate), code analysis (SAST) and secret detection (gitleaks).

**Continuous delivery** (on merging into the main branch):

- Building the **image** (multi-stage Dockerfile, Jib or buildpacks), tagged with the commit SHA (never just `latest`).
- **Image scanning** (Trivy, Grype) and SBOM generation; image signing (cosign).
- Publishing to the container registry.
- **Automatic deployment** to an integration or staging environment, followed by smoke tests and end-to-end or performance tests.
- **Promotion to production**, automatic (continuous deployment) or after an approval, with a canary or blue/green strategy and automatic rollback if the metrics get worse.

**GitOps** is an increasingly common approach for the deployment part: the desired state of each environment (Kubernetes manifests, Helm charts or Kustomize) lives in a Git repository, and a tool such as **Argo CD** or **Flux** synchronises it with the cluster. The CI pipeline doesn't deploy directly: it updates the image version in the configuration repository through a commit or pull request. Advantages: an auditable history of all deployments, rollback with a `git revert` and detection of manual changes in the cluster.

Important principles: **build once, deploy many** (the same artefact is promoted between environments, changing only the configuration), fast pipelines (parallelise and leave slow things for later stages), each microservice with its own independent pipeline, and backward-compatible database migrations.

> **Interview tip.** This question links the development side with the DevOps side perfectly. Mentioning quality gates, image scanning and GitOps shows a complete view of the lifecycle.

## Q089 · Monorepo or one repository per microservice? How is shared code managed?

*Topic: Organisation · Level 5 · Intermediate-Advanced*

**One repository per service (polyrepo)**:

- For: full autonomy for each team, independent pipelines and permissions, clear boundaries between services.
- Against: cross-cutting changes (upgrading the Spring Boot version in forty services) require forty pull requests; it is harder to discover code and maintain consistency.

**Monorepo** (all services in one repository):

- For: atomic changes across services, global refactorings, complete visibility, common tooling and configuration.
- Against: it requires build tools able to compile and test **only what a change affects** (Gradle with build cache, Bazel, Nx, Maven with `-pl`/`-am`), more complex pipelines and the risk that the ease of touching everything couples the services.

Neither is universally better; it depends on the size of the organisation and its tooling. Some very large companies use giant monorepos and others, thousands of repositories.

On **shared code**, the main rule is: **share technical code, not the domain model**.

- Acceptable: stable, versioned infrastructure libraries (common security configuration, structured logging, observability clients, standard error handling). The best way to package them is usually a **custom Spring Boot starter**.
- A **corporate BOM or parent** that pins the versions of Spring Boot and the approved libraries, to keep consistency without copying configuration.
- Dangerous: a library with the entities or DTOs of every service. Each change forces all consumers to update and redeploy at the same time, which recreates the distributed monolith. For contracts, it is better to share the **specification** (OpenAPI, Avro or Protobuf schemas) and let each service generate its own code, or to accept some DTO duplication.

To update dependencies across many repositories automatically, **Renovate** or **Dependabot** are used, and for deeper migrations (for example, upgrading the Spring Boot version) **OpenRewrite** recipes.

## Q090 · How are errors handled and propagated when one service calls another?

*Topic: Communication · Level 5 · Intermediate-Advanced*

An error in a chain of calls can originate in many places: the remote service rejects the request (4xx), fails internally (5xx), doesn't respond (timeout), can't be connected to or returns a response that can't be interpreted. Each case requires different handling.

Principles:

- **Classify the errors** according to whether they are the client's fault (4xx: retrying makes no sense), transient (timeouts, 503, 429: you can retry with backoff if the operation is idempotent) or permanent server errors (persistent 500s: circuit breaker).
- **Don't leak internal errors upwards without translating them**. If the Inventory service returns a 404 because the product doesn't exist, for the client of the Orders service that may be a 422 ("the order contains a non-existent product"), not a 404 for the orders URL. If Inventory responds with a 500, the Orders service should return a 502 or 503 with a controlled message, not forward the body of the original error, which could contain internal details.
- **A standard error format** across the organisation (Problem Details, RFC 9457) with a `type` field that identifies the business error and the `traceId` to correlate it.
- **Translate at the boundary**: the HTTP client adapter converts HTTP responses into exceptions of the calling service's domain.

```java
@Bean
RestClient inventoryClient(RestClient.Builder builder, InventoryProperties props) {
    return builder
        .baseUrl(props.url())
        .requestFactory(factoryWithTimeouts(props))
        .defaultStatusHandler(status -> status.value() == 404,
            (req, res) -> { throw new ProductNotFoundException(); })
        .defaultStatusHandler(HttpStatusCode::is5xxServerError,
            (req, res) -> { throw new InventoryUnavailableException(res.getStatusCode()); })
        .build();
}
```

- **Consistent timeouts** along the whole chain and, if possible, propagation of a *deadline*: if the original client has 200 ms left, it makes no sense for an intermediate service to wait 5 seconds for another.
- Decide on **degradation** in advance: can the product page be shown without the recommendations? Can the order be accepted and the stock validated later?
- Log the error only once, with context, at the point where it is handled; avoid each layer logging it again, generating five traces of the same failure.

# Level 6 · Advanced · Resilience, distributed data and microservice patterns

Circuit breaker, Saga, Outbox, CQRS, Event Sourcing, idempotency, eventual consistency and security between services.

This chapter contains 18 questions.

## Q091 · What is the Circuit Breaker pattern and how does it work?

*Topic: Resilience · Level 6 · Advanced*

It prevents a service from continuing to call a dependency that is failing. Without it, calls hang waiting for timeouts, threads are exhausted and the failure **cascades** through the whole system. It also gives the dependency time to recover.

It works like a state machine:

- **CLOSED**: calls go through normally and successes and failures are recorded in a sliding window (by number of calls or by time). If the failure rate or the rate of **slow calls** exceeds a threshold, it switches to OPEN.
- **OPEN**: calls fail **immediately** without reaching the dependency (fail-fast) and a **fallback** is executed (a default value, cache, degraded response or controlled error). After a waiting time it switches to HALF_OPEN.
- **HALF_OPEN**: it lets a limited number of test calls through. If they succeed, it goes back to CLOSED; if they fail, it goes back to OPEN.

In Spring, **Resilience4j** is used (Netflix Hystrix is discontinued), directly or through the Spring Cloud Circuit Breaker abstraction:

```java
@CircuitBreaker(name = "inventory", fallbackMethod = "unknownStock")
public Stock checkStock(Long productId) {
    return inventoryClient.stock(productId);
}

private Stock unknownStock(Long productId, Throwable ex) {
    return Stock.unknown(productId);
}
```

```yaml
resilience4j.circuitbreaker.instances.inventory:
  sliding-window-size: 20
  failure-rate-threshold: 50
  slow-call-duration-threshold: 2s
  wait-duration-in-open-state: 30s
  permitted-number-of-calls-in-half-open-state: 5
```

Fine points: decide which exceptions count as failures (a 404 or a validation error shouldn't open the circuit) and expose the state of the circuits as metrics.

### Common follow-up questions

**A circuit breaker per instance or shared between instances?**

Normally each instance has its own in-memory circuit breaker, which is enough: each one detects the failure independently within a few seconds. Sharing the state would add another dependency and complexity without much benefit.

**What fallback is appropriate for a pricing service?**

It depends on the business: a recent cached price may be acceptable for showing a catalogue, but not for charging an order. In that case it is better to fail in a controlled way than to charge a wrong price. The fallback is a product decision, not just a technical one.

## Q092 · Besides the circuit breaker, what other resilience patterns do you know?

*Topic: Resilience · Level 6 · Advanced*

- **Timeout**: never wait indefinitely. It is the most basic pattern and the most forgotten one. The timeouts of each hop must be consistent: the caller's greater than the sum of those that depend on it, or propagate a **deadline**.
- **Retry**: retry **transient** failures (timeouts, 503) with **exponential backoff and jitter** (randomness) so as not to synchronise all the clients. Only for **idempotent** operations and never on 4xx errors.
- **Bulkhead**: isolate resources (separate thread pools or semaphores per dependency) so that the saturation of one dependency doesn't consume all the service's resources.
- **Rate Limiter**: limit the rate of requests, to protect yourself or to respect third-party quotas.
- **Fallback / graceful degradation**: return cached data, a default value or reduced functionality.
- **Load shedding**: reject requests when the service is saturated (429/503) to protect those already in progress.
- **Health checks** and self-healing by the orchestrator.

**Danger: retry storms**. If each of the five layers in a chain retries 3 times, one request can turn into 3 to the power of 5 = 243 calls to the final dependency, just when it is overloaded. Solutions: retry at only one level (normally the one closest to the failure or the edge), retry budgets and circuit breakers.

In Resilience4j the order of the decorators matters. By default it is: Retry ( CircuitBreaker ( RateLimiter ( TimeLimiter ( Bulkhead ( function ) ) ) ) ), that is, the retry wraps the circuit breaker.

> **Interview tip.** Explaining the retry storm with the multiplicative calculation is impressive because it shows you have thought about real failures in production.

## Q093 · Why should each microservice have its own database? How do you query data from several services?

*Topic: Data · Level 6 · Advanced*

The **Database per Service** pattern states that each service is the sole owner of its data; the others access it only through its API or its events.

Reasons: if several services share tables, any schema change requires coordinating them (strong coupling), encapsulation and independent deployment are lost, one service can degrade another's performance and you can't choose the most suitable technology (**polyglot persistence**: relational for orders, documents for the catalogue, a graph for recommendations). It doesn't necessarily mean one server per service: it can be a separate schema with different credentials on the same server.

The problem is how to **query data that is spread out**:

- **API Composition**: a component (gateway, BFF or service) calls several services and combines the results in memory. Simple, but with more latency and lower availability, and inefficient for large joins or filters that span services.
- **CQRS with materialised views**: a query service subscribes to the events of other services and maintains a **denormalised read replica** optimised for that query. Fast and available, with eventual consistency.
- **Reference data replication**: a service keeps a local copy of the data it needs from another (for example, the customer's name in the order), updated through events.

What not to do: query another service's database directly.

## Q094 · How are transactions across several microservices managed? Explain the Saga pattern.

*Topic: Data · Level 6 · Advanced*

You can't use an ACID transaction that spans several databases belonging to different services. **Two-Phase Commit (2PC / XA)** exists, but it locks resources, depends on a coordinator, doesn't scale, reduces availability, and many modern brokers and databases don't support it. It is avoided in microservices.

The alternative is the **Saga** pattern: a sequence of **local transactions**, one per service. Each one publishes an event or message that triggers the next. If a step fails, **compensating transactions** are executed that semantically undo the previous steps (it is not a rollback: for example, "refund the payment" instead of "delete the payment").

Order example: Create order (PENDING) → Reserve stock → Charge → Confirm order. If the charge fails: release stock → cancel order.

Two ways of coordinating it:

- **Choreography**: there is no coordinator; each service listens to events and reacts by publishing others. Low coupling and simple for a few steps, but the flow is scattered and hard to follow and debug; there is a risk of cyclic dependencies.
- **Orchestration**: an **orchestrator** (a service or a workflow engine such as Temporal, Camunda or Conductor) tells each participant what to do through commands and manages the compensations. An explicit, centralised flow, easier to monitor and change; the orchestrator can accumulate too much logic.

Challenges: since there is no isolation, other processes see intermediate states. This is mitigated with **semantic countermeasures** (states such as `PAYMENT_PENDING`), semantic locks and designing the steps in the right order (those that can fail first; those that can't be compensated, such as sending an email, at the end). Compensations must be idempotent and retryable.

> **Interview tip.** Distinguishing choreography from orchestration with their trade-offs, and mentioning that compensations are not rollbacks, is the core of the answer.

### Common follow-up questions

**How do you know what state a saga is in if a service goes down halfway?**

The orchestrator (or each participant in choreography) persists the state of the saga and of each step. On recovery, it continues from the last confirmed step. Workflow engines such as Temporal manage this automatically and retry the pending steps.

**What is a pivot step in a saga?**

The point of no return: from there on, the saga is no longer compensated and can only move forward (the following steps are retried until they complete). Compensable steps go before the pivot and those that can't be undone, after it.

## Q095 · What is the dual write problem and how does the Transactional Outbox pattern solve it?

*Topic: Data · Level 6 · Advanced*

**Dual write**: a service needs to save to its database **and** publish a message to the broker. They are two different systems without a common transaction:

- If it saves and then fails to publish, the order exists but nobody finds out.
- If it publishes and then the commit fails, the other services react to an order that doesn't exist.
- Publishing inside the transaction doesn't fix it either: the message may go out and the transaction roll back afterwards.

**Transactional Outbox**: in the **same local transaction** in which the business data is modified, the event is inserted into an `outbox` table in the service's own database. Atomicity is guaranteed by the database. Then an independent process publishes the outbox records to the broker and marks them as sent.

```java
@Transactional
public void confirm(Long id) {
    Order order = orders.findById(id).orElseThrow();
    order.confirm();
    outbox.save(new OutboxEvent("Order", id, "OrderConfirmed", toJson(order)));
}   // both writes in the same transaction
```

Two ways of publishing the outbox:

- **Polling publisher**: a job periodically queries the pending events. Simple, but it adds load and latency.
- **Change Data Capture (CDC)**: a tool such as **Debezium** reads the database's transaction log (the WAL in PostgreSQL, the binlog in MySQL) and publishes the changes to Kafka. Low latency and no impact on queries.

The resulting guarantee is **at-least-once** (the relay may publish and crash before marking the record), so consumers must be **idempotent**. The symmetrical pattern on the consumer side is the **Inbox**, which records the processed messages.

### Common follow-up questions

**What happens to the outbox table when it grows a lot?**

The already-published events have to be cleaned up periodically (a deletion job or partitioning by date). With Debezium you can even insert and delete the record in the same transaction: CDC captures the insert from the log even though the row no longer exists.

## Q096 · What is an idempotent consumer and how is it implemented?

*Topic: Data · Level 6 · Advanced*

Since most messaging systems guarantee **at-least-once** delivery, and HTTP clients retry, the same message or request can arrive several times. An **idempotent consumer** guarantees that processing the same message N times has the same effect as processing it once.

Techniques:

- **Processed-messages table** (inbox / deduplication): each message carries a unique identifier. In the **same transaction** in which the business effect is applied, the ID is inserted into a table with a `UNIQUE` constraint. If it already existed, the message is ignored.
- **Naturally idempotent operations**: `UPDATE orders SET status = 'PAID'` is idempotent; `UPDATE account SET balance = balance - 10` is not.
- **State machines**: reject transitions that have already been applied (if the order is already PAID, ignore a second `PaymentReceived`).
- **Version or sequence control**: discard events with a version lower than or equal to the one already processed (this also solves out-of-order arrival).
- **Upserts** with a natural key instead of blind inserts.

```java
@KafkaListener(topics = "payments")
@Transactional
public void onPaymentReceived(PaymentReceived event) {
    if (!processed.registerIfNew(event.eventId())) {   // INSERT with UNIQUE
        return;                                        // duplicate: ignored
    }
    orderService.markPaid(event.orderId());
}
```

In HTTP APIs the same applies with an **Idempotency-Key** sent by the client, storing the associated response to return it on retries.

## Q097 · What is CQRS and when does it make sense to apply it?

*Topic: Patterns · Level 6 · Advanced*

**CQRS** (Command Query Responsibility Segregation) separates the **write** model (commands that change state and apply business rules) from the **read** model (queries optimised for displaying data).

Levels of application:

- **Logical**: different classes and services for commands and queries, the same database. Queries can use DTO projections or direct SQL without going through the domain model.
- **Physical**: separate stores. Writes go to a normalised DB; the events generated update one or more **read views** (another denormalised table, Elasticsearch, Redis...). Each side scales and is optimised independently.

When it makes sense:

- A large asymmetry between reads and writes.
- Complex queries that combine data from several aggregates or services (in microservices, it is the natural solution for queries that span services).
- A complex domain in which the rich write model isn't suitable for displaying data.
- Together with Event Sourcing, where it is practically mandatory.

Costs: more complexity, more infrastructure and **eventual consistency** between write and read (the user may not immediately see what they have just saved; this is mitigated by returning the result of the command or reading from the write model in that case).

For a simple CRUD, CQRS is over-engineering.

### Common follow-up questions

**How would you rebuild a corrupt or new read view?**

By reprocessing the events from the beginning (if they are retained in Kafka or in an event store) or with an initial load from the source service followed by processing events from that point. That is why projections must be idempotent and rebuildable.

## Q098 · What is Event Sourcing? What are its advantages and drawbacks?

*Topic: Patterns · Level 6 · Advanced*

Instead of storing the **current state** of an entity, you store the **immutable sequence of events** that led it to that state. The state is rebuilt by replaying the events. It is like a bank statement: the balance is the sum of the transactions.

```text
Account 42:
  AccountOpened(holder=Ana)
  MoneyDeposited(100)
  MoneyWithdrawn(30)
  MoneyDeposited(50)
  -> current balance = 120
```

The **event store** is an append-only log; the events are published so that other services or projections can react.

**Advantages**:

- **Complete auditing** and history by design; you can answer "what was the state on day X?" (temporal queries).
- Events are the source of truth and are published naturally: it solves dual write without an outbox.
- **New projections** can be created afterwards by reprocessing the history.
- It fits domains where events are the business (accounting, logistics, bookings).

**Drawbacks**:

- High complexity and a steep learning curve.
- Queries require **CQRS** with projections.
- **Event schema evolution**: old events can't be modified; *upcasting* or versioning is needed.
- Performance when rebuilding aggregates with many events: **snapshots** are used.
- Deleting personal data (GDPR) in an immutable log: *crypto-shredding* is used (encrypting personal data with a per-user key and destroying the key).

Tools: Axon Framework, EventStoreDB, or custom implementations on PostgreSQL or Kafka. It should not be applied to the whole system, only to the contexts where it adds value.

## Q099 · How would you migrate a monolith to microservices? Explain the Strangler Fig pattern and the Anti-Corruption Layer.

*Topic: Migration · Level 6 · Advanced*

Rewriting everything at once (*big bang*) is very risky: months without delivering value, changing requirements and a traumatic final migration. The recommended strategy is incremental.

**Strangler Fig** (Martin Fowler): a **facade or proxy** (normally an API Gateway) is placed in front of the monolith. A piece of functionality is extracted into a new service and the traffic for that part is diverted to it, while the rest keeps going to the monolith. Little by little, the new system "strangles" the old one until it can be retired.

Usual steps:

- Identify a bounded context with clear boundaries, business value and low coupling to start with.
- Modularise within the monolith first if necessary.
- Extract the service together with **its data** (the hardest part): during the transition it may require synchronisation, CDC or temporarily writing to both sides.
- Route the traffic gradually (canary, feature flags) comparing results, sometimes in shadow mode (*shadow traffic*).
- Retire the old code.

**Anti-Corruption Layer (ACL)**: a translation layer between the new service and the legacy system (or another context with a different model). It prevents the concepts, names and quirks of the old model from "contaminating" the new service's clean model. It is implemented as adapters, facades and translators at the boundary.

Other related patterns: **Branch by Abstraction** (introducing an abstraction in the monolith to change the implementation underneath) and **Parallel Run** (running both implementations and comparing the results).

## Q100 · What are the Sidecar pattern and a Service Mesh?

*Topic: Infrastructure · Level 6 · Advanced*

**Sidecar**: an auxiliary container is deployed next to the main container, in the same Kubernetes pod, sharing network and lifecycle. It takes care of cross-cutting functionality without modifying the application: network proxy, log collection, certificate management, observability agents.

**Service Mesh** (Istio, Linkerd, Consul Connect): an infrastructure layer that manages communication between services, normally with a **sidecar proxy** (Envoy in Istio) in each pod that intercepts all traffic. A control plane configures those proxies. It provides:

- Automatic **mTLS** between services (encryption and authentication of service identity).
- Retries, timeouts and circuit breaking configured declaratively.
- Traffic management: canary, percentage-based splitting, traffic mirroring.
- Uniform telemetry and traces without changing code.
- Authorisation policies between services.

Advantage: the capabilities are homogeneous in any language and move out of the application code. Drawbacks: operational complexity, additional latency and resource consumption. There are sidecar-less variants, such as Istio's **ambient mode**, which uses per-node proxies.

Implication for Spring: with a mesh, part of what you would do with Spring Cloud or Resilience4j (retries, mTLS, discovery) is delegated to the platform. You must avoid duplicating policies at both levels (for example, retries in the application and in the mesh multiplying each other).

## Q101 · How does caching work in Spring and what caching patterns do you know?

*Topic: Performance · Level 6 · Advanced*

Spring offers an annotation-based **cache abstraction**, independent of the provider (Caffeine locally, Redis or Hazelcast distributed). It is enabled with `@EnableCaching`:

- `@Cacheable`: if the result is in the cache, it returns it without executing the method; if not, it executes it and stores it.
- `@CachePut`: always executes and updates the cache.
- `@CacheEvict`: removes entries (one or all).

```java
@Cacheable(cacheNames = "products", key = "#id", unless = "#result == null")
public ProductDto get(Long id) { ... }

@CacheEvict(cacheNames = "products", key = "#id")
public void update(Long id, UpdateProduct cmd) { ... }
```

Since they are proxies, they are also affected by self-invocation.

**Caching patterns**:

- **Cache-aside** (lazy loading): the application checks the cache and, if the value isn't there, reads from the DB and fills it. The most common (it is what `@Cacheable` does).
- **Read-through**: the cache itself knows how to load from the source.
- **Write-through**: writes go to the cache and the DB synchronously.
- **Write-behind**: writes go to the cache and are persisted asynchronously (fast, with risk of loss).

**Typical problems**:

- **Invalidation** and stale data: always use a TTL and, in microservices, invalidate through events.
- **Cache stampede**: when a heavily used key expires, many requests go to the DB at once. It is mitigated with `@Cacheable(sync = true)`, locks, expiry with jitter or early refresh.
- Local cache with several instances: each one has different data. For consistency between replicas, use a distributed cache or event-based invalidation.
- Caching mutable objects or managed JPA entities.

### Common follow-up questions

**Local or distributed cache?**

A local cache (Caffeine) is extremely fast and has no network hop, ideal for data that changes rarely and tolerates some inconsistency between instances. A distributed one (Redis) shares data between instances and survives restarts, at the cost of network latency and another dependency. It is common to combine them in two levels.

## Q102 · What is eventual consistency? What do the CAP and PACELC theorems say?

*Topic: Data · Level 6 · Advanced*

**Eventual consistency**: if there are no new updates, all replicas or services will eventually converge to the same value, but for a while they may show different data. It is the norm in microservices with asynchronous communication: the order is already confirmed, but the "my orders" view doesn't reflect it yet for a few milliseconds or seconds.

**CAP theorem**: a distributed system cannot simultaneously guarantee **Consistency** (every read sees the latest write), **Availability** (every request receives a response) and **Partition tolerance** (it keeps working even if messages between nodes are lost). Since network partitions do happen in a real distributed system, the practical choice is: **during a partition**, prioritise consistency (CP, reject requests) or availability (AP, respond with possibly outdated data).

**PACELC** extends CAP: if there is a Partition, choose between Availability and Consistency; **Else** (in normal operation), choose between **Latency** and Consistency. It reflects that the cost of strong consistency (coordination and synchronous replicas) is always paid in latency, not only when there are failures.

Design consequences:

- Design the UX for eventual consistency ("processing" states, notifications when complete).
- Identify which operations **do** need strong consistency (don't sell the last seat twice) and resolve them within a single service or aggregate.
- Detect and correct divergences: idempotency, periodic reconciliations and versioned events.

## Q103 · How is security implemented in a microservices architecture with Spring?

*Topic: Security · Level 6 · Advanced*

The standard is **OAuth 2.0 + OpenID Connect** with **JWT**:

- An **Authorization Server** or Identity Provider (Keycloak, Okta, Auth0, Entra ID, or **Spring Authorization Server**) authenticates the user and issues tokens.
- Clients (SPA, mobile, BFF) obtain an **access token** (Authorization Code flow with PKCE for users; Client Credentials for machine-to-machine communication).
- Each microservice acts as a **Resource Server**: it validates the JWT locally (signature with the public keys from the JWKS endpoint, expiry, issuer and audience) without calling the identity server on every request.

```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: https://auth.mycompany.com/realms/store
```

```java
@PreAuthorize("hasAuthority('SCOPE_orders:write')")
public void cancel(Long id) { ... }
```

Key considerations:

- **Defence in depth**: don't rely only on the gateway. Each service validates the token (**zero trust** model).
- **Identity propagation**: forward the user's token to the services being called, or use *token exchange* to obtain tokens with a narrower audience and permissions.
- **Service-to-service**: Client Credentials or **mTLS** (often managed by the service mesh).
- **Short-lived** tokens and refresh tokens; limited revocation, since JWTs are self-contained.
- Don't store tokens in `localStorage` in SPAs: the **BFF** pattern with `HttpOnly`, `Secure` and `SameSite` cookies is better.
- Fine-grained authorisation (by resource owner) inside the service, not just by roles.
- Secrets management, input validation, rate limiting and security headers.

### Common follow-up questions

**How would you revoke a JWT before it expires?**

JWTs are self-contained, so they can't be revoked without additional state. Options: very short-lived tokens with revocable refresh tokens, a revocation list checked by the services (it loses part of the JWT's advantage) or opaque tokens with introspection for high-security cases.

## Q104 · How is rate limiting implemented in a distributed system? What algorithms exist?

*Topic: Resilience · Level 6 · Advanced*

Rate limiting caps the number of requests a client can make in a period. It protects against abuse and spikes, guarantees a fair share between clients and makes it possible to offer plans with different quotas.

Main algorithms:

- **Fixed window**: count requests per interval (for example, per calendar minute). Simple, but it allows bursts of twice the limit at the window boundary.
- **Sliding window** (log or counter): it corrects that effect, at a higher memory or computation cost.
- **Token bucket**: a bucket with a maximum capacity that refills at a constant rate; each request consumes a token. It allows controlled bursts up to the bucket's capacity and a sustained average rate. It is the most widely used.
- **Leaky bucket**: requests enter a queue that drains at a constant rate, which smooths the outgoing traffic.

With several instances of the service, the counter must be **shared**; if each instance counts on its own, the real limit is multiplied by the number of replicas. The usual solution is **Redis**, with atomic operations or Lua scripts.

Options in the ecosystem:

- **Spring Cloud Gateway**: the `RequestRateLimiter` filter with `RedisRateLimiter` (token bucket) and a `KeyResolver` that decides what to limit by (user, API key, IP).
- **Bucket4j**: a Java token bucket library with distributed backends (Redis, Hazelcast, databases).
- **Resilience4j RateLimiter**: limits the rate of an instance's **outgoing** calls, useful for respecting a third-party API's quota.
- Commercial API gateways, Envoy or the service mesh.

```yaml
spring.cloud.gateway.server.webflux.routes:
  - id: public-api
    uri: lb://catalog-service
    predicates: [ "Path=/api/catalog/**" ]
    filters:
      - name: RequestRateLimiter
        args:
          redis-rate-limiter.replenishRate: 10     # tokens per second
          redis-rate-limiter.burstCapacity: 20     # bucket capacity
          key-resolver: "#{@apiKeyResolver}"
```

The response when the limit is exceeded must be **429 Too Many Requests**, ideally with the `Retry-After` header and informational headers about the remaining limit, so that well-designed clients can adapt.

## Q105 · What is a distributed lock? What risks does it carry and what are fencing tokens?

*Topic: Concurrency · Level 6 · Advanced*

A distributed lock guarantees that, among several instances or processes, only one executes a critical section at a time: a scheduled task, the processing of a specific resource or an operation that doesn't tolerate concurrency.

Common implementations:

- **Database**: a lock row with `SELECT ... FOR UPDATE`, PostgreSQL's *advisory locks* or the **ShedLock** library for scheduled tasks.
- **Redis**: `SET key value NX PX 30000` (only if it doesn't exist, with expiry). **Redisson** offers high-level locks with automatic renewal.
- **ZooKeeper** or **etcd**: coordination systems with consensus guarantees, more robust.
- Spring Integration offers the `LockRegistry` abstraction with implementations for JDBC, Redis and ZooKeeper.

Distributed locks are much more delicate than local ones, because in a distributed system you cannot reliably distinguish between a slow process and a dead one:

- The lock needs an **expiry time** so that it doesn't stay locked forever if its holder dies.
- But if the process holding it suffers a long pause (a GC pause, a frozen virtual machine or a network problem), the lock expires, another process acquires it and **two processes believe they hold the lock at the same time**. The first one, on waking up, writes stale data.

The solution is **fencing tokens**: each time the lock is granted, a monotonically increasing number is handed out. The process includes that number in its writes, and the protected resource (for example, the database) **rejects writes with a token lower** than the last one seen. That way, the process that woke up late is rejected.

```sql
UPDATE resource SET data = :data, token = :token
WHERE id = :id AND token < :token;
```

Practical recommendation: before introducing a distributed lock, ask yourself whether it can be avoided. Often **optimistic locking** with `@Version`, uniqueness constraints in the database, atomic operations or partitioning the work are enough (in Kafka, all messages with the same key are processed by a single consumer, which serialises the work per entity without any need for locks).

## Q106 · What types of events exist? What is the difference between event notification and event-carried state transfer?

*Topic: Events · Level 6 · Advanced*

It is worth first distinguishing two levels:

- **Domain events**: relevant facts within a bounded context, in that context's language (`LineAddedToOrder`). They can be internal and change freely.
- **Integration events**: those published to other services. They are part of the **public contract**: they must be designed, versioned and documented (AsyncAPI) with the same care as a REST API. It is not advisable to simply publish internal events or to expose the persistence model.

Martin Fowler describes several styles of using events:

- **Event notification**: the event only reports that something happened, with minimal data (`OrderConfirmed { orderId: 1001 }`). A consumer that needs more information asks the emitter for it. Lightweight events and low data coupling, but it generates traffic back to the emitter and temporal coupling (if the emitter isn't available, the consumer can't complete its work).
- **Event-carried state transfer**: the event includes all the data consumers may need (`OrderConfirmed { orderId, customer, lines, total, address }`). Consumers keep their own local copy and don't need to ask again, which improves autonomy and availability. In exchange, events are bigger, there is duplicated data and the event schema is a broader contract that is harder to evolve.
- **Event sourcing**: events are the source of truth for the state (see the dedicated question).

Other event design decisions:

- **Full state-change events** (*snapshot* or *fat event*, with the whole entity) versus **delta events** (only what changed). The former fit Kafka compacted topics, which keep the latest state per key.
- Include standard metadata: a unique event identifier, type, schema version, date, source and tracing (the **CloudEvents** standard defines these attributes).
- Name events in the **past tense** and in business terms (`PaymentRejected`, not `UpdatePaymentsTable`).

## Q107 · What is multi-tenancy and what strategies exist for implementing it with Spring?

*Topic: Architecture · Level 6 · Advanced*

A **multi-tenant** application serves several customers (*tenants*: companies or organisations) with the same instance of the software, keeping their data isolated. It is the typical model of SaaS applications.

Data isolation strategies, from most to least isolated:

- **Database per tenant**: maximum isolation, independent backups and restores, the possibility of locating data by region. Higher cost and operational complexity (migrations across hundreds of databases, connection pools).
- **Schema per tenant**: one database with one schema per customer. Intermediate isolation.
- **Shared table with a discriminator column** (`tenant_id` in every table): the cheapest and simplest to operate, but isolation depends on **no query** forgetting to filter by tenant. It is reinforced with the database's row-level security (PostgreSQL **Row-Level Security**) or with automatic ORM filters.

Implementation in Spring:

- **Resolve the tenant** on each request: from the JWT token (a *claim* with the tenant), a subdomain or a header, in a filter that stores it in a request-bound context.
- **Route the connection**: for database or schema per tenant, `AbstractRoutingDataSource` chooses the `DataSource` according to the current tenant, or Hibernate with `MultiTenantConnectionProvider` and `CurrentTenantIdentifierResolver`.
- **Filter data**: for a shared table, Hibernate 6 offers `@TenantId`, which automatically adds the tenant filter to every query and assigns the value on insert.

```java
@Entity
public class Invoice {
    @Id @GeneratedValue Long id;
    @TenantId String tenant;   // Hibernate filters and fills it in automatically
    BigDecimal amount;
}
```

Other aspects: propagating the tenant to asynchronous threads and to messages (as a header), cache keys that include the tenant (a typical mistake is serving another customer's cached data), quotas and rate limiting per tenant to avoid the *noisy neighbour* problem, and metrics and logs tagged by tenant.

## Q108 · How do you design a reliable integration with webhooks or third-party APIs?

*Topic: Integration · Level 6 · Advanced*

Integrations with external systems (payment gateways, logistics providers, CRMs) are a common source of incidents because you don't control the other side.

**As a webhook receiver** (the third party notifies you of an event, for example "payment completed"):

- **Verify authenticity**: check the request's HMAC signature with the shared secret and reject old requests (timestamp) to prevent replay attacks.
- **Respond quickly**: store the event (in a table or a queue) and respond 2xx immediately; process it asynchronously afterwards. If processing is slow or fails, the provider will retry and duplicates will pile up.
- **Idempotency**: providers retry and may send the same event several times. Deduplicate by the event identifier.
- **Don't rely on ordering**: the "payment refunded" event may arrive before "payment completed". Use state machines or the provider's timestamps.
- **Reconciliation**: webhooks can be lost. A periodic process that queries the provider's API to cross-check states is the safety net.

**As a webhook emitter** towards your customers: sign the requests, retry with exponential backoff for a reasonable period, allow events to be queried and resent, and disable endpoints that fail persistently.

**As a client of third-party APIs**:

- Timeouts, retries only for idempotent operations (using the *idempotency keys* the provider offers) and a circuit breaker.
- Respect the provider's rate limits (Resilience4j RateLimiter, handling 429 with `Retry-After`).
- **Anti-Corruption Layer**: translate the provider's model into your own, so that a change in it, or a change of provider, doesn't affect the domain.
- Store the relevant requests and responses for auditing and support, without sensitive data.
- Test with **WireMock** simulating the error cases, and with the provider's sandbox environment in end-to-end tests.
- Monitor the integration separately (latency, error rate and quotas) and alert before customers notice.

# Level 7 · Expert · Internals, performance and system design

Senior-level questions: how Spring starts up internally, virtual threads, native images, production diagnostics and open-ended design exercises.

This chapter contains 17 questions.

## Q109 · What happens internally when SpringApplication.run() is executed?

*Topic: Internals · Level 7 · Expert*

Broadly speaking:

- **Deduce the application type** (servlet, reactive or none) from the classes present on the classpath.
- Load the registered `ApplicationContextInitializer`s and `ApplicationListener`s and publish `ApplicationStartingEvent`.
- **Prepare the `Environment`**: property sources (command line, environment variables, configuration files, active profiles) and publish `ApplicationEnvironmentPreparedEvent`. This is where the `EnvironmentPostProcessor`s act.
- Print the banner.
- **Create the appropriate `ApplicationContext`** and apply the initialisers.
- **Register the bean definitions**: the main class as the source; then, processing of `@Configuration`, component scan, `@Import` and **auto-configuration** (in that order, so that the `@ConditionalOnMissingBean` conditions see the user's beans).
- **Context refresh**, the core of startup:
  - Run the `BeanFactoryPostProcessor`s (they modify definitions before beans are created; for example, placeholder resolution or the `ConfigurationClassPostProcessor`).
  - Register the `BeanPostProcessor`s.
  - Create the **embedded web server** (`onRefresh`).
  - **Instantiate all non-lazy singletons**: dependency injection, initialisation callbacks and creation of AOP proxies.
  - Start the `SmartLifecycle` beans (among them, the web server, which starts listening on the port).
- Publish `ApplicationStartedEvent`, run the `CommandLineRunner`s / `ApplicationRunner`s and publish `ApplicationReadyEvent`; the readiness state switches to accepting traffic.

To analyse slow startups: `BufferingApplicationStartup` with the `/actuator/startup` endpoint, which shows how long each step and each bean takes.

> **Interview tip.** You don't need to memorise every event; what matters is the sequence Environment → definitions → post-processors → singletons and proxies → server → runners → ready.

## Q110 · What are circular dependencies? Why does Spring Boot forbid them by default?

*Topic: Internals · Level 7 · Expert*

A circular dependency appears when bean A needs B and B needs A (directly or indirectly through more beans).

- With **constructor injection** it is impossible to resolve: to create A you need B already created, and vice versa. Spring throws `BeanCurrentlyInCreationException` at startup.
- With **field or setter** injection, Spring historically resolved it through a three-level cache that exposes "early" references to beans that are not yet fully initialised. It works, but beans are used half-built, and the interaction with AOP proxies can produce subtle errors (injecting the original object instead of the proxy).

Since **Spring Boot 2.6**, circular references are **forbidden by default** (`spring.main.allow-circular-references=false`), because they almost always indicate a **design problem**: two classes with poorly distributed responsibilities.

Correct solutions:

- **Refactor**: extract the common logic into a third bean that both depend on.
- Replace the direct call with **events** (A publishes an event, B listens to it).
- Check whether one of the dependencies really belongs to another service or layer.

Emergency solutions: `@Lazy` on one of the injection points (it injects a proxy that resolves the real bean on first use) or `ObjectProvider<T>`. Re-enabling `allow-circular-references` should be the last resort.

## Q111 · What is Spring WebFlux? When should you choose it over Spring MVC?

*Topic: Reactive · Level 7 · Expert*

**Spring MVC** uses the **thread-per-request** model: each request occupies a thread from the server pool (Tomcat, 200 threads by default) for its whole duration, including I/O waits (database, HTTP calls). With many slow, concurrent requests, the threads run out.

**Spring WebFlux** is the **reactive, non-blocking** stack, based on **Project Reactor** (`Mono` for 0..1 elements, `Flux` for 0..N) and normally on Netty. A few threads (on the order of the number of cores, in an *event loop*) serve many requests because they never block: they register callbacks and are released while waiting for I/O. It also offers **backpressure** (the consumer controls the producer's pace) and streaming (Server-Sent Events).

```java
@GetMapping("/orders/{id}")
public Mono<OrderDto> get(@PathVariable Long id) {
    return orders.findById(id)                        // R2DBC, non-blocking
        .zipWith(customers.get(id))                   // HTTP call in parallel
        .map(t -> mapper.toDto(t.getT1(), t.getT2()));
}
```

Critical requirement: **the whole chain must be non-blocking**. A single blocking call (JDBC, JPA, a synchronous HTTP client) on the event loop degrades the entire server. That is why R2DBC is used instead of JPA, WebClient, reactive Mongo or Redis drivers, etc. BlockHound helps detect this in tests.

**When to choose it**: high concurrency with lots of I/O, streaming, gateways (Spring Cloud Gateway is reactive), composition of many remote calls.
**When not to**: most CRUD with JPA, teams without reactive experience (learning curve, harder debugging and stack traces). With the arrival of **virtual threads**, much of the scalability advantage can be obtained with MVC's imperative model, so WebFlux is left for cases where streaming and backpressure are needed.

### Common follow-up questions

**What would you do if you needed to call a blocking library from WebFlux?**

Wrap the call with Mono.fromCallable(...).subscribeOn(Schedulers.boundedElastic()), which runs it in a separate thread pool so as not to block the event loop. If it happens in many places, WebFlux is probably not the right option for that service.

## Q112 · What are Java 21 virtual threads and how are they used in Spring Boot?

*Topic: Concurrency · Level 7 · Expert*

**Virtual threads** (Project Loom, stable since Java 21) are lightweight threads managed by the JVM, not by the operating system. When a virtual thread blocks on an I/O operation, the JVM **unmounts** it from its *carrier* thread (a platform thread), which is then free to run another virtual thread. You can create millions of them; creating one costs very little.

Consequence: you get the scalability of the non-blocking model **while keeping the usual imperative, blocking code** (JDBC, RestClient, readable stack traces), without reactive complexity.

In Spring Boot 3.2+ they are enabled with a property:

```yaml
spring:
  threads:
    virtual:
      enabled: true
```

That way Tomcat serves each request in a virtual thread, and they are also used in `@Async`, Kafka and RabbitMQ listeners, scheduled tasks, etc.

Considerations:

- **Pinning**: in Java 21 and earlier, a virtual thread that blocks inside a `synchronized` block is pinned to its carrier and doesn't release it. The recommendation was to replace `synchronized` with `ReentrantLock` on hot paths. **Java 24 (JEP 491)** removed this problem for `synchronized`. It is diagnosed with JFR (the `jdk.VirtualThreadPinned` event).
- **They are not faster**, they only allow more concurrency for **I/O-bound** workloads. They add nothing for CPU-bound workloads.
- **Resources are still finite**: if thousands of virtual threads compete for a pool of 10 database connections, the bottleneck moves there. You may need to limit concurrency with semaphores.
- They should not be pooled (they are created per task), and care must be taken with large `ThreadLocal`s; in Java 25 **Scoped Values** were stabilised as an alternative.

> **Interview tip.** Mentioning pinning, its resolution in Java 24 and that the bottleneck moves to the connection pool shows real, up-to-date knowledge.

### Common follow-up questions

**Do virtual threads make WebFlux unnecessary?**

For most request-response business services, largely yes: you get high concurrency with imperative code. WebFlux still makes sense for streaming, backpressure and complex reactive composition of data streams.

## Q113 · What are GraalVM native images and AOT processing in Spring Boot?

*Topic: Performance · Level 7 · Expert*

**GraalVM Native Image** compiles the Java application *ahead of time* into a **native executable** for a specific platform, with no JVM at runtime. It performs a static reachability analysis from `main` and includes only the code that is used (the **closed-world** assumption).

Advantages:

- **Startup in tens of milliseconds** instead of seconds.
- Lower memory consumption.
- Ideal for serverless, scale-to-zero, CLIs and very fast scaling.

Drawbacks:

- **Slow** compilation (minutes) that uses a lot of memory.
- Reflection, dynamic proxies, resources and serialisation must be known at compile time (*reachability metadata*); libraries that don't declare them may fail.
- Peak sustained performance (*throughput*) may be lower than the JVM with JIT after warm-up (it improves with PGO).
- More limited JVM debugging and observability tools.
- Bean configuration is fixed at compile time: you can't change profiles that alter beans or `@ConditionalOnProperty` conditions at runtime.

Spring Boot 3 includes first-class support thanks to **Spring's AOT engine**: at build time it evaluates the conditions, generates source code that registers the bean definitions without reflection and produces the *hints* files for GraalVM. It is built with `mvn -Pnative native:compile` or as an image with buildpacks.

Alternatives on the JVM for improving startup: **CDS / AppCDS** (Class Data Sharing), supported by Boot 3.3+, **Project Leyden** (AOT cache, from Java 24/25) and **CRaC** (checkpoint/restore of an already warm JVM).

## Q114 · How do you size the database connection pool? What should you watch in HikariCP?

*Topic: Performance · Level 7 · Expert*

HikariCP is the default pool in Spring Boot. A common mistake is thinking that a bigger pool means more performance: the database has a limited number of cores and disks, and too many concurrent connections cause context switching and lock contention that **reduce** performance.

The starting recommendation in the HikariCP documentation (based on PostgreSQL) is `connections = (cores * 2) + effective disks`; in practice, small pools (10-20) usually perform better than pools of 100. In addition, you have to multiply by the **number of instances**: 20 connections × 15 pods = 300 connections against the database, which may exceed its `max_connections`. In that case a connection proxy such as PgBouncer is used.

Key parameters:

- `maximum-pool-size` and `minimum-idle` (for fixed-size pools they are recommended to be equal).
- `connection-timeout`: how long a thread waits for a free connection before failing (30 s by default; it is advisable to reduce it to fail fast).
- `max-lifetime`: must be **lower** than the connection timeout of the database or intermediate firewalls.
- `leak-detection-threshold`: warns if a connection is held for too long (leaks or long transactions).

Metrics to watch with Micrometer: `hikaricp.connections.active`, `.pending` (threads waiting for a connection: a clear sign of saturation), `.acquire` (time to obtain one) and `.usage` (time each connection is held).

Typical causes of pool exhaustion: transactions that include remote HTTP calls (the connection is held while waiting for another service), Open Session In View enabled, slow queries and, with virtual threads, excess concurrency that Tomcat's thread pool used to limit.

> **Interview tip.** The idea of "don't make remote calls inside a transaction" is one of the most valuable performance recommendations you can give.

### Common follow-up questions

**What would you do if you constantly see pending connections in the pool?**

Before enlarging the pool, find out why connections are being held: slow queries, long transactions, remote calls inside transactions or Open Session In View. Enlarging the pool without fixing the cause usually moves the problem to the database.

## Q115 · How would you create your own Spring Boot starter?

*Topic: Extensibility · Level 7 · Expert*

A custom starter is used to share cross-cutting configuration among a company's microservices: an auditing client, common security configuration, structured logging, correlation headers, clients for internal APIs...

Recommended structure in two modules:

- `mycompany-audit-spring-boot-autoconfigure`: contains the auto-configuration logic.
- `mycompany-audit-spring-boot-starter`: an empty module that only aggregates dependencies (the autoconfigure module and the necessary libraries).

The auto-configuration:

```java
@AutoConfiguration(after = JacksonAutoConfiguration.class)
@ConditionalOnClass(AuditClient.class)
@ConditionalOnProperty(prefix = "mycompany.audit", name = "enabled",
                       havingValue = "true", matchIfMissing = true)
@EnableConfigurationProperties(AuditProperties.class)
public class AuditAutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    AuditClient auditClient(AuditProperties props, RestClient.Builder builder) {
        return new AuditClient(builder.baseUrl(props.url()).build());
    }
}
```

And it is registered in `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` with the fully qualified class name.

Good practices:

- Always use `@ConditionalOnMissingBean` so that the user can override any bean.
- Properties with their own prefix and metadata (`spring-boot-configuration-processor`) for autocompletion.
- Don't use component scanning inside the auto-configuration.
- Test it with `ApplicationContextRunner`, which lets you quickly verify which beans are created depending on classes, properties and existing beans.

## Q116 · Design question: design the order backend of an e-commerce site with microservices.

*Topic: System design · Level 7 · Expert*

In these open questions, the **process** is valued more than the solution. An orderly approach:

**1. Clarify requirements**: volume (orders per second, peaks such as Black Friday), consistency requirements (can more stock be sold than there is?), expected latency, payment gateways, notifications, internationalisation.

**2. Identify bounded contexts and services**: Catalogue, Inventory, Cart, Orders, Payments, Shipping, Notifications, Customers. Each one with its own database.

**3. Main flow** (a Saga orchestrated by the Orders service):

- The customer confirms the cart: `POST /orders` with an **Idempotency-Key**. The order is created in `PENDING` status and the response is `202 Accepted` with the identifier.
- Inventory **reserves stock** (with a temporary reservation that expires).
- Payments authorises the charge with the external gateway (often asynchronously via webhook, also idempotent).
- If everything goes well, the order moves to `CONFIRMED` and `OrderConfirmed` is published; Shipping and Notifications react.
- If the payment fails or expires: compensation (release stock, order `CANCELLED`).

**4. Reliability**: an Outbox in each service that publishes events, idempotent consumers, DLQ, retries with backoff and timeouts on all synchronous calls.

**5. Data and queries**: "My orders" as a CQRS view fed by events; the heavily read catalogue behind a cache and CDN; search in Elasticsearch/OpenSearch.

**6. Scalability and peaks**: stateless services with autoscaling, queues to absorb peaks, rate limiting at the gateway, Kafka partitioning by `orderId`. For high-demand products, stock management with atomic operations or reservations in Redis.

**7. Cross-cutting**: an API Gateway with OAuth2, full observability (traces per order), canary deployments and contract tests between services.

**8. Explicit trade-offs**: eventual consistency when displaying the order; the possibility of minimal overselling versus strictly locking stock; orchestration versus choreography.

> **Interview tip.** Think out loud, draw, ask about the requirements before designing and name the trade-offs explicitly. A "perfect" design with no prior questions usually scores worse than a reasoned one.

## Q117 · A microservice in production starts responding very slowly. How do you investigate?

*Topic: Operations · Level 7 · Expert*

A systematic approach, from the general to the specific:

**1. Narrow down the impact with metrics**: since when? All instances or only some? All endpoints or one? Does it coincide with a deployment, a configuration change or a traffic peak? Review latencies by percentile (p50, p95, p99), error rate and throughput.

**2. Distributed traces**: locate slow requests and see which span the time goes into: a database query, a call to another service, waiting for the connection pool, time in the code itself?

**3. Application resources**:

- **CPU and GC**: JVM metrics (`jvm.gc.pause`, heap usage). Long pauses or continuous GC may indicate memory leaks or a poorly sized heap; check whether the container is limited by *CPU throttling*.
- **Threads**: a *thread dump* (`/actuator/threaddump` or `jstack`) shows threads that are blocked, waiting for locks or waiting for pool connections. Several dumps a few seconds apart reveal patterns.
- **Pools**: pending DB connections (`hikaricp.connections.pending`), a saturated server thread pool, HTTP client pools.

**4. Dependencies**: the database (slow queries, execution plans, locks, missing indexes after data growth), slow external services without proper timeouts, a broker with consumer lag.

**5. Profiling**: **Java Flight Recorder** (low overhead, suitable for production) or async-profiler to get flame graphs of CPU, allocations and locks. A *heap dump* analysed with Eclipse MAT if a leak is suspected.

**6. Mitigate before resolving**: roll back the last deployment, scale horizontally, activate circuit breakers or degrade features, and then carry out the root cause analysis with a **blameless postmortem**, adding alerts or tests that would have detected it earlier.

### Common follow-up questions

**What information would you ask for before touching anything?**

Since when it has been happening, whom it affects (all customers or some, all endpoints or one), what has changed recently (deployments, configuration, traffic, data) and whether other services are affected. These questions narrow down the problem faster than any tool.

## Q118 · What deployment strategies do you know and how are database changes managed without downtime?

*Topic: Deployment · Level 7 · Expert*

Deployment strategies:

- **Rolling update**: instances are replaced gradually (the default in Kubernetes). For a while the old and new versions coexist, so **they must be compatible**.
- **Blue/Green**: two complete environments; you deploy to the idle one and switch the traffic in one go. Immediate rollback, but it doubles resources.
- **Canary**: a small percentage of traffic is sent to the new version, metrics are compared (errors, latency) and it is progressively widened or automatically reverted (Argo Rollouts, Flagger, service mesh).
- **Feature flags**: the code is deployed switched off and activated through configuration, for specific groups of users (it decouples *deploy* from *release*). Tools: Unleash, LaunchDarkly, OpenFeature.
- **Shadow / dark launch**: the new version receives a copy of the real traffic without affecting the responses.

**Database changes without downtime**: since two versions of the code coexist, each migration must be compatible with the previous version and with the next one. The **expand/contract** pattern (or *parallel change*) is used. Example, renaming the `name` column to `full_name`:

- **Expand**: add the new column (nullable) and deploy code that **writes to both** and reads from the old one.
- **Migrate data**: copy the existing values in batches, without long locks.
- Deploy code that **reads from the new one** (and keeps writing to both).
- Deploy code that only uses the new one.
- **Contract**: in a later version, drop the old column.

Precautions: avoid operations that lock large tables (create indexes concurrently, add columns with default values carefully depending on the database) and test the migrations with realistic data volumes.

## Q119 · What microservice anti-patterns do you know?

*Topic: Anti-patterns · Level 7 · Expert*

- **Distributed monolith**: services that must be deployed together, that share domain libraries or that don't work without the others. You pay the cost of distribution without gaining independence.
- **Shared database**: several services reading and writing the same tables. Total coupling at the schema level.
- **Services that are too fine-grained** (*nanoservices*) or **entity services** (one per table): they force you to orchestrate dozens of calls for any operation.
- **Excessive communication** (*chatty*) and **long synchronous chains**: A calls B, which calls C, which calls D. Latency adds up and availability multiplies downwards.
- **Shared domain library** (the "common.jar" with everyone's entities): it couples the deployment cycles. Share only stable technical utilities, never the domain model.
- **Distributed transactions everywhere**: a sign of badly drawn boundaries.
- **Lack of observability**: not being able to follow a request across services turns any incident into a blind search.
- **No timeouts or resilience**: one slow service brings down all the others in cascade.
- **JPA entities in contracts** or events that expose the internal model.
- **Adopting microservices because they are fashionable**, with a small team and a poorly understood domain.
- **The "god" gateway or orchestrator**: they accumulate business logic from every domain.
- **Versioning everything at once** or breaking contracts without a transition period.

Many of these problems boil down to one idea: the boundaries between services should follow the boundaries of the business, and each service should be able to evolve, deploy and fail independently.

> **Interview tip.** Closing an interview by showing that you know the mistakes (and perhaps telling one you lived through and how it was solved) conveys experience more than any definition.

## Q120 · How do you tune the JVM of a Spring Boot application running in containers? Which garbage collector should you choose?

*Topic: JVM · Level 7 · Expert*

Since Java 10 (and backports in Java 8u191), the JVM **detects the container's limits** (cgroups) to calculate the available memory and number of CPUs. Even so, the defaults are not always appropriate.

**Memory**:

- By default, the maximum heap is only **25% of the container's memory**, too conservative for a container that only runs the JVM. It is adjusted with `-XX:MaxRAMPercentage=70` or `75`, instead of setting `-Xmx`, so that it adapts if the limit changes.
- The JVM uses memory **outside the heap**: metaspace (classes), code cache (JIT code), thread stacks, direct buffers (Netty, NIO) and the GC itself. If heap + non-heap exceed the container's limit, the kernel kills the process (**OOMKilled**, exit code 137) without any `OutOfMemoryError` appearing in the log. That is why 100% of the memory is not assigned to the heap.
- `-XX:+HeapDumpOnOutOfMemoryError` with a path on a persistent volume so that memory errors can be analysed, and `-XX:+ExitOnOutOfMemoryError` so that the orchestrator restarts the container instead of leaving it in a degraded state.

**CPU**: the JVM sizes the GC threads, the JIT and the common `ForkJoinPool` according to the CPUs it detects. With very low CPU limits (less than 1 CPU), Spring Boot's startup is very slow and *CPU throttling* appears. Many organisations set CPU `requests` and avoid strict `limits` for Java services, or reserve more CPU during startup.

**Garbage collectors**:

- **G1** (the default in most configurations): a good balance between throughput and pauses, suitable for most services. The JVM automatically chooses **Serial GC** if it detects fewer than 2 CPUs or less than 1792 MB, something common in small containers that can come as a surprise.
- **ZGC** (generational since Java 21): sub-millisecond pauses regardless of heap size, at the cost of somewhat higher CPU and memory consumption. Suitable for latency-sensitive services or large heaps.
- **Shenandoah**: a goal similar to ZGC (low latency).
- **Parallel GC**: maximum throughput, longer pauses; useful for batch processes.

The important thing is to **measure** before tuning: Micrometer GC metrics (`jvm.gc.pause`), GC logs (`-Xlog:gc*`) and Java Flight Recorder. Most memory problems are leaks in the code (unbounded caches, collections that keep growing) and are not fixed by changing parameters.

> **Interview tip.** Explaining why a Java container can die from OOMKilled without any OutOfMemoryError in the logs is a classic in interviews for roles with a DevOps component.

## Q121 · What is Spring Modulith and how does it help build a modular monolith?

*Topic: Architecture · Level 7 · Expert*

A **modular monolith** is an application deployed as a single unit, but internally organised into modules with **clear boundaries**, each with its public API and its internal details hidden, communicating preferably through events. It offers many of the design benefits of microservices (cohesion, low coupling, teams per module) without the distributed complexity, and it leaves the way prepared for extracting services if that is ever needed.

The problem is that, without tooling, the boundaries erode: any public class can be used from anywhere. **Spring Modulith** provides:

- **A module convention**: each direct package under the application's package is a module. The classes in the module's root package are its API; sub-packages are internal.
- **Structure verification** with a test that fails if a module accesses another module's internal details or if there are cyclic dependencies between modules:

```java
class ModularityTest {
    ApplicationModules modules = ApplicationModules.of(StoreApplication.class);

    @Test
    void verifiesStructure() {
        modules.verify();
    }

    @Test
    void generatesDocumentation() {
        new Documenter(modules).writeDocumentation();   // C4 / PlantUML diagrams
    }
}
```

- **Event-based communication** between modules with `@ApplicationModuleListener` (a transactional, asynchronous listener that runs after the commit), together with a persistent **event publication registry**: events are stored in the database within the transaction and marked as completed when processed, so that if the application goes down they can be reprocessed on startup (a built-in outbox).
- **Event externalisation**: with `@Externalized`, an internal event is also published to Kafka, RabbitMQ or other brokers, the first step towards a module becoming a service.
- **Per-module integration tests** with `@ApplicationModuleTest`, which start only one module (and optionally its dependencies), and the `Scenario` API for testing event-based flows.
- **Per-module observability**: traces that show the interactions between modules.

It is a very solid answer to the question "microservices from the start?": you can start with a well-bounded, verified modular monolith and extract a module into a service when there is a concrete reason (independent scaling, another team, different requirements).

## Q122 · Design question: a concert ticketing system with extreme demand peaks.

*Topic: System design · Level 7 · Expert*

It is a classic question because it combines **high concurrency over a scarce resource** with **traffic peaks** thousands of times the normal level at the moment sales open.

**Requirements to clarify**: the number of seats (50,000 numbered seats or general admission?), expected concurrent users, maximum time to complete the purchase, the limit of tickets per person, and the golden rule: **never sell the same seat twice**.

**Main components**:

- **Virtual waiting room**: when sales open, users enter a queue and are given access in turns, at a rate the system can absorb. It is the key to turning an impossible peak into a controlled flow. It can be implemented at the edge (CDN) or with Redis (sets ordered by turn and a signed access token).
- **Catalogue and availability**: the event and venue information is almost static and is served from cache and CDN. The availability map is shown with slightly outdated data (eventual consistency is acceptable for display).
- **Temporary seat reservation**: when choosing seats, a **hold** with an expiry is created (for example, 10 minutes) while the user pays. The operation must be atomic. Options: a conditional update in the database (`UPDATE seat SET status='HELD', until=... WHERE id=? AND status='FREE'`, checking the affected rows), a uniqueness constraint or, for extreme performance, atomic operations in Redis (Lua scripts) with persistence afterwards.
- **Payment**: a saga with the external gateway; the ticket is confirmed only after payment; idempotency in the gateway's webhook; if the hold expires without payment, the seats become available again.
- **Issuing and sending** tickets asynchronously (queues), with signed QR codes to prevent forgery.

**Scalability and protection**:

- Stateless services with autoscaling **scheduled in advance** (the peak is predictable: you know when sales open), and load tests before the event.
- Rate limiting per user and IP, anti-bot protection (CAPTCHA, behavioural detection), a limit of tickets per account.
- Isolation: the peak of one event must not degrade the rest of the platform (bulkheads, dedicated resources).

**Trade-offs to make explicit**: fairness (order of arrival) versus performance; strict per-seat locking versus general admission with an atomic counter (much simpler); strong consistency only in the reservation and eventual consistency in everything else.

> **Interview tip.** What is valued is identifying the critical point (the atomic reservation) and protecting the system from the peak (the waiting room), not drawing lots of boxes.

## Q123 · Design question: a multichannel notification service (email, SMS, push).

*Topic: System design · Level 7 · Expert*

Many services need to notify users (order confirmed, shipment on its way, password reset). Centralising it in a service avoids duplicating integrations and lets you manage preferences, templates and limits in a single place.

**Requirements**: channels (email, SMS, push, in-app), volume (peaks from mass campaigns versus transactional notifications), priorities (a verification code can't wait behind a million marketing emails), user preferences and consent, multilingual templates, tracking of delivery status.

**Design**:

- **Asynchronous input**: services publish events (`OrderConfirmed`) or commands (`SendNotification`) to Kafka or a queue. Optionally, a REST API for direct sends, which responds 202 and enqueues.
- **Processing**: the service resolves the recipient, checks their **preferences** (active channels, do-not-disturb hours, language, marketing opt-outs), renders the **template** and generates one notification per channel.
- **Separate queues per channel and per priority**: the saturation of an SMS provider doesn't affect email, and transactional messages don't get stuck behind campaigns. It is an example of the bulkhead pattern.
- **Workers per channel** that call the external providers (transactional email services, SMS, APNs and FCM for push), each with its circuit breaker, rate limits, retries with backoff and, if it is critical, a **fallback provider** (*failover*).
- **Idempotency**: a deduplication key per notification so as not to send the same SMS twice when there are retries (very visible and annoying for the user).
- **Status and traceability**: record each notification with its statuses (pending, sent, delivered, bounced, failed), updated through the providers' webhooks. Useful for support ("did the customer get the email?"), for detecting invalid addresses and for metrics.
- **Dead letter queue** for notifications that exhaust their retries, with alerts and the possibility of reprocessing them.

**Cross-cutting aspects**: regulatory compliance (consent, opt-outs, personal data in the logs), cost control per channel (SMS is expensive), per-user limits so as not to overwhelm them, and observability per channel and provider (delivery rate, latency, errors).

## Q124 · How would you guarantee the quality of a microservices system throughout its whole lifecycle?

*Topic: Quality · Level 7 · Expert*

Quality in a distributed system is not achieved just with tests at the end: it is built in at every phase (*shift-left*) and also verified in production (*shift-right*).

**During development**:

- Clear, verifiable acceptance criteria before coding; concrete examples with **BDD** (Given/When/Then scenarios with Cucumber or other tools) when business and development need a common language.
- TDD or, at the very least, tests written together with the code.
- Code reviews focused on design, security and testability.

**In the pipeline** (automated and fast):

- The test pyramid: unit, integration with Testcontainers, contract (Pact or Spring Cloud Contract) and a few end-to-end tests on critical flows.
- **Quality gates**: coverage of new code, static analysis, duplication and technical debt (SonarQube), architecture rules (ArchUnit), vulnerabilities in dependencies and images.
- **Mutation testing** (PIT): it modifies the code and checks whether any test fails. It measures the real quality of the tests, not just whether the lines are executed.
- Automated performance tests to detect regressions.

**Before and during deployment**:

- Ephemeral environments per pull request to validate changes in isolation.
- Smoke tests after each deployment and canary deployments with automatic metric analysis.
- Feature flags to activate functionality gradually.

**In production**:

- Observability with **SLOs** and alerts based on the user experience (error rate and latency of the important endpoints).
- **Synthetic monitoring**: automated tests that periodically run critical flows against production.
- **Chaos engineering**: introducing controlled failures (latency, loss of instances or dependencies) to verify that resilience really works.
- Blameless postmortems and improvement actions: every incident should translate into a test, an alert or a design change.

**Test data management**: synthetic or anonymised data (never real personal data from production), generated reproducibly, and isolation between tests to avoid order dependencies.

Overall metrics: the **DORA metrics** (deployment frequency, lead time for changes, change failure rate and time to restore) relate quality to the team's delivery capability.

> **Interview tip.** If the position combines development and QA, this is the question where you can show a complete vision: quality as a process, not as a phase at the end.

## Q125 · How would you plan and run performance tests for a microservice?

*Topic: Performance · Level 7 · Expert*

**1. Define goals** before running anything: without goals, a performance test only produces numbers. For example: "the search endpoint must respond in under 300 ms at the 95th percentile with 500 requests per second, with an error rate below 0.1%". Ideally, derived from the SLOs and from real traffic (and its expected growth).

**2. Choose the type of test**:

- **Load**: expected traffic over a period; it verifies that the goals are met.
- **Stress**: increase the load up to the breaking point; it finds the limit and **how it fails** (does it degrade gracefully or collapse?).
- **Spike**: sudden increases; it verifies autoscaling and protection.
- **Soak**: moderate load for hours; it reveals memory leaks, connections that aren't released or progressive degradation.

**3. Tools**: **Gatling** (scenarios in Java, Scala or Kotlin, excellent reports), **k6** (JavaScript, easy to integrate into CI), **JMeter** (a veteran, with a graphical interface), Locust (Python).

```java
public class SearchSimulation extends Simulation {
    HttpProtocolBuilder http = http.baseUrl("https://staging.store.com");

    ScenarioBuilder search = scenario("Product search")
        .exec(http("search").get("/api/products?q=sneakers")
            .check(status().is(200)));

    {
        setUp(search.injectOpen(rampUsersPerSec(10).to(500).during(Duration.ofMinutes(5))))
            .protocols(http)
            .assertions(global().responseTime().percentile(95).lt(300),
                        global().failedRequests().percent().lt(0.1));
    }
}
```

**4. Environment and data**: as close to production as possible (instance size, data volume, configuration), with external dependencies simulated (WireMock) so as not to test other people's systems, and varied data so as not to measure only cache hits.

**5. Measure and interpret**: look at **percentiles** (p95, p99), not the average, which hides the users who are suffering; correlate with the service's metrics (CPU, GC, connection pool, threads, database) to find the bottleneck; take JVM warm-up into account (the JIT takes time to optimise) and discard the first few minutes.

**6. Automate**: a reduced performance test in the pipeline detects regressions in every version; big tests are scheduled periodically or before known traffic events.

A classic mistake when using closed-model tools (a fixed number of virtual users waiting for each response) is **coordinated omission**: when the system slows down, the generator sends fewer requests and the results look better than they are. Open models (arrivals per second), like the one in the example, avoid it.

# Part II · Deep dives

Three chapters dedicated to technologies present in most microservices development positions. Within each chapter, the questions go from easier to harder.

# Deep Dive A · Apache Kafka in depth

Concepts, producers and consumers, Spring integration, error handling, topic design, delivery guarantees, schemas, ecosystem and operations.

This chapter contains 12 questions.

## Q126 · What are the fundamental concepts of Apache Kafka?

*Topic: Kafka · Concepts · Deep Dive A*

Kafka is a distributed **event streaming** platform. Its central abstraction is a **log**: an ordered, immutable, persistent sequence of records to which data is only appended at the end.

- **Record**: the unit of data. It has a **key** (optional), a **value**, headers and a timestamp.
- **Topic**: a logical category of records (`orders`, `payments`). It is the equivalent of a table or a named queue.
- **Partition**: each topic is divided into partitions, which are the actual logs. They are the unit of **parallelism** (more partitions, more consumers in parallel) and of **ordering** (order is only guaranteed within a partition).
- **Offset**: the position of a record within its partition. Each consumer group stores up to which offset it has processed.
- **Broker**: a Kafka server. A **cluster** has several brokers, among which the partitions are distributed.
- **Replicas**: each partition is replicated on several brokers (the replication factor, usually 3). One replica is the **leader**, which handles writes and reads; the others are **followers**. The set of replicas in sync with the leader is the **ISR** (*in-sync replicas*). If the leader goes down, another one is elected from the ISR.
- **Producer**: publishes records. With a key, the partition is chosen by hashing the key: all records with the same key go to the same partition and keep their order.
- **Consumer** and **consumer group**: the consumers in the same group share out the partitions (each partition is read by a single consumer in the group). Different groups read the topic independently, each with its own offsets: that is how several services consume the same events without interfering.
- **Retention**: records are kept for a configured time or size, **even if they have already been read**. That allows reprocessing (*replay*) and new consumers to join.

About cluster coordination: historically Kafka depended on **ZooKeeper** for metadata. **KRaft** mode (Raft consensus built into Kafka) replaces it, and since **Kafka 4.0** ZooKeeper has been removed completely.

The key difference from a traditional queue: in a queue, the message disappears when consumed and is shared out among consumers; in Kafka, the message remains and each group keeps its own read position.

> **Interview tip.** Mastering the relationship between partitions, ordering and parallelism is the foundation for all the Kafka questions that follow.

## Q127 · Which Kafka producer settings matter for reliability and performance?

*Topic: Kafka · Producer · Deep Dive A*

**Reliability**:

- `acks`: how many acknowledgements the producer waits for. `0` (none: fast, may lose data), `1` (only the leader: lost if the leader goes down before replicating) or `all` (all replicas in the ISR). Since Kafka 3.0, the default value is `all`.
- `min.insync.replicas` (topic or broker setting): with `acks=all`, the minimum number of in-sync replicas required to accept writes. The usual combination is **replication factor 3, `min.insync.replicas=2` and `acks=all`**: it tolerates the loss of one broker without losing data or availability.
- `enable.idempotence=true` (the default since Kafka 3.0): the broker discards duplicates caused by producer retries, using a producer identifier and sequence numbers. It also guarantees ordering within the partition even with retries.
- `retries` and `delivery.timeout.ms`: the producer automatically retries transient errors until the total delivery time runs out.

**Performance**:

- `linger.ms`: how long the producer waits to group records into a batch. A small value (5-20 ms) greatly increases throughput at the cost of minimal latency.
- `batch.size`: the maximum batch size per partition.
- `compression.type`: `lz4`, `zstd`, `snappy` or `gzip`. It compresses entire batches; it reduces network and disk usage.
- `buffer.memory`: memory for records waiting to be sent.

**Key and partitioning**: the choice of key is a design decision. With `orderId` as the key, all the events of an order are processed in order. A key with a poor distribution (for example, the country, if 80% of the traffic comes from one country) creates **hot partitions**. Without a key, records are spread across partitions (with the *sticky* partitioner, in batches).

In Spring Kafka, sending is asynchronous and returns a `CompletableFuture`:

```java
kafkaTemplate.send("orders", order.id().toString(), event)
    .whenComplete((result, error) -> {
        if (error != null) {
            log.error("Could not publish the event for order {}", order.id(), error);
        } else {
            log.debug("Published to partition {} offset {}",
                result.getRecordMetadata().partition(),
                result.getRecordMetadata().offset());
        }
    });
```

A classic mistake is ignoring the result of the send: if it fails after exhausting the retries, the event is silently lost. For strong guarantees together with the database, the Outbox pattern is used.

## Q128 · How does the Kafka consumer work? What is offset committing and what is a rebalance?

*Topic: Kafka · Consumer · Deep Dive A*

The consumer works with a **poll loop**: it asks the broker for records (`poll()`), processes them and **commits** the offset it has reached. If the consumer restarts, it continues from the last committed offset.

The moment of the commit determines the delivery guarantee:

- **Commit before processing**: if the consumer goes down during processing, those records are not read again → *at-most-once* (they may be lost).
- **Commit after processing**: if it goes down after processing and before the commit, those records are read again → *at-least-once* (they may be duplicated). **This is the usual option**, combined with idempotent consumers.

Kafka's automatic commit (`enable.auto.commit=true`) periodically commits the latest records received in `poll`, regardless of whether they have been processed, which can lose messages. **Spring Kafka disables auto-commit** and manages the commit itself according to the container's `AckMode`: `BATCH` by default (it commits after processing all the records from a `poll`); also `RECORD`, `MANUAL` or `MANUAL_IMMEDIATE` (the listener commits explicitly with an `Acknowledgment`).

`auto.offset.reset` decides what to do when a group has no stored offset (the first time): `earliest` (read from the beginning) or `latest` (only new records, Kafka's default). Spring Boot doesn't change this value, so a new service that should process the history needs `earliest`.

**Rebalance**: when a consumer joins or leaves the group (deployments, scaling, failures), the partitions are reassigned among the active consumers. During a classic rebalance, the group briefly stops consuming. Causes of unwanted rebalances:

- `max.poll.interval.ms` (5 minutes by default): if processing a batch takes longer than this between two `poll`s, Kafka considers the consumer dead and expels it from the group. Its records are reassigned and reprocessed, which can cause an infinite cycle. Solution: smaller batches (`max.poll.records`) or faster processing.
- `session.timeout.ms` and *heartbeats*: if the consumer doesn't send heartbeats (for example, because of a very long GC pause), it is also expelled.

Improvements to reduce the impact: **cooperative** assignment (`CooperativeStickyAssignor`, which only moves the necessary partitions), **static membership** (`group.instance.id`, which avoids rebalances on quick restarts) and the **new consumer group protocol** (KIP-848), generally available since Kafka 4.0, which moves coordination to the broker and makes rebalances incremental.

## Q129 · How is Kafka integrated into a Spring Boot application?

*Topic: Kafka · Spring · Deep Dive A*

With the `spring-kafka` dependency, Spring Boot auto-configures the `ProducerFactory`, the `ConsumerFactory`, the `KafkaTemplate` and the listener infrastructure from properties:

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
      group-id: shipping-service
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.springframework.kafka.support.serializer.ErrorHandlingDeserializer
      properties:
        spring.deserializer.value.delegate.class: org.springframework.kafka.support.serializer.JsonDeserializer
        spring.json.trusted.packages: "com.mycompany.events"
    listener:
      concurrency: 3
```

**Producing**:

```java
@Service
@RequiredArgsConstructor
public class EventPublisher {
    private final KafkaTemplate<String, Object> kafka;

    public void orderConfirmed(OrderConfirmed event) {
        kafka.send("orders.events", event.orderId().toString(), event);
    }
}
```

**Consuming**:

```java
@Component
public class OrdersListener {

    @KafkaListener(topics = "orders.events", groupId = "shipping-service")
    public void onEvent(OrderConfirmed event,
                        @Header(KafkaHeaders.RECEIVED_PARTITION) int partition,
                        @Header(KafkaHeaders.OFFSET) long offset) {
        shipping.prepareShipment(event);
    }
}
```

Important details:

- **`ErrorHandlingDeserializer`**: it wraps the real deserialiser. Without it, a message that can't be deserialised (a *poison pill*) causes an exception before reaching the listener, in an infinite loop, blocking the partition. With it, the error reaches the error handler and the message can be sent to the DLT.
- **Trusted packages** of the `JsonDeserializer`: for security, it only deserialises classes from authorised packages.
- **Type information**: by default, `JsonSerializer` adds a header with the Java class name. That couples the consumer to the producer's class; between different services it is preferable to disable it and have each consumer indicate its default type or use type mappings, or else to use Avro or Protobuf with Schema Registry.
- **`concurrency`**: the number of consumer threads per listener. It makes no sense to exceed the number of partitions of the topic: the extra consumers sit idle.
- Topic creation can be declared as `NewTopic` beans (useful in development), although in production it is usually managed with infrastructure as code.
- Spring Boot also offers Kafka integration through **Spring Cloud Stream**, a more abstract, function-based model (`Consumer<T>`, `Function<T, R>`) independent of the broker.

## Q130 · How are errors and retries handled when consuming from Kafka with Spring? What is a Dead Letter Topic?

*Topic: Kafka · Errors · Deep Dive A*

If a listener throws an exception, Spring Kafka delegates to the container's **`DefaultErrorHandler`**. By default it retries the record **9 times with no delay** (10 attempts in total) and, if it keeps failing, it logs it and **moves on to the next one**, that is, the message is discarded.

These retries are **blocking**: while retrying, the partition doesn't advance. For brief transient errors it is acceptable; for long errors, it delays all the messages in the partition.

**Usual configuration**: retries with exponential backoff and, once exhausted, sending to a **Dead Letter Topic (DLT)**, a topic where the messages that couldn't be processed are stored so they can be analysed and reprocessed later without blocking the main flow.

```java
@Bean
DefaultErrorHandler errorHandler(KafkaTemplate<Object, Object> template) {
    var recoverer = new DeadLetterPublishingRecoverer(template);   // publishes to <topic>-dlt
    var backoff = new ExponentialBackOffWithMaxRetries(4);
    backoff.setInitialInterval(1_000);
    backoff.setMultiplier(2.0);
    var handler = new DefaultErrorHandler(recoverer, backoff);
    handler.addNotRetryableExceptions(ValidationException.class,
                                      DeserializationException.class);
    return handler;
}
```

Classifying the exceptions is essential: a validation or deserialisation error will **never** be fixed by retrying, so it must go straight to the DLT.

**Non-blocking retries** with `@RetryableTopic`: the failed message is published to retry topics with increasing delays (`orders-retry-1000`, `orders-retry-2000`...) and finally to the DLT. The main partition keeps advancing in the meantime.

```java
@RetryableTopic(attempts = "4",
                backoff = @Backoff(delay = 1000, multiplier = 2.0),
                exclude = ValidationException.class)
@KafkaListener(topics = "orders")
public void process(OrderConfirmed event) { ... }

@DltHandler
public void onDlt(OrderConfirmed event, @Header(KafkaHeaders.EXCEPTION_MESSAGE) String error) {
    alerts.failedMessage(event, error);
}
```

The trade-off: with non-blocking retries **ordering is lost**, because later messages for the same order may be processed before the one being retried. If per-key ordering is critical, you have to use blocking retries or logic that detects and parks the subsequent messages with the same key.

Operating the DLT: monitor its size and alert on it, keep the source topic, partition, offset and exception in headers (the `DeadLetterPublishingRecoverer` does this automatically) and have a tool or procedure to reprocess the messages once the problem has been fixed.

> **Interview tip.** Mentioning that non-blocking retries break per-key ordering shows you understand the consequences, not just the configuration.

## Q131 · How are topics designed? How many partitions? One topic per event or per entity?

*Topic: Kafka · Design · Deep Dive A*

**Number of partitions**: it determines the maximum consumption parallelism (one consumer per partition in each group). The usual criterion: estimate the required throughput and what one consumer can process, and add a margin for growth, because **increasing partitions later changes the key assignment** (the hash of the key modulo the number of partitions) and breaks per-key ordering during the transition. Nor should you overdo it: many partitions increase broker resource consumption, recovery time and the duration of rebalances. For many business services, between 6 and 24 partitions is a reasonable range; it is adjusted with measurements.

**Replication factor**: 3 in production, with `min.insync.replicas=2`.

**Organisation of the events**:

- **One topic per event type** (`order-created`, `order-paid`, `order-cancelled`): simple schemas and consumers that subscribe only to what interests them, but **there is no ordering between event types** for the same entity: the consumer could see `order-cancelled` before `order-created`.
- **One topic per entity or aggregate** (`orders` with all its events, key `orderId`): the **order of all the events of each order is preserved**, which is what is normally needed. Consumers receive events they may not be interested in and ignore them. The topic contains several schemas (handled with unions in Avro or with the type in a header).

The practical rule: **events that need a relative order must go to the same topic with the same key**.

**Names**: follow a consistent convention, for example `<domain>.<entity>.<type>.v<version>` (`sales.orders.events.v1`), and avoid mixing dots and underscores (Kafka treats them as equivalent in metric names).

**Other decisions**:

- Retention according to use: days for integration events, indefinite with compaction for state topics.
- Separate **events** (facts published for anyone) from **commands** (directed at a specific service), usually in different topics.
- Define the **ownership** of each topic: a single producing service per event topic, which owns its schema.
- Manage topics as code (Terraform, operators such as Strimzi on Kubernetes, or versioned scripts) instead of letting applications create them in production.

## Q132 · What is exactly-once in Kafka and how do transactions work?

*Topic: Kafka · Guarantees · Deep Dive A*

Kafka offers **exactly-once semantics (EOS)** for the **consume → process → produce** pattern within Kafka. It relies on two mechanisms:

- **Idempotent producer**: it eliminates duplicates caused by the producer's own retries.
- **Transactions**: they allow writing to several topics and partitions **and committing the consumed offsets** atomically. Either all the records are published and the offsets advanced, or nothing happens. Consumers with `isolation.level=read_committed` only see records from committed transactions.

So, if a service reads a record from `orders`, publishes a record to `invoices` and fails before finishing, the transaction is aborted: the record in `invoices` will never be visible to `read_committed` consumers and the record from `orders` will be processed again.

In Spring Kafka it is enabled by configuring a transactional identifier prefix:

```yaml
spring:
  kafka:
    producer:
      transaction-id-prefix: billing-tx-
    consumer:
      isolation-level: read_committed
```

With this, the listener container starts a Kafka transaction for each consumed batch and commits the offsets within it. Everything the listener publishes with the `KafkaTemplate` is part of the same transaction.

**The fundamental limitation**: the guarantee only covers operations **within Kafka**. If the listener also writes to a database or calls an API, there is no atomic transaction between Kafka and those systems. Trying to coordinate a database transaction and a Kafka one (transaction synchronisation) only offers *best effort*: one commit can fail after the other has been committed.

That is why the practical recommendation for business services is:

- For **Kafka → database**: an **idempotent** consumer (deduplicating by event identifier in the same database transaction) with *at-least-once* delivery.
- For **database → Kafka**: the **Transactional Outbox** pattern with CDC or a publisher.
- Reserve Kafka transactions for purely Kafka → Kafka processing, such as **Kafka Streams** (which enables EOS with `processing.guarantee=exactly_once_v2`).

## Q133 · What is a Schema Registry and why use Avro or Protobuf instead of JSON?

*Topic: Kafka · Schemas · Deep Dive A*

With schemaless JSON, the contract between producer and consumers is implicit: if the producer renames a field, the consumers fail in production, and nothing prevents it. In addition, JSON is verbose (the name of each field is repeated in every message).

A **Schema Registry** (Confluent Schema Registry, Apicurio, AWS Glue Schema Registry) is a service that stores and versions message schemas:

- The producer registers (or looks up) the schema and sends in each message only a **schema identifier** together with the binary data.
- The consumer obtains the schema by its identifier (and caches it) to deserialise.
- The registry **validates the compatibility** of each new schema version according to a configured policy, **rejecting changes that would break consumers** before they reach production.

Compatibility modes:

- **BACKWARD** (the default in Confluent): consumers with the new schema can read data written with the previous one. It allows removing fields and adding fields **with a default value**. Consumers are upgraded first.
- **FORWARD**: consumers with the previous schema can read data from the new one. Producers are upgraded first.
- **FULL**: both at once.
- **TRANSITIVE** variants: compatibility is checked against all previous versions, not just the last one.

Formats:

- **Avro**: the most widespread in the Kafka ecosystem; schemas in JSON, compact binary, well-defined evolution rules (default values, unions with `null` for optional fields). Java class generation with the Maven or Gradle plugin.
- **Protobuf**: very efficient, excellent multi-language tooling, a good fit if gRPC is already used. Evolution is based on field numbers, which are never reused.
- **JSON Schema**: keeps JSON readable and adds validation, with less efficiency.

```json
{
  "type": "record",
  "name": "OrderConfirmed",
  "namespace": "com.mycompany.events",
  "fields": [
    { "name": "orderId", "type": "long" },
    { "name": "total",   "type": { "type": "bytes", "logicalType": "decimal", "precision": 12, "scale": 2 } },
    { "name": "channel", "type": ["null", "string"], "default": null }
  ]
}
```

Integration into the pipeline: the schemas live in the repository and their compatibility is checked against the registry in CI (Maven and Gradle plugins), so that an incompatible change fails in the pull request, not in production.

## Q134 · What are log retention and compaction in Kafka? What is a tombstone?

*Topic: Kafka · Storage · Deep Dive A*

Kafka offers two cleanup policies (`cleanup.policy`) for each topic:

**delete** (the default): records are deleted when they exceed the age limit (`retention.ms`, 7 days by default) or when the partition exceeds a size (`retention.bytes`). Deletion is done by whole log **segments**, not record by record, so data may remain somewhat longer than configured. Suitable for event streams where old data stops being of interest.

**compact**: Kafka guarantees to keep **at least the latest value for each key**. A background process (the *log cleaner*) removes old records for keys that have more recent values. The topic becomes a kind of table with the current state of each entity, which also keeps the recent history.

```text
Before compaction:      After compaction:
offset 0  k=A  v=1
offset 1  k=B  v=1
offset 2  k=A  v=2
offset 3  k=C  v=1      offset 3  k=C  v=1
offset 4  k=B  v=2      offset 4  k=B  v=2
offset 5  k=A  v=3      offset 5  k=A  v=3
```

Offsets don't change; the superseded records simply disappear.

Uses of compaction: **event-carried state transfer** (a new service rebuilds its local copy of, for example, the catalogue by reading the compacted topic from the beginning), Kafka's internal topics (`__consumer_offsets`), Kafka Streams state tables (`KTable`) and Kafka Connect's configuration and offsets.

A **tombstone** is a record with a key and a **null value**. It indicates that the entity has been deleted: after compaction, the key disappears completely (the tombstone is kept for a while, `delete.retention.ms`, so that consumers have a chance to see it). It is the way to delete data in a compacted topic, important for example for handling personal data deletion requests.

Both policies can be combined (`compact,delete`): it compacts and, in addition, deletes whatever exceeds the retention.

Related: **tiered storage** (generally available in recent versions of Kafka) moves old segments to cheaper object storage, which allows very long retention periods without expanding the brokers' disks.

## Q135 · What are Kafka Connect, Kafka Streams and Debezium? When would you use each one?

*Topic: Kafka · Ecosystem · Deep Dive A*

**Kafka Connect** is a framework for **moving data between Kafka and other systems** without writing code, through configurable connectors:

- **Source connectors**: read from an external system and publish to Kafka (databases, files, queues, APIs).
- **Sink connectors**: read from Kafka and write to an external system (Elasticsearch, object storage, data warehouses, databases).

It runs as a cluster of *workers* that manages parallelism, offsets and fault tolerance, and it supports simple per-record transformations (SMTs). Use cases: feeding a search index, dumping events into a data lake for analytics, integrating legacy systems.

**Debezium** is a set of Kafka Connect source connectors specialised in **Change Data Capture (CDC)**: they read the database's transaction log (PostgreSQL's WAL, MySQL's binlog, Oracle's redo log...) and publish each insert, update and delete as an event. It captures changes reliably, in order and without modifying the application or adding query load. It includes an **outbox router** that publishes the records of the outbox table to the appropriate topics. It is the usual piece for implementing the Transactional Outbox, and it is also used for migrations (Strangler Fig) and data replication.

**Kafka Streams** is a **Java library** (not a separate cluster) for building applications that process streams: filtering, transforming, enriching, aggregating by time windows and joining streams and tables. It manages local state (RocksDB, backed by Kafka topics to recover after failures), scales by adding instances and offers exactly-once. It integrates with Spring Boot through `@EnableKafkaStreams` or Spring Cloud Stream.

```java
@Bean
KStream<String, Order> salesByProduct(StreamsBuilder builder) {
    KStream<String, Order> orders = builder.stream("orders");
    orders
        .flatMapValues(Order::lines)
        .groupBy((key, line) -> line.productId())
        .windowedBy(TimeWindows.ofSizeWithNoGrace(Duration.ofMinutes(5)))
        .aggregate(() -> 0L, (product, line, total) -> total + line.quantity())
        .toStream()
        .to("sales-by-product-5m");
    return orders;
}
```

Use cases: real-time fraud detection, live business metrics, materialised views for CQRS, event enrichment.

**When to use each one**: Connect/Debezium to **integrate data** with external systems without code; Streams for **continuous processing logic** over the streams; a normal `@KafkaListener` to **react to events** with business logic that interacts with a service's database or APIs. Alternatives for larger-scale processing: Apache Flink.

## Q136 · How is Kafka monitored? What is consumer lag and why is it the most important metric?

*Topic: Kafka · Operations · Deep Dive A*

**Consumer lag** is the difference, per partition, between the last offset written to the topic and the last offset committed by a consumer group. It indicates **how many messages a consumer has pending**.

It is the most important metric from a service's point of view because:

- A steadily growing lag means that the consumer **can't keep up** (slow processing, too few consumers, a slow dependency) or that it is **stuck** (a poison pill, an error being retried endlessly, a consumer that keeps rebalancing).
- It translates directly into **business delay**: orders take longer to ship, notifications arrive late.
- It is better to alert on the **time lag** (the age of the oldest unprocessed message) than on the number of messages, because 10,000 messages may be one second in one topic and an hour in another.

Ways to obtain it: metrics from the consumer client itself exposed by Micrometer (`kafka.consumer.fetch.manager.records.lag.max` and similar), external tools that query the cluster such as **kafka-lag-exporter**, **Burrow** or **kminion**, or the dashboards of managed platforms.

Other relevant metrics:

- **Cluster**: under-replicated partitions (should be 0), offline partitions, number of active controllers (exactly 1), leader election rate, disk usage, latency of produce and fetch requests.
- **Producer**: error and retry rate, send latency, average batch size.
- **Consumer**: rebalance frequency, processing time per record, records sent to the DLT.

UI tools for exploring topics, messages and groups: **Kafka UI** (Provectus), **AKHQ**, **Redpanda Console**, **Conduktor**; on managed platforms (Confluent Cloud, Amazon MSK, Aiven), their own consoles. For deployments on Kubernetes, the **Strimzi** operator manages the cluster and exposes metrics for Prometheus.

**Scaling consumers** based on lag, rather than on CPU, is a very good use of **KEDA** on Kubernetes (within the limit of the number of partitions).

## Q137 · When would you not use Kafka? What alternatives exist?

*Topic: Kafka · Comparison · Deep Dive A*

Kafka is very powerful, but it is not the answer to everything:

- **Classic work queues** (distributing tasks among workers, with per-message retries and delays, priorities, individual messages that are acknowledged or rejected): **RabbitMQ**, Amazon SQS or the cloud provider's queues are a more natural fit. Kafka commits offsets per partition, not individual messages, and a slow message blocks the partition. Kafka is adding queue semantics (**share groups**, KIP-932, introduced in 4.x versions) to cover part of this case, but it is worth checking their maturity in the specific version.
- **Synchronous request-response**: if the caller needs the answer immediately, HTTP or gRPC are simpler. Building request/reply on Kafka is possible (`ReplyingKafkaTemplate`) but it adds latency and complexity.
- **Low volumes and small teams**: operating a Kafka cluster has a real cost. For a few events, an outbox with a table and a publisher, or a simple managed service, may be enough. If Kafka is used, the managed version (Confluent Cloud, Amazon MSK, Aiven) removes much of the operational burden.
- **Complex content-based routing** or per-message priorities: RabbitMQ does it natively with exchanges.
- **Very large messages** (files, videos): they are stored in object storage and only the reference is sent through Kafka (*claim check pattern*).

Alternatives and complements:

- **RabbitMQ**: a mature AMQP broker, with flexible routing; its *streams* (since version 3.9) offer a Kafka-style persistent log.
- **Apache Pulsar**: separates compute and storage (BookKeeper), native multi-tenancy, supports queues and streams; more complex to operate.
- **Redpanda**: compatible with the Kafka API, implemented in C++ without a JVM, with an emphasis on low latency and operational simplicity.
- **NATS / JetStream**: lightweight and very fast, popular in cloud-native and edge environments.
- **Cloud services**: Amazon SQS/SNS/EventBridge/Kinesis, Google Pub/Sub, Azure Service Bus/Event Hubs.

The mature answer in an interview is to choose according to the requirements (volume, ordering, retention, replay, consumption patterns, the team's operational capacity), not according to fashion.

# Deep Dive B · Docker and Kubernetes for Spring Boot developers

Containers and images, building images for Spring Boot, local development with Compose, Kubernetes objects, deployment, scaling, diagnostics and security.

This chapter contains 10 questions.

## Q138 · What is a container and how does it differ from a virtual machine? What are images and their layers?

*Topic: Docker · Concepts · Deep Dive B*

A **virtual machine** virtualises the hardware: each VM runs its own complete operating system on top of a hypervisor. Strong isolation, but startups take minutes and resource consumption is considerable.

A **container** virtualises the operating system: it is a normal host process isolated through Linux kernel features:

- **Namespaces**: isolate what the process sees (processes, network, file system, users, hostname).
- **cgroups**: limit what the process can use (CPU, memory, I/O).

All containers share the host's kernel, so they start in milliseconds or seconds and take up much less space. Isolation is weaker than a VM's, which matters in hostile multi-tenant environments (that is what runtimes with more isolation, such as gVisor or Kata Containers, are for).

An **image** is the read-only template from which containers are created. It is made up of stacked **layers**: each Dockerfile instruction that modifies the file system (`RUN`, `COPY`, `ADD`) creates a new layer that records only the differences. When a container runs, a thin writable layer is added on top, which disappears with the container.

Practical consequences of layers:

- **Build cache**: if a layer hasn't changed (nor any previous one), Docker reuses it. That is why the things that change rarely (dependencies) are copied first and those that change often (the code) last. If the whole jar is copied in a single layer, any one-line change forces you to upload the tens of megabytes of dependencies again.
- **Sharing**: several images with the same base image share those layers on disk and in the registry.
- Deleting a file in a later layer **does not reduce** the image size (it is still in the earlier layer); that is why cleanup is done in the same `RUN` instruction or multi-stage builds are used.

Images follow the **OCI** standard and are identified by name and tag (`registry/store/orders:1.4.2`) or, immutably, by their *digest* (`@sha256:...`). In production it is advisable to deploy by immutable tag or by digest, never by `latest`.

## Q139 · How would you write a Dockerfile for a Spring Boot application following good practices?

*Topic: Docker · Images · Deep Dive B*

A multi-stage Dockerfile that takes advantage of the Spring Boot jar's layers:

```dockerfile
# ---------- Stage 1: build ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace
COPY mvnw pom.xml ./
COPY .mvn .mvn
RUN ./mvnw -B dependency:go-offline          # cacheable dependency layer
COPY src src
RUN ./mvnw -B package -DskipTests

# ---------- Stage 2: layer extraction ----------
FROM eclipse-temurin:21-jre AS layers
WORKDIR /app
COPY --from=build /workspace/target/*.jar app.jar
RUN java -Djarmode=tools -jar app.jar extract --layers --launcher --destination extracted

# ---------- Stage 3: final image ----------
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

Good practices it reflects:

- **Multi-stage**: the final image doesn't contain the JDK, Maven or the source code; only a **JRE** and the application. Smaller size and a smaller attack surface.
- **Layers ordered by frequency of change**: dependencies (almost never change), loader, snapshots and, at the end, the application code. A new version only uploads a few kilobytes or megabytes.
- **Non-root user**: if someone compromises the application, they don't get root privileges inside the container.
- **ENTRYPOINT in exec form** (JSON array): Java runs as **PID 1** and receives the signals (`SIGTERM`) directly, which allows an orderly shutdown. In shell form (`ENTRYPOINT java -jar ...` without brackets), PID 1 is `sh`, which doesn't forward signals, and the container ends up being forcibly killed after the grace period.
- JVM options via an environment variable (`JAVA_TOOL_OPTIONS`), which can be overridden in each environment.
- **Pinned base image versions** (ideally by digest), regularly updated to receive security patches.
- A **`.dockerignore`** file so as not to send `target/`, `.git` or local files to the build context.

Many teams build the jar in the CI pipeline and use only the last two stages, so as not to compile twice. Other options without a Dockerfile: **buildpacks** (`spring-boot:build-image`) and **Jib**.

To shrink the image even further: **distroless** or *chiseled* base images (no shell or package manager) and a custom JRE built with `jlink` that includes only the JDK modules needed.

> **Interview tip.** Explaining why the ENTRYPOINT must be in exec form (signals and PID 1) is a detail almost nobody mentions and it shows real experience with containers.

## Q140 · What alternatives to the Dockerfile exist for building Spring Boot images? Buildpacks and Jib.

*Topic: Docker · Images · Deep Dive B*

**Cloud Native Buildpacks** (Paketo in the case of Spring Boot): they analyse the application and build the image following good practices without needing a Dockerfile.

```bash
./mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=registry/store/orders:1.4.2
```

- They detect the Java version, add a JRE, split the jar into layers, automatically calculate the JVM memory configuration according to the container's limit and run as a non-root user.
- They allow **rebase**: updating the base image (for example, for an operating system security patch) without rebuilding the application.
- They support CDS and native compilation with GraalVM through options.
- Trade-offs: less fine-grained control, dependence on the chosen *builder*, and they need a Docker (or compatible) daemon during the build.

**Jib** (from Google): a Maven and Gradle plugin that builds the image **without Docker** and without a Dockerfile, directly from the build.

```bash
./mvnw compile jib:build -Dimage=registry/store/orders:1.4.2
```

- It automatically separates dependencies, resources and classes into different layers.
- It doesn't need a Docker daemon, which simplifies the CI pipeline (no need for Docker-in-Docker or privileges).
- **Reproducible** builds: same code, same image digest.
- Trade-offs: designed specifically for Java applications; more limited operating system customisation.

**How to choose**:

- Dockerfile: maximum control and transparency, valid for any stack; it requires maintaining good practices manually.
- Buildpacks: good practices by default and convenient base patches; very well integrated with Spring Boot.
- Jib: fast builds without Docker in CI.

In all cases it is advisable to complete the process with **vulnerability scanning** (Trivy, Grype), generating an **SBOM** (the list of components in the image) and **signing** the image (Sigstore cosign) so that its provenance can be verified before deploying.

## Q141 · How would you use Docker Compose when developing microservices with Spring Boot?

*Topic: Docker · Development · Deep Dive B*

**Docker Compose** defines and runs multi-container applications with a YAML file. In development it is ideal for starting the infrastructure a service needs (database, Kafka, Redis, a Keycloak, an observability stack) with a single command.

```yaml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: orders
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

  orders:
    build: .
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/orders
      SPRING_KAFKA_BOOTSTRAP_SERVERS: kafka:9092
    depends_on:
      postgres:
        condition: service_healthy
    ports: ["8080:8080"]

volumes:
  pgdata:
```

Important details:

- Services communicate by **service name** on Compose's internal network (`postgres:5432`), not via `localhost`: inside a container, `localhost` is the container itself.
- `depends_on` on its own waits for the container to **start**, not for it to be **ready**. With `condition: service_healthy` and a `healthcheck`, it waits until the dependency responds.
- **Named volumes** keep data between restarts; `docker compose down -v` deletes them.
- Kafka is a special case: clients receive the advertised addresses (`advertised.listeners`) from the broker, and they must be reachable from wherever the client runs (the host or the Compose network). It is a classic source of connection errors.

**Integration with Spring Boot** (3.1+): with the `spring-boot-docker-compose` dependency, when you start the application from the IDE, Boot detects the `compose.yaml`, starts the containers, waits until they are ready and **automatically configures the connections** (the database URL, username and password, Kafka servers...), with no manual properties. When the application stops, it can stop them.

A similar alternative: using **Testcontainers at development time** (`SpringApplication.from(App::main).with(ContainersConfig.class).run(args)`), reusing the same container definitions as in the tests.

Compose is also useful for demo environments or local end-to-end tests with several services, but in production the usual choice is Kubernetes or a managed platform.

## Q142 · What are the basic Kubernetes objects a developer needs to know?

*Topic: Kubernetes · Concepts · Deep Dive B*

Kubernetes is a container orchestrator: you declare the **desired state** to it and its controllers work continuously to make the actual state match (reconciliation).

- **Pod**: the smallest deployment unit. One or more containers that share network (the same IP) and volumes. They are ephemeral: they can disappear and be replaced by others with a different IP. They are almost never created directly.
- **Deployment**: manages a set of identical stateless pods (number of replicas, pod template, update strategy). Underneath it creates **ReplicaSets**; each version of the deployment has its own, which allows rollback.
- **Service**: a stable DNS name and address that load-balances traffic among the pods matching a label selector. Types: `ClusterIP` (internal, the most common), `NodePort`, `LoadBalancer` (exposes it through the cloud provider's load balancer) and `Headless` (no virtual IP, it resolves to the pods' IPs).
- **Ingress** (and its evolution, the **Gateway API**): HTTP routing rules from outside the cluster to the Services (by host and path), with TLS termination. It requires a controller (NGINX, Traefik, the cloud provider's...).
- **ConfigMap** and **Secret**: configuration and sensitive data injected as environment variables or files. Secrets are only base64-encoded, not encrypted, unless encryption at rest is enabled; in practice they are integrated with external managers (External Secrets Operator, Vault).
- **Namespace**: a logical grouping to separate teams, applications or environments, with their own quotas and permissions.
- **StatefulSet**: for stateful applications (databases, Kafka) that need a stable identity (`kafka-0`, `kafka-1`) and their own persistent storage per replica.
- **PersistentVolume** and **PersistentVolumeClaim**: storage that survives pods.
- **Job** and **CronJob**: tasks that run to completion, once or on a schedule (a good alternative to `@Scheduled` with several replicas).
- **DaemonSet**: one pod per node (log or monitoring agents).
- **HorizontalPodAutoscaler**: adjusts the number of replicas according to metrics.
- **ServiceAccount**, **Role** and **RoleBinding**: identity and permissions (RBAC) within the cluster.

Basic commands: `kubectl get pods`, `kubectl describe pod <name>`, `kubectl logs -f <pod>`, `kubectl apply -f <file>`, `kubectl rollout status deployment/<name>`, `kubectl rollout undo deployment/<name>`, `kubectl port-forward svc/<name> 8080:80`.

## Q143 · What would a production-ready Kubernetes manifest for a Spring Boot microservice look like?

*Topic: Kubernetes · Deployment · Deep Dive B*

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: orders
  labels: { app: orders }
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate: { maxSurge: 1, maxUnavailable: 0 }
  selector:
    matchLabels: { app: orders }
  template:
    metadata:
      labels: { app: orders }
    spec:
      terminationGracePeriodSeconds: 45
      securityContext:
        runAsNonRoot: true
      containers:
        - name: orders
          image: registry.mycompany.com/store/orders:1.4.2
          ports:
            - containerPort: 8080
          env:
            - name: SPRING_PROFILES_ACTIVE
              value: prod
            - name: SPRING_DATASOURCE_PASSWORD
              valueFrom:
                secretKeyRef: { name: orders-db, key: password }
          envFrom:
            - configMapRef: { name: orders-config }
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
  name: orders
spec:
  selector: { app: orders }
  ports:
    - port: 80
      targetPort: 8080
```

Decisions you should be able to justify:

- **`maxUnavailable: 0`**: during deployment there are never fewer ready replicas than desired.
- **Three probes**: `startupProbe` protects the startup (up to 150 seconds here) without having to make the liveness probe very permissive; **liveness** restarts the container if it gets stuck; **readiness** removes it from the Service while it can't serve.
- **Orderly shutdown**: when Kubernetes deletes a pod, in parallel it removes it from the Service's endpoints and sends it `SIGTERM`. The `preStop` of a few seconds gives the load balancers time to stop sending it traffic before the application starts shutting down; then Spring Boot's graceful shutdown finishes the in-flight requests. `terminationGracePeriodSeconds` must cover both. (The `sleep` action in `preStop` is native in recent versions of Kubernetes; before, an `exec` with `sleep` was used, which requires that binary to be in the image.)
- **Resources**: memory `requests` equal to the limit for predictable JVM behaviour; CPU limit omitted to avoid *throttling*, a common practice (although it depends on each organisation's policy).
- **Secrets** from a `Secret`, not in the ConfigMap or the image.
- **Security**: non-root user, no privilege escalation and a read-only file system, with an `emptyDir` at `/tmp` because Tomcat and other libraries need to write temporary files.

Usual complements: a **PodDisruptionBudget** (`minAvailable: 2`) so that node maintenance doesn't take down all the replicas, **anti-affinity** rules or `topologySpreadConstraints` to spread the replicas across nodes and zones, a **HorizontalPodAutoscaler** and **NetworkPolicies** to limit which services can talk to which.

## Q144 · What are Helm and Kustomize? How are differences between environments managed?

*Topic: Kubernetes · Tooling · Deep Dive B*

Maintaining almost identical YAML manifests for development, staging and production separately leads to duplication and accidental differences. Two tools solve the problem with different approaches:

**Helm** is a package manager for Kubernetes based on **templates**. A *chart* contains manifest templates with variables (Go template syntax) and a `values.yaml` file with the default values. Each environment provides its own values file.

```yaml
# templates/deployment.yaml (excerpt)
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
helm upgrade --install orders ./chart -f values-prod.yaml --set image.tag=1.4.2
```

- For: very powerful, it manages release versions and rollback, and there is a huge ecosystem of public charts for installing infrastructure (Kafka, PostgreSQL, Prometheus, ingress controllers...).
- Against: complex templates are hard to read and debug; template logic is mixed with YAML.

**Kustomize** (built into `kubectl apply -k`) uses **overlays** without templates: a **base** with valid YAML manifests and per-environment **overlays** that apply patches.

```text
k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── overlays/
    ├── staging/kustomization.yaml    (1 replica, staging image)
    └── prod/
        ├── kustomization.yaml        (3 replicas, larger resources)
        └── patch-resources.yaml
```

- For: pure, readable YAML, with no template language; very suitable for your own applications.
- Against: less expressive for complex parameterisation; it doesn't manage the release lifecycle.

In practice it is common to use **Helm to install third-party software** and **Kustomize (or simple Helm) for your own services**. Both fit with **GitOps**: Argo CD and Flux can render Helm charts and Kustomize overlays from a Git repository and apply them to the cluster.

Good practice: the difference between environments should be **only configuration** (replicas, resources, URLs, secrets), never the image: the same image tested in staging is the one that reaches production.

## Q145 · How do you autoscale a microservice on Kubernetes? HPA, VPA and KEDA.

*Topic: Kubernetes · Scaling · Deep Dive B*

**HorizontalPodAutoscaler (HPA)**: adjusts the number of replicas of a Deployment according to metrics. By default it uses CPU or memory (through the Metrics Server), comparing usage with the container's `requests`.

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: orders
spec:
  scaleTargetRef: { apiVersion: apps/v1, kind: Deployment, name: orders }
  minReplicas: 3
  maxReplicas: 20
  metrics:
    - type: Resource
      resource:
        name: cpu
        target: { type: Utilization, averageUtilization: 65 }
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300    # avoids scaling up and down continuously
```

Considerations for Java services:

- **Memory is not a good scaling metric** for the JVM: the heap tends to grow up to its limit and the GC doesn't necessarily return it to the system, so memory usage doesn't reflect the load.
- CPU during **startup** is very high (JIT compilation, Spring initialisation), which can cause cascading scale-ups if new pods are created at the same time. Stabilisation windows and a good `startupProbe` help.
- Scaling takes time: detection, pod scheduling, image download and application startup. For predictable peaks it is better to scale in advance or on a schedule.

**Custom or external metrics**: the HPA can use business metrics (requests per second, latency, queue length) through adapters such as Prometheus Adapter.

**KEDA** (Kubernetes Event-Driven Autoscaling) simplifies event-based scaling with *scalers* for dozens of sources: **Kafka consumer lag**, RabbitMQ or SQS queue length, Prometheus queries, cron. It also allows **scaling to zero** replicas when there is no work. For a Kafka consumer it is the most natural way to scale: more lag, more consumers (up to the number of partitions).

**VerticalPodAutoscaler (VPA)**: adjusts the containers' `requests` and `limits` according to historical usage. Useful above all in recommendation mode for sizing correctly; in automatic mode it recreates the pods to apply changes and it must not be combined with an HPA based on the same metric.

**Cluster Autoscaler** or **Karpenter**: add or remove cluster **nodes** when there are pods that don't fit or under-used nodes. Scaling pods without scaling nodes ends in pending pods.

## Q146 · A pod is in CrashLoopBackOff. How do you diagnose it? What other problematic states do you know?

*Topic: Kubernetes · Operations · Deep Dive B*

**CrashLoopBackOff** means that the container starts, terminates (with an error) and Kubernetes restarts it over and over, with increasing waits between attempts.

Diagnosis process:

- `kubectl describe pod <pod>`: shows the **events** (probe failures, lack of resources, problems mounting volumes) and, in `Last State`, the **reason and exit code** of the last termination.
- `kubectl logs <pod> --previous`: the logs of the **previous** container, the one that failed (without `--previous` you see those of the current attempt, which may not have written anything yet).
- Interpret the exit code: `1` is usually an application error (an exception at startup: missing configuration, unreachable database, a bean that can't be created); **`137`** indicates that the process was killed with `SIGKILL`, normally because of **OOMKilled** (it exceeded the memory limit) or because it didn't terminate in time; `143` is a termination with `SIGTERM`.

Typical causes in Spring Boot: missing properties or secrets, connection errors with dependencies at startup, failing Flyway migrations, **overly aggressive liveness probes** that kill the application before it finishes starting, and insufficient memory limits for the JVM.

Other common states:

- **ImagePullBackOff / ErrImagePull**: the image can't be downloaded: wrong name or tag, a private registry without credentials (`imagePullSecrets`) or without network access.
- **Pending**: the pod can't be scheduled on any node: requested resources that don't fit, impossible affinity constraints or a persistent volume that can't be bound. `kubectl describe` shows the reason.
- **OOMKilled**: the container exceeded its memory limit. Review the heap configuration against the limit, off-heap consumption or memory leaks.
- **Running but not ready** (`READY 0/1`): the readiness probe fails; the pod receives no traffic.
- **CreateContainerConfigError**: usually indicates that a referenced ConfigMap or Secret is missing.
- **Evicted**: the node ran out of resources (memory, disk) and evicted the pod.

Useful tools: `kubectl get events --sort-by=.lastTimestamp`, `kubectl exec -it <pod> -- sh` (if the image has a shell), **ephemeral debug containers** (`kubectl debug -it <pod> --image=busybox --target=<container>`, essential with distroless images), `kubectl top pod` for real consumption, and interfaces such as **k9s** or Lens.

> **Interview tip.** Remembering --previous in kubectl logs and the meaning of exit code 137 is exactly the kind of practical detail they look for in interviews with a platform component.

## Q147 · What security good practices would you apply to containers and Kubernetes deployments?

*Topic: Kubernetes · Security · Deep Dive B*

**In the image**:

- Minimal (JRE, distroless), up-to-date base images; fewer packages mean fewer vulnerabilities.
- Vulnerability **scanning** in CI (Trivy, Grype, the registry's scanner) and a remediation policy according to severity.
- Never include secrets in the image (not in intermediate layers or in the Dockerfile's `ENV` variables either): anyone with access to the image can extract them.
- Sign the images and generate the SBOM; in the cluster, admit only signed images from trusted registries (admission policies with Kyverno or OPA Gatekeeper).

**In the pod** (`securityContext`):

- `runAsNonRoot: true` and an unprivileged user.
- `allowPrivilegeEscalation: false`, drop unnecessary Linux *capabilities* (`drop: ["ALL"]`).
- `readOnlyRootFilesystem: true`, with `emptyDir` volumes only where writing is needed.
- Never `privileged` containers for applications.
- The **Pod Security Standards** (`restricted`) applied per namespace enforce these rules.

**In the cluster**:

- **RBAC** with least privilege; applications normally don't need access to the Kubernetes API, so automatic mounting of the ServiceAccount token is disabled (`automountServiceAccountToken: false`).
- **NetworkPolicies**: by default, any pod can communicate with any other. With a default-deny policy and explicit rules, a compromised service can't reach another service's database.
- **Secrets**: encryption at rest in etcd and integration with external managers (Vault, Secrets Manager, Key Vault) through External Secrets Operator or the CSI Secrets Store driver; periodic rotation.
- **mTLS** between services with a service mesh when internal encryption and service identity are required.
- *Workload identity* to access cloud services without static credentials.

**In the application**: up-to-date, analysed dependencies, input validation, Actuator not exposed publicly, security headers and logs without sensitive data.

The principle that sums it all up is **defence in depth**: assume that some layer will fail and that the others must limit the damage.

# Deep Dive C · Observability and monitoring

Golden signals, Prometheus, Micrometer, Grafana, alerts and SLOs, centralised logs, distributed tracing, OpenTelemetry, commercial platforms and signal correlation.

This chapter contains 11 questions.

## Q148 · What is the difference between monitoring and observability? What are the golden signals?

*Topic: Observability · Concepts · Deep Dive C*

**Monitoring** is watching indicators known in advance to detect known problems: "alert me if CPU exceeds 90%" or "if the health endpoint fails". It answers questions you already knew you had to ask.

**Observability** is the ability to understand **what is happening inside the system from its outputs**, even for new problems nobody anticipated: "why have payments from customers in one country using cards from a particular bank been taking 4 seconds since Tuesday?". It requires rich, correlated telemetry with enough context (logs, metrics and traces with useful attributes) to be able to ask new questions without deploying new code.

In microservices, observability is essential: a request crosses many services and a failure in any one of them shows up as a symptom in another.

The **four golden signals**, popularised by Google's SRE book, are the starting point for watching any user-facing service:

- **Latency**: how long requests take, in percentiles (p50, p95, p99), distinguishing between successful and failed ones (a fast error can mask bad latency).
- **Traffic**: how much demand the service receives (requests per second, messages per second).
- **Errors**: the rate of failed requests, both explicit (5xx) and implicit (wrong responses, or responses too slow according to the service agreement).
- **Saturation**: how close the service is to its capacity (connection pool usage, internal queues, busy threads, CPU, memory). It usually anticipates problems.

Equivalent methods: **RED** (Rate, Errors, Duration) for services, and **USE** (Utilization, Saturation, Errors) for resources such as CPU, memory, disk or pools.

With Spring Boot Actuator and Micrometer, most of these metrics are obtained without code: `http.server.requests` (with URI, method, status and outcome tags) gives the traffic, errors and latency of each endpoint; the HikariCP, Tomcat and JVM metrics cover saturation.

## Q149 · How does Prometheus work and what types of metrics exist?

*Topic: Observability · Prometheus · Deep Dive C*

**Prometheus** is the reference monitoring system in the cloud-native ecosystem. Main characteristics:

- **Pull model**: Prometheus periodically *scrapes* an HTTP endpoint of each application that exposes its metrics in text format. In Spring Boot, `/actuator/prometheus` with the `micrometer-registry-prometheus` dependency.
- **Target discovery**: on Kubernetes it automatically discovers the pods and services to scrape (often through the **Prometheus Operator** and `ServiceMonitor` or `PodMonitor` resources).
- **Time-series database**: each series is identified by the metric name and a set of **labels**: `http_server_requests_seconds_count{uri="/api/orders", method="GET", status="200"}`.
- **PromQL** for querying and aggregating, and **alerting** rules evaluated by Prometheus and sent to **Alertmanager**, which groups, silences and routes them (email, Slack, PagerDuty, Opsgenie).

Types of metrics:

- **Counter**: a value that only increases (it resets when the process restarts). Total requests, total errors, bytes sent. Its absolute value is never used, but rather its rate of change with `rate()`.
- **Gauge**: a value that goes up and down. Active connections, memory used, queue size, temperature.
- **Histogram**: counts observations in predefined **buckets**, as well as their sum and count. It allows percentiles to be calculated **by aggregating across instances** with `histogram_quantile()`. It is the right type for latencies.
- **Summary**: calculates the percentiles in the application itself. More precise for one instance, but **percentiles can't be aggregated** across instances (the average of three pods' p99s is not the global p99). That is why histograms are preferred in microservices.

In Micrometer, for a `Timer` to publish histograms, they have to be enabled:

```yaml
management:
  endpoints.web.exposure.include: health,info,prometheus
  metrics:
    distribution:
      percentiles-histogram:
        http.server.requests: true
    tags:
      application: ${spring.application.name}
      environment: ${ENVIRONMENT:local}
```

Prometheus's limitations: it is designed for short- or medium-term local retention and a single instance. For high availability, long retention and a global view across several clusters, **Thanos**, **Grafana Mimir**, **Cortex** or **VictoriaMetrics** are used. For short-lived processes (jobs) that don't live long enough to be scraped there is the **Pushgateway**, or the metrics are sent via OTLP.

## Q150 · How do you create custom business metrics with Micrometer? What is cardinality and why does it matter?

*Topic: Observability · Micrometer · Deep Dive C*

**Micrometer** is Spring's metrics facade (the "SLF4J of metrics"): the code is instrumented once and the metrics are exported to whichever system is configured (Prometheus, Datadog, New Relic, OTLP, CloudWatch...).

Technical metrics come out of the box, but the most valuable ones are usually **business** metrics: orders created, amount invoiced, payments rejected by reason, time to confirmation.

```java
@Service
public class OrderService {
    private final Counter ordersCreated;
    private final Timer confirmationTime;
    private final MeterRegistry registry;

    public OrderService(MeterRegistry registry) {
        this.registry = registry;
        this.ordersCreated = Counter.builder("store.orders.created")
            .description("Orders created")
            .register(registry);
        this.confirmationTime = Timer.builder("store.orders.confirmation")
            .publishPercentileHistogram()
            .register(registry);
    }

    public void paymentRejected(String reason) {
        registry.counter("store.payments.rejected", "reason", reason).increment();
    }

    public Order confirm(Long id) {
        return confirmationTime.record(() -> confirmInternal(id));
    }
}
```

More declarative alternatives: `@Timed` and `@Counted` (they require registering the corresponding aspect) or the **Observation API** with `@Observed`, which generates both a metric and a trace span.

For gauges, you register a function that Micrometer calls when publishing: `Gauge.builder("store.queue.pending", queue, Queue::size).register(registry)`. Micrometer keeps a weak reference to the observed object: if nothing else references it, the gauge disappears, a surprising and frequent mistake.

**Cardinality**: each distinct combination of label values creates a **new time series**. With the labels `method` (5 values) × `uri` (40) × `status` (10) there are already 2,000 series per instance. If you add a label with **unbounded values** (user identifier, order identifier, email, URL with parameters), the number of series grows out of control:

- Prometheus consumes a lot of memory and becomes slow or crashes.
- On commercial platforms, the cost skyrockets (billing is per series).

Practical rules:

- Labels may only take a **small, bounded set** of values (rejection reason, country, channel, customer type).
- Specific identifiers go in **logs and traces**, which are made for that, never in metrics.
- Spring already normalises the URI of `http.server.requests` to the template (`/api/orders/{id}`), but a badly written custom filter can break it; in HTTP clients, always use URI templates.
- Labels can be limited or removed with a `MeterFilter` (for example, `MeterFilter.maximumAllowableTags`).

> **Interview tip.** Cardinality is probably the most expensive mistake in observability. Mentioning it spontaneously when talking about custom metrics shows production experience.

## Q151 · Which PromQL queries and Grafana dashboards would you use to watch a microservice?

*Topic: Observability · Grafana · Deep Dive C*

**Grafana** is the most widely used visualisation tool: it builds dashboards on top of multiple data sources (Prometheus, Loki, Tempo, Elasticsearch, databases, cloud platforms) and also manages alerts.

Fundamental PromQL queries for a Spring Boot service:

```text
# Traffic: requests per second per endpoint
sum by (uri) (rate(http_server_requests_seconds_count{application="orders"}[5m]))

# Error rate (percentage of 5xx)
sum(rate(http_server_requests_seconds_count{application="orders", status=~"5.."}[5m]))
  / sum(rate(http_server_requests_seconds_count{application="orders"}[5m]))

# p95 latency per endpoint (requires histograms to be enabled)
histogram_quantile(0.95,
  sum by (le, uri) (rate(http_server_requests_seconds_bucket{application="orders"}[5m])))

# Connection pool saturation: threads waiting for a connection
max by (pod) (hikaricp_connections_pending{application="orders"})

# GC pauses per second
sum by (pod) (rate(jvm_gc_pause_seconds_sum{application="orders"}[5m]))

# Heap usage over the maximum
sum by (pod) (jvm_memory_used_bytes{area="heap"}) / sum by (pod) (jvm_memory_max_bytes{area="heap"})
```

Key PromQL concepts: `rate()` calculates the per-second rate of a counter over a window (and handles counter resets), `sum by (...)` aggregates keeping only the specified labels, `histogram_quantile()` calculates percentiles from the buckets and the `_bucket` suffix identifies those buckets.

Recommended structure for a service dashboard:

- A **summary row** with the golden signals: traffic, error rate, p50/p95/p99 latency and SLO status.
- A **row per endpoint**: the most used and the slowest.
- **Dependencies**: latency and errors of outgoing calls (HTTP clients, database, Kafka, consumer lag).
- **Resources**: CPU, heap and non-heap memory, GC, threads, connection pool.
- **Business**: orders per minute, rejected payments, amount.

Good practices: template variables (environment, service, pod) to reuse the same dashboard for all services, annotations for **deployments** to correlate changes in behaviour with versions, dashboards managed as code (JSON in Git, Grafonnet or Grafana provisioning) and links that let you jump from a metric to the logs and traces of the same period. There are community dashboards for the JVM and Spring Boot that serve as a starting point.

## Q152 · How do you design good alerts? What are SLIs, SLOs, SLAs and the error budget?

*Topic: Observability · Alerts · Deep Dive C*

A bad alerting system generates **fatigue**: so many irrelevant alerts that the team stops paying attention to them and the important one goes unnoticed.

Principles of a good alert:

- **Alert on symptoms, not causes**: what matters is that users are suffering errors or slowness, not that a pod's CPU is at 90% (which may be completely normal). Causes are useful in dashboards for diagnosis.
- **Every alert must be actionable**: if there is nothing to do when you receive it, it shouldn't wake anyone up. Each alert links to a **runbook** with the diagnostic steps.
- **Distinguish urgency**: what requires immediate attention (paging the on-call person) from what can wait until working hours (a ticket).

Terminology:

- **SLI** (*Service Level Indicator*): a measure of the quality of the service from the user's point of view. For example, the proportion of payment requests that complete successfully in under 500 ms.
- **SLO** (*Service Level Objective*): the internal target for an SLI over a time window. For example, 99.9% of payment requests successful and fast over 30 days.
- **SLA** (*Service Level Agreement*): the contractual commitment to customers, with consequences (penalties) if it is breached. Always less demanding than the internal SLO, to leave a margin.
- **Error budget**: what the SLO allows to fail. A 99.9% SLO over 30 days allows about 43 minutes of unavailability or 0.1% of failed requests. If the budget runs out, reliability is prioritised over new features; if there is budget left, more risk can be taken (deploying more often, experimenting).

**Burn rate alerts**: instead of alerting on any error, you alert when the budget is being consumed too quickly. For example, a consumption 14 times higher than sustainable for an hour would exhaust the monthly budget in two days: it requires immediate action. A consumption 3 times higher for six hours deserves a ticket. Combining long and short windows reduces both false positives and detection time.

```yaml
groups:
  - name: orders-slo
    rules:
      - alert: OrdersErrorBudgetFastBurn
        expr: |
          (sum(rate(http_server_requests_seconds_count{application="orders",status=~"5.."}[1h]))
            / sum(rate(http_server_requests_seconds_count{application="orders"}[1h]))) > (14 * 0.001)
        for: 2m
        labels: { severity: page }
        annotations:
          summary: "Orders is burning through its error budget very fast"
          runbook_url: "https://wiki.mycompany.com/runbooks/orders-errors"
```

Tools such as **Sloth** or **Pyrra** automatically generate these rules from an SLO definition.

## Q153 · How are logs centralised and exploited in microservices? ELK, EFK and Loki.

*Topic: Observability · Logs · Deep Dive C*

With dozens of services and ephemeral replicas, logging into each machine to read files is unfeasible: logs must be **centralised**.

The usual architecture:

- The application writes **structured JSON logs to stdout** (a 12-factor principle).
- A **collector agent** on each node (a DaemonSet on Kubernetes) reads the containers' logs, adds metadata (namespace, pod, container, labels) and sends them to storage: **Fluent Bit**, **Fluentd**, **Vector**, **Filebeat**, **Promtail/Alloy** or the **OpenTelemetry Collector**.
- **Searchable storage** and a query interface.

The most common stacks:

- **ELK** (Elasticsearch, Logstash, Kibana) or **EFK** (with Fluentd/Fluent Bit instead of Logstash), or its fork **OpenSearch**. It indexes the full content of the logs: very powerful free-text search and analytics, at the cost of high storage and operating costs.
- **Grafana Loki**: it only indexes the **labels** (service, namespace, level), not the content; the text is filtered at query time. Much cheaper to operate at large scale and perfectly integrated with Grafana, Prometheus and Tempo. Queries with LogQL: `{app="orders", level="ERROR"} |= "timeout" | json | duration > 2000`.
- **Commercial platforms** (Datadog, Splunk, New Relic, Elastic Cloud) and cloud services (CloudWatch Logs, Azure Monitor, Google Cloud Logging).

What to log and how:

- **Structured format** with consistent fields across services: timestamp, level, service, version, `traceId`, `spanId`, message and context attributes (order identifier, user identifier in pseudonymised form). Spring Boot 3.4+ generates structured JSON natively.
- **Levels used judiciously**: `ERROR` for what requires attention, `WARN` for recoverable anomalies, `INFO` for relevant business and lifecycle events, `DEBUG` disabled in production (it can be enabled on the fly with `/actuator/loggers` during an investigation).
- **Correlation**: having the `traceId` on every line lets you go from a slow trace to all its logs in every service.
- **Never** passwords, tokens, card numbers or unnecessary personal data (regulatory compliance); apply masking.
- **One error, one log**: log the exception with its stack trace only once, where it is handled.
- Control the **volume**: logs are one of the most expensive items in observability. Sample very repetitive logs, define retention periods by type and don't log every successful request if metrics and traces already exist.

## Q154 · How does distributed tracing work? What are sampling and context propagation?

*Topic: Observability · Traces · Deep Dive C*

A **trace** represents the complete journey of a request through the system. It is made up of **spans**: each span is a named operation with a start, duration, status and attributes (an HTTP request received, a call to another service, a database query, the publication of a message). Spans form a tree through parent-child relationships, and they all share the same `traceId`.

**Context propagation**: for service B to know that its work is part of the trace started in A, A sends the context in headers. The standard is **W3C Trace Context**:

```text
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
             version-traceId (16 bytes)-parent spanId (8 bytes)-flags (sampled)
```

There is also the `baggage` header for propagating business key-value pairs along the trace (for example, the tenant). In messaging, the context travels in the message headers.

In Spring Boot 3, **Micrometer Tracing** is used with a bridge to **OpenTelemetry** (or to Brave) and an exporter:

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

With this, incoming requests, HTTP clients created from the injected *builders*, JDBC (with the appropriate library), Kafka and RabbitMQ are instrumented automatically, and the `traceId` is added to the logs' MDC. Spring Boot 4 also offers a dedicated OpenTelemetry starter.

**Sampling**: storing every trace of a high-traffic system is very expensive.

- **Head-based**: the decision is made at the start of the trace (for example, 10%) and propagated. Simple and cheap, but it may discard precisely the trace of the interesting error.
- **Tail-based**: the decision is made at the end, once it is known whether the trace had errors or was slow. It lets you keep 100% of traces with errors or high latency and a sample of the rest. It requires temporarily storing all the spans, normally in the **OpenTelemetry Collector** (the `tail_sampling` processor).

Trace backends: **Jaeger**, **Zipkin**, **Grafana Tempo**, and commercial APM platforms. The view of a trace (a *waterfall* diagram) immediately shows where the time goes and which call failed.

An important detail: context propagation is easily lost when switching threads (`@Async`, `CompletableFuture`, custom executors). Spring Boot configures propagation in its managed executors, but an `Executors.newFixedThreadPool()` created by hand needs to be wrapped (`ContextExecutorService` from the Context Propagation library).

## Q155 · What is OpenTelemetry? What role does the OpenTelemetry Collector play? Java agent or Micrometer?

*Topic: Observability · OpenTelemetry · Deep Dive C*

**OpenTelemetry** (OTel) is a CNCF project that defines an **open standard** for generating, collecting and exporting telemetry (traces, metrics and logs), with APIs and SDKs for many languages, common semantic conventions (standard attribute names such as `http.request.method` or `db.system`) and the **OTLP** protocol. Its great advantage is **vendor independence**: you instrument once and send to any compatible backend (practically all of them are today).

The **OpenTelemetry Collector** is an intermediate process between the applications and the backends. It is deployed as an agent (on each node) or as a central service (*gateway*), or both. Its pipeline has three parts:

- **Receivers**: receive telemetry (OTLP, Prometheus, Jaeger, Zipkin, file logs...).
- **Processors**: transform it: batch it, add Kubernetes metadata, remove sensitive attributes, apply **tail-based sampling**, limit memory.
- **Exporters**: send it to one or several destinations at the same time (Tempo and Datadog, for example).

Advantages of using it: applications only know about the Collector (changing vendor doesn't require touching them), it centralises processing, retries on backend failures and allows sending to several destinations during a migration.

**Two ways to instrument a Spring Boot application**:

- **OpenTelemetry Java agent** (`-javaagent:opentelemetry-javaagent.jar`): it automatically instruments hundreds of libraries through bytecode manipulation, without changing the code or the dependencies. Very convenient, especially for legacy applications or many heterogeneous services. Trade-offs: it increases startup time, it is less transparent when debugging, it can conflict with other agents and it is not compatible with GraalVM native images.
- **Micrometer (Observation API, Micrometer Tracing) or the OpenTelemetry starter for Spring Boot**: instrumentation built into the framework itself through dependencies and configuration. Lighter, controlled from the Spring configuration and it works with native images; it covers the libraries that Spring integrates, and the rest need manual instrumentation or specific libraries.

Both options export via OTLP, so from the Collector onwards the result is the same. The choice usually depends on the organisation's standardisation: many companies use the agent as a common standard for all languages, while Spring-focused teams prefer the native integration.

**Logs** in OpenTelemetry work as a bridge: the SDK collects the events from Logback or Log4j2 (through an *appender*) and sends them via OTLP with the trace context already included, as an alternative to reading the stdout files.

## Q156 · What monitoring platforms and tools do you know? How would you choose between open source and commercial options?

*Topic: Observability · Tooling · Deep Dive C*

**Open source stack** (self-managed or as a managed version):

- **Prometheus** + **Alertmanager** for metrics and alerts; **Thanos**, **Mimir** or **VictoriaMetrics** to scale it.
- **Grafana** for visualisation. The Grafana Labs suite (**Loki** for logs, **Tempo** for traces, **Mimir** for metrics, **Pyroscope** for profiling and **Alloy** as the collector) is known as the LGTM stack and offers a very integrated experience.
- **ELK/OpenSearch** for logs with full-text search.
- **Jaeger** or **Zipkin** for traces.
- The **OpenTelemetry Collector** as the common collection piece.
- **Kiali** (with Istio) to visualise service mesh traffic.

**Commercial observability and APM platforms**:

- **Datadog**: a very complete platform (infrastructure, APM, logs, RUM, security), a huge number of integrations and a very polished experience. The cost can grow a lot (per host, per custom metric series, per log volume).
- **Dynatrace**: strong in automatic dependency detection and AI-based root cause analysis, with a single agent (OneAgent); very present in large enterprises.
- **New Relic**: a veteran APM with pricing based on data volume and users.
- **Elastic Observability**: built on the Elastic stack, backed by OpenTelemetry.
- **Splunk Observability** and **Honeycomb** (the latter strongly oriented towards high-cardinality events and trace exploration).
- **Cloud providers' services**: Amazon CloudWatch and X-Ray, Azure Monitor and Application Insights, Google Cloud Operations.
- Incident and on-call management: **PagerDuty**, **Opsgenie**, **incident.io**.

**Selection criteria**:

- **Total cost**: the commercial licence versus the cost of the people and machines needed to operate your own stack. At small scale, managed options usually work out cheaper; at large scale, the cost of commercial platforms becomes a major issue.
- **The team's capacity** to operate observability infrastructure (which also needs high availability: observability can't go down together with the system it watches).
- **Correlation** between signals and the investigation experience.
- **Sovereignty and compliance requirements** about where the data is stored.
- **Avoiding vendor lock-in**: instrumenting with **OpenTelemetry** keeps the freedom to change backend without re-instrumenting the applications.

In an interview, more important than knowing every tool is explaining **what you would do with them**: which signals to collect, how to correlate them and how to investigate an incident from start to finish.

## Q157 · How are metrics, logs and traces correlated to investigate an incident? What are exemplars?

*Topic: Observability · Correlation · Deep Dive C*

Observability delivers its full value when the three signals are **connected** and you can navigate from one to another:

- **From the alert to the metric**: an SLO alert leads to the service dashboard; you see that the p99 of an endpoint has shot up since 10:42, coinciding with a deployment (an annotation on the panel).
- **From the metric to the trace**: thanks to **exemplars**, identifiers of specific traces that fell into each bucket are stored alongside the points of the latency histogram. From the spike in the chart you click on an exemplar and a real slow trace opens.
- **From the trace to the logs**: the trace shows that the time goes into a database query in the inventory service; since all the logs carry the `traceId`, you query all the logs of that request across all services.
- **From the logs to the cause**: the logs show a warning that the connection pool is exhausted and retries against a degraded database replica.
- **Profiling**: if the time goes into the application's own CPU, a continuous profile (Pyroscope, JFR, the APM platforms' profilers) linked to the spans shows which methods consume the CPU.

Micrometer supports **exemplars** with Prometheus when tracing is enabled: when it observes a latency, it attaches the `traceId` of the current trace. Grafana shows them as points on the histogram panels, linked to Tempo or Jaeger. To store them, Prometheus must be started with the exemplars feature enabled.

Requirements for this correlation to work:

- **Common identifiers**: the same service name, environment and version in all three signals (in OpenTelemetry, the *resource attributes* `service.name`, `deployment.environment`, `service.version`).
- **`traceId` in all logs**, including those of message consumers and asynchronous tasks.
- **Deployment and configuration-change markers** on the dashboards.
- Tools that link to each other (Grafana with Prometheus, Loki and Tempo; or an integrated APM platform).

Closing the loop: after resolving the incident, a **postmortem** documents the timeline, the root cause and the actions (an alert that would have warned earlier, a test, a badly configured timeout, a resource limit). The **MTTD** (mean time to detect) and **MTTR** (mean time to recover) metrics measure the effectiveness of this whole system.

> **Interview tip.** Telling a real incident following this path (alert → metric → trace → log → cause → action) is one of the most convincing answers you can give in a senior interview.

## Q158 · What types of health checks exist and what is synthetic monitoring?

*Topic: Observability · Health · Deep Dive C*

**Internal health checks** (those exposed by the application, such as `/actuator/health`):

- **Liveness**: the process is alive and not stuck. It must be very simple and not depend on external systems.
- **Readiness**: the instance can serve traffic right now (it has finished starting, it isn't saturated, it has access to its essential dependencies).
- **Detailed health**: the status of each component (database, disk, broker, external services) for diagnosis. Spring Boot aggregates the `HealthIndicator`s and you can configure **groups** to decide which indicators count in each probe:

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

Precautions: a health indicator that calls a slow external service can make the health endpoint itself slow and failing; and marking an instance as unavailable because of a **non-critical** dependency can take all the replicas out of load balancing at once because of someone else's problem. It is recommended that dependency health checks be fast, with timeouts, and that only dependencies without which no request can really be served affect readiness.

**Synthetic monitoring**: automated tests that **simulate a user** from outside the system, periodically and from different locations:

- **Uptime checks**: a request to a public endpoint every minute, verifying the status code, content and response time.
- **Synthetic transactions**: complete multi-step flows (search for a product, add it to the cart, start the payment with a test account), with automated browsers (Playwright) or API scripts.

They detect problems that internal monitoring doesn't see: DNS, expired certificates, CDN, load balancers or a deployment that broke the flow even though every service responds "healthy". They also work when there is no real traffic (in the early hours), which makes it possible to detect failures before users do.

Tools: **Prometheus Blackbox Exporter**, **Grafana Synthetic Monitoring**, **Checkly**, **Uptime Kuma**, and the synthetic features of Datadog, New Relic or Dynatrace. A natural complement: **RUM** (*Real User Monitoring*), which measures the experience of real users in the browser or mobile app.

# Appendices

## Appendix A · Rapid-fire questions

Short questions that often come up at the start of an interview to gauge the level, or as a quick round at the end. The expected answer fits in one or two sentences.

**What is the default scope of a bean?**
Singleton: one instance per application context.

**Which embedded server does Spring Boot use by default?**
Tomcat in Spring MVC applications; Netty in WebFlux applications.

**Which library does Spring Boot use by default for JSON?**
Jackson.

**Which connection pool does Spring Boot use by default?**
HikariCP.

**What is the minimum Java version required by Spring Boot 3?**
Java 17.

**What is the difference between `@Controller` and `@RestController`?**
`@RestController` adds `@ResponseBody` to all methods: what is returned is serialised into the body instead of being interpreted as a view name.

**What does `@Transactional(readOnly = true)` do?**
It marks the transaction as read-only: Hibernate skips dirty checking and flushing, and some drivers or routers can send the query to replicas.

**Does `@Transactional` roll back on an `IOException`?**
No; by default it only rolls back on unchecked exceptions and errors, unless `rollbackFor` is configured.

**What does `findById` return in Spring Data?**
An `Optional<T>`.

**Which annotation marks a version field for optimistic locking?**
`@Version`.

**Which HTTP code corresponds to a created resource?**
`201 Created`, ideally with the `Location` header.

**Which code indicates that the client has exceeded the request limit?**
`429 Too Many Requests`.

**Which HTTP verb is not idempotent: PUT or POST?**
POST.

**Which Actuator endpoint exposes metrics for Prometheus?**
`/actuator/prometheus`.

**Which library replaced Hystrix for circuit breakers in Spring?**
Resilience4j.

**What replaced Spring Cloud Sleuth in Spring Boot 3?**
Micrometer Tracing.

**What replaced Netflix Zuul as the gateway in Spring Cloud?**
Spring Cloud Gateway.

**What replaced Ribbon for client-side load balancing?**
Spring Cloud LoadBalancer.

**Which synchronous HTTP client is recommended in modern Spring?**
`RestClient`, directly or through `@HttpExchange` interfaces.

**What guarantees ordering in Kafka?**
Order is only guaranteed within a partition; the same key is used so that related messages go to the same partition.

**How many consumers from the same group can read a partition at once?**
One.

**What is consumer lag?**
The difference between the last offset written and the last one committed by a group: the messages waiting to be processed.

**Which configuration combination prevents data loss in Kafka if a broker goes down?**
Replication factor 3, `min.insync.replicas=2` and `acks=all`.

**What is a tombstone in Kafka?**
A record with a null value that marks the deletion of a key in a compacted topic.

**What does exit code 137 mean in a container?**
The process was terminated with SIGKILL, normally because it exceeded the memory limit (OOMKilled).

**What is the difference between liveness and readiness?**
Liveness decides whether to restart the container; readiness decides whether to send it traffic.

**Which Kubernetes object gives a stable address to a set of pods?**
A Service.

**Which Kubernetes object would you use for a scheduled task?**
A CronJob.

**Why not use `latest` as the image tag in production?**
Because it is neither immutable nor traceable: you don't know which version is deployed and rollback can't be guaranteed.

**Which type of Prometheus metric would you use for latencies?**
A histogram, because its percentiles can be aggregated across instances.

**Which PromQL function calculates the per-second rate of a counter?**
`rate()`.

**What is the cardinality of a metric?**
The number of distinct time series it generates, determined by the combinations of its label values.

**Which standard defines the `traceparent` header?**
W3C Trace Context.

**What is an SLO?**
An internal reliability target for a service indicator over a time window, for example 99.9% successful requests over 30 days.

**Which pattern solves dual writes between a database and a broker?**
Transactional Outbox.

**Which pattern manages business transactions across several services?**
Saga, with local transactions and compensations.

**Which pattern separates the read and write models?**
CQRS.

**Which pattern allows a monolith to be migrated incrementally?**
Strangler Fig.

**Which pattern isolates resources so that a failing dependency doesn't exhaust all the threads?**
Bulkhead.

**Which GoF pattern does Spring use for `@Transactional`?**
Proxy.

**Which GoF pattern do `JdbcTemplate` and `RestTemplate` represent?**
Template Method (with callbacks).

**Which GoF pattern does the Spring Security filter chain represent?**
Chain of Responsibility.

## Appendix B · Annotations cheat sheet

### Core and configuration

| Annotation | Use |
|---|---|
| `@SpringBootApplication` | Main class: configuration, auto-configuration and component scanning. |
| `@Component`, `@Service`, `@Repository`, `@Controller`, `@RestController` | Stereotypes that register beans through scanning. |
| `@Configuration` / `@Bean` | Configuration class and methods that build beans. |
| `@Autowired`, `@Qualifier`, `@Primary` | Injection and disambiguation of candidates. |
| `@Value` | Injection of a single property or SpEL expression. |
| `@ConfigurationProperties` | Typed binding of a group of properties. |
| `@Profile` | Registers the bean only when certain profiles are active. |
| `@ConditionalOnClass`, `@ConditionalOnMissingBean`, `@ConditionalOnProperty` | Auto-configuration conditions. |
| `@Lazy` | Lazy initialisation or injection of a deferred proxy. |
| `@Scope` | Changes the bean's scope (prototype, request, session...). |
| `@PostConstruct` / `@PreDestroy` | Initialisation and destruction callbacks. |
| `@EventListener` / `@TransactionalEventListener` | Listening to application events. |
| `@Async` / `@EnableAsync` | Asynchronous execution. |
| `@Scheduled` / `@EnableScheduling` | Scheduled tasks. |
| `@Cacheable`, `@CachePut`, `@CacheEvict` / `@EnableCaching` | Cache abstraction. |

### Web

| Annotation | Use |
|---|---|
| `@RequestMapping`, `@GetMapping`, `@PostMapping`, `@PutMapping`, `@PatchMapping`, `@DeleteMapping` | Mapping requests to methods. |
| `@PathVariable`, `@RequestParam`, `@RequestHeader`, `@RequestBody` | Extracting data from the request. |
| `@ResponseStatus` | Fixed status code for a method or an exception. |
| `@RestControllerAdvice`, `@ExceptionHandler` | Global exception handling. |
| `@Valid`, `@Validated` | Triggering validation. |
| `@CrossOrigin` | Local CORS configuration. |
| `@HttpExchange`, `@GetExchange`... | Declarative HTTP clients. |

### Data and transactions

| Annotation | Use |
|---|---|
| `@Entity`, `@Table`, `@Id`, `@GeneratedValue`, `@Column` | Basic JPA mapping. |
| `@OneToMany`, `@ManyToOne`, `@OneToOne`, `@ManyToMany`, `@JoinColumn` | Relationships. |
| `@Embeddable` / `@Embedded` | Embedded value objects. |
| `@Version` | Optimistic locking. |
| `@Query`, `@Modifying`, `@EntityGraph`, `@Lock` | Queries in Spring Data repositories. |
| `@Transactional` | Transaction demarcation. |

### Testing

| Annotation | Use |
|---|---|
| `@SpringBootTest` | Full context. |
| `@WebMvcTest`, `@DataJpaTest`, `@JsonTest`, `@RestClientTest` | Test slices. |
| `@MockitoBean`, `@MockitoSpyBean` | Replacing beans with mocks or spies in the context. |
| `@Testcontainers`, `@Container`, `@ServiceConnection` | Containers for tests with automatic connection. |
| `@DynamicPropertySource` | Properties computed at runtime. |
| `@ActiveProfiles`, `@TestPropertySource` | Test profiles and properties. |
| `@WithMockUser` | Simulated user for security tests. |

### Security, resilience and messaging

| Annotation | Use |
|---|---|
| `@EnableMethodSecurity`, `@PreAuthorize` | Method-level authorisation. |
| `@CircuitBreaker`, `@Retry`, `@RateLimiter`, `@Bulkhead`, `@TimeLimiter` | Resilience4j. |
| `@KafkaListener`, `@RetryableTopic`, `@DltHandler` | Kafka consumption, non-blocking retries and DLT. |
| `@RabbitListener` | RabbitMQ consumption. |
| `@Observed` | Observation (metric and trace) of a method with Micrometer. |

## Appendix C · Essential configuration properties

| Property | What it is for |
|---|---|
| `server.port` | The application's HTTP port. |
| `server.shutdown=graceful` | Orderly shutdown, waiting for in-flight requests. |
| `spring.lifecycle.timeout-per-shutdown-phase` | Maximum time for each shutdown phase. |
| `spring.profiles.active` | Active profiles. |
| `spring.application.name` | Service name (used in traces, metrics and discovery). |
| `spring.datasource.url` / `username` / `password` | Database connection. |
| `spring.datasource.hikari.maximum-pool-size` | Maximum size of the connection pool. |
| `spring.jpa.open-in-view=false` | Disable Open Session In View. |
| `spring.jpa.hibernate.ddl-auto=validate` | Validate the schema instead of generating it. |
| `spring.jpa.properties.hibernate.default_batch_fetch_size` | Batch fetching to mitigate N+1. |
| `spring.threads.virtual.enabled=true` | Virtual threads (Java 21+). |
| `spring.mvc.problemdetails.enabled=true` | Error responses in Problem Details format. |
| `management.endpoints.web.exposure.include` | Actuator endpoints exposed over HTTP. |
| `management.server.port` | A separate port for Actuator. |
| `management.endpoint.health.probes.enabled` | Liveness and readiness groups. |
| `management.tracing.sampling.probability` | Proportion of traces sampled. |
| `management.metrics.distribution.percentiles-histogram.*` | Publish latency histograms. |
| `logging.level.<package>` | Log level per package. |
| `logging.structured.format.console` | Structured JSON logs (ecs, logstash, gelf). |
| `spring.kafka.bootstrap-servers` | Kafka brokers. |
| `spring.kafka.consumer.group-id` / `auto-offset-reset` | Consumer group and behaviour when there is no previous offset. |
| `spring.kafka.listener.concurrency` | Consumer threads per listener. |
| `spring.config.import` | Import additional configuration (Config Server, files, config trees). |

## Appendix D · Glossary

**ACID**: the properties of database transactions: atomicity, consistency, isolation and durability.

**Aggregate**: in DDD, a group of entities and value objects treated as a unit of consistency, with a root as the only access point.

**AOP (aspect-oriented programming)**: a technique for applying cross-cutting logic (transactions, security, metrics) without mixing it with business logic.

**AOT (ahead-of-time)**: processing or compilation at build time instead of at runtime.

**API Gateway**: a single entry point that routes external requests to internal services and applies cross-cutting policies.

**At-least-once**: a delivery guarantee in which no message is lost, but it may be delivered more than once.

**Backpressure**: a mechanism by which a consumer tells the producer the rate at which it can process.

**BFF (Backend for Frontend)**: a backend specific to one type of client.

**BOM (Bill of Materials)**: a POM that pins compatible versions of a set of dependencies.

**Bounded Context**: an explicit boundary within which a domain model is coherent.

**Bulkhead**: isolation of resources so that the failure of one part doesn't exhaust the resources of the whole system.

**Canary**: a deployment that sends a small percentage of traffic to the new version before rolling it out fully.

**CAP**: the theorem stating that, in the event of a network partition, a distributed system must choose between consistency and availability.

**Cardinality**: the number of distinct time series a metric generates.

**CDC (Change Data Capture)**: capturing a database's changes by reading its transaction log.

**Circuit Breaker**: a pattern that cuts off calls to a failing dependency to avoid cascading failures.

**Consumer group**: a set of Kafka consumers that share out the partitions of a topic.

**Consumer lag**: the messages waiting to be processed by a consumer group.

**CQRS**: the separation of the write (commands) and read (queries) models.

**DLQ / DLT**: a dead-letter queue or topic, where messages that couldn't be processed are sent.

**DTO**: a data transfer object that defines an API's contract.

**Error budget**: the margin of failure an SLO allows over a time window.

**Event Sourcing**: persisting state as an immutable sequence of events.

**Eventual consistency**: the guarantee that, without new writes, all replicas will eventually converge to the same value.

**Exemplar**: a reference to a specific trace associated with a point in a metric.

**Fat jar**: an executable jar that contains the application and all its dependencies.

**Feature flag**: a configuration switch for enabling or disabling features without deploying.

**Fencing token**: an increasing number that accompanies a distributed lock in order to reject writes from stale holders.

**GitOps**: the practice of managing the state of infrastructure and deployments from a Git repository.

**Graceful shutdown**: an orderly shutdown that finishes in-flight requests before closing.

**HPA**: HorizontalPodAutoscaler, automatic scaling of the number of replicas in Kubernetes.

**Idempotency**: the property of an operation that produces the same effect whether it is executed once or several times.

**IoC (Inversion of Control)**: the principle by which a framework controls the creation and lifecycle of objects.

**ISR (In-Sync Replicas)**: the replicas of a Kafka partition that are in sync with the leader.

**JWT**: a signed, self-contained token with information (claims) about the user or client.

**KRaft**: Kafka's built-in consensus mode that replaces ZooKeeper.

**Liveness / Readiness**: probes that indicate whether a container should be restarted or can receive traffic.

**mTLS**: mutual TLS, in which client and server authenticate each other with certificates.

**N+1**: a performance problem in which an additional query is run for each element of a list.

**Observability**: the ability to understand the internal state of a system from its outputs (logs, metrics and traces).

**OSIV (Open Session In View)**: a pattern that keeps the Hibernate session open for the whole HTTP request.

**OTLP**: OpenTelemetry's protocol for transmitting telemetry.

**Outbox**: a pattern that stores events in a table within the same business transaction so they can be published later.

**Partition**: a subdivision of a Kafka topic; the unit of parallelism and ordering.

**Poison pill**: a message that causes an error every time an attempt is made to process it.

**Proxy**: an object that stands in for another to control access and add behaviour.

**Rate limiting**: limiting the number of requests allowed in an interval.

**Saga**: a sequence of local transactions with compensations to maintain consistency across services.

**Schema Registry**: a service that stores message schemas and validates their compatibility.

**Service Mesh**: an infrastructure layer that manages communication between services through proxies.

**Sidecar**: an auxiliary container deployed next to the main one in the same pod.

**SLI / SLO / SLA**: service level indicator, objective and contractual agreement.

**Span**: a unit of work within a distributed trace.

**Starter**: an aggregated Spring Boot dependency for a use case.

**Strangler Fig**: a pattern for incrementally migrating a legacy system.

**Test slice**: a test that loads only part of the Spring context.

**Tombstone**: a record with a null value that marks a deletion in a compacted topic.

**Trace**: the complete journey of a request through several services, made up of spans.

**Twelve-Factor**: a methodology of twelve principles for cloud-native applications.

**Value Object**: an immutable object defined by its attributes, with no identity of its own.

**Virtual threads**: lightweight threads managed by the JVM that allow high concurrency with blocking code.

## Appendix E · Four-week study plan

**Week 1 · Solid fundamentals.** The chapters for levels 1 to 3. Create a small API from scratch with Spring Initializr (for example, order management) with validation, error handling with Problem Details, persistence with JPA and Flyway, and tests with `@WebMvcTest`, `@DataJpaTest` and Testcontainers. Deliberately trigger an N+1 and fix it; trigger the self-invocation problem and prove it with a test.

**Week 2 · Design.** Level 4. Refactor the previous API towards a feature-based organisation or a light hexagonal architecture; introduce value objects with records, a state machine for the order and an interchangeable strategy (for example, shipping cost calculation). Add ArchUnit or Spring Modulith rules that verify the structure.

**Week 3 · Distribution.** Levels 5 and 6 and the Kafka deep dive. Split the example into two or three services that communicate via REST and Kafka; implement a simple Outbox, an idempotent consumer, a DLT and a circuit breaker with Resilience4j. Test the failures: stop a service, introduce latency with WireMock, send duplicate or malformed messages.

**Week 4 · Operations and review.** The Docker and Kubernetes and the observability deep dives, and level 7. Containerise the services, start them with Docker Compose together with Prometheus, Grafana and a tracing backend, and deploy them to a local cluster (kind, k3d or minikube) with probes and resources. Build a dashboard with the golden signals and an alert. Finish with mock interviews: answer random questions out loud, practise two system design questions against the clock (45 minutes) and review the rapid-fire questions appendix.

General advice: having your own project in a public repository with all of the above is worth more than any memorised answer, because it lets you answer many questions with "in my project I did it this way, for this reason".

## Appendix F · How to approach the interview

**Conceptual interview.** Answer from the general to the specific: first the idea in one sentence, then the detail and, if appropriate, an example from your experience. If you don't know something, say so naturally and reason out loud about how you would find out or what you assume; it is valued much more highly than making things up.

**Live coding or practical exercise.** Before writing, restate the problem in your own words and ask about the edge cases. Start with a simple solution that works and improve it afterwards. Write tests even if you aren't asked to: they say a lot about the way you work. Name things well and comment on your decisions out loud.

**Code review.** Look layer by layer: correctness (bugs, edge cases, concurrency), security (injection, sensitive data, authorisation), performance (N+1, long transactions, remote calls in loops), design (responsibilities, coupling, testability) and style. Prioritise your findings: a possible bug is not the same as a name that could be improved.

**System design.** Follow a structure: functional and non-functional requirements, volume estimates, API, data model, high-level architecture, a deep dive into the critical point, and trade-offs and risks. Draw, ask questions and don't fall in love with the first solution.

**Behavioural questions.** Prepare three or four real stories in the situation, task, action and result format: a production incident you resolved, a technical decision you defended or that turned out to be wrong, an improvement you proposed and a conflict within the team. Stories about your own mistakes and what you learned tend to be the most convincing.

**Questions you can ask at the end:**

- What does the cycle look like from the moment a change is merged until it reaches production? How often do you deploy?
- How are incidents and on-call managed?
- What testing strategy does the team follow and who is responsible for quality?
- What is the team's biggest technical challenge over the coming months?
- How are architecture decisions made?
- What would make someone successful in this role during the first year?

These questions don't just give you information to decide: they show genuine interest and a professional view of software development.
