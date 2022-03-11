install.packages("caTools")
install.packages("ROCR")
install.packages("party")
install.packages("nnet")
install.packages("e1071")
install.packages("tree")
install.packages("caret")
install.packages("FNN")
install.packages("neuralnet")
install.packages("kohonen")
library(ggplot2)
library(caTools)
library(ROCR)
library(party)
library(nnet)
library(e1071)
library(tree)
library(caret)
library(FNN)
library(neuralnet)
library(kohonen)

options(scipen = 100)


proiect <- read.csv(file = "set date proiect.csv", header = TRUE, sep = ",")
proiect <- na.omit(proiect)
View(proiect)

proiect2 <- cbind(proiect[,1:2], proiect[,5:22])
View(proiect2)


attach(proiect)

summary(proiect2)

which.min(Income)
which.max(Income)


# Regresia logistica binomiala
promotion <- data.frame(NumDealsPurchases, NumCampaigns, Accepted)
View(promotion)

windows()
ggplot(promotion, aes(x = NumDealsPurchases, y = NumCampaigns, col = Accepted)) +
  geom_point(aes(size = 5)) + 
  theme_gray()

promotion$Accepted.factor <- factor(promotion$Accepted)
View(promotion)

set.seed(90)
split <- sample.split(promotion$Accepted.factor, SplitRatio = 0.75)

set_antrenare <- subset(promotion, split == TRUE)

set_testare <- subset(promotion, split == FALSE)

windows()
ggplot(promotion, aes(x = NumDealsPurchases, y = NumCampaigns, col = Accepted.factor)) + 
  geom_point(aes(size = 5)) + 
  theme_gray()

regresie_logistica_b <- glm(Accepted.factor ~ NumDealsPurchases + NumCampaigns, data = set_antrenare, family = binomial)
summary(regresie_logistica_b)

exp(coef(regresie_logistica_b))

contrasts(promotion$Accepted.factor)

probabilitate <- predict(regresie_logistica_b, set_testare, type = "response")

vect_antr <- rep("0", dim(set_antrenare)[1])
vect_antr[probabilitate > 0.5] = "1"
table(vect_antr, set_antrenare$Accepted.factor)
(124 + 15)/(124 + 39 + 39 + 15) * 100

predictie <- predict(regresie_logistica_b, newdata = data.frame(NumDealsPurchases = c(7, 15), NumCampaigns = c(2, 4)), type = "response")
predictie[1] <= 0.5
predictie[2] <= 0.5

vect_test <- rep("0", dim(set_testare)[1])
vect_test[probabilitate > 0.5] = "1"
table(vect_test, set_testare$Accepted.factor)
mean(vect_test == set_testare$Accepted.factor)

pred <- predict(regresie_logistica_b, newdata = set_testare, type = "response")
predc <- prediction(pred, set_testare$Accepted.factor)
perf <- performance(predc, measure = "tpr", x.measure = "fpr")
plot(perf)

auc <- performance(predc, measure = "auc")
auc@y.values[[1]]


is.recursive(set_testare)
is.atomic(set_testare)
getElement(set_testare, "Accepted.factor")


# Regresie logistica multinomiala
client <- data.frame(Education, Year_Birth, Marital_Status, Income)
View(client)

client$Education.factor <- factor(client$Education)
client$out <- relevel(client$Education.factor, ref = "Basic")

regresie_logistica_m <- multinom(out ~ Year_Birth + Marital_Status + Income, data = client, trace = FALSE)
summary(regresie_logistica_m)

exp(coef(regresie_logistica_m))

predict(regresie_logistica_m, client)

predict(regresie_logistica_m, client, type = "prob")

predict(regresie_logistica_m, client[c(10, 127, 254),], type = "prob")

matrice_confuzie <- table(client$Education[1:40], predict(regresie_logistica_m)[1:40])



# Arbori de clasificare 
set.seed(120)
esantion <- sample(2, nrow(proiect), replace = TRUE, prob = c(0.7, 0.3))

setAntrenare <- proiect[esantion == 1,]

setTestare <- proiect[esantion == 2,]

formula <- NumDealsPurchases ~ NumWebPurchases + NumCatalogPurchases + NumStorePurchases

proiect_ctree <- ctree(formula, data = setAntrenare)
print(proiect_ctree)
table(predict(proiect_ctree), setAntrenare$NumDealsPurchases)

plot(proiect_ctree)
plot(proiect_ctree, type = "simple")

test_predictie <- predict(proiect_ctree, newdata = setTestare)
matriceConfuzie <- table(test_predictie, setTestare$NumDealsPurchases)

classAgreement(matriceConfuzie)



# Arbori de regresie
attach(proiect2)

windows()
hist(proiect2$Income, col = "cadetblue2", main = "Histograma Income")
proiect2$Income <- log(proiect2$Income)
windows()
hist(proiect2$Income, col = "darkolivegreen2", main = "Histograma Income dupa logaritmare")

split <- createDataPartition(y = proiect2$Income, p = 0.5, list = FALSE)

antrenare <- proiect2[split,]

testare <- proiect2[-split,]

arbore <- tree(Income~., testare)

plot(arbore)
text(arbore, pretty = 0)

cv_arbore <- cv.tree(arbore)
cv_arbore$size
round(cv_arbore$dev, 3)
windows()
plot(cv_arbore$size, cv_arbore$dev, type = "b")

arbore1 <- prune.tree(arbore, best = 8)
plot(arbore1)
text(arbore1, pretty = 0)

pred_arbore <- predict(arbore1, testare)
windows()
plot(pred_arbore, testare$Income)

round(mean((pred_arbore - testare$Income)^2), 5)



# KNN pentru clasificare
deals <- data.frame(NumDealsPurchases, NumWebPurchases, NumStorePurchases, Accepted)
View(deals)
str(deals)

deals$Accepted[deals$Accepted == 0] <- 'Nu'
deals$Accepted[deals$Accepted == 1] <- 'Da'
deals$Accepted <- factor(deals$Accepted)
View(deals)

set.seed(1300)
set <- sample(2, nrow(deals), replace = TRUE, prob = c(0.7, 0.3))

training <- deals[set == 1,]
test <- deals[set == 2,]
str(training)

training_ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3, classProbs = TRUE, summaryFunction = twoClassSummary)

set.seed(200)
fit <- train(Accepted~., data = training, method = 'knn', tuneLength = 20, trControl = training_ctrl, preProc = c("center", "scale"),
             metric = "ROC", tuneGrid = expand.grid(k = 1:60))
plot(fit, col = "darkorchid2", main = "Curba ROC")

matr_conf <- predict(fit, newdata = test)
confusionMatrix(matr_conf, test$Accepted)



# KNN pentru regresie
cheltuieli <- data.frame(ID, Year_Birth, Income, MntWines)
View(cheltuieli)

set.seed(1000)
model_knn3 <- knn.reg(train = cheltuieli[c("Income")],
                     y = cheltuieli$MntWines,
                     test = data.frame(Income = seq(25000, 40000)),
                     k = 3)
plot(cheltuieli$Income, cheltuieli$MntWines, xlim = c(0, 50000), ylim = c(0, 1000), main = "Valorile variabilelor MntWines si Income \n Curba KNN pentru k = 3")
lines(seq(25000, 40000), model_knn3$pred, col = "red")

model_knn_pred3 <- knn.reg(train = cheltuieli[c("Income")],
                          y = cheltuieli$MntWines,
                          test = cheltuieli[c("Income")],
                          k = 3)

mse_knn3 <- mean((model_knn_pred3$pred - cheltuieli$MntWines)^2)

dim(cheltuieli)

R2_knn3 <- 1 - mse_knn3 / (var(cheltuieli$MntWines) * 288 / 289)


model_knn21 <- knn.reg(train = cheltuieli[c("Income")],
                     y = cheltuieli$MntWines,
                     test = data.frame(Income = seq(25000, 40000)),
                     k = 21)
plot(cheltuieli$Income, cheltuieli$MntWines, xlim = c(0, 80000), ylim = c(0, 1000),  main = "Valorile variabilelor MntWines si Income \n Curbele KNN pentru k = 3 si k = 21")
lines(seq(25000, 40000), model_knn3$pred, col = "red")
lines(seq(25000, 40000), model_knn21$pred, col = "blue")

model_knn_pred21 <- knn.reg(train = cheltuieli[c("Income")],
                           y = cheltuieli$MntWines,
                           test = cheltuieli[c("Income")],
                           k = 21)

mse_knn21 <- mean((model_knn_pred21$pred - cheltuieli$MntWines)^2)
R2_knn21 <- 1 - mse_knn21 / (var(cheltuieli$MntWines) * 288 / 289)

model_liniar <- lm(MntWines ~ Income, data = cheltuieli)
model_pred <- predict(model_liniar, newdata = data.frame(Income = seq(25000, 40000)))

plot(cheltuieli$Income, cheltuieli$MntWines, xlim = c(0, 80000), main = "Valorile variabilelor MntWines si Income \n Curbele KNN pentru k = 3 si k = 21 \n Dreapta predictiilor modelului liniar")
lines(seq(25000, 40000), model_knn3$pred, col = "red")
lines(seq(25000, 40000), model_knn21$pred, col = "blue")
lines(seq(25000, 40000), model_pred, col = "green")



# SVM pentru clasificare
info <- data.frame(Marital_Status, Education, Year_Birth, Income, Recency)
View(info)

index <- 1:nrow(info)
test_index <- sample(index, trunc(length(index) * 30 / 100))
test_set <- info[test_index,]
train_set <- info[-test_index,]

info_train <- subset(train_set, Marital_Status == 'Single', select = Education:Recency)

info_test <- subset(test_set, Marital_Status == 'Single', select = Education:Recency)

info_svm <- best.svm(factor(Education)~., data = info_train)

info_svm_liniar <- best.svm(factor(Education)~., data = info_train, type = "C-classification", kernel = "linear")

clasa_train <- predict(info_svm, info_train)
mat_conf_train <- table(info_train$Education, predict(info_svm, info_train))
round(mean(info_train$Education == predict(info_svm, info_train)), 2)

clasa_test <- predict(info_svm, info_test)
mat_conf_test <- table(info_test$Education, predict(info_svm, info_test))
round(mean(info_test$Education == predict(info_svm, info_test)), 2)

info_svm$index

info_part <- info[,c(3, 4, 5)]
fit <- svm(factor(Education)~ Income + Recency, data = info_part, type = 'C-classification', kernel = 'linear')

dev.new(width = 5, height = 5)
windows()
plot(fit, info_part)   



# SVM pentru regresie
df <- cbind(proiect[,1:2], proiect[,5:21])
View(df)

classColumn <- 3
dim(df)

set_date <- sample(1:289, replace = FALSE)
set_date_train <- set_date[1:200]
set_date_test <- set_date[201:289]

setantrenare <- df[set_date_train,]
setantrenare <- na.omit(setantrenare)

settestare <- df[set_date_test,]
settestare <- na.omit(settestare)

svm_model <- svm(Income~., data = setantrenare, kernel = "radial", epsilon = 0)
svm_pred <- predict(svm_model, settestare[,-classColumn])
summary(svm_pred)

RMSE <- sqrt(mean((svm_pred - settestare[,classColumn])^2))
print(RMSE)

cor.test(svm_pred, settestare[,classColumn], method = "pearson")
cor.test(svm_pred, settestare[,classColumn], method = "spearman")

data.frame(settestare[,classColumn], svm_pred)

windows()
plot(svm_pred, settestare$Income, xlab = "Venitul anual previzionat", ylab = "Venitul anual real", main = "Dependenta dintre venitul anual real si venitul anual previzionat", col = "cornflowerblue")
abline(0,1)



# Retele neuronale artificiale pentru clasificare
head(proiect)
table(proiect$Marital_Status)
date <- cbind(proiect[,4:14])
View(date)

ob_train <- date[sample(1:289, 200),]
head(ob_train)

ob_train$Alone <- c(ob_train$Marital_Status == 'Alone')
ob_train$Divorced <- c(ob_train$Marital_Status == 'Divorced')
ob_train$Married <- c(ob_train$Marital_Status == 'Married')
ob_train$Single <- c(ob_train$Marital_Status == 'Single')
ob_train$Together <- c(ob_train$Marital_Status == 'Together')
ob_train$Widow <- c(ob_train$Marital_Status == 'Widow')
ob_train$Marital_Status <- NULL
head(ob_train)

retea <- neuralnet(Alone + Divorced + Married + Single + Together + Widow ~ Income + Kidhome + Teenhome + Recency + MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds, 
                   ob_train, hidden = 3, lifesign = "full", stepmax = 1e8)
plot(retea, rep = "best", intercept = FALSE)

date_bind <- cbind(date[,2:5])
View(date_bind)
predictie_retea <- compute(retea, date[,-1])
predictie_retea$net.result[1:10,]

rezultat <- 0
for(i in 1:289) {
  rezultat[i] <- which.max(predictie_retea$net.result[i,])
}
for(i in 1:289) {
  if(rezultat[i] == 1) {
    rezultat[i] = "Alone"
  }
}
for(i in 1:289) {
  if(rezultat[i] == 2) {
    rezultat[i] = "Divorced"
  }
}
for(i in 1:289) {
  if(rezultat[i] == 3) {
    rezultat[i] = "Married"
  }
}
for(i in 1:289) {
  if(rezultat[i] == 4) {
    rezultat[i] = "Single"
  }
}
for(i in 1:289) {
  if(rezultat[i] == 5) {
    rezultat[i] = "Together"
  }
}
for(i in 1:289) {
  if(rezultat[i] == 6) {
    rezultat[i] = "Widow"
  }
}

comparatie <- date
comparatie$Predicted <- rezultat
head(comparatie)
comparatie[1:10, c(1,12)]
confuzie <- table(comparatie$Marital_Status, comparatie$Predicted)
classAgreement(confuzie)



# Retele neuronale artificiale pentru regresie
set.seed(100)
split <- sample.split(proiect$Recency, SplitRatio = 0.75)

antr <- subset(proiect, split == TRUE)
View(antr)

testt <- subset(proiect, split == FALSE)
View(testt)

regr <- cbind(proiect[,1:2], proiect[,5:21])
regr <- regr[,-c(14,15)]
View(regr)

maxim <- apply(regr, 2, max)
minim <- apply(regr, 2, min)
regr_std <- round(as.data.frame(scale(regr, center = minim, scale = maxim-minim)), 3)
View(regr_std)

antrenare_retea <- subset(regr_std, split == TRUE)
testare_retea <- subset(regr_std, split == FALSE)

retea2 <- neuralnet(Recency ~ NumDealsPurchases + NumWebPurchases + NumCatalogPurchases + NumStorePurchases, antrenare_retea, hidden = 5, linear.output = TRUE)
plot(retea2)

predictie_retea2 <- compute(retea2, testare_retea[,c(13:16)]) 
head(predictie_retea2$net.result)

predictie_retea2 <- (predictie_retea2$net.result * (max(regr$Recency) - min(regr$Recency))) + min(regr$Recency)
head(predictie_retea2)

windows()
plot(testt$Recency, predictie_retea2, col = "magenta", pch = 12, ylab = "Valori previzionate", xlab = "Valori reale", main = "Dependenta dintre valorile reale si valorile previzionate")
abline(0,1)

eroare <- (sum(testt$Recency - predictie_retea2)^2 / nrow(testt))^0.5

data.frame(testt$Recency, predictie_retea2)



# SOM 
set.seed(10)
som_date <- cbind(proiect[,4:5], proiect[,8:14])
View(som_date)

som_proiect <- som(scale(som_date[,-1]), grid = somgrid(5, 4, "hexagonal"))
plot(som_proiect, main = "Date proiect")
windows()
plot(som_proiect, type = "changes", col = "darkorange1")
plot(som_proiect, type = "mapping", labels = as.integer(MntMeatProducts), col = as.integer(MntMeatProducts), main = "Mapping plot")
plot(som_proiect, type = "mapping", labels = as.factor(som_date$Marital_Status), main = "Mapping plot")
