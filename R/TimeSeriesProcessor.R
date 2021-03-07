# ==============================================================================
# Class TimeSeriesProcessor is a machine that is used to perform various
# transformations on and calculations based on time series.
# ==============================================================================


TimeSeriesProcessor <- R6::R6Class(
  classname = "TimeSeriesProcessor",
  public = list(),
  private = list()
)



TimeSeriesProcessor$dtDoForwardFill <- function() {
  
}

# dtTestData <- objPekao$dtGetData()
# data.table::setnames(x = dtTestData, old = "price_Pekao", new = "value")
# dtData <- data.table::copy(x = dtTestData)
# TimeSeriesProcessor$dtCalculateLags(dtData = dtData, cValueCol = "value")
TimeSeriesProcessor$dtAddDifferences <- function(dtData, cValueCols = "value") {
  
  # 1. input validation
  
  # 2. iterate over the cols and add newcols
  
  cNewColname <- paste0("diff_", cValueCol)
  dtData[, (cNewColname) := c(NA, diff(x = dtData[[cValueCol]]))]
  
}



TimeSeriesProcessor$dtAddLogReturns <- function(dtData, cValueCol = "value") {
  cNewColname <- paste0("diff_", cValueCol)
  dtData[, (cNewColname) := c(NA, diff(x = dtData[[cValueCol]]))]
}



TimeSeriesProcessor$dtAddRelativeReturns <- function(dtData, cValueCol = "value") {
  cNewColname <- paste0("diff_", cValueCol)
  dtData[, (cNewColname) := c(NA, diff(x = dtData[[cValueCol]])/dtData[[cValueCol]])]
}



TimeSeriesProcessor$dtAddLags <- function(dtData, cValueCol = "value") {
  cNewColname <- paste0("lag_", cValueCol)
  dtData[, (cNewColname) := as.double(quantmod::Lag(x = dtData[[cValueCol]], 1))]
}



# TimeSeriesProcessor$dtAddWeekdays(dtData, cQuoteDateCol = "quote_date")
TimeSeriesProcessor$dtAddWeekdays <- function(dtData, cQuoteDateCol = "quote_date") {
  # 1. check if column pointed at by cQuoteDateCol is of Date class
  if (!lubridate::is.Date(x = dtData[[cQuoteDateCol]])) {
    stop("Error inside TimeSeriesProcessor$dtAddWeekdays: the columns pointed at ", 
         "by cQuoteDateCol: ", cQuoteDateCol, " is not of Date class! ")
  }
  # 2. add the weekday column
  cNewColname <- "weekday_num"
  dtData[, (cNewColname) := lubridate::wday(
    x = dtData[[cQuoteDateCol]], week_start = getOption("lubridae.week.start", 1))]
}



# TimeSeriesProcessor$lAnalyzeTimeSeriesQuality <- function() {
#   
# }



TimeSeriesProcessor$dtValidateAndStandardizeDailyData <- function(
  dtData, bAllowNegative = FALSE, cPriceColname = "quote_date", 
  cQuoteTimeColname = "price") {
  
  # 1. check if the dtData is a data.table
  if (!data.table::is.data.table(x = dtData)) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "dtData is not a data.table class object! ")
  }
  if (nrow(dtData) == 0) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "dtData has no rows! ")
  }
  # 2. check if column cPriceColname is in the dtData and if it is a double
  if (!(cPriceColname %in% colnames(x = dtData))) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "the column given by the parameter cPriceColname: ", cPriceColname, 
         " is not in present in the dtData!")
  }
  if (!is.double(x = dtData[[cPriceColname]])) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "the column given by the parameter cPriceColname: ", cPriceColname, 
         " is present in the dtData but it is not of double type!")
  }
  if (!bAllowNegative) {
    if (any(dtData[[cPriceColname]] < 0)) {
      stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
           "the column given by the parameter cPriceColname: ", cPriceColname, 
           " contains negative values that are not allowed!")
    }
  }
  # 3. check if column cQuoteTimeColname is in the dtData
  if (!(cQuoteTimeColname %in% colnames(x = dtData))) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "the column given by the parameter cQuoteTimeColname: ", cPriceColname, 
         " is not in present in the dtData!")
  }
  # 4. check if column cQuoteTimeColname is of Date class
  if (!lubridate::is.Date(x = dtData[[cQuoteTimeColname]])) {
    stop("Error when checking dtData passed to TimeSeriesProcessor$dtValidateAndStandardizeDailyData: ",
         "the column given by the parameter cPriceColname: ", cPriceColname, 
         " is present in the dtData but it is not of double type!")
  }  
  # 5. further parse the dtData before returning
  cColsToKeep <- c(cQuoteTimeColname, cPriceColname)
  dtData <- dtData[, cColsToKeep, with = FALSE]
  data.table::setnames(x = dtData, old = cColsToKeep, new = c("quote_date", "price"))
  data.table::setkey(dtData)
  
  return(dtData) 
}



cMyStooqTickers <- c("PKO", "PEO", "KGH", "JSW", "ATT", "CDR", "PGE")
dateStartDate <- as.Date("2016-01-01")
dateEndDate <- as.Date("2020-12-31")

lData <- okeanos.stooq::lGetDailyDataForTickersFromStooq(
  cTickers = cMyStooqTickers, dateStartDate = dateStartDate, 
  dateEndDate = dateEndDate, bAddTickerToColnames = FALSE)

lData2 <- lapply(X = lData, FUN = function(x) {
  cColsOut <- c("Date", "Close")
  return(x[, cColsOut, with = FALSE])
})

lData3 <- lapply(X = seq(1, length(lData2)), FUN = function(x, cStocksNames, lDataIn) {
  cStockName <- cStocksNames[[x]]
  dtDataOut <- lDataIn[[cStockName]]
  data.table::setnames(x = dtDataOut, old = "Close", new = paste0(cStockName, "_Close"))
}, cStocksNames = names(x = lData2), lDataIn = lData2)


dtRes <- Reduce(f = function(dtLeft, dtRight) {
  merge(x = dtLeft, y = dtRight, by = "Date", all = TRUE)
}, x = lData3)




TimeSeriesProcessor$lJoinMultipleTimeSeries <- function(
  lDataIn, cJoinColName = "Date", cJoinType = "inner") {
  
  Reduce(f = function(dtLeft, dtRight) {
    data.table::merge(x = dtLeft, y = dtRight, by = "Date")
  }, x = lDataIn)
  
}

