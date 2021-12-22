library(RCurl)
library(XML)
library(readxl)
library(dplyr)
library(forecast)
library(zoo)

url <- "https://www.cbr.ru/hd_base/mkr/mkr_base/?UniDbQuery.Posted=True&UniDbQuery.From=01.08.2000&UniDbQuery.To=31.12.2021&UniDbQuery.st=SF&UniDbQuery.ob=OB_MIACR_0&UniDbQuery.Currency=1&UniDbQuery.sk=Dd1_"
parse_url <- getURL(url,.opts = list(ssl.verifypeer = FALSE) )
data.raw <- readHTMLTable(parse_url)[[1]]
colnames(data.raw) <- c("Date","MIACR")
data.raw$Date <- as.Date(data.raw$Date, format = "%d.%m.%Y")
data.raw$MIACR <- as.numeric(gsub(",",".",data.raw$MIACR))

full.ts <- data.frame("Date" = seq(from = as.Date('2000-08-01'),to = as.Date('2021-12-16'),by = "day"))
data.ts <- full.ts %>% 
  left_join(data.raw, by = c("Date")) %>%
  na.locf(fromLast = TRUE)

ts <- ts(data.ts$MIACR)
ts

ts <- ts(data.ts$MIACR, 
         start = c(2000,08),
         end = c(2021,12),
         frequency = 365)
ts
plot(ts)
# time series is ready. Let's analyse it
acf(ts)
pacf(ts)
decompose(ts)
plot(decompose(ts))

auto.arima(ts)

ts2 <- diff(ts)
plot(ts2)
tail(ts2)
