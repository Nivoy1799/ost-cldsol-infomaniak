// ==========================================================================
// Cloud Solutions - Gruppenarbeit 1: Evaluation eines Cloud-Providers
// Provider: Infomaniak (Jelastic PaaS)
// Autoren: Jovin Risch & Lenny Merlo
// ==========================================================================

// --- Dokumentkonfiguration ---
#set document(
  title: "Cloud Solutions - Gruppenarbeit 1: Infomaniak",
  author: ("Jovin Risch", "Lenny Merlo"),
)

#set text(font: "New Computer Modern", size: 11pt, lang: "de")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm))

// Codeblöcke
#show raw.where(block: true): block.with(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

// Überschriften-Styling
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(0.5cm)
  text(size: 18pt, weight: "bold", it)
  v(0.3cm)
}

#show heading.where(level: 2): it => {
  v(0.4cm)
  text(size: 14pt, weight: "bold", it)
  v(0.2cm)
}

#show heading.where(level: 3): it => {
  v(0.3cm)
  text(size: 12pt, weight: "bold", it)
  v(0.15cm)
}

// --- Hilfsfunktionen ---
#let screenshot(path, caption: none, width: 80%) = {
  figure(
    if path == none {
      rect(
        width: width,
        height: 6cm,
        fill: luma(240),
        stroke: 1pt + luma(200),
        [
          #set align(center + horizon)
          #text(fill: luma(150), size: 10pt)[Screenshot einfügen]
        ],
      )
    } else {
      image(path, width: width)
    },
    caption: caption,
  )
}

#let todo(body) = {
  block(
    fill: rgb("#FFF3CD"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    stroke: 1pt + rgb("#FFECB5"),
    [*TODO:* #body],
  )
}

// ========================================================================
// TITELSEITE
// ========================================================================
#page(margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm), header: none, footer: none)[
  #v(3cm)
  #align(center)[
    #text(size: 12pt, fill: luma(100))[OST -- Ostschweizer Fachhochschule]
    #v(0.3cm)
    #text(size: 12pt, fill: luma(100))[Modul: Cloud Solutions]
    #v(2cm)
    #line(length: 60%, stroke: 1pt + luma(180))
    #v(0.8cm)
    #text(size: 26pt, weight: "bold")[Gruppenarbeit 1]
    #v(0.3cm)
    #text(size: 18pt)[Evaluation eines Cloud-Providers]
    #v(0.5cm)
    #text(size: 16pt, fill: rgb("#0066CC"), weight: "bold")[Infomaniak -- Jelastic PaaS]
    #v(0.8cm)
    #line(length: 60%, stroke: 1pt + luma(180))
    #v(2.5cm)
    #text(size: 13pt)[
      Jovin Risch & Lenny Merlo
    ]
    #v(1cm)
    #text(size: 12pt, fill: luma(100))[
      Frühlingssemester 2026
    ]
    #v(0.3cm)
    #text(size: 12pt, fill: luma(100))[
      Abgabe: 15. März 2026
    ]
  ]
]

// ========================================================================
// INHALTSVERZEICHNIS
// ========================================================================
#page(header: none, footer: none)[
  #v(1cm)
  #text(size: 18pt, weight: "bold")[Inhaltsverzeichnis]
  #v(0.5cm)
  #outline(title: none, indent: 1.5em, depth: 3)
]

// --- Header & Footer ab hier ---
#set page(
  header: {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Cloud Solutions], [Gruppenarbeit 1], [FS 2026],
    )
    line(length: 100%, stroke: 0.5pt + luma(200))
  },
  footer: {
    line(length: 100%, stroke: 0.5pt + luma(200))
    v(0.2cm)
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [Infomaniak -- Risch und Merlo],
      [Seite #context counter(page).display("1")],
    )
  },
)
#counter(page).update(1)


// ========================================================================
// AUFGABE 1: Hello (Cloud) World
// ========================================================================
= Hands-On: Hello (Cloud) World

== Vorstellung des Providers

// TODO: Kurze Vorstellung von Infomaniak und dem Jelastic PaaS Angebot
// - Was ist Infomaniak? (Schweizer Cloud-Provider, Hauptsitz Genf)
// - Was bietet Jelastic PaaS? (Container-basierte PaaS-Lösung)
// - Welche Technologien werden unterstützt? (Java, Node.js, PHP, Python, etc.)

#todo[Infomaniak und das Jelastic PaaS Angebot vorstellen. Schweizer Provider, Datacenter-Standorte, unterstützte Technologien.]

== Registrierung und Setup

// TODO: Registrierungsprozess beschreiben
// - Account-Erstellung bei Infomaniak
// - Zugang zum Jelastic Dashboard
// - Installation allfälliger CLI-Tools oder IDE-Plugins

#todo[Registrierungsprozess und Setup-Schritte dokumentieren mit Screenshots.]

== Hello-World-Tutorial

// TODO: Gewähltes Tutorial beschreiben und durcharbeiten
// - Welches Tutorial / welche Applikation wurde gewählt? (z.B. Java Spring Boot)
// - Schritte zum Deployment
// - Screenshots der laufenden Applikation

#todo[Hello-World-Tutorial durcharbeiten und dokumentieren. Kein triviales Beispiel (keine statische HTML-Seite), z.B. eine Java-Applikation.]

== Teamarbeit und Deployment

// TODO: Teamarbeit dokumentieren
// - Können alle Teammitglieder deployen?
// - Benutzer- und Zugriffsrechteverwaltung
// - GitHub/GitLab-Integration möglich?

#todo[Teamarbeit beim Deployment beschreiben. Zugriffsrechte, gemeinsames Deployen.]

== Beantwortung der Fragen

=== Weshalb haben Sie diesen Provider für die Evaluation ausgewählt?

// TODO: Begründung für die Wahl von Infomaniak
// - Schweizer Provider, Datenschutz
// - Jelastic PaaS als interessante Plattform
// - Persönliche Erfahrungen / Interesse

#todo[Begründung für die Providerwahl verfassen.]

=== Möglichkeiten zum Starten und Stoppen der Applikation

// TODO: Start/Stop-Mechanismen beschreiben
// - Dashboard-Optionen
// - CLI-Befehle falls vorhanden
// - API-Zugriff

#todo[Start- und Stopp-Möglichkeiten dokumentieren mit Screenshots.]

=== Deployment-Automatisierung

// TODO: Automatisierungsmöglichkeiten beschreiben
// - CI/CD-Integration
// - Git-Hooks
// - API-basiertes Deployment
// - Welche Schritte wären nötig?

#todo[Möglichkeiten der Deployment-Automatisierung beschreiben (muss nicht eingerichtet werden).]

=== Logging und Monitoring

// TODO: Log-Zugriff beschreiben
// - Wo findet man die Logs?
// - Sind HTTP Requests/Responses sichtbar?
// - Monitoring-Features

#todo[Log-Zugriff und Monitoring dokumentieren. HTTP Requests/Responses?]

=== Vor- und Nachteile gegenüber Railway

// TODO: Vergleich mit Railway
// - Vorteile von Infomaniak
// - Nachteile von Infomaniak
// - Unterschiede im Workflow

#todo[Vor- und Nachteile gegenüber Railway diskutieren.]


// ========================================================================
// AUFGABE 2: OSSM-Definition
// ========================================================================
= Analyse: OSSM-Definition

Im Folgenden werden die vier OSSM-Kriterien (On-Demand, Self-Service, Scalable, Measurable) auf das Jelastic-Cloud-Angebot von Infomaniak angewandt.

== On-Demand

Infomaniak Jelastic erfüllt das On-Demand-Kriterium vollständig. Über das Jelastic-Dashboard kann ein neues Environment innerhalb weniger Minuten erstellt werden: Der Benutzer klickt auf «New Environment», wählt im Topology Wizard den gewünschten Application Server (z.B. Tomcat, Spring Boot, Node.js), eine Datenbank (PostgreSQL, MySQL, MariaDB) sowie optionale Komponenten wie Load Balancer oder Cache-Layer aus. Das Environment wird anschliessend automatisch provisioniert und ist in der Regel innerhalb von 1--5 Minuten betriebsbereit.

Als Cloud-User merkt man das On-Demand-Prinzip besonders daran, dass kein Genehmigungsprozess, keine Wartezeit und kein manueller Eingriff durch Infomaniak-Mitarbeitende nötig ist. Environments können jederzeit erstellt, geklont, gestoppt und gelöscht werden. Auch das Hinzufügen weiterer Nodes (z.B. ein zusätzlicher Datenbankserver) ist jederzeit über den Topology Editor möglich, ohne dass ein Support-Ticket erstellt werden muss. Es besteht zudem keine Mindestvertragslaufzeit -- Ressourcen werden stündlich abgerechnet und können sofort wieder freigegeben werden.#footnote[Vgl. https://www.infomaniak.com/en/hosting/dedicated-and-cloud-servers/jelastic-cloud]

== Self-Service

Infomaniak Jelastic bietet umfassende Self-Service-Möglichkeiten über mehrere Schnittstellen:

- *Web-Dashboard (Jelastic Dashboard):* Die primäre Verwaltungsoberfläche bietet vollständige Kontrolle über alle Environments. Benutzer können Applikationen deployen (via WAR/ZIP-Upload, Git/SVN-Repository oder Docker-Images), Environment-Variablen konfigurieren, SSL-Zertifikate verwalten (inkl. Let's Encrypt Auto-SSL), Logs direkt im Browser einsehen und einen integrierten Dateimanager nutzen.

- *REST API:* Eine umfassende API deckt nahezu alle Dashboard-Operationen ab -- von Environment-Management über Deployment bis hin zu Billing-Abfragen. Dies ermöglicht die Integration in bestehende Automatisierungsworkflows.#footnote[Vgl. https://docs.jelastic.com/api/]

- *CLI (Command-Line Interface):* Das Jelastic CLI ermöglicht die skriptbasierte Verwaltung und lässt sich in CI/CD-Pipelines (Jenkins, GitLab CI, GitHub Actions) integrieren.

- *SSH-Zugang:* Direkter Terminal-Zugang zu Containern für Debugging und Administration.

- *Marketplace:* One-Click-Installation von vorkonfigurierten Paketen (z.B. WordPress, GitLab, Kubernetes, Let's Encrypt).

Für sämtliche Standardoperationen ist kein Kontakt mit dem Infomaniak-Support erforderlich. Alles -- von der Environment-Erstellung über Skalierung bis zum Deployment -- kann durch den Benutzer selbst durchgeführt werden.

== Skalierbarkeit

Die Skalierbarkeit ist eines der herausragenden Merkmale von Jelastic und basiert auf dem *Cloudlet-Konzept*. Ein Cloudlet ist die kleinste Ressourceneinheit und entspricht *128 MiB RAM + 400 MHz CPU*. Diese bewusst kleine Granularität ermöglicht eine feinstufige Ressourcenzuweisung.

*Vertikale Skalierung (automatisch):* Jelastic unterscheidet zwischen zwei Cloudlet-Typen:
- *Reserved Cloudlets:* Der garantierte Mindestanteil an Ressourcen, der immer alloziert (und abgerechnet) wird -- unabhängig von der tatsächlichen Nutzung. Günstigerer Stückpreis.
- *Dynamic Cloudlets:* Der obere Grenzwert, bis zu dem eine Instanz bei Bedarf automatisch skaliert. Dynamische Cloudlets werden nur bei tatsächlichem Verbrauch berechnet und haben einen höheren Stückpreis.

Die vertikale Skalierung erfolgt *automatisch und ohne Downtime* innerhalb des konfigurierten Bereichs. Benötigt eine Applikation mehr RAM oder CPU, werden dynamische Cloudlets sofort alloziert. Sinkt die Last, werden sie wieder freigegeben. Der Benutzer konfiguriert lediglich den Bereich über zwei Schieberegler im Topology Wizard.

*Horizontale Skalierung:* Nodes können innerhalb eines Environment-Layers manuell oder automatisch hinzugefügt und entfernt werden. Automatische horizontale Skalierung ist über konfigurierbare Trigger möglich (z.B. «wenn CPU-Auslastung \> 80% für 5 Minuten, füge einen Node hinzu»). Neue Nodes werden automatisch beim Load Balancer registriert.

*Zeitpunkt:* Die vertikale Skalierung erfolgt in Echtzeit. Die horizontale Skalierung benötigt typischerweise 1--2 Minuten für das Provisioning neuer Nodes.#footnote[Vgl. https://docs.jelastic.com/automatic-vertical-scaling/ und https://docs.jelastic.com/automatic-horizontal-scaling/]

== Measurable

Das Measurable-Kriterium ist bei Infomaniak Jelastic vollständig erfüllt. Die Plattform bietet eine detaillierte, granulare Verbrauchsmessung und transparente Abrechnung:

- *Echtzeit-Monitoring:* Jeder Node verfügt über ein integriertes Statistik-Panel mit Anzeige von CPU-Auslastung (MHz und Prozent), RAM-Verbrauch (MiB), Disk-I/O und Netzwerk-Traffic. Historische Daten können über Zeiträume von 1 Stunde bis 1 Monat visualisiert werden.

- *Billing Dashboard:* Das Abrechnungs-Dashboard zeigt den aktuellen Ressourcenverbrauch pro Environment und pro Node, aufgeschlüsselt nach Ressourcentyp (Cloudlets, Speicherplatz, Traffic, öffentliche IPs). Tägliche und monatliche Kostenzusammenfassungen sowie Kostenprognosen sind verfügbar.

- *Abrechnungsgranularität:* Cloudlets werden *stündlich* abgerechnet. Das System misst den Spitzenverbrauch innerhalb jeder Stunde und rechnet entsprechend ab. Auch Speicherplatz (pro GB/Stunde), externer Traffic (pro GB) und öffentliche IPv4-Adressen (pro Stunde) werden separat erfasst.

- *Verbrauchsbenachrichtigungen:* Benutzer können Ausgabenlimits konfigurieren und werden per E-Mail benachrichtigt, wenn der Verbrauch bestimmte Schwellenwerte erreicht.

Die geschätzten Kosten werden bereits im Topology Wizard angezeigt, bevor ein Environment erstellt wird -- der Benutzer sieht also vorab, was die gewählte Konfiguration kosten wird.#footnote[Vgl. https://www.infomaniak.com/en/support/faq/2262/jelastic-cloud-resources-available-depending-on-type-of-account]


// ========================================================================
// AUFGABE 3: Self-Information
// ========================================================================
= Hands-On: Self-Information

== Deployment der Self-Information-Applikation

// TODO: Deployment-Prozess dokumentieren
// - Import in IDE
// - Konfigurationsschritte
// - Deployment-Schritte
// - Allfällige Hindernisse und Lösungen

#todo[Deployment-Prozess der Self-Information-Applikation dokumentieren inkl. Hindernisse.]

== Beantwortung der Fragen

=== Verfügbarer RAM

// TODO: Wieviel RAM steht der Cloud-Instanz maximal zur Verfügung?

#todo[Maximalen RAM der Cloud-Instanz angeben (Screenshot der Self-Information-App).]

=== JVM-Hersteller

// TODO: Von welchem Hersteller stammt die JVM?

#todo[JVM-Hersteller angeben (Screenshot der Self-Information-App).]

=== IP-Adresse des Servers

// TODO: Welche IP-Adresse hat der Server laut Self-Information-Applikation?

#todo[Server-IP-Adresse angeben (Screenshot der Self-Information-App).]

== Gegenüberstellung: Infomaniak vs. Railway

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Infomaniak (Jelastic PaaS)*]),
      table.cell(fill: rgb("#E8F0FE"), [*Railway*]),
    ),
    // --- Registrierung und Anmeldung ---
    table.cell(colspan: 2, fill: luma(240), [*Registrierung und Anmeldung*]),
    [
      #todo[Schritte, Commands, Screenshots für Infomaniak]
    ],
    [
      #todo[Vergleich mit Railway: Unterschiede, Vor-/Nachteile]
    ],
    // --- Deployment ---
    table.cell(colspan: 2, fill: luma(240), [*Deployment*]),
    [
      #todo[Deployment-Schritte Infomaniak]
    ],
    [
      #todo[Vergleich mit Railway-Deployment]
    ],
    // --- Operations ---
    table.cell(colspan: 2, fill: luma(240), [*Operations (Start, Stop, Logs)*]),
    [
      #todo[Operations-Schritte Infomaniak]
    ],
    [
      #todo[Vergleich mit Railway-Operations]
    ],
    // --- Antworten zu den Fragen ---
    table.cell(colspan: 2, fill: luma(240), [*Antworten zu den Fragen*]),
    [
      #todo[Antworten Infomaniak (RAM, JVM, IP)]
    ],
    [
      #todo[Vergleich mit Railway]
    ],
  ),
  caption: [Gegenüberstellung: Infomaniak (Jelastic PaaS) vs. Railway],
)


// ========================================================================
// AUFGABE 4: Preisrecherche
// ========================================================================
= Analyse: Preisrecherche

== Ausgangslage

Die Preisrecherche basiert auf folgender Annahme gemäss Aufgabenstellung:

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Ressource*]),
      table.cell(fill: rgb("#E8F0FE"), [*Anforderung*]),
    ),
    [CPU], [4 Cores],
    [RAM], [8 GB],
    [Block-Storage], [100 GB],
    [Datenbank (PostgreSQL)], [50 GB Kapazität],
    [HTTP Traffic (Inbound + Outbound)], [1 TB / Monat],
    [Zusätzliche Rechenkapazität (1. Tag/Monat, 24h)], [32 Cores, 128 GB RAM],
  ),
  caption: [Ressourcenanforderungen gemäss Aufgabenstellung],
)

== Preismodelle

Infomaniak Jelastic Cloud verwendet ein *Pay-per-Use-Modell* auf Stundenbasis. Die zentrale Abrechnungseinheit ist der *Cloudlet* (1 Cloudlet = 128 MiB RAM + 400 MHz CPU). Dabei werden zwei Cloudlet-Typen unterschieden:#footnote[Vgl. https://www.infomaniak.com/en/hosting/dedicated-and-cloud-servers/jelastic-cloud]

- *Reserved Cloudlets:* Im Voraus konfigurierte Mindestressourcen. Diese werden immer berechnet, auch wenn die tatsächliche Nutzung darunter liegt. Dafür ist der Stückpreis günstiger.
- *Dynamic Cloudlets:* Automatisch zugewiesene Zusatzressourcen bei Lastspitzen. Diese werden nur berechnet, wenn sie tatsächlich genutzt werden, haben aber einen höheren Stückpreis.

Es gibt *kein klassisches Subscription-Modell* mit fixen Monatspaketen. Stattdessen kombiniert jedes Environment einen garantierten Mindestanteil (Reserved) mit einem Maximum für automatische Skalierung (Dynamic). Dies ermöglicht eine kosteneffiziente Nutzung: In Zeiten geringer Last fallen nur die Reserved-Cloudlet-Kosten an, bei Lastspitzen skaliert das System automatisch und berechnet nur den tatsächlichen Mehrverbrauch.

Der Basispreis für die kleinste Konfiguration (1 Cloudlet = 128 MB RAM, 400 MHz CPU, 20 GB Storage, 1 IPv4) liegt bei ca. *CHF 0.00865/Stunde* (ca. CHF 6.31/Monat).

== Zahlungsmethoden

Infomaniak bietet folgende Zahlungsmethoden an:
- Kredit- und Debitkarten (Visa, Mastercard)
- PayPal
- Banküberweisung (Wire Transfer)
- Prepaid-Guthaben (Konto kann im Voraus aufgeladen werden)

== Gratis-Angebot

Infomaniak bietet einen *14-tägigen kostenlosen Testaccount* für Jelastic Cloud an. Dieser unterliegt folgenden Einschränkungen:

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Eigenschaft*]),
      table.cell(fill: rgb("#E8F0FE"), [*Trial-Account*]),
    ),
    [Laufzeit], [14 Tage],
    [Max. Environments], [5],
    [Max. Leistung], [8 Cloudlets (3.2 GHz CPU + 1 GB RAM)],
    [SSD-Speicher], [10 GB],
    [Bandbreite], [20'000 Kb/s],
    [Öffentliche IP-Adressen], [Nicht verfügbar],
    [Custom SSL], [Nicht verfügbar],
    [Docker Images], [Nicht verfügbar],
  ),
  caption: [Einschränkungen des 14-tägigen Trial-Accounts],
)

Ein dauerhaft kostenloses Angebot (Free Tier) wie bei einigen Hyperscalern existiert *nicht*.#footnote[Vgl. https://www.infomaniak.com/en/support/faq/2262/jelastic-cloud-resources-available-depending-on-type-of-account]

== Abgerechnete Ressourcen

Bei Infomaniak Jelastic werden folgende Ressourcen separat abgerechnet:

- *Cloudlets (CPU + RAM):* Pro Stunde, differenziert nach Reserved und Dynamic
- *SSD-Speicher:* Pro GB pro Stunde (20 GB im Basispreis enthalten, erweiterbar bis 100 GB pro Environment)
- *Externer Traffic:* 2.8 GB/Stunde (ca. 2 TB/Monat) inklusive, darüber hinaus pro GB
- *Öffentliche IPv4-Adressen:* Pro Stunde (nur mit Bezahlaccount)
- *Interner Traffic:* Kostenlos

*Mögliche versteckte Kosten:*
- IPv4-Adressen werden separat berechnet
- SSL-Zertifikate (Let's Encrypt ist kostenlos, eigene Zertifikate erfordern öffentliche IP)
- Über dem Inklusiv-Kontingent liegender externer Traffic

== Kostenberechnung über drei Jahre

*Annahmen für die Berechnung:*
- 1 Cloudlet = 128 MiB RAM + 400 MHz CPU
- Für 8 GB RAM werden 64 Cloudlets benötigt (64 × 128 MiB = 8'192 MiB), was gleichzeitig 25.6 GHz CPU ergibt (mehr als die geforderten 4 Cores)
- Für die Burst-Kapazität (128 GB RAM) werden 1'024 Cloudlets benötigt
- Stundensatz Basis-Cloudlet: ca. CHF 0.00865 (für 1 Cloudlet inkl. 20 GB Storage + 1 IP)

#todo[Exakte Cloudlet-Preise (Reserved vs. Dynamic, CHF/Stunde) aus dem Jelastic-Dashboard oder Pricing-Calculator verifizieren und Tabelle ausfüllen. Die Preise im Dashboard unter «Quotas & Pricing» sind massgeblich.]

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, right, right, right),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Position*]),
      table.cell(fill: rgb("#E8F0FE"), [*Monatlich*]),
      table.cell(fill: rgb("#E8F0FE"), [*Jährlich*]),
      table.cell(fill: rgb("#E8F0FE"), [*3 Jahre*]),
    ),
    [Compute: 64 Reserved Cloudlets (8 GB RAM)], [--], [--], [--],
    [Block-Storage (100 GB)], [--], [--], [--],
    [PostgreSQL DB-Node + 50 GB Storage], [--], [--], [--],
    [Traffic (1 TB/Mt. -- grösstenteils inkl.)], [≈ 0], [≈ 0], [≈ 0],
    [Burst: 1'024 Dyn. Cloudlets (24h/Mt.)], [--], [--], [--],
    [Öffentliche IPv4-Adresse], [--], [--], [--],
    table.cell(fill: luma(240), [*Total*]),
    table.cell(fill: luma(240), [*--*]),
    table.cell(fill: luma(240), [*--*]),
    table.cell(fill: luma(240), [*--*]),
  ),
  caption: [Kostenberechnung über drei Jahre (Preise aus Dashboard verifizieren)],
)

*Hinweis zum Traffic:* Im Bezahlaccount sind 2.8 GB/Stunde externer Traffic inkludiert, was ca. 2 TB/Monat entspricht. Da laut Aufgabenstellung nur 1 TB/Monat anfallen, dürften *keine zusätzlichen Traffic-Kosten* entstehen.

== Schwierigkeiten beim Vergleich

Beim Preisvergleich zwischen verschiedenen Cloud-Providern treten mehrere Schwierigkeiten auf:

- *Unterschiedliche Abrechnungseinheiten:* Jelastic verwendet das Cloudlet-Modell (128 MiB + 400 MHz), während andere Provider direkt nach vCPUs und GB RAM abrechnen. Eine direkte Gegenüberstellung erfordert Umrechnungen und ist nicht trivial.

- *Kopplung von CPU und RAM:* Bei Jelastic sind CPU und RAM in einem Cloudlet fest gekoppelt. Man kann nicht unabhängig voneinander mehr CPU bei gleichem RAM oder umgekehrt bestellen. Für CPU-intensive Workloads (4 Cores gefordert) erhält man mit 64 Cloudlets deutlich mehr CPU (25.6 GHz) als nötig, weil der RAM der limitierende Faktor ist.

- *Pay-per-Use vs. fixe Instanzen:* Das stündliche Pay-per-Use-Modell von Jelastic unterscheidet sich fundamental von fixen Monats- oder Jahrespreisen anderer Provider. Die tatsächlichen Kosten hängen stark vom Nutzungsprofil ab.

- *Versteckte Kosten:* IPv4-Adressen, SSL-Zertifikate und Traffic-Überschreitungen werden bei verschiedenen Providern unterschiedlich gehandhabt. Manche Provider inkludieren diese, andere berechnen sie separat.

- *Burst-Kapazität:* Die Möglichkeit, für nur 24 Stunden pro Monat auf 32 Cores / 128 GB zu skalieren, ist mit dem Cloudlet-Modell von Jelastic gut abbildbar (Dynamic Cloudlets werden nur bei Nutzung berechnet), während dies bei Fixed-Instance-Providern eine separate, grössere Instanz erfordern würde.

- *Regionale Preisunterschiede:* Infomaniak als Schweizer Provider rechnet in CHF ab und hat Datacenter ausschliesslich in der Schweiz, was für Schweizer Kunden ein Vorteil, preislich aber möglicherweise teurer als US-basierte Hyperscaler sein kann.


// ========================================================================
// AUFGABE 5: Service Level Agreements (SLAs)
// ========================================================================
= Analyse: Service Level Agreements (SLAs)

Infomaniak definiert seine SLA-Bedingungen in den «Besonderen Geschäftsbedingungen» (AGB) für Cloud-Server-Dienste, konkret in Artikel 7 (Non-managed) bzw. Artikel 8 (Managed Cloud-Server). Im Folgenden werden die SLA-Bedingungen analysiert und die Review-Fragen beantwortet.#footnote[Quelle: Infomaniak Besondere Geschäftsbedingungen -- Managed und Non-managed Cloud-Server, Überprüfung vom 25.04.2023. Abrufbar unter https://www.infomaniak.com/en/legal/general-terms-and-conditions]

== Service Level Objectives (SLOs)

Infomaniak definiert ein klares Service Level Objective: Die garantierte *Verfügbarkeitsrate beträgt 99.99%*. Dies entspricht einer maximalen erlaubten Ausfallzeit von lediglich *5 Minuten pro Monat*. Die Verfügbarkeitsrate berechnet sich aus der Gesamtzahl der Minuten im Monat abzüglich der Nichtverfügbarkeitsminuten, geteilt durch die Gesamtzahl der Minuten. Dieses SLO ist im Vergleich zu vielen anderen Providern sehr ambitioniert -- die meisten Hyperscaler garantieren 99.9% bis 99.95%. Explizite Performance-Garantien (z.B. garantierte IOPS oder Latenzwerte) werden jedoch nicht definiert; das SLO bezieht sich ausschliesslich auf die Infrastruktur-Verfügbarkeit.

Darüber hinaus definiert Infomaniak *Fehlerklassen mit maximalen Antwortzeiten:*

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Fehlerklasse*]),
      table.cell(fill: rgb("#E8F0FE"), [*Auswirkung*]),
      table.cell(fill: rgb("#E8F0FE"), [*Max. Unterbrechung*]),
    ),
    [A], [Nichtverfügbarkeit der Dienstleistung], [5 Minuten],
    [A2], [Zusätzliche Minuten der Nichtverfügbarkeit von A], [1 Minute],
    [B], [Verlangsamung des Internetnetzes], [60 Minuten],
    [C], [Problem der Dienstleistungssicherheit], [60 Minuten],
    [D], [Problem mit dem Service-Update], [120 Minuten],
    [E], [Ausfall eines virtuellen Servers des Kunden], [120 Minuten],
  ),
  caption: [Fehlerklassen und maximale Unterbrechungszeiten gemäss Infomaniak AGB],
)

== «Questions to Ask» (Dimension Data White Paper)

=== 1. What is covered by the SLA?

Das SLA von Infomaniak deckt die *Infrastruktur-Verfügbarkeit* ab: Netzwerkkonnektivität, Server-Hardware, Stromversorgung und Kühlung in den eigenen Rechenzentren sowie die Verfügbarkeit der Cloud-Plattform. Explizit *ausgeschlossen* sind: Probleme auf Applikationsebene, Fehler durch Kundenkonfiguration oder -code, Dienste von Drittanbietern, geplante Wartungsarbeiten sowie Ereignisse höherer Gewalt. Auch die unsachgemässe Nutzung des Dienstes durch den Kunden sowie Sperrungen aufgrund von AGB-Verstössen sind von den Sanktionen ausgenommen. Das SLA ist somit primär ein *Infrastruktur-SLA*, nicht ein Applikations-SLA.

=== 2. What are the service levels?

Der zentrale Service Level ist die *99.99% monatliche Verfügbarkeitsgarantie*. Die Berechnung erfolgt auf Monatsbasis. Infomaniak bietet keine gestaffelten Service-Level-Tiers an (z.B. 99.9% vs. 99.99% zu verschiedenen Preispunkten), wie dies bei Hyperscalern wie AWS oder Azure üblich ist. Es gibt einen einheitlichen Standard-SLA für alle Cloud-Kunden. Geplante Wartungsarbeiten, über die der Kunde spätestens *48 Arbeitsstunden im Voraus* informiert wird, haben eine aufschiebende Wirkung auf die Sanktionen und werden nicht als Downtime gewertet.

=== 3. What happens when service levels are not met?

Bei Nichteinhaltung der Service Levels kann der Kunde *Vertragsstrafen* geltend machen. Die Höhe ist gestaffelt nach Fehlerklasse und Anzahl Vorfälle pro Jahr:

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Fehlerklasse*]),
      table.cell(fill: rgb("#E8F0FE"), [*Vorkommen/Jahr*]),
      table.cell(fill: rgb("#E8F0FE"), [*Strafe (% der Vertragssumme)*]),
    ),
    [A], [1], [10%],
    [A], [2], [20%],
    [A], [3], [30%],
    [A], [4+], [50% mit möglicher Vertragsverletzung],
    [B bis E], [2], [5%],
    [B bis E], [4], [10%],
    [B bis E], [6], [20%],
    [B bis E], [8+], [30%],
  ),
  caption: [Vertragsstrafen bei SLA-Verletzungen gemäss Infomaniak AGB],
)

Die Vertragsstrafe darf *maximal 50% des laufenden Vertrags* nicht überschreiten. Der Kunde muss die Nichtverfügbarkeit *innerhalb von zwei Monaten* nach Auftreten melden und dabei Datum, Uhrzeit des Beginns und Endes angeben. Infomaniak analysiert die Ursache und entscheidet, ob die Nichtverfügbarkeit von Infomaniak verschuldet wurde. Die Entschädigung erfolgt als *Gutschrift auf das Prepaid-Konto*, nicht als Barauszahlung.

=== 4. How are service levels measured?

Infomaniak überwacht die Verfügbarkeit seiner Dienste *kontinuierlich mittels eigener Messindikatoren* und kann so die gesamte System- und Netzinfrastruktur überwachen (Art. 7.2.4 AGB). Infomaniak ergreift proaktiv Massnahmen zur Systemverfügbarkeit und zur Erkennung potenzieller infrastrukturbedingter Störungen. Die Messmethodik (Intervalle, Messpunkte) wird jedoch *nicht detailliert offengelegt*. Im Streitfall sind Infomaniaks interne Monitoring-Daten die Referenz. Der Kunde hat begrenzte Möglichkeiten, die SLA-Einhaltung unabhängig zu verifizieren. Dies ist eine *Transparenzlücke* im Vergleich zu Hyperscalern, die oft öffentliche Status-Dashboards mit historischen Uptime-Daten bereitstellen.

=== 5. What are the customer's obligations?

Die Kundenpflichten sind in Artikel 5 der AGB umfassend definiert: Der Kunde ist *allein verantwortlich* für die auf dem Dienst installierten Inhalte, Daten sowie deren Entwicklung, Betrieb, Wartung und Support. Der Kunde muss seine Applikationen und deren Abhängigkeiten aktuell halten. Bei Problemen durch veraltete Software kann Infomaniak nicht haftbar gemacht werden. Zudem ist der Kunde für die *Datensicherung* verantwortlich -- Infomaniak erstellt keine automatischen Sicherungskopien, es sei denn, der Kunde aktiviert den Snapshot-Slot explizit. Der Kunde muss Störungen *unverzüglich über das Supportportal melden* und alle nötigen Informationen bereitstellen.

== Fehlende Evaluationskriterien

Das Dimension Data White Paper bietet einen soliden Rahmen für die SLA-Evaluation, lässt aus unserer Sicht aber einige relevante Aspekte unberücksichtigt:

- *Datensouveränität und Gerichtsstand:* Gerade für europäische und Schweizer Unternehmen ist die Frage, unter welcher Jurisdiktion die Daten liegen und welches Recht im Streitfall gilt, von zentraler Bedeutung. Infomaniak hat den Gerichtsstand in *Genf, Schweiz*, was unter Schweizer Recht fällt und keiner US-Gesetzgebung (z.B. CLOUD Act) unterliegt.

- *Datenlokation und Portabilität:* Wo genau werden die Daten physisch gespeichert? Infomaniak hostet ausschliesslich in Schweizer Rechenzentren (Genf und Winterthur). Zudem stellt sich die Frage der Datenportabilität: Wie einfach lassen sich Daten und Applikationen zu einem anderen Provider migrieren?

- *Ökologische Aspekte:* In Zeiten wachsenden Umweltbewusstseins wäre ein Kriterium zur Nachhaltigkeit sinnvoll. Infomaniak wirbt mit 100% erneuerbarer Energie und ISO 14001-Zertifizierung.

- *Exit-Strategie:* Was passiert bei Vertragsende? Nach Beendigung werden Daten gemäss AGB *sofort und unwiderruflich gelöscht*. Der Kunde muss seine Daten vorher selbständig sichern.

== Bedeutung von SLAs

*a) Bei der Entscheidung, in die Cloud zu gehen:* SLAs sind ein wichtiger, aber nicht der einzige Faktor bei der Cloud-Entscheidung. Sie schaffen Vertrauen und eine vertragliche Grundlage für die erwartete Dienstqualität. Für unternehmenskritische Anwendungen sind sie essentiell, da sie definieren, welche Verfügbarkeit man erwarten kann und welche Kompensation bei Nichteinhaltung vorgesehen ist. Allerdings garantieren selbst ambitionierte SLAs wie Infomaniaks 99.99% keine absolute Ausfallsicherheit -- Unternehmen müssen zusätzlich eigene Redundanz- und Backup-Strategien implementieren.

*b) Bei der Provider-Auswahl:* SLAs sind ein wichtiges Differenzierungsmerkmal zwischen Providern, sollten aber kritisch hinterfragt werden. Ein 99.99%-SLA ist nur so viel wert wie die dahinterstehende Infrastruktur und der Kompensationsmechanismus. Infomaniaks Ansatz mit gestaffelten Vertragsstrafen bis maximal 50% der Vertragssumme ist deutlich konkreter als bei manchen kleineren Providern, bleibt aber hinter den automatisierten Credit-Systemen der Hyperscaler zurück. Letztlich sollte die SLA-Bewertung stets im Kontext des Gesamtpakets erfolgen: Preis, Funktionalität, Support-Qualität und nicht zuletzt die tatsächliche historische Verfügbarkeit.

== Weitere relevante Dokumente

Neben dem SLA gibt es weitere Dokumente, die ein zukünftiger Cloud-Consumer sorgfältig prüfen sollte:

- *Allgemeine Nutzungsbedingungen (ANB/AGB):* Regeln die grundsätzlichen Vertragsbeziehungen, Kündigungsfristen und Haftungsbeschränkungen. Infomaniak: https://www.infomaniak.com/en/legal/general-terms-and-conditions

- *Datenschutzrichtlinien:* Infomaniak unterliegt dem Schweizer Datenschutzgesetz (nDSG, seit 1. September 2023 in Kraft) und gewährleistet DSGVO-konforme Datenverarbeitung. Alle Daten werden *ausschliesslich in Rechenzentren in der Schweiz* gespeichert, die Eigentum von Infomaniak sind (Art. 6.1 AGB).

- *Auftragsverarbeitungsvertrag (AVV/DPA):* Erforderlich bei der Verarbeitung personenbezogener Daten. Definiert die Rollen (Infomaniak als Auftragsverarbeiter), technisch-organisatorische Massnahmen und Unterauftragnehmer. Verfügbar unter: https://www.infomaniak.com/en/legal/data-protection-act

- *Gerichtsstand:* Ausschliesslicher Gerichtsstand ist *Genf, Schweiz*. Alle Streitigkeiten unterliegen Schweizer Recht. Für Schweizer Kunden bedeutet dies Rechtssicherheit in einer stabilen Jurisdiktion ohne Exposition gegenüber US-Gesetzen wie dem CLOUD Act.

- *Datacenter-Informationen:* Infomaniak betreibt eigene Rechenzentren in der Region Genf und Winterthur/Zürich. Diese sind mit N+1-Redundanz für Netzwerk, Strom und Kühlung ausgestattet und ISO 27001-zertifiziert. Informationen unter: https://www.infomaniak.com/en/about/our-datacenters

- *Datensicherung (Art. 6 AGB):* Besonders wichtig: Beim Non-managed Cloud-Server erstellt Infomaniak *keine automatischen Backups*. Der Kunde muss den Snapshot-Slot selbst aktivieren und ist allein für die Integrität und Sicherung seiner Daten verantwortlich.


// ========================================================================
// AUFGABE 6: Management Summary
// ========================================================================
= Analyse: Management Summary

*Empfehlung: Infomaniak Jelastic Cloud als PaaS-Provider*

Infomaniak positioniert sich als Schweizer Alternative zu den grossen Hyperscalern und richtet sich mit seinem Jelastic-Cloud-Angebot gezielt an KMU, Entwicklerteams und Organisationen, die Wert auf Datensouveränität legen.

*Stärken:*
- *Datensouveränität:* Alle Daten verbleiben in der Schweiz, unterliegen Schweizer Recht (nDSG) und sind nicht dem US CLOUD Act ausgesetzt. Für Unternehmen mit regulatorischen Anforderungen (Finanzbranche, Gesundheitswesen, öffentliche Verwaltung) ist dies ein entscheidendes Argument.
- *Feingranulare Skalierung:* Das Cloudlet-Modell ermöglicht eine stufenweise, automatische vertikale Skalierung ohne Downtime. Besonders für Workloads mit variablem Ressourcenbedarf (z.B. saisonale Schwankungen) ist dies kosteneffizient.
- *Ambitioniertes SLA:* Die 99.99%-Verfügbarkeitsgarantie mit konkretem Strafenkatalog übertrifft viele Wettbewerber.
- *Nachhaltigkeit:* 100% erneuerbare Energie und ISO 14001-Zertifizierung.
- *Self-Service-Vollständigkeit:* Dashboard, API, CLI und SSH decken alle operativen Bedürfnisse ab.

*Einschränkungen:*
- *Keine Multi-Region-Verfügbarkeit:* Alle Datacenter befinden sich in der Schweiz. Für global verteilte Anwendungen mit Latenz-Anforderungen in anderen Regionen ist dies ein Nachteil.
- *Kleineres Ökosystem:* Im Vergleich zu AWS, Azure oder GCP fehlen zahlreiche Managed Services (z.B. Serverless Functions, KI/ML-Services, IoT-Plattformen).
- *Cloudlet-Kopplung:* CPU und RAM sind in Cloudlets fest gekoppelt. Bei asymmetrischen Anforderungen (z.B. viel CPU, wenig RAM) kann dies zu Mehrkosten führen.
- *Transparenzlücken:* SLA-Messmethodik nicht öffentlich detailliert; Kompensation nur auf Antrag und als Prepaid-Gutschrift.

*Fazit:* Infomaniak Jelastic Cloud eignet sich besonders für *Schweizer Unternehmen und Organisationen*, die eine PaaS-Lösung mit vollständiger Datensouveränität in der Schweiz benötigen. Für Standard-Webapplikationen, Java-basierte Backends und containerisierte Microservices bietet die Plattform eine solide, kosteneffiziente Lösung. Für Unternehmen, die ein breites Spektrum an Managed Cloud Services, globale Präsenz oder hochspezialisierte Dienste (KI, Big Data) benötigen, bleiben die Hyperscaler die bessere Wahl. Infomaniak empfiehlt sich somit als *starker Nischen-Provider* für den Schweizer Markt -- nicht als Allround-Alternative zu AWS oder Azure.


// ========================================================================
// ANHANG
// ========================================================================
= Anhang <anhang>

== Hilfsmittelverzeichnis

Gemäss der «Leitlinie zum Umgang mit KI-basierten Hilfsmitteln in Lehre und Weiterbildung» der OST (September 2024) deklarieren wir den Einsatz folgender KI-Tools:

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Tool*]),
      table.cell(fill: rgb("#E8F0FE"), [*Verwendungszweck*]),
      table.cell(fill: rgb("#E8F0FE"), [*Umfang*]),
    ),
    [Claude Code (Anthropic, Claude Opus 4)],
    [Unterstützung bei Recherche (Preise, SLA-Analyse, OSSM-Kriterien), Strukturierung des Berichts, Textformulierung, Erstellung des Typst-Templates],
    [Alle Analyse-Kapitel (Kap. 2, 4, 5, 6) wurden mit KI-Unterstützung recherchiert und vorformuliert. Alle Fakten wurden anhand der Primärquellen (Infomaniak-Website, AGB-Dokumente) verifiziert.],
  ),
  caption: [Eingesetzte KI-Tools gemäss OST-Leitlinie],
)

Sämtliche Hands-On-Aufgaben (Kapitel 1 und 3) wurden eigenständig durchgeführt. Die Verantwortung für alle Inhalte, Aussagen und Schlussfolgerungen liegt bei den Autoren.

== Quellenverzeichnis

+ Infomaniak -- Jelastic Cloud Produktseite. https://www.infomaniak.com/en/hosting/dedicated-and-cloud-servers/jelastic-cloud

+ Infomaniak -- Jelastic Cloud Ressourcen und Account-Typen. https://www.infomaniak.com/en/support/faq/2262/jelastic-cloud-resources-available-depending-on-type-of-account

+ Infomaniak -- Allgemeine und besondere Geschäftsbedingungen. https://www.infomaniak.com/en/legal/general-terms-and-conditions

+ Infomaniak -- Datenschutzrichtlinie. https://www.infomaniak.com/en/legal/confidentiality-policy

+ Infomaniak -- Datenschutz-Grundverordnung (DPA). https://www.infomaniak.com/en/legal/data-protection-act

+ Infomaniak -- Besondere Geschäftsbedingungen Managed und Non-managed Cloud-Server (PDF, Überprüfung vom 25.04.2023).

+ Jelastic / Virtuozzo -- Plattform-Dokumentation. https://docs.jelastic.com/

+ Jelastic / Virtuozzo -- API-Dokumentation. https://docs.jelastic.com/api/

+ Jelastic -- Automatic Vertical Scaling. https://docs.jelastic.com/automatic-vertical-scaling/

+ Jelastic -- Automatic Horizontal Scaling. https://docs.jelastic.com/automatic-horizontal-scaling/

+ OST -- Leitlinie zum Umgang mit KI-basierten Hilfsmitteln in Lehre und Weiterbildung (September 2024).

+ WHTop -- Infomaniak Jelastic Cloud Plan Details. https://www.whtop.com/plans/infomaniak.com/135580
