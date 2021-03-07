

testthat::test_that(desc = "testing 'DailyStockPriceTimeSeries' class", code = {
  
  dtDataIn <- data.table::copy(dtPekaoData)
  dtDataIn <- dtDataIn[, c("Date", "Close"), with = FALSE]
  
  objPekao <- DailyStockPriceTimeSeries$new(
    dtData = dtDataIn, cId = "Pekao", cCurrencyTicker = "PLN",
    cPriceColname = "Close", cQuoteTimeColname = "Date", 
    bAllowNegativePrices = FALSE)
  
  
})


