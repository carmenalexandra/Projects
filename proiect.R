# Importul librariilor

library(forecast)
library(ggplot2)
library(readxl)
library(TSstudio)
library(lmtest)
library(Metrics)
library(uroot)
library(urca)
library(dplyr)
library(seasonal)
library(readxl)
library(tseries)
library(TSA)
library(fpp2)
library(vars)
library(stats)
library(changepoint)
library(uroot)
library(FinTS)
library(gt)
library(mFilter)
library(tidyverse)
library(stargazer)
library(Metrics)
library(utils)
library(utf8)
library(tsDyn)
library(dynlm)
library(aTSA)


# ------------- Aplicatia 1 ------------------

# Importarea seriei
Z <- Date_benzina
View(Z)

# Creare obiectului de tip ts
y <- ts(Z, start = 2015, frequency = 12)
y

# Graficul seriei
autoplot(y) +
  xlab("An") + ylab("Pret in dolari") +
  ggtitle("Evolutia lunara a pretului benzinei incepand cu anul 2015 - SUA") +
  theme_bw()

# Graficul pentru identificarea sezonalitatii
ggsubseriesplot(y) +
  ylab("Pret in dolari") +
  ggtitle("Seasonal subseries plot: Evolutia lunara a pretului benzinei - SUA") +
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_bw() # seria prezinta sezonalitate foarte slaba

# Desezonalizarea seriei prin metoda X11
y_seas_adj <- y %>% seas(x11 = "") 

# Graficul componentelor sezoniere
autoplot(y_seas_adj) +
  ggtitle("Metoda desezonalizarii seriei prin metoda X11") + theme_bw()

# Graficul seriei desezonalizate
autoplot(y, series= "Data") +
  autolayer(trendcycle(y_seas_adj), series = "Trend") +
  autolayer(seasadj(y_seas_adj), series = "Seasonally Adjusted") +
  xlab("An") + ylab("Pret in dolari") +
  ggtitle("Preturi lunare benzina in SUA") +
  scale_colour_manual(values=c("gray","blue","red"),
                      breaks=c("Data","Seasonally Adjusted","Trend")) +
  theme_bw()

# Graficul de sezonalitate al componentei sezoniere a metodei X11
y_seas_adj %>% seasonal() %>% 
  ggsubseriesplot() + 
  ggtitle("Graficul de sezonalitate: Componenta sezoniera pentru preturile lunare ale benzinei") +
  ylab("Seasonal") + 
  theme_bw()

# Graficul de sezonalitate a seriei ajustate sezonier
seasadj(y_seas_adj) %>% ggsubseriesplot() +
  ggtitle("Graficul de sezonalitate: Componenta sezoniera ajustata pentru preturile lunare ale benzinei") +
  ylab("Seasonal") + 
  theme_bw()

# Time series plots
autoplot(seasadj(y_seas_adj)) +
  ggtitle("Evolutia componentei sezoniere ajustate pentru preturile lunare ale benzinei") +
  xlab("An") +
  ylab("Pret in dolari") +
  theme_bw()

# Split pe training si test data sets (training 80%, test 20%)
training <- window(seasadj(y_seas_adj), start=c(2015,1), end=c(2019,12))
test <- tail(seasadj(y_seas_adj), 2*12+3)

# Corelograma seriei ajustate sezonier (ACF si PACF)
ggtsdisplay(seasadj(y_seas_adj))


# Prognoza prin metoda Holt a trendului liniar
fit <- holt(training, h=36)
summary(fit)
forecast::accuracy(fit,test)
autoplot(fit)






# Modele ARIMA non sezoniere

# Corelograma seriei ajustate sezonier
training %>% ggtsdisplay()



## Testarea stationaritatii prin ADF pentru seria nediferentiata

# Elemente deterministe
adf_ur <- training %>%
  ur.df(., type="none", selectlags=c("AIC"))
summary(adf_ur) # nestationara la 90%, 95%, 99% (sunt mai mici in valoare absoluta)

# Intercept
adf_ur <- training %>%
  ur.df(., type='drift', selectlags=c("AIC"))
summary(adf_ur) # nestationara la 90%, 95%, 99% (sunt mai mici in valoare absoluta)

# Trend si intercept
adf_ur <- training %>%
  ur.df(., type='trend', selectlags=c("AIC"))
summary(adf_ur) # nestationara la 90%, 95%, 99% (sunt mai mici in valoare absoluta)


# Testarea stationaritatii prin KPSS pentru seria nediferentiata
training %>% ur.kpss() %>% summary() 
# valoarea testului 0.7816 > toate valorile critice
# seria este nestationara 


# Testarea stationaritatii prin Philips-Perron pentru seria nediferentiata
PP.test(training) # p > 0.1 serie nestationara


## Testul Zivot-Andrews pentru testarea radacinii unitare atunci cand avem structural break

# Trend
za_ur <- training %>% ur.za(., model = "trend", lag = 1)
summary(za_ur) # p < 0.1 seria este nestationara cu structural break in trend   
plot(za_ur) 

# Intercept 
za_ur <- training %>% ur.za(., model = "intercept", lag = 1)
summary(za_ur) # p < 0.1 seria este nestationara cu structural break in intercept 
plot(za_ur) 

# Trend si intercept
za_ur <- training %>% ur.za(., model = "both", lag = 1)
summary(za_ur) # p < 0.1 seria este nestationara cu structural break in trend si intercept 
plot(za_ur) # testul ne confirma ca indiferent daca eliminam structural break seria tot ramane nestationara 




# Putem confirma si cu functia ndiffs ca seria are nevoie de diferentiere
ndiffs(training) # diferenta de ordinul 1


# Corelograma seriei ajustate sezonier a diferentei de ordinul 1
training %>% diff(lag=1) %>% ggtsdisplay()

# Crearea seriei diferentei de ordinul 1
training_dif1 <- training %>% diff(lag=1)




## Testarea stationaritatii prin ADF pentru seria diferentiata de ordinul 1

# Elemente deterministe
adf_ur <- training_dif1 %>% ur.df(., type="none", selectlags=c("AIC"))
summary(adf_ur) # stationara |test statistic| > |valori critice|

# Intercept
adf_ur <- training_dif1 %>% ur.df(., type='drift', selectlags=c("AIC"))
summary(adf_ur) # stationara |test statistic| > |valori critice|

# Trend si intercept
adf_ur <- training_dif1 %>% ur.df(., type='trend', selectlags=c("AIC"))
summary(adf_ur) # stationara |test statistic| > |valori critice|



# Testarea stationaritatii prin KPSS pentru seria diferentiata de ordin 1
training_dif1 %>% ur.kpss() %>% summary() 
# valoarea testului 0.0469 < toate valorile critice
# seria este stationara la toate pragurile de semnificatie 


# Testarea stationaritatii prin Philips-Perron pentru seria diferentiata de ordin 1
PP.test(training_dif1) # p > 0.1  (F) => serie stationara


# Confirmarea si cu ajutorul functiei ndiffs 
ndiffs(training_dif1)





# Putem identifica lagurile maximale pentru AR si MA acum pe baza corelogramei 
# deoarece am stabilit prin testele de stationaritate ca seria primei diferentei 
# este stationara 
training %>% diff(lag=1) %>% ggtsdisplay()

# Pe PACF identificam ca ordinul maximal AR este 1
# Pe ACF identificam ca ordinul maximal MA este 1

# In urmatorul pas incepem sa testam combinatii de modele ARIMA(p,d,q)
# In estimare, folosim seria training, nu estimam pe seria diferentei de ordinul 1
# si setam parametrul d=1 deoarece ne dorim sa diferentiem seria in estimare 

fit1 <- Arima(training, order=c(0,1,0), include.constant =TRUE)
coeftest(fit1) # model potential
summary(fit1)

fit2 <- Arima(training, order=c(1,1,0), include.constant =TRUE)
coeftest(fit2)  # model potential
summary(fit2)

fit3 <- Arima(training, order=c(0,1,1), include.constant =TRUE)
coeftest(fit3)  # coeficienti nesemnificativi
summary(fit3)

fit4 <- Arima(training, order=c(1,1,1), include.constant =TRUE)
coeftest(fit4)  # coeficienti nesemnificativi
summary(fit4)



# Identificarea modelului cu cel mai mic BIC
arma_res_bic <- rep(0,4)
arma_res_bic[1] <- fit1$bic 
arma_res_bic[2] <- fit2$bic 
arma_res_bic[3] <- fit3$bic 
arma_res_bic[4] <- fit4$bic 
which(arma_res_bic == min(arma_res_bic))




# Modelul optim devine ARIMA(1,1,0) din punct de vedere BIC
fit2 <- Arima(training, order=c(1,1,0), include.constant =TRUE)
coeftest(fit2)
summary(fit2)


# Testam acuratetea si pe zona de test
fit2_acc <- fit2 %>% forecast(h=36) 
summary(fit2_acc)
forecast::accuracy(fit2_acc, test)



# Prognoza modelului ARIMA(1,1,0)
fit2 %>% forecast(h=36) %>% autoplot()


# Testarea ipotezelor pe reziduuri
checkresiduals(fit2)

# Normalitate
jarque.bera.test(residuals(fit2)) 
# rezidurile sunt distribuite normal
# deoarece p-value > 0.1


# Autocorelarea reziduurilor prin Box-Pierce
Box.test(residuals(fit2), lag=1)
Box.test(residuals(fit2), lag=2)
Box.test(residuals(fit2), lag=3)
Box.test(residuals(fit2), lag=4)
Box.test(residuals(fit2), lag=5)
Box.test(residuals(fit2), lag=6)
Box.test(residuals(fit2), lag=12)
Box.test(residuals(fit2), lag=24) 


# Autocorelarea reziduurilor prin Ljung-Box
Box.test(residuals(fit2), lag=1, type = 'Lj')
Box.test(residuals(fit2), lag=2, type = 'Lj')
Box.test(residuals(fit2), lag=3, type = 'Lj')
Box.test(residuals(fit2), lag=4, type = 'Lj')
Box.test(residuals(fit2), lag=5, type = 'Lj')
Box.test(residuals(fit2), lag=6, type = 'Lj')
Box.test(residuals(fit2), lag=12, type = 'Lj')
Box.test(residuals(fit2), lag=24, type = 'Lj') 


# Testarea Heteroschedasticitatii
ArchTest(residuals(fit2), lags = 1)
ArchTest(residuals(fit2), lags = 2)
ArchTest(residuals(fit2), lags = 3)
ArchTest(residuals(fit2), lags = 4)
ArchTest(residuals(fit2), lags = 5)
ArchTest(residuals(fit2), lags = 6)
ArchTest(residuals(fit2), lags = 12)
ArchTest(residuals(fit2), lags = 24)




# Pentru a putea compara acuratetea prognozelor vom folosi testul Diebold Mariano

# fit - Holt trend liniar 
# fit2 - model optim identificat cu ajutorul ARIMA(1,1,0)

dm.test(fit2$residuals, fit$residuals, h=1) 
# pe zona de training, nu exista diferente semnificative
# intre prognozele modelelor deoarece p > 0.1
dm.test(fit2_acc$mean,fit$mean, h=1)
# pe zona de test, exista diferente semnificative
# intre prognoze deoarece p < 0.1, prin urmare ambele modele pot fi luate in considerare




# Graficul final al prognozei
autoplot(y) +
  autolayer(fit, series = "Holt", PI = FALSE) +
  autolayer(fit2_acc, series = "ARIMA", PI = FALSE) +
  guides(colour = guide_legend(title = "Previziune")) +
  xlab("An") + ylab("Pret in dolari") +
  ggtitle("Previziunea finala a pretului benzinei in SUA") +
  theme_bw()



# ------------ Aplicatia 2 --------------
Z <- Date_benzina
View(Z)

y <- ts(Z, start = 2015, frequency = 12)
y


# SARIMA 

# Graficul seriei
autoplot(y) + ylab("Dolari") + xlab("An") +
  ggtitle('Pretul mediu lunar al benzinei') + theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

# Graficul de sezonalitate
ggsubseriesplot(y) +
  ylab("Dolari") +
  ggtitle("Seasonal subseries plot: Evolutia lunara a pretului benzinei - SUA") +
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

# Corelograma seriei 
ggtsdisplay(y)


# Testarea radacinii unitare
#none
rw_none <- ur.df(y, type='none', selectlags = c("AIC"))
summary(rw_none) # serie nestationara
#drift
rw_t <- ur.df(y, type='drift', selectlags = c("AIC"))
summary(rw_t) # serie stationara pentru 90%
#trend
rw_ct <- ur.df(y, type='trend', selectlags = c("AIC"))
summary(rw_ct) # serie nestationara


# KPSS
y %>% ur.kpss() %>% summary() # t > valori critice (90%, 95%, 97,5%)


# Philips-Perron
PP.test(y) # p > 0.05 => serie nestationara


# Testarea radacinii unitare sezoniere 
# Testul Hegy 
hegy.test(y) 
# p > 0.1 pentru t_1 => radacina unitara sezoniera



# Vom aplica diferenta sezoniera in prima faza
y %>% diff(lag=12) %>% ggtsdisplay() 
# seria ramane nestationara si este nevoie
# si de diferenta de ordin 1 

# Seria diferentiata sezonier si de ordin 1 
y %>% diff(lag=12) %>% diff() %>% ggtsdisplay() 
# seria pare sa devina stationara 
# si vom testa din nou cu ADF, KPSS, PP



y_diff <- y %>% diff(lag=12) %>% diff()



# Testul ADF
# none
rw_none <- ur.df(y_diff, type='none', selectlags = c("AIC"))
summary(rw_none) # serie stationara
# drift
rw_t <- ur.df(y_diff, type='drift', selectlags = c("AIC"))
summary(rw_t) # serie stationara
# trend
rw_ct <- ur.df(y_diff, type='trend', selectlags = c("AIC"))
summary(rw_ct) # serie stationara


# Testul KPSS
y_diff %>% ur.kpss() %>% summary() 
# t < valori critice => serie stationara


# Testul Philips-Perron
PP.test(y_diff) 
# p < 0.01 => serie stationara



# Pe baza corelogramei putem identifica lagurile maximale pe toate componentele 
# Lagurile AR si MA se identifica similar cu ARIMA - AR(1), MA(1)
# Componenta SAR se identifica pe PACF pentru lagurile sezoniere SAR(1)
# Componenta SMA se identifica pe ACF pentru lagurile sezoniere SMA(1)

fit1 <- Arima(y,order=c(1,1,1), seasonal=c(1,1,1))
coeftest(fit1) #SAR, MA, AR nesemnificative

fit2 <- Arima(y,order=c(1,1,1), seasonal=c(0,1,1))
coeftest(fit2) # AR, MA nesemnificative

fit3 <- Arima(y,order=c(0,1,1), seasonal=c(1,1,1))
coeftest(fit3) # SAR nesemnificativ

fit4 <- Arima(y,order=c(0,1,1), seasonal=c(0,1,1))
coeftest(fit4) # model potential 

fit5 <- Arima(y,order=c(1,1,0), seasonal=c(0,1,1))
coeftest(fit5) # model potential 

fit6 <- Arima(y,order=c(1,1,0), seasonal=c(1,1,0))
coeftest(fit6) # model potential 

fit7 <- Arima(y,order=c(0,1,1), seasonal=c(1,1,0))
coeftest(fit7) # model potential

fit8 <- Arima(y,order=c(1,1,0), seasonal=c(1,1,1))
coeftest(fit8) # SAR nesemnificativ

fit9 <- Arima(y,order=c(1,1,1), seasonal=c(1,1,0))
coeftest(fit9) # AR, MA nesemnificative


summary(fit4) # AIC = 259.61   BIC = 252.69
summary(fit5) # AIC = 258.57   BIC = 251.65
summary(fit6) # AIC = 247.17   BIC = 240.26
summary(fit7) # AIC = 248.22   BIC = 241.31

# Modelul cu cele mai mici criterii informationale este SARIMA(1,1,0)(1,1,0)[12]
# si vom testa reziduurile


# Testarea reziduurilor 
checkresiduals(fit6)

# Normalitate
jarque.bera.test(residuals(fit6))
# reziduurile nu sunt normal distribuite

#Autocorelare
Box.test(residuals(fit6),lag = 1, type = 'Lj')
Box.test(residuals(fit6),lag = 2, type = 'Lj')
Box.test(residuals(fit6),lag = 3, type = 'Lj')
Box.test(residuals(fit6),lag = 4, type = 'Lj')
Box.test(residuals(fit6),lag = 5, type = 'Lj')
Box.test(residuals(fit6),lag = 12, type = 'Lj')
Box.test(residuals(fit6),lag = 24, type = 'Lj')

# Heteroschedasticitate
ArchTest(residuals(fit6), lags = 1)
ArchTest(residuals(fit6), lags = 2)
ArchTest(residuals(fit6), lags = 3)
ArchTest(residuals(fit6), lags = 4)
ArchTest(residuals(fit6), lags = 5)
ArchTest(residuals(fit6), lags = 6)
ArchTest(residuals(fit6), lags = 12)
ArchTest(residuals(fit6), lags = 24)

# Prognoza 
fit6 %>% forecast(h=12) %>% autoplot() + ylab('Dolari') +
  theme_bw() +theme(plot.title = element_text(hjust = 0.5))





# Estimare ETS si Holt-Winters
fit_ets <- ets(y)
fit_hw <- holt(y, seasonal = "additive",h=12)

summary(fit_ets)
summary(fit_hw)
summary(fit6)

# ETS
# RMSE = 0.03969497  MAE = 0.02828038  MAPE = 4.270558

# HW aditiv
# RMSE = 0.03914877  MAE = 0.2845938   MAPE = 4.342308

# SARIMA
# RMSE = 0.03988937  MAE = 0.0292882   MAPE = 4.504313 
# Modelul ETS are erorile de prognoza mai mici


# Prognoza ETS
fit_ets %>% forecast::forecast(h=12) %>%
  autoplot() +
  ylab("Dolari") + 
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))

# Prognoza prin metoda Holt-Winters aditiv
fit_hw %>% forecast::forecast(h=12) %>%
  autoplot() +
  ylab("Dolari") + 
  theme_bw() +theme(plot.title = element_text(hjust = 0.5))



# Testul Diebold Mariano
dm.test(residuals(fit_ets),residuals(fit6))
# deoarece p < 0.1 acceptam H0
# modelele SARIMA(1,1,0)(0,1,1)[12] si ETS au prognoze diferite

dm.test(residuals(fit_hw),residuals(fit6))
# deoarece p > 0.1 respingem H0
# modelele SARIMA(1,1,0)(0,1,1)[12] si HW au prognoze similare

dm.test(residuals(fit_ets),residuals(fit_hw))
# deoarece p < 0.1 acceptam H0
# modelele HW si ETS au prognoze diferite



# Graficul celor trei modele 
autoplot(y) +
  autolayer(fit6 %>% forecast::forecast(h=12), series="SARIMA(1,1,0)(0,1,1)[12]", PI=FALSE) +
  autolayer(fit_ets %>% forecast::forecast(h = 12), series="ETS",PI=FALSE) +
  autolayer(fit_hw %>% forecast::forecast(h = 12), series="HW",PI=FALSE) +
  xlab("An") +
  ylab("Dolari") +
  ggtitle("Previziunea finala pret mediu lunar benzina SUA") +
  guides(colour=guide_legend(title="Forecast")) +
  theme_bw()



# -------------- Aplicatia 3 ----------------
# Incarcarea setului de date
benzina <- read.csv("C:/Users/Vivo/Desktop/Facultate/An 3/Sem2/Serii de timp/ST/Ap3/Benzina.csv",
                    header = FALSE, sep = ";")
petrol <- read.csv("C:/Users/Vivo/Desktop/Facultate/An 3/Sem2/Serii de timp/ST/Ap3/Ulei.csv",
                   header = FALSE, sep = ";")

# Declaram variabilele de tip ts
benzina <- ts(benzina, start = c(2015,1), frequency = 12)
petrol <-ts(petrol, start = c(2015,1), frequency = 12)

# Graficul seriilor
autoplot(cbind(benzina,petrol)) +
  ylab('') +
  ggtitle('Graficul seriei multivariata - benzina si petrol') +
  theme_bw()

# Crearea unui df cu toate cele doua variabile
dset <- cbind(benzina, petrol)
View(dset)

# Graficul seriei
autoplot(dset) + 
  ylab('') + 
  ggtitle('Graficul seriei multivariate') + 
  theme_bw()





# Testul Engle-Granger de detectare a cointegrarii

# Pasul 1 - Testam stationaritatea seriilor
adf.bzn <- ur.df(benzina, type = "trend", selectlags = "AIC")
summary(adf.bzn) # serie nestationara

adf.petrol <- ur.df(petrol, type = "trend", selectlags = "AIC")
summary(adf.petrol) # serie nestationara

ndiffs(benzina)
ndiffs(petrol)


# Corelograma primei diferente
ggtsdisplay(diff(benzina)) # seria pare stationara
ggtsdisplay(diff(petrol)) # seria pare stationara


# Testarea stationaritatii seriilor diferentiate
adf.bzn2 <- ur.df(diff(benzina), type = "trend", selectlags = "AIC")
summary(adf.bzn2) # serie stationara

adf.ptr2 <- ur.df(diff(petrol), type = "trend", selectlags = "AIC")
summary(adf.ptr2) # serie stationara

ndiffs(diff(benzina))
ndiffs(diff(petrol))



# Pas 2: aplicam testul de cointegrare pe seriile reziduurilor

coint.test(y = benzina, X = petrol, d = 1)
# => respingem ipoteza nula => serii cointegrate
coint.test(y = petrol, X = benzina, d = 1) 
# => respingem ipoteza nula => serii cointegrate


# Cointegrarea Johansen

# Selectarea lagului 
lagselect <- VARselect(dset, lag.max = 8, type = 'const')
lagselect$selection 
# 2 laguri conform testelor
# Pentru a testa Johansen avem nevoie de laguri selectate - 1 
# => 2 - 1 = 1


# Testul Johansen - metoda Trace
ctest1 <- ca.jo(dset, type = 'trace', ecdet = 'const', K = 2)
summary(ctest1) 
# r = 0 test < val critice => nu avem relatie de cointegrare
# r <= 1 test < val critice => nu avem relatie de cointegrare

# Testul Johansen - metoda valorilor proprii maxime
ctest2 <- ca.jo(dset, type = 'eigen', ecdet = 'const', K = 2)
summary(ctest2)
# r = 0 test < val critice => nu avem relatie de cointegrare
# r <= 1 test < val critice => nu avem relatie de cointegrare


# Ambele metode de cointegrare Johanses confirma ca nu exista o relatie de cointegrare intre serii
# Se va aplica metoda VAR




# Implementarea VAR
model <- VAR(diff(dset), p = 2,
             type = 'const', 
             season = NULL, 
             exog = NULL)
summary(model)

stargazer(model[['varresult']], 
          type = 'text')



# Diagnosticul pe reziduuri
# Autocorelarea
Serial <- serial.test(model, 
                      lags.pt = 12, 
                      type = 'PT.asymptotic')
Serial 
# pvalue > 0.1 nu avem autocorelare in reziduuri



# Heteroscedasticitate
Arch <- vars::arch.test(model,
                        lags.multi = 12, 
                        multivariate.only = TRUE)
Arch
# pvalue > 0.1 homoschedasticitate



# Normalitatea reziduurilor
Norm <- normality.test(model, 
                       multivariate.only = TRUE)
Norm
# pvalue JB < 0.1 reziduurile nu sunt normal distribuite



# Testarea pentru rupturi in serie
Stability <- stability(model,type = 'OLS-CUSUM')
plot(Stability) 
# modele stabile



# Cauzalitate Granger
Granger_benzina <- causality(model, cause = 'benzina')
Granger_benzina
# p < 0.1 => benzina prezinta cauzalitate Granger cu petrol

Granger_petrol <- causality(model, cause = 'petrol')
Granger_petrol 
# p < 0.1 => petrol prezinta cauzalitate Granger cu benzina


# Functia de raspuns la impuls (IRF) 
benzina_irf <- irf(model, impulse = 'petrol', response = 'benzina', 
                   n.ahead = 20, boot = TRUE, ci=0.90) 

plot(benzina_irf, ylab = 'Benzina', 
     main = 'Raspunsul pretului benzinei la socurile modificarii pretului petrolului')

petrol_irf <- irf(model, impulse = 'benzina', response = 'petrol', 
                  n.ahead = 20, boot = TRUE, ci=0.90)

plot(petrol_irf, ylab = 'petrol', 
     main = 'Raspunsul pretului petrolului la socurile modificarii pretului benzinei')


# Descompunerea variante
FEVD <- fevd(model, n.ahead = 12)
plot(FEVD) 

# Prognoza VAR
model_forecast <- VAR(dset, 
                      p = 2, 
                      type = 'const', 
                      season = NULL, 
                      exog = NULL)
forecast <- predict(model_forecast,
                    n.ahead = 12, 
                    ci = 0.90) 


plot(forecast, name = 'benzina')
plot(forecast, name = 'petrol')

fanchart(forecast, names='benzina')
fanchart(forecast, names='petrol')
