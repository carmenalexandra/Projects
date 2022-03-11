install.packages("psych")
install.packages("sp")
install.packages("raster")
install.packages("moments")
install.packages("ggplot2")
install.packages("Hmisc")
install.packages("corrplot")
install.packages("ggcorrplot")
install.packages("ggpubr")
install.packages("PerformanceAnalytics")
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("rela")
install.packages("GPArotation")
install.packages("graphics")
install.packages("reshape2")
install.packages("NbClust")
install.packages("cluster")
install.packages("MASS")
install.packages("tidyverse", dependecies = TRUE)
install.packages("dendextend", dependencies = TRUE)
install.packages("clValid")
install.packages("DiscriMiner")
install.packages("e1071")
install.packages("caret")
install.packages("gmodels")

library(psych)
library(sp)
library(raster)
library(moments)
library(ggplot2)
library(Hmisc)
library(corrplot)
library(ggcorrplot)
library(ggpubr)
library(PerformanceAnalytics)
library(FactoMineR)
library(factoextra)
library(rela)
library(GPArotation)
library(graphics)
library(reshape2)
library(ggplot2)
library(NbClust)
library(cluster)
library(MASS)
library(tidyverse)
library(dendextend)
library(clValid)
library(DiscriMiner)
library(e1071)
library(class)
library(caret)
library(gmodels)

options(scipen = 100)


#### Importarea datelor in R ####
tema <- read.csv(file = "tema AD.csv", header = TRUE, sep = ",")
View(tema)
attach(tema)
tema_AD <- tema[,2:21]
View(tema_AD)


#### Statistici descriptive ####
# a) Functiile summary, skewness si kurtosis 
summary(tema)
which.min(LRYt)   
which.max(LRYt)   
which.min(COS)    
which.max(COS)    

# Coeficientul de asimetrie
skewness(tema_AD)

# Coeficientul de boltire
kurtosis(tema_AD)

# b) Functia describe
View(describe(tema))
which.min(UNt)    # 54. LAO
which.max(UNt)    # 76. NAM

# c) Functiile cv, sd, var si mean
apply(tema_AD, 2, cv)
apply(tema_AD, 2, sd)
apply(tema_AD, 2, var)
apply(tema_AD, 2, mean)

# f) Boxplot-uri
# Varianta 1 - functia boxplot
boxplot(PDY, horizontal = TRUE, xlab = "PDY", col = "cyan3", main = "Boxplot Probability of dying among youth ages 20-24 years (per 1,000)")
boxplot(SEs, horizontal = TRUE, xlab = "SEs", col = "coral", main = "Boxplot School enrollment, secondary (% gross)") 

# Varianta 2 - functia ggplot
ggplot(data = tema, mapping = aes(Rpt)) +
  geom_boxplot(fill = "blueviolet", outlier.colour = "deeppink3") +
  theme_gray() +
  ggtitle("Boxplot Repeaters, primary, total (% of total enrollment)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5))
ggplot(data = tema, mapping = aes(PREd)) +
  geom_boxplot(fill = "cornflowerblue") +
  theme_gray() +
  ggtitle("Boxplot Preprimary education, duration (years)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5))


#### Reprezentari grafice ####
# a) Functia plot si functia abline
# Varianta 1 - functia plot si functia abline
# Dependenta dintre Rpt si SEp
plot(SEp, Rpt, col = "cadetblue", xlab = "SEp", ylab = "Rpt", main = "Dependenta dintre Repeaters, primary, total (% of total enrollment) \nsi School enrollment, primary (% gross)")
abline(lm(Rpt ~ SEp))

# Dependenta dintre UNt si LFt
windows()
par(mfrow = c(1, 2))
plot(LFt, UNt, xlab = "LFt", ylab = "UNt")
plot(LFt, UNt, col = "darkviolet", xlab = "LFt", ylab = "UNt", main = "Dependenta dintre Unemployment, \ntotal (% of total labor force) \nsi Labor force, total")
abline(lm(UNt ~ LFt))
cor(UNt, LFt)   # -0.23 < 0

# Dependenta dintre OASp si SEp
plot(SEp, OASp, col = "red", xlab = "SEp", ylab = "OASp", main = "Dependenta dintre Over-age students, primary (% of enrollment) \nsi School enrollment, primary (% gross)")
abline(lm(OASp ~ SEp))

# Varianta 2 - functia ggplot
# Dependenta dintre LRYt si POP
lm(LRYt ~ POP)
windows()
d1 <- ggplot(tema, aes(x = POP, y = LRYt)) +
  geom_point(color = "deeppink3") +
  theme_gray() +
  xlab("POP") +
  ylab("LRYt") +
  geom_text(
    label=tema$Country.Code,
    nudge_x = 0.25, nudge_y = 0.25,
    check_overlap = TRUE) 
d2 <- ggplot(tema, aes(x = POP, y = LRYt)) +
  geom_point(color = "deeppink3") +
  theme_gray() +
  xlab("POP") +
  ylab("LRYt") +
  geom_text(
    label=tema$Country.Code,
    nudge_x = 0.25, nudge_y = 0.25,
    check_overlap = TRUE) +
  geom_abline(intercept = 34.3153) +
  ggtitle("Dependenta dintre Literacy rate, \nyouth total (% of people ages 15-24) \nsi Population ages 15-64 (% of total population)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, color = "darkorchid"))
ggarrange(d1, d2, nrow = 1, ncol = 2)
cor(LRYt, POP)   # 0.63 > 0

# b) Functia ggplot
# Dependenta dintre AERp si SEp
windows()
ggplot(tema, aes(x = SEp, y = AERp)) +
  geom_point(color = "cyan4") +
  theme_gray() +
  xlab("SEp") +
  ylab("AERp") +
  geom_text(
    label=tema$Country.Code,
    nudge_x = 0.25, nudge_y = 0.25,
    check_overlap = TRUE) 

# c) Histograma si densitatea de probabilitate
# Varianta 1 - functiile hist si lines
hist(AOS, freq = F, xlab = "AOS", ylab = "Densitate", col = "bisque3", main = "Histograma Adolescents out of school (% of lower secondary school age)")
lines(density(AOS), col = "deeppink2", lwd = 4)
hist(COS, freq = F, xlab = "COS", ylab = "Densitate", col = "antiquewhite2", main = "Histograma Children out of school (% of primary school age)")
lines(density(COS), col = "coral1", lwd = 4)
hist(NOD, freq = F, xlab = "NOD", ylab = "Densitate", col = "cornsilk2", main = "Histograma Number of deaths ages 20-24 years")
lines(density(NOD), col = "darkorchid", lwd = 4)

# Varianta 2 - functia ggplot
windows()
ggplot(tema, aes(x = AERp)) +
  geom_histogram(aes(y = ..density..), colour = "black", fill = "darkolivegreen3") +
  xlab("AERp") +
  ylab("Densitate") +
  geom_density(alpha = .2, fill = "blue") +
  ggtitle("Histograma Adjusted net enrollment rate, primary (%)") +
  theme(plot.title = element_text(hjust = 0.5, size = 20))
ggplot(tema, aes(x = OASp)) +
  geom_histogram(aes(y = ..density..), colour = "black", fill = "aliceblue") +
  xlab("OASp") +
  ylab("Densitate") +
  geom_density(alpha = .2, fill = "darkviolet") +
  ggtitle("Histograma Over-age students, primary (% of enrollment)") +
  theme(plot.title = element_text(hjust = 0.5, size = 20))
ggplot(tema, aes(x = UNt)) +
  geom_histogram(aes(y = ..density..), colour = "black", fill = "beige") +
  xlab("UNt") +
  ylab("Densitate") +
  geom_density(alpha = .2, fill = "chocolate4") +
  ggtitle("Histograma Unemployment, total (% of total labor force)") +
  theme(plot.title = element_text(hjust = 0.5, size = 20))


#### Prelucrarea datelor ####
# 1. Standardizarea variabilelor prin functia scale
tema_std <- scale(tema_AD)
View(tema_std)

# 2. Functiile sd si mean pentru variabilele standardizate
apply(tema_std, 2, sd)
apply(tema_std, 2, mean)

# 3. Matricea de corelatie si matricea de covarianta a variabilelor standardizate - functiile cor si cov
cor_std <-round(cor(tema_std), 3)
View(cor_std)
cov_std <- round(cov(tema_std), 4) 
View(cov_std)

# 4. Construiti o functie care transforma variabilele din matricea datelor prin impartirea fiecarei variabile la media sa si aplicati functia obtinuta unei variabile la alegere, si apoi pentru toata matricea de date
fct <- function(x) {
  a <- x / mean(x)
  return(a)
}

# Pentru o variabila aleasa aleator - POP
# Varianta 1 - fct
fct(tema_AD$POP)

# Varianta 2 
POP2 <- tema_AD$POP / mean(tema_AD$POP)
View(as.matrix(POP2))

# Pentru toata matricea de date
df <- data.frame(tema_AD)
df_nou <- data.frame(lapply(df, fct))
View(df_nou)

# 5.1. Matricea de corelatie pentru matricea de date, matricea de corelatie pentru variabilele standardizate si matricea de corelatie pentru matricea obtinuta prin aplicarea functiei de la punctul 4.
cor_tema <- round(cor(tema_AD), 3)
View(cor_tema)
cor_std <- round(cor(tema_std), 3)
View(cor_std)
cor_m <- round(cor(df_nou), 3)
View(cor_m)

# 5.2. Matricea de covarianta pentru matricea de date, matricea de covarianta pentru variabilele standardizate si matricea de covarianta pentru matricea obtinuta prin aplicarea functiei de la punctul 4.
cov_tema <- round(cov(tema_AD), 3)
View(cov_tema)
cov_std <- round(cov(tema_std), 4)
View(cov_std)
cov_m <- round(cov(df_nou), 4)
View(cov_m)

# 6. Matricea produselor incrucisate pentru matricea de date
# Varianta 1
matrice <- as.matrix(tema_AD)
t <- t(matrice)%*%matrice
round(t, 3)
View(round(t, matrice))

# Varianta 2 - functia crossprod
prod_incr <- crossprod(matrice)
View(round(prod_incr, 2))

# 7. Functia rnorm, matricea de covarianta a variabilelor centrate si matricea produselor incrucisate pentru variabilele centrate
rn <- rnorm(6000, 3, 0.2)
rn <- as.matrix(rn, nrow = 1000, ncol = 6)

# matricea de covarianta a variabilelor centrate
rns <- scale(rn, center = TRUE, scale = FALSE)
round(cov(rns), 4)

# matricea produselor incrucisate pentru variabilele centrate
mat_prod <- crossprod(rns)
mat_prod <- mat_prod / 1000
round(mat_prod, 4)


#### Vectori, valori proprii si combinatii liniare ####
# 1. Functia eigen aplicata matricii de covarianta a datelor standardizate
# Varianta 1
cov_std <- round(cov(tema_std), 4)
es <- eigen(cov_std)

# Varianta 2
# valorile proprii
vp <- round(es$values, 3)

# vectorii proprii
vect <- round(es$vectors, 3)

# normele vectorilor
vect1 <- es$vectors[,1]
norma1 <- sum(vect1^2)

vect5 <- es$vectors[,5]
norma5 <- sum(vect5^2)

# 2. Construiti o combinatie liniara intre datele standardizate si primul vector propriu din matricea anterioara
vect1 <- es$vectors[,1]
C1 <- tema_std%*%vect1
var(C1)

# 3. Construiti o combinatie liniara intre datele standardizate si al doilea vector propriu (ca ponderi) din matricea anterioara
vect2 <- es$vectors[,2]
C2 <- tema_std%*%vect2
var(C2)

# 4. Matricea transpusa a matricei care contine vectorii proprii de mai sus - functia t
vect <- round(es$vectors, 4)
mat_t <- t(vect)

# 5. Inmultirea a 3 matrici:
# matricea transpusa a vectorilor proprii * matricea de covarianta a datelor standardizate * matricea vectorilor proprii
M <- round(mat_t%*%cov_std%*%vect, 3)
View(M)


#### Analiza corelatiilor. Grafice pentru sintetizarea analizei corelatiilor ####
# 1. Matricea de corelatie a variabilelor din setul de date - functia cor
cor_tema <- round(cor(tema_AD), 3)
View(cor_tema)
tema_std <- scale(tema_AD)
cor_std <- round(cor(tema_std), 3)
View(cor_std)

# 2. Functia rcorr
rcorr(as.matrix(tema_AD))

# 3. Graficul matricei de corelatie
# Varianta 1 - functia corrplot
cor_tema <- round(cor(tema_AD), 3)
windows()
corrplot(cor_tema, method = "color", addCoef.col = "black", col = c("mistyrose3", "gray95", "lightblue3"), title = "Graficul matricei de corelatie", mar = c(0, 0, 2, 0))
dev.off()
par(mfrow = c(1, 2))
corrplot(cor_tema, method = "circle", type = "upper", col = c("firebrick4", "moccasin", "orangered2"), title = "Partea superioara a graficului matricei de corelatie", mar = c(0, 0, 2, 0))
windows()
corrplot(cor_tema, method = "square", type = "lower", col = c("olivedrab", "paleturquoise", "greenyellow"), title = "Partea inferioara a graficului matricei de corelatie", mar = c(0, 0, 2, 0))

# Varianta 2 - functia ggcorrplot
windows()
ggcorrplot(cor_tema, lab = TRUE, colors = c("mediumorchid3", "gray95", "slateblue1"), title = "Graficul matricei de corelatie") +
  theme_gray() +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 25)) +
  xlab("Indicatori") +
  ylab("Indicatori")
cor1 <- ggcorrplot(cor_tema, method = "circle", show.diag = TRUE, type = "upper", colors = c("firebrick4", "floralwhite", "orangered2"), title = "Partea superioara a graficului \nmatricei de corelatie") +
  theme_gray() +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15)) +
  xlab("Indicatori") +
  ylab("Indicatori")
cor2 <- ggcorrplot(cor_tema, type = "lower", show.diag = TRUE, colors = c("olivedrab", "mintcream", "greenyellow"), title = "Partea inferioara a graficului \nmatricei de corelatie") +
  theme_gray() +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15)) +
  xlab("Indicatori") +
  ylab("Indicatori")
windows()
ggarrange(cor1, cor2, nrow = 1, ncol = 2)

# 4. Corelograma
# Varianta 1 - functia chart.Correlation
windows()
chart.Correlation(tema_AD)
# Varianta 2 - psych correlation plot
windows()
pairs.panels(tema_AD, density = TRUE, cor = TRUE, stars = TRUE, jiggle = TRUE, factor = 500, hist.col = "gray")


#### Analiza componentelor principale ####
# 1. Matricile de covarianta si corelatie ale variabilelor standardizate - functiile cor si cov
tema_std <- scale(tema_AD)

# Matricea de covarianta
cov_std <- round(cov(tema_std), 3)
View(cov_std)

# Matricea de corelatie
cor_std <- round(cor(tema_std), 3)
View(cor_std)

# 2. Extragerea componentelor principale - functia princomp
# Elimin CEd, GIRp, OASp, PREd, PEd, Rpt, SEd
tema_prc <- cbind(tema[,2:4], tema[,7:9], tema[,10:11], tema[,14:15], tema[,17:18], tema[,20:21])
tema_prc <- tema_prc[,-7]
View(tema_prc)
tema_std2 <- scale(tema_prc)
View(tema_std2)

# Standard deviation
pca <- princomp(tema_std2, cor = TRUE)
stdev <- pca$sdev

# Valori proprii
valp <- stdev*stdev

# Procent informational
pr_info <- valp * 100 / 13

# Procent cumulat
pr_cum <- cumsum(pr_info)

# Data frame-ul componentelor principale 
df_prc <- round(data.frame(stdev, valp, pr_info, pr_cum), 4)
View(df_prc)

# 3. Analiza componentelor principale (functia prcomp) si graficul 
pc <- prcomp(tema_std2)
windows()
plot(pc, main = "Scree plot - componente principale", type = 'l', col = "maroon4")

# 4. Identificarea numarului de componente principale retinute in analiza
# Criteriul 1: Criteriul procentului de acoperire
P1 <- (valp[1] / sum(valp[1:13])) * 100         
P2 <- (sum(valp[1:2]) / sum(valp[1:13])) * 100  
P3 <- (sum(valp[1:3]) / sum(valp[1:13])) * 100

# Criteriul 2: Criteriul lui Kaiser (pct 2)
valp <- stdev*stdev

# Criteriul 3: Criteriul pantei (pct 3)
windows()
plot(pc, main = "Scree plot - componente principale", type = 'l', col = "maroon4")
abline (v = 5, lwd = 3, col = "red")

# 5. Vectorii proprii ai matricei de covarianta
vp <- pca$loadings
write.table(round(vp, 3))

# 6. Extrageti vectorii proprii si valorile proprii ale matricei de covarianta - functia eigen
# Valorile proprii
cov_std2 <- round(cov(tema_std2), 3)
eigen(cov_std2)$values

# Vectorii proprii
round(eigen(cov_std2)$vectors, 3)

# 7. Scoruri principale (primele 10 observatii)
sc <- pca$scores[,1:3]
rownames(sc) <- tema$Country.Code
sc[1:10,]

# Proprietatile componentelor principale
round(cor(sc), 5)

# 8. Matricea de corelatie intre variabile originale si componentele principale
cor_std2 <- cor(tema_std2, sc)
View(round(cor_std2, 3))
# Varianta 1 - corrplot
windows()
par(mfrow = c(1, 2))
corrplot(cor_std2, method = "circle", col = c("darkgoldenrod1", "bisque", "chocolate2"), title = "Graficul matricei de corelatie \ncomponente principale", mar = c(0, 0, 2, 0))
corrplot(cor_std2, method = "number", col = c("dodgerblue2", "grey", "hotpink3"), title = "Graficul matricei de corelatie \ncomponente principale", mar = c(0, 0, 2, 0))

# Varianta 2 - functia ggcorrplot
windows()
ggcorrplot(cor_std2, lab = TRUE, colors = c("lightpink3", "papayawhip", "skyblue3"), title = "Graficul matricei de corelatie - componente principale") +
  theme_gray() +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15)) +
  xlab("Indicatori") +
  ylab("Componente principale")

# 9. Cercul corelatiilor
dev.off()
cerc_cor <- seq(0,2 * pi,length = 100)
plot(cos(cerc_cor), sin(cerc_cor), type="l", col = "mediumblue", xlab = "W1", ylab = "W2", main = "Cercul corelatiilor")
text(cor_std2[,1], cor_std2[,2], rownames(cor_std2), col = "mistyrose4", cex = 0.7)

# 10. Reprezentarea observatiilor in planul principal
df_cprc <- data.frame(sc)
View(df_cprc)

# Varianta 1 - functia plot
windows()
plot(df_cprc[,1], df_cprc[,2], xlab = "W1", ylab = "W2", col = "lightsteelblue4" , main = "Plot componente principale - W1 si W2")
text(df_cprc[,1], df_cprc[,2], labels = rownames(sc), col = "navy", pos = 3, cex = 0.7)
windows()
plot(df_cprc[,1], df_cprc[,3], xlab = "W1", ylab = "W3", col = "violetred4" , main = "Plot componente principale - W1 si W3")
text(df_cprc[,1], df_cprc[,3], labels = rownames(sc), col = "orangered3", pos = 3, cex = 0.7)

# Varianta 2 - functia ggplot
windows()
ggplot(df_cprc, aes(x = df_cprc[,2], y = df_cprc[,3])) +
  geom_point(shape = 16, size = 2, col = "palegreen4") +
  theme_gray() +
  geom_text(label = rownames(sc), vjust = 0, hjust = 0, size = 3) +
  xlab("W1") +
  ylab("W2") +
  ggtitle("Plot componente principale - W2 si W3") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))

# 11. Biplot
par(mfrow = c(1, 2), mar = c(4, 4, 4, 4))
biplot(df_cprc[,1:2], pca$loadings[,1:2], col = "lightsteelblue4", xlab = "W1", ylab = "W2", cex = c(0.5,0.7), main = "Biplot componente principale - W1 si W2")
biplot(df_cprc[,2:3], pca$loadings[,2:3], col = "violetred4", xlab = "W2", ylab = "W3", cex = c(0.5,0.7), main = "Biplot componente principale - W2 si W3")
fviz_pca_biplot(pca, repel = TRUE, col.var = "brown", col.ind = "plum4")

# 12. Extragerea componentelor principale folosind functia PCA
cp <- PCA(X = tema_std2)
summary(cp)
round(cp$var$cos2, 3)

# 13.1. Graficul indivizilor
windows()
fviz_pca_ind(pca,
             col.ind = "cos2",
             gradient.cols = c("royalblue1", "sandybrown", "orangered"),
             repel = TRUE, title = "Graficul indivizilor")

# 13.2. Graficul variabilelor 
windows()
fviz_pca_var(pca,
             col.var = "contrib",
             gradient.cols = c ("green3", "navajowhite2", "tomato3"),
             repel = TRUE, title = "Graficul variabilelor")


#### Evaluarea factoriabilitatii datelor ####
# 1. Testul KMO
# Varianta 1 - functia implicita 
KMO(tema_AD)

# Varianta 2 - functie explicita
functie_kmo <- function(tema_AD)
{
  tema_AD <- subset(tema_AD,complete.cases(tema_AD))
  r <- cor(tema_AD)
  r2 <- r^2
  i <- solve(r)
  d <- diag(i)
  p2 <- (-i/sqrt(outer(d,d)))^2
  diag(r2) <- diag(p2) <- 0
  KMO <- sum(r2)/(sum(r2)+sum(p2))
  MSA <- colSums(r2)/(colSums(r2)+colSums(p2))
  return(list(KMO=KMO, MSA=MSA))
}
functie_kmo(tema_AD)

# Varianta 3 - matrice
R <- cor(tema_AD)
invR <- solve(R)
A <- matrix(1, nrow(invR), ncol(invR))
for (i in 1:nrow(invR)) 
{
  for (j in (i+1):ncol(invR))
  {
    A[i,j] <- invR[i,j]/sqrt(invR[i,i]*invR[j,j])
    A[j,i] <- A[i,j]
  }
}
colnames(A) <- colnames(tema_AD)
rownames(A) <- colnames(tema_AD)
round(A,3)
kmo.num <- sum(R^2) - sum(diag(R^2))
kmo.denom <- kmo.num + (sum(A^2) - sum(diag(A^2)))
kmo <- kmo.num/kmo.denom

# Varianta 4 - functie din pachetul rela
rez <- paf(as.matrix(tema_AD))
rez$KMO

# 2. Testul Bartlett
# Varianta 1 - functie implicita
cortest.bartlett(tema_AD)

# Varianta 2 - functie explicita
functie_bartlett <- function(tema_AD)
{
  R <- cor(tema_AD)
  n <- ncol(tema_AD)
  m <- nrow(tema_AD)
  test_bartlett <- -((m-1)-((2*n)+5)/6) * log(det(R))
  df <- (n*(n-1)/2)
  crit <- qchisq(.95, df)
  p <- pchisq(test_bartlett, df, lower.tail = FALSE)
  cat("Bartlett's test of sphericity: X2(", df, ")=", test_bartlett, ", p=", round(p,6),sep="")
}
functie_bartlett(tema_AD)
qchisq(0.05, 190, lower.tail = FALSE)  # 223.16

# Varianta 3 - functie din pachetul rela
rez <- paf(as.matrix(tema_AD))
rez$Bartlett


#### Determinarea numarului de factori de extras ####
# 1. Criteriul pantei - scree plot
windows()
scree(tema_AD)
abline (v = 4, lwd = 3, col = "red")
pr_info <- valp * 100 / 20
pr_info[4]

# 2. Analiza paralela 
windows()
fa.parallel(tema_AD)

# 3. Criteriul lui Kaiser
tema_std <- scale(tema_AD)
pca <- princomp(tema_std, cor = TRUE)
stdev <- pca$sdev
valp <- stdev * stdev

# 4. Criteriul procentului de acoperire
pr_info <- valp * 100 / 20
pr_cum <- cumsum(pr_info)
procente <- round(data.frame(pr_info, pr_cum), 3)


#### Realizarea analizei factoriale ####
# 1. Factorializarea axei principale (pa)
# fara rotatie 
pa_fara_rotatie <- fa(tema_AD, nfactors = 4, rotate = "none", fm = "pa")
print(pa_fara_rotatie$loadings, cutoff = 0.4)
windows()
fa.diagram(pa_fara_rotatie)
windows()
corrplot(pa_fara_rotatie$loadings, cutoff = 0.4, method = "number", col = c("chocolate2", "darkgoldenrod1", "firebrick2"))

# comunalitatea
pa_fara_rotatie$communality

# valorile proprii 
pa_fara_rotatie$values

# procentul de varianta contabilizat
100 * pa_fara_rotatie$values[1:4] / 20

# cu rotatie
pa_cu_rotatie <- fa(tema_AD, nfactors = 4, rotate = "Varimax", fm = "pa")
print(pa_cu_rotatie$loadings, cutoff = 0.4)
windows()
fa.diagram(pa_cu_rotatie)
windows()
corrplot(pa_cu_rotatie$loadings, cutoff = 0.4, method = "number", col = c("deepskyblue4", "darkseagreen3", "forestgreen"))

# comunalitatea
pa_cu_rotatie$communality

# valorile proprii 
pa_cu_rotatie$values

# procentul de varianta contabilizat
100 * pa_cu_rotatie$values[1:4] / 20

# 2. Metoda verosimilitatii maxime (ml)
# fara rotatie
ml_fara_rotatie <- fa(tema_AD, nfactors = 4, rotate = "none", fm = "ml")
print(ml_fara_rotatie$loadings, cutoff = 0.4)
windows()
fa.diagram(ml_fara_rotatie)
windows()
corrplot(ml_fara_rotatie$loadings, cutoff = 0.4, method = "number", col = c("deeppink3", "bisque3", "red"))

# comunalitatea
ml_fara_rotatie$communality

# valorile proprii 
ml_fara_rotatie$values

# procentul de varianta contabilizat
100 * ml_fara_rotatie$values[1:4] / 20

# cu rotatie
ml_cu_rotatie <- fa(tema_AD, nfactors = 4, rotate = "Varimax", fm = "ml")
print(ml_cu_rotatie$loadings, cutoff = 0.4)
windows()
fa.diagram(ml_cu_rotatie)
windows()
corrplot(ml_cu_rotatie$loadings, cutoff = 0.4, method = "number", col = c("purple1", "plum2", "violetred2"))

# comunalitatea
ml_cu_rotatie$communality

# valorile proprii 
ml_cu_rotatie$values

# procentul de varianta contabilizat
100 * ml_cu_rotatie$values[1:4] / 20


#### ACS ####
# 1.1. Importarea datelor in R
tema <- read.csv(file = "tema 3 ACS.csv", header = TRUE, sep = ",")
nume <- tema[,1]
rownames(tema) <- nume
tema <- tema[,-1]
View(tema)
head(tema)
tema <- tema[-22,-18]
View(tema)

# 1.2. Convertirea datelor in format tabel
tema_tab <- as.table(as.matrix(tema))
tema_tab

# 1.3. Reprezentarea grafica a datelor
# balloon plot
# varianta 1 - fct balloonplot()
windows()
balloonplot(t(tema_tab), main = "Reprezentarea grafica a datelor", dotcolor = "hotpink4", text.size = 0,5, xlab = "", ylab = "", label = FALSE, show.margins = FALSE)

# varianta 2 - fct ggballoonplot()
windows()
ggballoonplot(tema, ggtheme = theme_gray(), fill = "value", shape = 22) + 
  gradient_fill(c("blue1", "darkolivegreen1", "brown1"))

# mosaic plot
windows()
mosaicplot(tema_tab, shade = TRUE, las = 2, main = "Reprezentarea grafica a datelor")

# 2. Testul de independenta hi^2
X2 <- chisq.test(tema)
hi2 <- 837.35
df <- (nrow(tema) - 1) * (ncol(tema) - 1)
pval <- pchisq(hi2, df = df, lower.tail = FALSE)
round(X2$expected, 3)

# 3. Analiza corespondentelor simple
windows()
CA(tema, ncp = 4, graph = TRUE)
rez <- CA(tema, graph = FALSE)

# 3.1. Interpretarea rezultatelor
summary(rez, nb.dec = 2, ncp = 2)

# valori proprii- varianta 1
rez$eig

# valori proprii - varianta 2
get_eigenvalue(rez)

# scree plot - varianta 1
fviz_screeplot(rez, addlabels = TRUE, ylim = c(0, 60))

# scree plot - varianta 2
1/(ncol(tema) - 1)          # 0,0625
1/(ncol(tema) - 1) * 100    # 6,25%
fviz_screeplot(rez, addlabels = TRUE, ylim = c(0, 60)) + geom_hline(yintercept = 6.25, linetype = 2, color = "magenta")

# 3.2. Rezultatele pe coloana
rez$col
get_ca_col(rez)
rez$col$coord
rez$col$cos2
rez$col$contrib
fviz_ca_col(rez, repel = TRUE, col.col = "darkorchid1", shape.col = 15)

# calitatea reprezentarii coloanelor
# varianta 1 - gradient.cols
windows()
fviz_ca_col(rez, col.col = "cos2", gradient.cols = c("magenta3", "paleturquoise3", "salmon2"), repel = TRUE)

# varianta 2 - alpha.col
windows()
fviz_ca_col(rez, alpha.col = "cos2", repel = TRUE)
windows()
corrplot(rez$col$cos2, is.corr = FALSE, col = c("orangered", "goldenrod", "violetred3"))
windows()
fviz_cos2(rez, choice = "col", axes = 1:2)

# contributia coloanelor la dimensiuni
windows()
corrplot(rez$col$contrib, is.corr = FALSE, col = c("darkolivegreen", "goldenrod", "darkseagreen"))
windows()
fviz_contrib(rez, choice = "col", axes = 1:5)
windows()
fviz_ca_col(rez, col.col = "contrib", gradient.cols = c("dodgerblue1", "greenyellow", "firebrick1"), repel = TRUE)

# 3.3. Rezultatele pe linie
rez$row
get_ca_row(rez)
rez$row$coord
rez$row$cos2
rez$row$contrib
fviz_ca_row(rez, repel = TRUE, col.row = "darkorange2", shape.row = 10)

# calitatea reprezentarii liniilor
# varianta 1 - gradient.cols
windows()
fviz_ca_row(rez, col.row = "cos2", gradient.cols = c("cyan3", "coral", "deeppink"), repel = TRUE)

# varianta 2 - alpha.row
windows()
fviz_ca_row(rez, alpha.row = "cos2", repel = TRUE)
windows()
corrplot(rez$row$cos2, is.corr = FALSE, col = c("dodgerblue2", "gray70", "indianred"))
windows()
fviz_cos2(rez, choice = "row", axes = 1:2)

# contributiile liniilor la dimensiuni
windows()
corrplot(rez$row$contrib, is.corr = FALSE, col = c("lightslateblue", "lightsalmon", "lightseagreen"))
windows()
fviz_contrib(rez, choice = "row", axes = 1:5)
windows()
fviz_ca_row(rez, col.row = "contrib", gradient.cols = c("limegreen", "lightgoldenrod", "mediumpurple1"), repel = TRUE)

# 3.4. CA - biplot
# biplot simetric
windows()
fviz_ca_biplot(rez, repel = TRUE)

# biplot asimetric
windows()
fviz_ca_biplot(rez, map = "rowprincipal", arrow = c(TRUE, TRUE), repel = TRUE)
windows()
fviz_ca_biplot(rez, map = "colprincipal", arrow = c(TRUE, TRUE), repel = TRUE)
windows()
fviz_ca_biplot(rez, map = "symbiplot", arrow = c(TRUE, TRUE), repel = TRUE)

# contributia biplot
windows()
fviz_ca_biplot(rez, map = "colgreen", arrow = c(TRUE, FALSE), repel = TRUE)

# 4. Descrierea dimensiunii 
desc <- dimdesc(rez, axes = 1:5)


#### ACM ####
# 1. Importarea datelor 
tema2 <- read.csv(file = "tema 3 ACM.csv", header = TRUE, sep = ",")
View(tema2)
nume <- tema2[,1]
rownames(tema2) <- nume
tema2 <- tema2[,-1]
View(tema2)

# 2. Analiza corespondentelor multiple si rezumatul datelor
rez_MCA <- MCA(tema2, graph = FALSE)
summary(rez_MCA, nb.dec = 3, nbelements = Inf, ncp = 2)
rez2 <- MCA(tema2, graph = TRUE)

# 3. Vizualizarea si interpretarea rezultatelor ACM
plot(rez_MCA)

# valori proprii - varianta 1
rez_MCA$eig

# valori proprii - varianta 2
get_eigenvalue(rez_MCA)
fviz_eig(rez_MCA, addlabels = TRUE, ylim = c(0,60))

# 3.1. Rezultatele variabilelor categoriale
var_cat <- get_mca_var(rez_MCA)
head(var_cat$coord)
head(var_cat$cos2)
head(var_cat$contrib)

# corelatia dintre variabile si dimensiunile principale
windows()
fviz_mca_var(rez_MCA, choice = "mca.cor", repel = TRUE, ggtheme = theme_gray())

# coordonatele variabilelor categoriale
windows()
fviz_mca_var(rez_MCA, repel = TRUE, ggtheme = theme_gray(), col.var = "cyan4", shape.var = 20)

# calitatea reprezentarii variabilelor categoriale
# varianta 1
windows()
fviz_mca_var(rez_MCA, col.var = "cos2", gradient.cols = c("darkolivegreen4", "cyan3", "darkorange"), repel = TRUE)

# varianta 2
windows()
fviz_mca_var(rez_MCA, alpha.var = "cos2", repel = TRUE, ggtheme = theme_gray())
windows()
corrplot(var_cat$cos2, is.corr = FALSE, col = c("hotpink3", "yellowgreen", "lightsteelblue4"))
windows()
fviz_cos2(rez_MCA, choice = "var", axes = 1:5)

# contributia variabilelor categoriale la dimensiuni
windows()
fviz_contrib(rez_MCA, choice = "var", axes = 1:5)

# varianta 1
windows()
fviz_mca_var(rez_MCA, col.var = "contrib", gradient.cols = c("tomato2", "lightseagreen", "orchid3"), ggtheme = theme_gray(), repel = TRUE)

# varianta 2
windows()
fviz_mca_var(rez_MCA, alpha.var = "contrib", repel = TRUE, ggtheme = theme_gray())


# 3.2. Rezultatele indivizilor
var_ind <- get_mca_ind(rez_MCA)
head(var_ind$coord)
head(var_ind$cos2)
head(var_ind$contrib)

# coordonatele indivizilor
windows()
fviz_mca_ind(rez_MCA, repel = TRUE, ggtheme = theme_gray(), col.ind = "mediumpurple3", shape.ind = 10)

# calitatea reprezentarii indivizilor
# varianta 1
windows()
fviz_mca_ind(rez_MCA, col.ind = "cos2", gradient.cols = c("dodgerblue2", "goldenrod3", "forestgreen"), repel = TRUE, ggtheme = theme_gray())

# varianta 2
windows()
fviz_cos2(rez_MCA, choice = "ind", axes = 1:5)

# contributia indivizilor la dimensiuni
windows()
fviz_contrib(rez_MCA, choice = "ind", axes = 1:5)

# colorarea indivizilor pe grupuri
windows()
fviz_mca_ind(rez_MCA, label = "none", habillage = "Continent", pallete = c("deeppink", "cornflowerblue"), addEllipses = TRUE, ellipse.type = "confidence", ggtheme = theme_gray())
windows()
fviz_mca_ind(rez_MCA, habillage = 3, addEllipses = TRUE)
windows()
fviz_ellipses(rez_MCA, c("Continent", "Limba.oficiala"), geom = "point")
windows()
plotellipses(rez_MCA, keepvar = "all", axes = c(1, 2))

# 4. Biplot-ul
windows()
fviz_mca_biplot(rez_MCA, repel = TRUE, ggtheme = theme_gray())

# 5. Descrierea dimensiunii
mca.desc <- dimdesc(rez_MCA, axes = 1:5)


#### Invatarea nesupervizata. Analiza cluster si algoritmi de clustering ####
# 2. Metode ierarhice 
# 2.1. Pregatirea datelor
tema_AD <- na.omit(tema_AD)

# standardizare (functia scale)
tema_std <- scale(tema_AD, scale = TRUE)
rownames(tema_std) <- tema$Country.Code
View(tema_std)

# normalizare (metoda min-max)
minim <- apply(tema_AD, 2, min)
maxim <- apply(tema_AD, 2, max)
tema_scal <- as.data.frame(scale(tema_AD, center = minim, scale = maxim-minim))
View(tema_scal)

# 2.2. Evaluarea distantelor intre forme
# Varianta 1 - functia dist()
matrice_dist <- dist(as.matrix(tema_std), method = "euclidian")
View(as.matrix(matrice_dist))
m <- melt(as.matrix(matrice_dist))
windows()
ggplot(data = m, aes(x = Var1, y = Var2, fill = value)) + 
  geom_tile() +
  ggtitle("Reprezentarea grafica a distantelor intre forme") +
  theme(axis.text.x = element_text(angle = 50), plot.title = element_text(face = "bold", hjust = 0.5)) + 
  scale_fill_gradient(low = "palegreen", high = "orangered")

# Varianta 2 - functia get_dist()
dist <- get_dist(tema_scal)
View(as.matrix(dist))
windows()
fviz_dist(dist, gradient = list(low = "plum3", mid = "lightyellow", high = "darksalmon"))

# Varianta 3 - construirea propriu-zisa a matricei
dist_euclid <- sqrt((tema_std[1, 1] - tema_std[2, 1])^2 +
                      (tema_std[1, 2] - tema_std[2, 2])^2 +
                      (tema_std[1, 3] - tema_std[2, 3])^2 +
                      (tema_std[1, 4] - tema_std[2, 4])^2 +
                      (tema_std[1, 5] - tema_std[2, 5])^2 +
                      (tema_std[1, 6] - tema_std[2, 6])^2 +
                      (tema_std[1, 7] - tema_std[2, 7])^2 +
                      (tema_std[1, 8] - tema_std[2, 8])^2 +
                      (tema_std[1, 9] - tema_std[2, 9])^2 + 
                      (tema_std[1, 10] - tema_std[2, 10])^2 +
                      (tema_std[1, 11] - tema_std[2, 11])^2 +
                      (tema_std[1, 12] - tema_std[2, 12])^2 +
                      (tema_std[1, 13] - tema_std[2, 13])^2 +
                      (tema_std[1, 14] - tema_std[2, 14])^2 +
                      (tema_std[1, 15] - tema_std[2, 15])^2 +
                      (tema_std[1, 16] - tema_std[2, 16])^2 +
                      (tema_std[1, 17] - tema_std[2, 17])^2 +
                      (tema_std[1, 18] - tema_std[2, 18])^2 +
                      (tema_std[1, 19] - tema_std[2, 19])^2 +
                      (tema_std[1, 20] - tema_std[2, 20])^2)
dist_euclid     # 7.87734
matrice_dist[1]   # 7.87734
tema_std[1:2,]

# 2.3. Metoda propriu-zisa
# 2.3.1. Metoda Ward
met_ward <- hclust(matrice_dist, method = "ward.D2")
cbind(met_ward$merge, met_ward$height)

# dendograma
windows()
plot(met_ward, labels = rownames(tema_std))

# barplot
windows()
barplot(met_ward$height, names.arg = (nrow(tema_scal) - 1):1)

# metoda cotului 
windows()
fviz_nbclust(tema_std, hcut, method = "wss") + 
  geom_vline(xintercept = 3, linetype = 2) + 
  labs(subtitle = "Elbow Method - legatura simpla")

# regula majoritatii
reg_maj <- NbClust(tema_std, distance = "euclidean", min.nc = 2, max.nc = 6, method = "ward.D2", index = "all")

# graficul siluetei medii
graf_sil <- silhouette(cutree(met_ward, k = 3), tema_std)
windows()
plot(graf_sil, cex.names = 0.5)

# centroizii
centroizi <- tapply(as.matrix(tema_std), list(rep(cutree(met_ward, 3), ncol(tema_std)), col(tema_std)), mean)
colnames(centroizi) <- colnames(tema_std)
round(centroizi, 3)

# incadrarea clusterelor in dendograma
windows()
plot(met_ward, labels = rownames(tema_std))
rect.hclust(met_ward, k = 3, border = 2:5)

# 2.3.2. Metoda celor mai apropiati vecini
# Varianta 1 - functia hclust()
leg_simpla <- hclust(matrice_dist, method = "single")
round(leg_simpla$height, 3)

# dendograma
plot(leg_simpla, labels = rownames(tema_std))

# regula majoritatii
reg_maj2 <- NbClust(tema_std, distance = "euclidean", min.nc = 2, max.nc = 7, method = "single", index = "all")

# incadrarea clusterelor in dendograma
windows()
plot(leg_simpla, labels = rownames(tema_std))
rect.hclust(leg_simpla, k = 6, border = 2:5)

# graficul siluetei medii 
graf_sil2 <- silhouette(cutree(leg_simpla, k = 6), tema_std)
windows()
plot(graf_sil2, cex.names = 0.5)

# Varianta 2 - functia agnes()
agnes_single <- agnes(dist(tema_scal), method = "single")

# coeficientul de aglomerare
agnes_single$ac

# inaltimile de agregare
round(agnes_single$height, 3)

# 2.3.3. Metoda celor mai departati vecini
leg_completa <- hclust(matrice_dist, method = "complete")
round(leg_completa$height, 3)

# dendograma
windows()
plot(leg_completa, labels = rownames(tema_std))

# regula majoritatii 
reg_maj3 <- NbClust(tema_std, distance = "euclidean", min.nc = 2, max.nc = 6, method = "complete", index = "all")

# incadrarea clusterelor in dendograma
windows()
plot(leg_completa, labels = rownames(tema_std))
rect.hclust(leg_completa, k = 4, border = 2:5)

# 2.3.4. Metoda distantei medii dintre elementele celor doua grupuri
leg_medie <- hclust(matrice_dist, method = "average")
round(leg_medie$height, 3)

# dendograma
windows()
plot(leg_medie, labels = rownames(tema_std))

# regula majoritatii
reg_maj4 <- NbClust(tema_std, distance = "euclidean", min.nc = 2, max.nc = 6, method = "average", index = "all")

# incadrarea clusterelor in dendograma
windows()
plot(leg_medie, labels = rownames(tema_std))
rect.hclust(leg_medie, k = 3, border = 2:5)

# 2.3.5. Clustering pentru legatura de tip centroid
leg_centroid <- hclust(matrice_dist, method = "centroid")
round(leg_centroid$height, 3)

# dendograma
windows()
plot(leg_centroid, labels = rownames(tema_std))

# regula majoritatii
reg_maj5 <- NbClust(tema_std, distance = "euclidean", min.nc = 3, max.nc = 6, method = "centroid", index = "all")

# incadrarea clusterelor in dendograma
windows()
plot(leg_centroid, labels = rownames(tema_std))
rect.hclust(leg_centroid, k = 3, border = 2:5)

# 2.4. Lucrul cu dendograme
leg_simpla <- hclust(matrice_dist, method = "single")
subgrup_simpla <- cutree(leg_simpla, k = 4)
table(subgrup_simpla)
windows()
plot(leg_simpla, labels = rownames(tema_std))
rect.hclust(leg_simpla, k = 4, border = 2:5)
windows()
fviz_cluster(list(data = tema_scal, cluster = subgrup_simpla))

# compararea a doua dendograme (leg_simpla - met_ward)
matrice_dist <- dist(as.matrix(tema_std), method = "euclidian")
leg_simpla <- hclust(matrice_dist, method = "single")
met_ward <- hclust(matrice_dist, method = "ward.D2")
dendograma1 <- as.dendrogram(leg_simpla)
dendograma2 <- as.dendrogram(met_ward)
windows()
tanglegram(dendograma1, dendograma2)

# calitatea alinierii celor 2 arbori
lista <- dendlist(dendograma1, dendograma2)
coef_imbinare <- entanglement(lista)
windows()
tanglegram(dendograma1, dendograma2, highlight_distinct_edges = FALSE, common_subtrees_color_lines = FALSE, common_subtrees_color_branches = TRUE,
           main = paste("entanglement = ", round(coef_imbinare, 2)))

# 3. Metoda k-mean clustering (algoritmul centrului mobil)
dim(tema_AD)

# 3.1. Pregatirea datelor
tema_AD <- na.omit(tema_AD)

# standardizare (functia scale)
tema_std <- scale(tema_AD, scale = TRUE)
rownames(tema_std) <- tema$Country.Code
View(tema_std)

# normalizare (metoda min-max)
minim <- apply(tema_AD, 2, min)
maxim <- apply(tema_AD, 2, max)
tema_scal <- as.data.frame(scale(tema_AD, center = minim, scale = maxim-minim))
View(tema_scal)

# 3.2. Evaluarea distantelor intre forme
# Varianta 1 - functia dist()
matrice_dist <- dist(as.matrix(tema_std), method = "euclidian")
View(as.matrix(matrice_dist))
m <- melt(as.matrix(matrice_dist))
windows()
ggplot(data = m, aes(x = Var1, y = Var2, fill = value)) + 
  geom_tile() +
  ggtitle("Reprezentarea grafica a distantelor intre forme") +
  theme(axis.text.x = element_text(angle = 50), plot.title = element_text(face = "bold", hjust = 0.5)) + 
  scale_fill_gradient(low = "cadetblue1", high = "violetred3")

# Varianta 2 - functia get_dist()
dist <- get_dist(tema_scal)
View(as.matrix(dist))
windows()
fviz_dist(dist, gradient = list(low = "darkolivegreen3", mid = "blanchedalmond", high = "darkorange1"))

# 3.3. Metoda propriu-zisa
kmeans_clustering <- kmeans(tema_std, centers = 3)
print(kmeans_clustering$cluster)
tema_cluster <- data.frame(tema_std, kmeans_clustering$cluster)
View(tema_cluster)
windows()
fviz_cluster(kmeans_clustering, data = tema_std)
windows()
tema_std %>% 
  as_tibble() %>%
  mutate(cluster = kmeans_clustering$cluster, state = row.names(tema)) %>%
  ggplot(aes(NOD, POP, color = factor(cluster), label = state)) + 
  geom_text() +
  theme_gray()

# 3.4. Masurarea calitatii unei parti k-mean
BSS <- kmeans_clustering$betweenss
TSS <- kmeans_clustering$totss
BSS/TSS * 100

# 4. Alegerea celui mai bun dintre algoritmii de clustering
metode_clustering <- c("hierarchical", "kmeans")
masuri_interne <- clValid(tema_std, nClust = 2:8, clMethods = metode_clustering, validation = "internal", 
                          maxitems = 600, metric = "euclidean", method = "average")
summary(masuri_interne)
masuri_stabilitate <- clValid(tema_std, nClust = 2:8, clMethods = metode_clustering, validation = "stability", 
                              maxitems = 500, metric = "euclidean", method = "average")
summary(masuri_stabilitate)
optimalScores(masuri_stabilitate)

# 5. Evaluarea variabilitatii intraclasa si interclase
variabile <- cbind(kmeans_clustering$totss, kmeans_clustering$tot.withinss, kmeans_clustering$betweenss, kmeans_clustering$betweenss/kmeans_clustering$tot.withinss)
kmeans_clustering$withinss

# 6. Evaluarea puterii de discriminare a variabilelor
round(kmeans_clustering$centers, 3)
centroizi_df <- data.frame(round(kmeans_clustering$centers, 3))
describe(centroizi_df)
min_centroizi <- describe(centroizi_df)$min
max_centroizi <- describe(centroizi_df)$max
c1 <- t(centroizi_df[1,])
c2 <- t(centroizi_df[2,])
c3 <- t(centroizi_df[3,])
df <- data.frame(c1, c2, c3, min_centroizi, max_centroizi)
rownames(df) <- colnames(centroizi_df)
View(df)
windows()
ggplot(df) +
  geom_segment(aes(x = rownames(df), xend = rownames(df), y = min_centroizi, yend = max_centroizi), color = "lightslateblue") +
  geom_point(aes(x = rownames(df), y = c1), color = rgb(0.3, 0.1, 0.6), size = 5) +
  geom_point(aes(x = rownames(df), y = c2), color = rgb(0.6, 0.3, 0.1), size = 5) +
  geom_point(aes(x = rownames(df), y = c3), color = rgb(0.1, 0.6, 0.3), size =  5)
rez <- rbind(round(discPower(tema_cluster[,2:21], tema_cluster[,1])$F_statistic, 4), round(discPower(tema_cluster[,2:21], tema_cluster[,1])$p_value, 4))


#### Invatarea supervizata. Algoritmi de clasificare a datelor în mediul R ####
tema_AD <- na.omit(tema_AD)

# 1. Algoritmul k-means clustering
tema_std <- scale(tema_AD, scale = TRUE)
rownames(tema_std) <- tema$Country.Code
View(tema_std)
kmeans_clustering <- kmeans(tema_std, centers = 3)
k_cluster <- kmeans_clustering$cluster
set_date <- cbind(tema_std, k_cluster)
set_date <- round(set_date, 3)
View(set_date)
date <- data.frame(set_date)
View(date)
dim <- round(nrow(date) * 0.7)
esantion <- sample(seq_len(nrow(date)), size = dim)
set_antrenare <- date[esantion,]
round(set_antrenare, 3)
set_testare <- date[-esantion,]
round(set_testare, 3)
df <- data.frame(set_antrenare)
df$k_cluster[df$k_cluster == 1] <- 'Clasa 1'
df$k_cluster[df$k_cluster == 2] <- 'Clasa 2'
df$k_cluster[df$k_cluster == 3] <- 'Clasa 3'
View(df)

# 2. Clasificatorul naiv Bayesian
bayes <- naiveBayes(as.factor(df[,21])~., data = df[,-21])
summary(bayes)
bayes$apriori
bayes$tables
bayes$levels
predictie <- predict(bayes, df[,-21], type = "class")
matrice_confuzie <- table(predictie, df[,21], dnn = c("Prediction", "Actual"))
confusionMatrix(matrice_confuzie)
predictie2 <- predict(bayes, df[,-21], type = "raw")
round(predictie2, 4)
predictie_test <- predict(bayes, set_testare[,-21], type = "class")
table(predictie_test, set_testare[,21], dnn = c("Prediction", "Actual"))
predictie_test2 <- predict(bayes, set_testare[,-21], type = "raw")
round(predictie_test2, 4)

# 3. Algoritmul KNN
pr <- knn(set_antrenare[,-21], set_testare[,-21], cl = set_antrenare[,21], k = 2)
df_pred <- data.frame(set_testare[,21], pr)
matrC_test <- table(pr, set_testare[,21])
CrossTable(x = pr, y = set_testare[,21], prop.chisq = FALSE)
pr2 <- knn(set_antrenare[,-21], set_testare[,-21], cl = set_antrenare[,21], k = 4)
df_pred2 <- data.frame(set_testare[,21], pr2)
matrC_test2 <- table(pr2, set_testare[,21])
CrossTable(x = pr2, y = set_testare[,21], prop.chisq = FALSE)

# acuratetea modelului
acc <- function(x) {
  sum(diag(x) / (sum(rowSums(x)))) * 100
}
acc(matrC_test)
acc(matrC_test2)
