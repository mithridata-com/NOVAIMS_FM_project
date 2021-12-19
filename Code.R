library(RCurl)
library(readxl)
library(forecast)
url <- "https://www.cbr.ru/vfs/eng/statistics/BankSector/Borrowings/02_01_Funds_all_e.xlsx"
path_tmp <- tempfile(fileext = ".xls")  
download.file(url, destfile=path_tmp, method="curl", mode = "wb")

data.raw <- read_xlsx(path_tmp, sheet = 3)
data <- as.data.frame(t(data.raw[,-1]))
colnames(data) <- c("Date","Customer funds","funds of organizations", "Deposits of legal entities", "Deposits and other funds of individuals")
data$Date <- as.Date(as.numeric(data[,"Date"]), origin = "1900-01-01")-2

data.ts <- ts(as.numeric(data[,"Deposits and other funds of individuals"]), 
              start = c(2012,01,01),
              frequency = 12)
# time series is ready. Let's analyse it
data.ts
acf(data.ts)
pacf(data.ts)
decompose(data.ts)
plot(decompose(data.ts))