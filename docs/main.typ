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

Infomaniak ist ein unabhängiger Schweizer Cloud- und Hosting-Provider mit Hauptsitz in Genf, gegründet 1994. Das Unternehmen betreibt eigene Rechenzentren in der Schweiz (Genf und Winterthur) und positioniert sich als datensouveräne Alternative zu den US-amerikanischen Hyperscalern. Alle Daten unterliegen ausschliesslich Schweizer Recht und sind nicht dem US CLOUD Act ausgesetzt. Infomaniak ist ISO 27001- und ISO 14001-zertifiziert und betreibt seine Infrastruktur mit 100% erneuerbarer Energie.

Neben klassischen Hosting-Produkten (Webhosting, E-Mail, Domains) bietet Infomaniak mit der *Jelastic Cloud* eine PaaS-Lösung an, die auf der Virtuozzo/Jelastic-Plattform basiert. Jelastic ermöglicht das Deployment von Applikationen in einer Vielzahl von Technologien -- darunter Java, Go, Node.js, PHP, Python, Ruby und .NET -- sowie Docker-Container und Kubernetes-Cluster. Die Plattform zeichnet sich durch automatische vertikale Skalierung, ein Pay-per-Use-Abrechnungsmodell auf Stundenbasis und ein integriertes Web-Dashboard zur Verwaltung aus.

#screenshot("artifakte/value_proposition_jpc.png", caption: [Willkommensseite der Infomaniak Jelastic Cloud mit Übersicht der Plattform-Features.])

== Registrierung und Setup

Der Registrierungsprozess bei Infomaniak verläuft über die Hauptwebsite und erinnert an klassische Schweizer Hosting-Provider wie Hostpoint. Die Oberfläche ist einfach gehalten und richtet sich primär an ein weniger technisches Publikum -- für erfahrene Entwickler wirkt der Prozess eher ungewohnt im Vergleich zu den Onboarding-Flows moderner Cloud-Plattformen.

*Verifikation:* Die Identitätsprüfung erfolgt telefonisch: Man wird an eine Nummer angerufen und muss innerhalb von zwei Minuten dreimal bestätigen. Dieser Prozess ist ungewöhnlich, aber funktional. Die erste Bestellung einer Public-Cloud-Instanz erfordert sofort eine Zahlung. Positiv hervorzuheben ist, dass neben Kreditkarte auch *Twint* als Zahlungsmittel angeboten wird -- für einen Schweizer Provider erwartbar, aber dennoch ein Pluspunkt gegenüber internationalen Anbietern.

*Problem bei der Erstbestellung:* Die initiale Bestellung wurde gesperrt, da die Verifikation noch nicht abgeschlossen war. Beim Versuch, den Vorgang fortzusetzen, erschien lediglich eine generische Fehlermeldung ohne Hinweis auf das weitere Vorgehen. Da der telefonische Support für Nicht-Premium-Kunden nur Montag bis Freitag von 09:00 bis 18:00 Uhr erreichbar ist, musste am Wochenende ein Support-Ticket eröffnet werden. Der Support antwortete über den Chat und bot als alternative Identifikation an, ein Foto des Ausweises sowie ein Selfie mit dem Ausweis einzusenden. Nach Einsendung wurde die Bestellung zeitnah freigeschaltet.

*MFA-Einrichtung:* Der Multi-Faktor-Authentifizierungsprozess war hingegen vorbildlich umgesetzt. Die Aufforderung zur Aktivierung war klar als «Action Required» gekennzeichnet, und der Einrichtungsprozess verlief reibungslos.

*Zugang zur Jelastic Cloud:* Der Zugang zum Jelastic-Dashboard war initial schwierig zu finden. Der Name «Jelastic Cloud» ist im Kontext des ansonsten klar strukturierten Infomaniak-Portfolios ungewohnt und nicht sofort als PaaS-Lösung erkennbar. Einmal gefunden, wirkt das Dashboard jedoch aufgeräumt und weniger überladen als die Konsolen grosser Hyperscaler.

== Hello-World-Tutorial

Anstelle eines trivialen Beispiels wurde eine eigene Go-Applikation entwickelt: das *Swiss Transport Board*. Die Applikation zeigt Live-Abfahrtszeiten des Schweizer öffentlichen Verkehrs an, basierend auf der offenen API von transport.opendata.ch. Als Caching-Layer wird Memcached eingesetzt, um wiederholte API-Anfragen zu vermeiden.

*Stack:*
- Go (net/http, kein Framework)
- Memcached (gomemcache)
- HTML/CSS inline (kein Frontend-Framework)

=== Environment erstellen

Im Jelastic Dashboard wurde über «New Environment» ein neues Environment mit folgender Topologie erstellt:

- *Application Server:* Go (Golang 1.26.1)
- *Cache:* Memcached 1.6.41
- *Cloudlets:* 2 Reserved, bis zu 10 Dynamic (Scaling Limit)
- *Datacenter:* Geneva DC3

#screenshot("artifakte/jpc_add_enviroment.png", caption: [Topology Wizard: Erstellung des Go-Environments mit Memcached-Cache-Node im Datacenter Geneva DC3.])

=== Deployment via Git-Integration

Das Deployment erfolgt über die integrierte Git-Anbindung im Jelastic Dashboard. Im Deployment Manager unter dem Reiter «Git/SVN» wird eine beliebige Git-Repository-URL und der gewünschte Branch (in unserem Fall `main`) angegeben -- die Integration ist vendor-neutral und funktioniert mit GitHub, GitLab (z.B. gitlab.ost.ch), Bitbucket oder jedem anderen Git-Server gleichermassen. Jelastic klont das Repository, führt automatisch `go get` und `go build` aus und startet die Applikation. Die Option «Check and auto-deploy updates» wurde aktiviert, sodass bei Änderungen im Repository automatisch ein Redeployment ausgelöst wird.

Anfänglich befand sich der Go-Code in einem Unterverzeichnis (`swiss-transport-board/`). Da die Git-Integration von Jelastic keine Monorepo-Strukturen mit Unterverzeichnissen unterstützt, musste die Projektstruktur angepasst werden: Die Go-Dateien wurden in das Repository-Root verschoben.

#screenshot("artifakte/jpc_env_group.png", caption: [Laufendes Environment mit Go Application Server (Node 197699) und Memcached Cache (Node 197700), deployed via Git-Integration.])

=== Laufende Applikation

Nach erfolgreichem Deployment ist die Applikation unter der Jelastic-URL erreichbar. Die Abfahrtszeiten werden live von der Transport-API abgerufen und mit Linie, Ziel, Gleis und allfälliger Verspätung angezeigt.

#screenshot("artifakte/swiss_transport_app.png", caption: [Swiss Transport Board: Live-Abfahrten ab Rapperswil SG mit S-Bahn-, IR- und Regionalverbindungen.])

== Teamarbeit und Deployment

Die Zusammenarbeit im Team erfolgt über das gemeinsame Git-Repository. Beide Teammitglieder können Code pushen, wodurch über die aktivierte Auto-Deploy-Funktion automatisch ein Redeployment auf der Jelastic-Plattform ausgelöst wird. De facto können somit beide Teammitglieder indirekt deployen, ohne direkten Zugang zum Jelastic-Dashboard zu benötigen.

*Einschränkungen bei der Zugriffsverwaltung:* Die Jelastic Cloud von Infomaniak bietet kein Multi-User- oder Team-Management für ein einzelnes Environment. Es gibt lediglich die Möglichkeit, die *Ownership eines Environments zu transferieren* -- ein gleichzeitiger Zugriff mehrerer Benutzer auf dasselbe Dashboard-Konto ist nicht vorgesehen. Dies ist ein deutlicher Nachteil gegenüber Hyperscalern wie AWS (IAM) oder Azure (RBAC), die feingranulare Zugriffsrechte und Team-Kollaboration ermöglichen.

*Workaround:* Durch die Git-Integration wird dieses Problem für den Deployment-Workflow weitgehend entschärft: Beide Teammitglieder arbeiten im Git-Repository, und das Deployment wird automatisch durch Pushes auf den `main`-Branch ausgelöst. Für administrative Aufgaben (Environment-Konfiguration, Logs, Monitoring) ist jedoch nur der Account-Inhaber zuständig.

== Beantwortung der Fragen

=== Weshalb haben Sie diesen Provider für die Evaluation ausgewählt?

Infomaniak wurde aus mehreren Gründen als Evaluationsgegenstand gewählt:

- *Schweizer Datensouveränität:* Als einer der wenigen Schweizer Cloud-Provider mit eigener PaaS-Lösung bietet Infomaniak eine interessante Alternative zu den US-dominierten Hyperscalern. Gerade im Kontext des Schweizer Datenschutzgesetzes (nDSG) und der zunehmenden Diskussion um den US CLOUD Act ist dies ein relevantes Differenzierungsmerkmal.

- *Jelastic als unbekannte Plattform:* Im Gegensatz zu den weitverbreiteten Plattformen (AWS, Azure, GCP, Railway) war Jelastic für beide Teammitglieder Neuland. Die Evaluation bot die Gelegenheit, eine weniger bekannte PaaS-Lösung kennenzulernen und mit den etablierten Anbietern zu vergleichen.

- *Lokaler Bezug:* Infomaniak ist in der Schweizer IT-Landschaft als Hosting-Provider bekannt, die Jelastic-Cloud-Lösung hingegen weniger. Es war interessant zu untersuchen, wie sich ein Schweizer Anbieter im PaaS-Segment schlägt.

- *Skepsis gegenüber Hyperscalern:* Die jüngsten Preiserhöhungen bei Azure haben die kritische Haltung gegenüber der Abhängigkeit von grossen US-Cloud-Providern zusätzlich verstärkt. Dies motivierte, einen lokalen Anbieter als mögliche Alternative zu evaluieren.

=== Möglichkeiten zum Starten und Stoppen der Applikation

Jelastic bietet mehrere Wege, eine Applikation zu starten und zu stoppen:

- *Dashboard:* Im Environment-Überblick stehen Buttons für «Start», «Stop» und «Restart» zur Verfügung. Das gesamte Environment oder einzelne Nodes können unabhängig gesteuert werden. Ein gestopptes Environment verbraucht keine Cloudlets und verursacht entsprechend keine Kosten (ausser für reservierten Speicherplatz und öffentliche IPs).

- *REST API:* Über die Jelastic API können Environments programmatisch gestartet und gestoppt werden (`environment.control.StartEnv` / `StopEnv`). Dies ermöglicht die Integration in externe Automatisierungstools.

- *CLI:* Das Jelastic CLI bietet entsprechende Kommandos für die skriptbasierte Verwaltung.

- *Auto-Scaling:* Obwohl kein expliziter Start/Stop, werden Dynamic Cloudlets automatisch alloziert und freigegeben, was einem automatischen «Scale-to-near-zero» gleichkommt -- bei minimaler Last fallen nur die Reserved-Cloudlet-Kosten an.

=== Deployment-Automatisierung

Für die Deployment-Automatisierung bietet Jelastic mehrere Ansätze:

- *Git Auto-Deploy (eingesetzt):* Die von uns genutzte Variante. Im Deployment Manager wird ein Git-Repository hinterlegt und die Option «Check and auto-deploy updates» aktiviert. Jelastic prüft periodisch (konfigurierbar) auf Änderungen im Repository und deployt automatisch. Dies ist die einfachste Automatisierungsmöglichkeit und wurde für unser Projekt eingerichtet.

- *REST API + CI/CD-Pipeline:* Über die Jelastic REST API lässt sich ein Deployment aus einer CI/CD-Pipeline (z.B. GitHub Actions, GitLab CI, Jenkins) auslösen. Der typische Ablauf wäre: Code pushen, CI-Pipeline baut und testet, bei Erfolg wird via API-Call ein Redeployment auf Jelastic ausgelöst. Dieses Vorgehen ermöglicht eine engere Kontrolle (z.B. Deployment nur nach bestandenen Tests).

- *Jelastic CLI in Scripts:* Das CLI kann in Shell-Scripts oder CI-Jobs eingebettet werden und bietet ähnliche Möglichkeiten wie die REST API.

Für unser Projekt wurde die Git-Auto-Deploy-Variante gewählt, da sie den geringsten Aufwand erfordert und für eine Hello-World-Applikation ausreichend ist. Zusätzlich haben wir eine GitHub-Actions-Pipeline eingerichtet, die bei jedem Push Linting, Tests und Security-Checks durchführt -- das eigentliche Deployment wird jedoch von Jelastic direkt über die Git-Integration ausgelöst.

=== Logging und Monitoring

*Log-Zugriff:* Jelastic bietet Zugang zu den Applikations-Logs über das Dashboard. Über den «Log»-Button am jeweiligen Node öffnet sich ein Log-Viewer, der die verfügbaren Log-Dateien auflistet. Im Hintergrund handelt es sich um einen FTP-Wrapper, der den Zugriff auf die Log-Dateien des Containers ermöglicht. Für technisch versierte Benutzer ist dies ausreichend, für Einsteiger dürfte die Darstellung jedoch unübersichtlich sein. Alternativ kann über SSH direkt auf die Log-Dateien zugegriffen werden.

HTTP Requests und Responses sind in den Go-Applikations-Logs sichtbar, sofern die Applikation diese selbst loggt (in unserem Fall via `slog`). Ein integriertes HTTP-Request-Logging auf Plattformebene (vergleichbar mit einem Access-Log eines vorgeschalteten Reverse Proxys) ist nicht standardmässig vorhanden, kann aber durch Hinzufügen eines Load-Balancer-Nodes (z.B. NGINX) erreicht werden.

*Monitoring:* Jeder Node verfügt über ein Statistik-Panel, das CPU-Auslastung, RAM-Verbrauch, Disk-I/O und Netzwerk-Traffic in Echtzeit anzeigt. Historische Daten können über verschiedene Zeiträume (1 Stunde bis 1 Monat) visualisiert werden. Die Darstellung ist funktional, aber schlicht -- externe Monitoring-Tools wie Grafana oder Datadog müssten manuell integriert werden.

*Fehlermeldungen:* Die Fehlermeldungen der Plattform sind verbesserungswürdig. Beispielsweise lieferte ein fehlgeschlagenes Deployment lediglich die Meldung _«The [jem vcs update] operation has failed: Project updated failed»_ ohne weitere Hinweise auf die Ursache. Die Lösung erforderte das manuelle Durchsuchen der Log-Dateien. Im Vergleich dazu bieten auch grosse Provider wie Azure keine durchwegs bessere Erfahrung beim Log-Zugriff, jedoch sind deren Fehlermeldungen in der Regel informativer.

=== Vor- und Nachteile gegenüber Railway

Railway ist eine moderne, entwicklerzentrierte PaaS-Plattform mit Sitz in den USA, die sich durch ein besonders einfaches Developer-Experience auszeichnet. Im Folgenden wird Infomaniak Jelastic mit Railway verglichen:

*Vorteile von Infomaniak Jelastic gegenüber Railway:*
- *Datensouveränität:* Daten verbleiben in der Schweiz unter Schweizer Recht -- Railway hostet auf GCP in den USA.
- *Feingranulare Skalierung:* Das Cloudlet-Modell ermöglicht eine stufenweise vertikale Skalierung. Railway bietet zwar auch automatische Skalierung, jedoch weniger transparent.
- *Infrastrukturkontrolle:* Jelastic erlaubt die Konfiguration der gesamten Topologie (Load Balancer, Cache-Nodes, Datenbanken) über den Topology Wizard. Railway abstrahiert die Infrastruktur stärker.
- *SSH-Zugang:* Direkter Terminal-Zugang zu den Containern für Debugging. Railway bietet dies nur eingeschränkt.

*Nachteile von Infomaniak Jelastic gegenüber Railway:*
- *Developer Experience:* Railway bietet ein deutlich moderneres Onboarding. Ein Deployment ist innerhalb von Minuten via `railway up` oder Git-Integration möglich -- ohne manuelle Topologie-Konfiguration.
- *UI/UX:* Das Jelastic-Dashboard wirkt im Vergleich zu Railways schlankem Interface veraltet und verschachtelt.
- *Fehlermeldungen:* Railway liefert klare Build-Logs direkt im Dashboard; bei Jelastic sind die Fehlermeldungen oft kryptisch.
- *Monorepo-Support:* Railway unterstützt Monorepos mit konfigurierbarem Root-Directory nativ. Jelastic erfordert, dass die Applikation im Repository-Root liegt.
- *Team-Kollaboration:* Railway bietet native Team-Features mit rollenbasiertem Zugriff. Jelastic erlaubt nur einen einzelnen Account-Inhaber pro Environment.
- *Gratis-Angebot:* Railway bietet ein dauerhaftes Free Tier (mit Einschränkungen), Infomaniak lediglich einen 14-tägigen Trial.


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
      Registrierung über Infomaniak-Website. Telefonische Verifikation oder alternativ ID + Selfie. MFA-Aktivierung gut umgesetzt. Zugang zur Jelastic Cloud nicht sofort intuitiv auffindbar.
    ],
    [
      Railway: Anmeldung via GitHub OAuth in Sekunden. Keine Identitätsprüfung nötig. Sofortiger Zugang zum Dashboard. Deutlich schnelleres Onboarding.
    ],
    // --- Deployment ---
    table.cell(colspan: 2, fill: luma(240), [*Deployment*]),
    [
      Environment manuell im Topology Wizard erstellen (Go + Memcached). Git-Repository im Deployment Manager hinterlegen. Auto-Deploy aktivieren. Kein Monorepo-Support -- Applikation muss im Repository-Root liegen.
    ],
    [
      Railway: `railway up` oder GitHub-Repo verknüpfen. Automatische Build-Erkennung (Dockerfile, Nixpacks). Monorepo-Support mit konfigurierbarem Root-Directory. Deutlich weniger manuelle Konfiguration.
    ],
    // --- Operations ---
    table.cell(colspan: 2, fill: luma(240), [*Operations (Start, Stop, Logs)*]),
    [
      Start/Stop/Restart über Dashboard-Buttons, REST API oder CLI. Logs über Log-Viewer (FTP-basiert) oder SSH. Monitoring via integriertes Statistik-Panel (CPU, RAM, Disk, Network). Fehlermeldungen oft kryptisch.
    ],
    [
      Railway: Start/Stop über Dashboard oder CLI. Logs werden in Echtzeit im Dashboard gestreamt. Build-Logs klar strukturiert. Integriertes Metrics-Dashboard. Insgesamt modernere UX.
    ],
    // --- Antworten zu den Fragen ---
    table.cell(colspan: 2, fill: luma(240), [*Antworten zu den Fragen (RAM, JVM, IP)*]),
    [
      #todo[Nach Deployment der Self-Information-App ausfüllen: Verfügbarer RAM, JVM-Hersteller, Server-IP-Adresse.]
    ],
    [
      #todo[Nach Deployment auf Railway ausfüllen: Vergleichswerte RAM, JVM, IP.]
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

Die folgenden Fragen basieren auf dem Dimension Data White Paper «Comparing Public Cloud Service Level Agreements» und den Vorlesungsunterlagen (Cloudonomics, SLA -- Week 3).#footnote[Vgl. Dimension Data, _Comparing Public Cloud Service Level Agreements_, White Paper, 2013.]

=== 1. How are uptime and availability calculated?

Infomaniak berechnet die Verfügbarkeit auf *Monatsbasis*: Die Verfügbarkeitsrate ergibt sich aus der Gesamtzahl der Minuten im Monat abzüglich der Nichtverfügbarkeitsminuten, geteilt durch die Gesamtzahl der Minuten. Dies entspricht der Best Practice gemäss Dimension Data, wonach SLAs typischerweise monatlich berechnet werden sollten und nur den Zeitraum berücksichtigen, in dem der Kunde tatsächlich Dienste bezieht. Im Gegensatz dazu berechnet beispielsweise AWS die Verfügbarkeit über die letzten 12 Monate seit Vertragsbeginn, wobei die ersten 12 Monate als 100% Uptime angenommen werden -- auch wenn der Kunde in dieser Zeit noch gar kein Nutzer war.

Infomaniak bietet keine gestaffelten Service-Level-Tiers an (z.B. 99.9% vs. 99.99% zu verschiedenen Preispunkten), wie dies bei Hyperscalern wie AWS oder Azure üblich ist. Es gibt einen einheitlichen Standard-SLA für alle Cloud-Kunden. Geplante Wartungsarbeiten, über die der Kunde spätestens *48 Arbeitsstunden im Voraus* informiert wird, haben eine aufschiebende Wirkung auf die Sanktionen und werden nicht als Downtime gewertet.

Zur Einordnung der 99.99%-Garantie dient die folgende Tabelle erlaubter Downtimes:#footnote[Quelle: Wikipedia, _High availability_.]

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, right, right, right),
    stroke: 0.5pt + luma(180),
    table.header(
      table.cell(fill: rgb("#E8F0FE"), [*Verfügbarkeit*]),
      table.cell(fill: rgb("#E8F0FE"), [*Downtime/Jahr*]),
      table.cell(fill: rgb("#E8F0FE"), [*Downtime/Monat*]),
      table.cell(fill: rgb("#E8F0FE"), [*Downtime/Woche*]),
    ),
    [99% («two nines»)], [3.65 Tage], [7.20 Stunden], [1.68 Stunden],
    [99.9% («three nines»)], [8.76 Stunden], [43.8 Minuten], [10.1 Minuten],
    [99.95%], [4.38 Stunden], [21.56 Minuten], [5.04 Minuten],
    [*99.99% («four nines»)*], [*52.56 Minuten*], [*4.32 Minuten*], [*1.01 Minuten*],
    [99.999% («five nines»)], [5.26 Minuten], [25.9 Sekunden], [6.05 Sekunden],
  ),
  caption: [Erlaubte Ausfallzeiten bei verschiedenen Verfügbarkeitsstufen],
)

=== 2. What should be in place for me to be covered?

Das SLA von Infomaniak deckt die *Infrastruktur-Verfügbarkeit* ab: Netzwerkkonnektivität, Server-Hardware, Stromversorgung und Kühlung in den eigenen Rechenzentren sowie die Verfügbarkeit der Cloud-Plattform. Es handelt sich primär um ein *Infrastruktur- und Plattform-SLA* (gemäss der Dimension-Data-Klassifikation: Facilities-level und Platform-level SLA). Ein Application-level SLA wird nicht angeboten.

Explizit *ausgeschlossen* sind: Probleme auf Applikationsebene, Fehler durch Kundenkonfiguration oder -code, Dienste von Drittanbietern, geplante Wartungsarbeiten sowie Ereignisse höherer Gewalt. Auch die unsachgemässe Nutzung des Dienstes durch den Kunden sowie Sperrungen aufgrund von AGB-Verstössen sind von den Sanktionen ausgenommen.

Im Vergleich zu Hyperscalern wie AWS, Microsoft Azure oder HP Cloud, die teilweise verlangen, dass der Kunde in *mehreren Availability Zones* deployt, um SLA-Ansprüche geltend machen zu können, stellt Infomaniak keine solchen architektonischen Voraussetzungen. Allerdings betreibt Infomaniak Rechenzentren ausschliesslich in der Schweiz (Genf und Winterthur), sodass keine Multi-Region-Redundanz möglich ist. Der Kunde ist zudem *allein verantwortlich* für die Datensicherung -- Infomaniak erstellt keine automatischen Backups, sofern der Snapshot-Slot nicht explizit aktiviert wird (Art. 5/6 AGB).

=== 3. What about performance degradation as opposed to hard downtime?

Das SLA unterscheidet über die Fehlerklassen implizit zwischen vollständiger Nichtverfügbarkeit und Leistungsbeeinträchtigung:

- *Fehlerklasse A* (Nichtverfügbarkeit): Totaler Ausfall des Dienstes -- max. 5 Minuten Unterbrechung.
- *Fehlerklasse B* (Verlangsamung des Internetzugangs): Netzwerk-Performance-Degradation -- max. 60 Minuten.
- *Fehlerklasse C--E*: Sicherheitsprobleme, Update-Probleme und Ausfälle einzelner virtueller Server -- 60 bis 120 Minuten.

Dies ist positiv zu bewerten: Gemäss Dimension Data sollten Cloud-SLAs *sowohl harte Downtime als auch Performance-Degradation* abdecken. Allerdings fehlen bei Infomaniak *explizite Performance-Garantien* wie garantierte IOPS, Latenzwerte oder Netzwerk-Durchsatz. Es bleibt unklar, ab welchem Grad der Verlangsamung eine Fehlerklasse B ausgelöst wird. Das SLA fokussiert auf *Server-Verfügbarkeit*, nicht auf *Netzwerk-Performance* -- ein Aspekt, den das Dimension Data White Paper als «one of the most important components of cloud architecture» hervorhebt.

=== 4. What are the penalties for SLA violations?

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

Die Vertragsstrafe darf *maximal 50% des laufenden Vertrags* nicht überschreiten. Die Entschädigung erfolgt als *Gutschrift auf das Prepaid-Konto*, nicht als Barauszahlung. Im Vergleich dazu: Terremark zahlt USD 96 pro 24-Stunden-Ausfallperiode (bis 50% der Monatsgebühren); Amazon begrenzt SLA-Credits auf 10% der monatlichen Rechnung; HP begrenzt auf 30% der betroffenen Ressourcenkosten; Rackspace erstattet bis 100%, aber nur für die tatsächlich ausgefallenen Server.#footnote[Vgl. Dimension Data, _Comparing Public Cloud Service Level Agreements_, S. 3.]

=== 5. What do I have to do to request a credit?

Der Kunde muss die Nichtverfügbarkeit *innerhalb von zwei Monaten* nach Auftreten über das Supportportal melden und dabei Datum, Uhrzeit des Beginns und Endes angeben. Infomaniak analysiert daraufhin die Ursache und entscheidet, ob die Nichtverfügbarkeit von Infomaniak verschuldet wurde.

Dies entspricht der Branchenpraxis: Gemäss Dimension Data verlangen die meisten Provider eine schriftliche Meldung innerhalb einer bestimmten Frist. Eine Frist von 30 Tagen gilt als Standard. Infomaniaks Frist von *zwei Monaten* ist somit grosszügiger als üblich. Allerdings warnt das White Paper: Wenn der Aufwand für den Nachweis des Ausfalls (Dokumentation, Zeitaufwand) den potenziellen Credit übersteigt, ist der *praktische Wert des SLA erheblich gemindert*. Bei Infomaniak kommt hinzu, dass die Messmethodik *nicht detailliert offengelegt* wird (Art. 7.2.4 AGB) -- Infomaniaks interne Monitoring-Daten sind im Streitfall die Referenz. Dies ist eine *Transparenzlücke* im Vergleich zu Hyperscalern, die oft öffentliche Status-Dashboards mit historischen Uptime-Daten bereitstellen.

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

+ Dimension Data -- _Comparing Public Cloud Service Level Agreements: Questions to ask when evaluating public cloud SLAs._ White Paper, CS / DDMS-1249, Februar 2013.

+ Prof. Mirko Stocker -- _Cloudonomics, SLA._ Vorlesungsunterlagen Cloud Solutions (CldSol), OST, Frühlingssemester 2026, Week 3.

+ Jelastic / Virtuozzo -- Plattform-Dokumentation. https://docs.jelastic.com/

+ Jelastic / Virtuozzo -- API-Dokumentation. https://docs.jelastic.com/api/

+ Jelastic -- Automatic Vertical Scaling. https://docs.jelastic.com/automatic-vertical-scaling/

+ Jelastic -- Automatic Horizontal Scaling. https://docs.jelastic.com/automatic-horizontal-scaling/

+ OST -- Leitlinie zum Umgang mit KI-basierten Hilfsmitteln in Lehre und Weiterbildung (September 2024).

+ WHTop -- Infomaniak Jelastic Cloud Plan Details. https://www.whtop.com/plans/infomaniak.com/135580
