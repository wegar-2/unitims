dateStartDate <- as.Date("2001-01-01")
dateEndDate <- as.Date("2020-12-31")
cTwentyYearsFxRates <- c("EURUSD", "USDJPY", "GBPUSD", "NZDUSD", "CADUSD",
                         "USDCHF", "USDKRW", "USDTRY", "EURPLN", "USDRUB")


lMakeDailyFxTimeSeriesFromStooq <- function(cFxPairs, dateStartDate, dateEndDate) {

  lRes <- VariousUtils::StooqUtils$lGetDailyDataForTickersFromStooq(
    cTickers = cMyFxRates,
    dateStartDate = dateStartDate,
    dateEndDate = dateEndDate)

  # use the fetched data to create class FxTimeSeries object instances ---------
  lFxTimeSeries <- vector(mode = "list", length = length(cMyFxRates))
  names(lFxTimeSeries) <- cMyFxRates

  for (cIterFxPair in cMyFxRates) {
    cIterBaseTicker <- ""
    cIterQuoteTicker <- ""

    objIterFxTimeSeris <- FxTimeSeries$new(cQuotedTicker = "USD", cBaseTicker = "EUR",
                                           dtData = lRes[[]], cFxRateColname = "Close",
                                           cIdPrefix = "stooq_close",
                                           cQuoteTimeColname = "Date")



  }
}
