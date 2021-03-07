


FactoryDailyStockPriceTimeSeries <- R6::R6Class(
  classname = "FactoryDailyStockPriceTimeSeries",
  public = list(),
  private = list()
)



lCreateDailyStockPriceTimeSeries <- function(lData) {

  # 1. input validation
  
  # 2. 
  lDailyStockPriceTimeSeries <- vector(mode = "list", length = length(lData))
  names(lDailyStockPriceTimeSeries) <- names(lData)
  for (cIterStockName in names(lDailyStockPriceTimeSeries)) {
    objIter <- tryCatch(expr = {
      DailyStockPriceTimeSeries$new(
        dtData = lData[[cIterStockName]],
        cId = cIterStockName,
        cCurrencyTicker = ,
        cPriceColname = ,
        cQuoteTimeColname = ,
        bAllowNegativePrices = 
      )
    }, error = function(er) {
      
    }, finally = {
      
    })
    
    
    lDailyStockPriceTimeSeries[[cIterStockName]] <- objIter
  }
  
  
  return(lDailyStockPriceTimeSeries)  
}


