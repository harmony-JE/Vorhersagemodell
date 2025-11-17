# Projekt: Vorhersagemodell für Herz-Kreislauf-Erkrankungen

## 1. Projektübersicht

Dies ist ein Data-Science-Projekt in R, dessen Ziel es ist, das Vorhandensein einer Herz-Kreislauf-Erkrankung (Variable `target`) bei Patienten vorherzusagen. 

Basierend auf dem "Cleveland Heart Disease"-Datensatz aus dem UCI Machine Learning Repository, analysiert dieses Projekt 13 klinische Merkmale, um ein Vorhersagemodell zu entwickeln. Der Workflow umfasst Datenbereinigung, explorative Datenanalyse (EDA), statistische Tests und die Erstellung eines logistischen Regressionsmodells.

Das finale Modell dient dazu, die Wahrscheinlichkeit einer Herzerkrankung basierend auf den signifikantesten Prädiktoren zu schätzen.

## 2. Datensatz

Der verwendete Datensatz (`processed.cleveland.data`) enthält 14 Variablen von 297 Patienten, nachdem fehlende Werte entfernt wurden.

Die Zielvariable ist:
* `target`: Vorhandensein einer Herz-Kreislauf-Erkrankung (0 = Nein, 1 = Ja)

Die wichtigsten Prädiktoren sind:
* `age`: Alter in Jahren
* `sex`: Geschlecht (0 = Frau, 1 = Mann)
* `cp`: Brustschmerztyp (1 = Stabile Angina, 2 = Instabile Angina, 3 = Andere Schmerzen, 4 = Asymptomatisch)
* `trestbps`: Ruheblutdruck (in mm/Hg)
* `chol`: Cholesterinspiegel (in mg/dl)
* `fbs`: Nüchternblutzucker > 120 mg/dl (1 = Ja, 0 = Nein)
* `restecg`: Ruhe-EKG-Ergebnisse
* `thalach`: Maximale erreichte Herzfrequenz
* `exang`: Belastungsinduzierte Angina (1 = Ja, 0 = Nein)
* `oldpeak`: ST-Senkung durch Belastung im Vergleich zur Ruhe
* `slope`: Die Steigung des ST-Segments bei Spitzenbelastung
* `ca`: Anzahl der durch Fluoroskopie gefärbten Hauptgefäße (0-3)
* `thal`: Thalassämie (3 = Normal; 6 = Behoben; 7 = Reversibel)

*(Eine vollständige Beschreibung aller Variablen ist in der Datei `Grille+de+codage+-+Projet+Data+Science.png` enthalten.)*

## 🛠 3. Projekt-Workflow

Das Projekt folgt einer strukturierten Data-Science-Pipeline:

### 1. Datenimport und -bereinigung
* Einlesen der Daten von der UCI-Website.
* Zuweisung aussagekräftiger Spaltennamen.
* Umkodierung der `target`-Variable in ein binäres Format (0 oder 1).
* Entfernung von Zeilen mit fehlenden Werten (im Datensatz als `?` markiert).

### 2. Datenvorverarbeitung
* Konvertierung der Variablen in die korrekten Datentypen (Faktoren für kategoriale Daten und Integer/Numerisch für quantitative Daten).
* Umbenennung der Faktorstufen zur besseren Interpretierbarkeit (z. B. `sex` 0/1 zu `Frau`/`Mann`).

### 3. Explorative Datenanalyse (EDA)
* **Deskriptive Statistik:** Berechnung von Häufigkeiten, Proportionen, Mittelwerten, Medianen und Standardabweichungen.
* **Visualisierung:** Erstellung verschiedener Diagramme (siehe `R-Projekt-Final-DE.html`), um Muster zu erkennen:
    * Balkendiagramme (z. B. Verteilung nach Geschlecht, Brustschmerztyp)
    * Kreisdiagramm (Verteilung der `target`-Variable)
    * Boxplots (z. B. Alter, Ruheblutdruck)
    * Histogramme
    * Gekreuzte Diagramme (z. B. `target` vs. `sex`, `target` vs. `age`)

### 4. Statistische Inferenz
* Durchführung statistischer Tests, um die signifikantesten Prädiktoren für die `target`-Variable zu identifizieren:
    * **Chi-Quadrat-Test:** Für kategoriale Variablen (z. B. `cp`, `exang`, `ca`, `thal` zeigten alle eine hohe Signifikanz).
    * **Shapiro-Wilk-Test:** Zur Überprüfung der Normalverteilung von quantitativen Variablen.
    * **t-Test & Mann-Whitney-U-Test:** Zum Vergleich der Mittelwerte von quantitativen Variablen (z. B. `age`, `trestbps`, `thalach`, `oldpeak`) zwischen gesunden und kranken Patienten.

### 5. Modellierung (Logistische Regression)
* **Datenaufteilung:** Die Daten wurden im Verhältnis 80/20 in ein Trainings- und ein Testset aufgeteilt.
* **Modelltraining:** Es wurde ein logistisches Regressionsmodell (`glm`) mit der `target`-Variable als abhängiger Variable trainiert.
* **Merkmalsauswahl (Feature Selection):** Durch schrittweise Rückwärtsselektion (basierend auf der Signifikanz der Prädiktoren) wurde das Modell optimiert. Das finale Modell verwendet die Prädiktoren:
    * `sex`
    * `cp`
    * `exang`
    * `oldpeak`
    * `ca`

## 4. Wichtige Ergebnisse

Die Bewertung des finalen logistischen Regressionsmodells ergab folgende Resultate:

* **Modellgenauigkeit (auf dem Testset):**
    * **Accuracy:** **74,58 %**
    * Das Modell ist signifikant besser als die "No Information Rate" (p-Wert: 0.01).

* **Modellanpassung (auf dem Trainingsset):**
    * **AUC (Area Under the Curve):** **0,928**
        * Dieser hohe Wert (nahe 1) von der ROC-Kurve zeigt, dass das Modell eine sehr gute Trennschärfe zwischen den Klassen ("Ja" und "Nein") aufweist.
    * **Hosmer-Lemeshow-Test:**
        * Ein p-Wert von **0,702** (deutlich > 0,05) bestätigt, dass das Modell gut an die Daten angepasst ist (die Nullhypothese H0, dass das Modell gut passt, wird beibehalten).

## 5. Verwendete Programmieung Sprache

* **Sprache:** R
* 📖 **Wichtige R-Bibliotheken:**
    * `dplyr`: Datenmanipulation
    * `caTools`: Aufteilung in Trainings-/Testsets
    * `caret`: Erstellung der Konfusionsmatrix
    * `performance`: Durchführung des Hosmer-Lemeshow-Tests
    * `pROC`: Erstellung der ROC-Kurve und Berechnung der AUC

## 6. Ausführung

Das vollständige Skript und die Ergebnisse (inklusive aller Grafiken) sind in den folgenden Dateien enthalten:
* `R-Projekt-Final-DE.r`: Das R-Quellcode-Skript.
* `R-Projekt-Final-DE.html`: Der gerenderte HTML-Bericht mit Code und Ausgaben.//
**Alternative**: Klicken Sie einfach folgender Link: <https://harmony-htw.github.io/Vorhersagemodell/R-Projekt-Final-DE.html>


## 👥 Team Members

- **Harmony Emadjeu Jontcheu** – Hochschule für Technik und Wirtschaft Berlin
- **Frank Kouemo Feupissie** – Hochschule für Technik und Wirtschaft Berlin
