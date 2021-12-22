library(RCurl)
library(XML)
library(openxlsx)
library(dplyr)
library(forecast)
library(zoo)
library(httr)
library(curl)

urlfile<-"https://raw.githubusercontent.com/mithridata-com/NOVAIMS_FM_project/main/mortgage_data.csv"
mortgage <- read.csv2( curl(urlfile) )
colnames(mortgage) <- c("REPORT_DATE","QUANTITY","VOLUME")
mortgage$QUANTITY <- as.numeric(gsub(" ","",mortgage$QUANTITY))
mortgage$VOLUME <- as.numeric(gsub(" ","",mortgage$VOLUME))

par(mfrow = c(3,1))
ts.q <- ts(mortgage$QUANTITY, 
         start = c(2009,01),
         end = c(2021,10),
         frequency = 12)
ts.q

plot(ts.q, main = "TS QUANTITY OF MORTGAGE PER MONTH")
acf(ts.q, main = "ACF")
pacf(ts.q, main = "PACF")

ts.v <- ts(mortgage$VOLUME, 
           start = c(2009,01),
           end = c(2021,10),
           frequency = 12)
ts.v

plot(ts.v, main = "TS VOLUME OF MORTGAGE PER MONTH")
acf(ts.v, main = "ACF")
pacf(ts.v, main = "PACF")
