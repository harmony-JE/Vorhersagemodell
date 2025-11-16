#---------------------------------------------------------------
#          Import und Vorverarbeitung der Daten
#---------------------------------------------------------------

# Import der Daten
data <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"), header = FALSE)

# Ändern der Spaltennamen
colnames(data) <- c("age", "sex", "cp", "trestbps", "chol", "fbs", "restecg", "thalach", "exang", "oldpeak", "slope", "ca", "thal", "target")

# Vorverarbeitung der Zielspalte
data$target[data$target==2] <- 1
data$target[data$target==3] <- 1
data$target[data$target==4] <- 1

# Entfernen von fehlenden Werten
valeurs_manquantes_ca <- which(data$ca %in% "?")
valeurs_manquantes_thal <-which(data$thal %in% "?")
valeurs_manquantes <- c(valeurs_manquantes_ca, valeurs_manquantes_thal)
valeurs_manquantes
data <- data[-valeurs_manquantes,]

# Überprüfung des Variablentyps
str(data)

# Ändern des Variablentyps

## Qualitative Variablen (factor = qualitative Variable)
data$sex <- as.factor(data$sex)
data$cp <- as.factor(data$cp)
data$fbs <- as.factor(data$fbs)
data$restecg <- as.factor(data$restecg)
data$exang <- as.factor(data$exang)
data$slope <- as.factor(data$slope)
data$ca <- as.factor(data$ca)
data$thal <- as.factor(data$thal)
data$target <- as.factor(data$target)

## Quantitative Variablen
data$age <- as.integer(data$age)
data$trestbps <- as.integer(data$trestbps)
data$chol <- as.integer(data$chol)
data$thalach <- as.integer(data$thalach)

# Umkodierung der Variablen
levels(data$sex) <- c("Frau", "Mann")
levels(data$cp) <- c("Stabile Angina", "Instabile Angina", "Andere Schmerzen", "Asymptomatisch")
levels(data$fbs) <- c("Nein", "Ja")
levels(data$restecg) <- c("Normal", "Anomalien", "Hypertrophie")
levels(data$exang) <- c("Nein", "Ja")
levels(data$slope) <- c("Ansteigend", "Stabil", "Abfallend")
levels(data$ca) <- c("Keine Anomalie", "Niedrig", "Mittel", "Hoch")
levels(data$thal) <- c("Nein", "Thalassämie unter Kontrolle", "Instabile Thalassämie")
levels(data$target) <- c("Nein", "Ja")

# Überprüfung des Variablentyps
str(data)

# Überprüfung auf fehlende Werte
apply(data, 2, anyNA)

#---------------------------------------------------------------
#                Beschreibende Statistiken
#---------------------------------------------------------------

# Schlüsselindikatoren (qualitative Variablen)

# Variable sex
table(data$sex) # Absolute Häufigkeiten
prop.table(table(data$sex)) # Relative Häufigkeiten
round(prop.table(table(data$sex)), 4) # Gerundete relative Häufigkeiten
round(prop.table(table(data$sex)), 4)*100 # Prozentsätze

# Variable cp
table(data$cp)
round(prop.table(table(data$cp)), 4)*100

# Variable fbs
table(data$fbs)
round(prop.table(table(data$fbs)), 4)*100

# Variable restecg
table(data$restecg)
round(prop.table(table(data$restecg)), 4)*100

# Variable exang
table(data$exang)
round(prop.table(table(data$exang)), 4)*100

# Variable slope
table(data$slope)
round(prop.table(table(data$slope)), 4)*100

# Variable ca
table(data$ca)
round(prop.table(table(data$ca)), 4)*100

# Variable thal
table(data$thal)
round(prop.table(table(data$thal)), 4)*100

# Variable target
table(data$target)
round(prop.table(table(data$target)), 4)*100

# --------------------

# Schlüsselindikatoren (quantitative Variablen)

## Minimum, Quartile, Median, Mittelwert und Maximum
summary(data$age)
summary(data$trestbps)
summary(data$chol)
summary(data$thalach)
summary(data$oldpeak)

## Varianz und Standardabweichung
var(data$age)
sd(data$age)
var(data$trestbps)
sd(data$trestbps)
var(data$chol)
sd(data$chol)
var(data$thalach)
sd(data$thalach)
var(data$oldpeak)
sd(data$oldpeak)

#---------------------------------------------------------------
#                Grafiken (Datenvisualisierung)
#---------------------------------------------------------------

# Balkendiagramme (qualitative Variablen)

## Variable sex
graph1 <- plot(data$sex,
     xlab = "Geschlecht",
     ylab = "Anzahl",
     main = "Verteilung der Patienten nach Geschlecht",
     las = 1,
     # horiz = T
     sub = "Daten: Heart Disease Data Set (UCI Machine Learning)",
     # names.arg = c("Feminin", "Masculin"),
     # space = 2
     # col = "red"
     col = c("#e63946", "#a8dadc"),
     # border = "blue",
     # density = 80,
     # yaxt = 'n'
     cex.main = 1.8,
     cex.axis = 1,
     cex.lab = 1.2,
     ylim = c(0, 250)
     )
text(x = graph1, y = table(data$sex)+10, labels = as.character(table(data$sex)), cex = 1.1, font = 3)

## Variable cp
graph2 <- plot(data$cp,
               xlab = "Brustschmerzen",
               ylab = "Anzahl",
               main = "Verteilung der Patienten nach Brustschmerztyp",
               space = 0.3,
               col = c("#e63946", "#f1faee", "#a8dadc", "#457b9d"),
               cex.main = 1.5,
               cex.lab = 1.2,
               ylim = c(0,170)
               )
text(x = graph2, y = table(data$cp)+7, labels = as.character(table(data$cp)), cex = 1.1, font = 3)

# --------------------

# Kreisdiagramm (qualitative Variablen)

## Variable target
pie(table(data$target),
    main = "Verteilung der Patienten nach dem Vorhandensein einer Herz-Kreislauf-Erkrankung",
    clockwise = TRUE,
    col = c("#2a9d8f", "#f4a261"),
    cex.main = 1.2,
    )

# --------------------

# Boxplots (quantitative Variablen)

## Variable age
boxplot(data$age,
        ylab = "Alter",
        main = "Boxplot der Population nach Alter",
        col = "#e63946",
        las = 1,
        cex.main = 1.7,
        cex.lab = 1.2,
        sub = "Daten: Heart Disease Data Set (UCI Machine Learning)",
        # horizontal = TRUE
        notch = TRUE,
        # border = "blue"
        ylim = c(20,80)
        )

# --------------------

# Histogramme (quantitative Variablen)

## Variable trestbps
graph3 <- hist(data$trestbps,
     xlab = "Ruheblutdruck",
     ylab = "Anzahl",
     main = "Verteilung der Patienten nach Ruheblutdruck",
     las = 1,
     sub = "Daten: Heart Disease Data Set (UCI Machine Learning)",
     col = "lightslateblue",
     ylim = c(0,80),
     xlim = c(80,200),
     cex.main = 1.4,
     cex.lab = 1.2)
text(x = graph3$mids, graph3$counts, labels = graph3$counts, adj = c(0.5, -0.5))

# --------------------

# Gekreuzte Balkendiagramme

## Variablen target/sex
graph4 <- barplot(table(data$target, data$sex),
        beside = TRUE,
        col = c("#003049", "#d62828"),
        xlab = "Geschlecht",
        ylab = "Patienten",
        las = 1,
        main = "Verteilung der Patienten nach Vorhandensein einer Herz-Kreislauf-Erkrankung \n und Geschlecht",
        ylim = c(0,150),
        cex.main = 1.2,
        cex.lab = 1.2
        )
legend("top", legend = levels(data$target), fill = c("#003049", "#d62828"), title = "Herz-Kreislauf-Erkrankung", horiz = TRUE)
text(x = graph4, y = table(data$target, data$sex)+7, labels = as.character(table(data$target, data$sex)), cex = 1.1, font = 3)

# --------------------

# Gekreuzte Boxplots

## Variable target/age
boxplot(data$age ~ data$target,
        main = "Boxplot der Population nach Alter und Vorhandensein \n einer Herz-Kreislauf-Erkrankung",
        xlab = "Vorhandensein einer Herz-Kreislauf-Erkrankung",
        ylab = "Alter",
        col = "yellow",
        las = 1,
        ylim = c(20, 80),
        cex.main = 1.2,
        cex.lab = 1.2
        )

## Variable target/trestbps
boxplot(data$trestbps ~ data$target,
        main = "Boxplot der Population nach Ruheblutdruck \n und Vorhandensein einer Herz-Kreislauf-Erkrankung",
        xlab = "Vorhandensein einer Herz-Kreislauf-Erkrankung",
        ylab = "Ruheblutdruck",
        col = "yellow",
        las = 1,
        cex.main = 1.2,
        cex.lab = 1.2
)

#---------------------------------------------------------------
#                     Statistische Tests
#---------------------------------------------------------------

## Berechnung der Prozentsätze
round(prop.table(table(data$sex, data$target), margin = 1), 4)*100
round(prop.table(table(data$cp, data$target), margin = 1), 4)*100
round(prop.table(table(data$fbs, data$target), margin = 1), 4)*100
round(prop.table(table(data$restecg, data$target), margin = 1), 4)*100
round(prop.table(table(data$exang, data$target), margin = 1), 4)*100
round(prop.table(table(data$slope, data$target), margin = 1), 4)*100
round(prop.table(table(data$ca, data$target), margin = 1), 4)*100
round(prop.table(table(data$thal, data$target), margin = 1), 4)*100

## Chi-Quadrat-Test (qualitative Variablen)
## H0: Die beiden Variablen sind unabhängig (wenn p-Wert > 0,05)
## H1: Die beiden Variablen sind abhängig (wenn p-Wert < 0,05)
chisq.test(data$sex, data$target)
chisq.test(data$cp, data$target)
chisq.test(data$fbs, data$target)
chisq.test(data$restecg, data$target)
chisq.test(data$exang, data$target)
chisq.test(data$slope, data$target)
chisq.test(data$ca, data$target)
chisq.test(data$thal, data$target)

## Berechnung der Mittelwerte
tapply(data$age, data$target, mean)
tapply(data$trestbps, data$target, mean)
tapply(data$chol, data$target, mean)
tapply(data$thalach, data$target, mean)
tapply(data$oldpeak, data$target, mean)

## Shapiro-Wilk-Test
### H0: Die Stichprobe folgt einer Normalverteilung (wenn p-Wert > 0,05)
### H1: Die Stichprobe folgt keiner Normalverteilung (wenn p-Wert < 0,05)
library(dplyr)
shapiro.test(filter(data, target == "Ja")$age) # H1 (Angepasst von "Oui" zu "Ja")
shapiro.test(filter(data, target == "Ja")$trestbps) # H1
shapiro.test(filter(data, target == "Ja")$chol) # H0
shapiro.test(filter(data, target == "Ja")$thalach) # H0
shapiro.test(filter(data, target == "Ja")$oldpeak) # H1

## Mann-Whitney-Test
### H0: Es gibt keinen signifikanten Unterschied zwischen den Mittelwerten der beiden Variablen (wenn p-Wert > 0,05)
### H1: Es gibt einen signifikanten Unterschied zwischen den Mittelwerten der beiden Variablen (wenn p-Wert < 0,05)
wilcox.test(data$age~data$target)
wilcox.test(data$trestbps~data$target)
wilcox.test(data$oldpeak~data$target)

## t-Test (Student's t-test)
### H0: Es gibt keinen signifikanten Unterschied zwischen den Mittelwerten der beiden Variablen (wenn p-Wert > 0,05)
### H1: Es gibt einen signifikanten Unterschied zwischen den Mittelwerten der beiden Variablen (wenn p-Wert < 0,05)
t.test(data$chol~data$target)
t.test(data$thalach~data$target)

#---------------------------------------------------------------
#                     Maschinelles Lernen
#---------------------------------------------------------------

# Logistisches Regressionsmodell

## Aufteilung des Datensatzes in Trainings- und Testset
set.seed(99)
library(caTools)
split = sample.split(data$target, SplitRatio = 0.8)
train = subset(data, split == TRUE)
test = subset(data, split == FALSE)

## Erstellung des Modells
RegressionLogistique = glm(target ~., data = train, family = "binomial")
summary(RegressionLogistique)

## Optimierung des logistischen Regressionsmodells, um nur signifikante Variablen beizubehalten
RegressionLogistique = update(RegressionLogistique, .~.-restecg)
RegressionLogistique = update(RegressionLogistique, .~.-slope)
RegressionLogistique = update(RegressionLogistique, .~.-thal)
RegressionLogistique = update(RegressionLogistique, .~.-age)
RegressionLogistique = update(RegressionLogistique, .~.-fbs)
RegressionLogistique = update(RegressionLogistique, .~.-chol)
RegressionLogistique = update(RegressionLogistique, .~.-thalach)
# RegressionLogistique = update(RegressionLogistique, .~.-cp)
RegressionLogistique = update(RegressionLogistique, .~.-trestbps)
summary(RegressionLogistique)
# AIC-Kriterium ohne die Variable cp: 202,23
# AIC-Kriterium mit der Variable cp: 177,71

## Vorhersagen
prediction = predict(RegressionLogistique, test, type = "response")
prediction
tableau_prediction = as.data.frame(prediction)
creation_fonction = function(x){
    return(ifelse(x>0.5,1,0))
}
tableau_prediction = apply(tableau_prediction, 2, creation_fonction)

## Messung der Modellleistung
levels(test$target) <- c(0,1)
library(caret)
confusionMatrix(as.factor(test$target), as.factor(tableau_prediction))

## Vergleichstabelle
tableau_comparaison = cbind(test, tableau_prediction)
tableau_comparaison$prediction <- as.factor(tableau_comparaison$prediction)
levels(tableau_comparaison$target) <- c("Nein", "Ja")
levels(tableau_comparaison$prediction) <- c("Nein", "Ja")

## Hosmer-Lemeshow-Test
## H0: Die Anpassung des Modells an die Daten ist gut (wenn p-Wert > 0.05)
## H1: Die Anpassung des Modells an die Daten ist schlecht (wenn p-Wert < 0.05)
library(performance)
performance_hosmer(RegressionLogistique)

## Erstellung der ROC-Kurve
library(pROC)
par(pty = "s")
roc(train$target, RegressionLogistique$fitted.values,
    plot = TRUE,
    main = "ROC-Kurve des logistischen Regressionsmodells",
    col = "#377eb8",
    lwd = 4,
    xlab = "Falsch-Positiv-Rate",
    ylab = "Wahr-Positiv-Rate",
    legacy.axes = TRUE
    )