tema_curs <- read.csv(file = "../Desktop/R/tema.csv", header = TRUE, sep = ",")
tema_curs <- read.csv(file = "tema.csv", header = TRUE, sep = ",")
View(tema_curs)
attach(tema_curs)

Rentabilitate_Nike <- c(252)
Rentabilitate_Nike[1] = 0
for(j in 2:length(Pret_Nike))
{
  Rentabilitate_Nike[j] <- (Pret_Nike[j] / Pret_Nike[j-1]) - 1
}

Rentabilitate_Mc <- c(252)
Rentabilitate_Mc[1] = 0
for(j in 2:length(Pret_Mc))
{
  Rentabilitate_Mc[j] <- (Pret_Mc[j] / Pret_Mc[j-1]) - 1
}

Rentabilitate_SP <- c(252)
Rentabilitate_SP[1] = 0
for(j in 2:length(Pret_SP))
{
  Rentabilitate_SP[j] <- (Pret_SP[j] / Pret_SP[j-1]) - 1
}

date_initiale.df <- data.frame(Date, Pret_Nike, Pret_Mc, Pret_SP, Volum_Nike, Volum_Mc, Volum_SP)
View(date_initiale.df)

date.df <- data.frame(Date, Pret_Nike, Pret_Mc, Pret_SP, Volum_Nike, Volum_Mc, Volum_SP, Rentabilitate_Nike, Rentabilitate_Mc, Rentabilitate_SP)
View(date.df)
write.csv(date.df, file = "date finale tema.csv")

write.csv(sts_descriptive, file = "statistici descriptive tema.csv")

statistici_descriptive <- matrix(nrow = 6, ncol = 9)
row.names(statistici_descriptive) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.")
colnames(statistici_descriptive) <- c("Pret_Nike", "Pret_Mc", "Pret_SP", "Volum_Nike", "Volum_Mc", "Volum_SP", "Rentabilitate_Nike", "Rentabilitate_Mc", "Rentabilitate_SP")

statistici_descriptive[1:6, 1] <- summary(Pret_Nike)
statistici_descriptive[1:6, 2] <- summary(Pret_Mc)
statistici_descriptive[1:6, 3] <- summary(Pret_SP)
statistici_descriptive[1:6, 4] <- summary(Volum_Nike)
statistici_descriptive[1:6, 5] <- summary(Volum_Mc)
statistici_descriptive[1:6, 6] <- summary(Volum_SP)
statistici_descriptive[1:6, 7] <- summary(Rentabilitate_Nike)
statistici_descriptive[1:6, 8] <- summary(Rentabilitate_Mc)
statistici_descriptive[1:6, 9] <- summary(Rentabilitate_SP)

View(statistici_descriptive)
write.csv(statistici_descriptive, file = "statistici descriptive tema.csv")


matrice_variatii <- matrix(nrow = 4, ncol = 9)
row.names(matrice_variatii) <- c("sd", "CV", "skewness", "kurtosis")
colnames(matrice_variatii) <- c("Pret_Nike", "Pret_Mc", "Pret_SP", "Volum_Nike", "Volum_Mc", "Volum_SP", "Rentabilitate_Nike", "Rentabilitate_Mc", "Rentabilitate_SP")

matrice_variatii[1,1] <- sd(Pret_Nike)
matrice_variatii[1,2] <- sd(Pret_Mc)
matrice_variatii[1,3] <- sd(Pret_SP)
matrice_variatii[1,4] <- sd(Volum_Nike)
matrice_variatii[1,5] <- sd(Volum_Mc)
matrice_variatii[1,6] <- sd(Volum_SP)
matrice_variatii[1,7] <- sd(Rentabilitate_Nike)
matrice_variatii[1,8] <- sd(Rentabilitate_Mc)
matrice_variatii[1,9] <- sd(Rentabilitate_SP)

matrice_variatii[2,1] <- 100 * sd(Pret_Nike) / mean(Pret_Nike)
matrice_variatii[2,2] <- 100 * sd(Pret_Mc) / mean(Pret_Mc)
matrice_variatii[2,3] <- 100 * sd(Pret_SP) / mean(Pret_SP)
matrice_variatii[2,4] <- 100 * sd(Volum_Nike) / mean(Volum_Nike)
matrice_variatii[2,5] <- 100 * sd(Volum_Mc) / mean(Volum_Mc)
matrice_variatii[2,6] <- 100 * sd(Volum_SP) / mean(Volum_SP)
matrice_variatii[2,7] <- 100 * sd(Rentabilitate_Nike) / mean(Rentabilitate_Nike)
matrice_variatii[2,8] <- 100 * sd(Rentabilitate_Mc) / mean(Rentabilitate_Mc)
matrice_variatii[2,9] <- 100 * sd(Rentabilitate_SP) / mean(Rentabilitate_SP)

library(moments)
matrice_variatii[3,1] <- skewness(Pret_Nike)
matrice_variatii[3,2] <- skewness(Pret_Mc)
matrice_variatii[3,3] <- skewness(Pret_SP)
matrice_variatii[3,4] <- skewness(Volum_Nike)
matrice_variatii[3,5] <- skewness(Volum_Mc)
matrice_variatii[3,6] <- skewness(Volum_SP)
matrice_variatii[3,7] <- skewness(Rentabilitate_Nike)
matrice_variatii[3,8] <- skewness(Rentabilitate_Mc)
matrice_variatii[3,9] <- skewness(Rentabilitate_SP)

matrice_variatii[4,1] <- kurtosis(Pret_Nike)
matrice_variatii[4,2] <- kurtosis(Pret_Mc)
matrice_variatii[4,3] <- kurtosis(Pret_SP)
matrice_variatii[4,4] <- kurtosis(Volum_Nike)
matrice_variatii[4,5] <- kurtosis(Volum_Mc)
matrice_variatii[4,6] <- kurtosis(Volum_SP)
matrice_variatii[4,7] <- kurtosis(Rentabilitate_Nike)
matrice_variatii[4,8] <- kurtosis(Rentabilitate_Mc)
matrice_variatii[4,9] <- kurtosis(Rentabilitate_SP)

View(matrice_variatii)


dev.off()

par(mfrow = c(1,2), mar = c(2,2,2,2))
hist(Pret_Nike, main = "Histograma pretului actiunilor Nike", col = "lightblue")
boxplot(Pret_Nike, horizontal = TRUE, main = "Boxplot-ul pretului actiunilor Nike", col = "lightblue")

hist(Pret_Mc, main = "Histograma pretului actiunilor Mc", col = "lightgreen")
boxplot(Pret_Mc, horizontal = TRUE, main = "Boxplot-ul pretului actiunilor Mc", col = "lightgreen")

hist(Pret_SP, main = "Histograma pretului indicelui de piata S&P500", col = "lightpink")
boxplot(Pret_SP, horizontal = TRUE, main = "Boxplot-ul pretului indicelui de piata S&P500", col = "lightpink")

hist(Volum_Nike, main = "Histograma volumului actiunilor Nike", col = "lightblue")
boxplot(Volum_Nike, horizontal = TRUE, main = "Boxplot-ul volumului actiunilor Nike", col = "lightblue")

hist(Volum_Mc, main = "Histograma volumului actiunilor Mc", col = "lightgreen")
boxplot(Volum_Mc, horizontal = TRUE, main = "Boxplot-ul volumului actiunilor Mc", col = "lightgreen")

hist(Volum_SP, main = "Histograma volumului indicelui de piata S&P500", col = "lightpink")
boxplot(Volum_SP, horizontal = TRUE, main = "Boxplot-ul volumului indicelui de piata S&P500", col = "lightpink")

hist(Rentabilitate_Nike, main = "Histograma rentabilitatii actiunilor Nike", col = "lightblue")
boxplot(Rentabilitate_Nike, horizontal = TRUE, main = "Boxplot-ul rentabilitatii actiunilor Nike", col = "lightblue")

hist(Rentabilitate_Mc, main = "Histograma rentabilitatii actiunilor Mc", col = "lightgreen")
boxplot(Rentabilitate_Mc, horizontal = TRUE, main = "Boxplot-ul rentabilitatii actiunilor Mc", col = "lightgreen")

hist(Rentabilitate_SP, main = "Histograma rentabilitatii indicelui de piata S&P500", col = "lightpink")
boxplot(Rentabilitate_SP, horizontal =TRUE, main = "Boxplot-ul rentabilitatii indicelui de piata S&P500", col = "lightpink")


matrice_corelatie <- cor(date.df[-1])
View(matrice_corelatie)

library(corrplot)
corrplot(matrice_corelatie, method = "number")


dev.off()

par(mfrow = c(2,1))
plot(Rentabilitate_Nike, type = "l", col = "magenta", main = "Rentabilitatea actiunilor Nike")
plot(Rentabilitate_SP, type = "l", col = "darkblue", main = "Rentabilitatea indicelui de piata")

plot(Rentabilitate_Mc, type = "l", col = "orange", main = "Rentabilitatea actiunilor McDonald's")
plot(Rentabilitate_SP, type = "l", col = "darkblue", main = "Rentabilitatea indicelui de piata")

plot(Pret_Nike, type = "l", col = "purple", main = "Evolutia pretului actiunilor Nike")
plot(Pret_SP, type = "l", col = "blue", main = "Evolutia pretului actiunilor indicelui de piata")

plot(Pret_Mc, type = "l", col = "green", main = "Evolutia pretului actiunilor McDonald's")
plot(Pret_SP, type = "l", col = "blue", main = "Evolutia pretului actiunilor indicelui de piata")

plot(Volum_Nike, type = "l", col = "aquamarine3", main = "Volumul actiunii Nike")
plot(Volum_SP, type = "l", col = "darkgrey", main = "Volumul indicelui de piata")

plot(Volum_Mc, type = "l", col = "deeppink", main = "Volumul actiunii Mc")
plot(Volum_SP, type = "l", col = "darkgrey", main = "Volumul indicelui de piata")
