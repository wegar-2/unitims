


testthat::test_that(desc = "testing class 'TimeSeriesProcessor' ", code = {
  
  dtDataOut <- TimeSeriesProcessor$dtValidateAndStandardizeDailyData(
    dtData = dtPekaoData, bAllowNegative = FALSE, 
    cPriceColname = "Close", cQuoteTimeColname = "Date", )
  
})