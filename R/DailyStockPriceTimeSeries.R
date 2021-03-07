# ==============================================================================
# Class for working with time series of prices of various assets. 
# At the moment this class is developed with stocks in mind so it will not be 
# eligible for use with e.g. assets with term structure of forward prices e.g. commodities
# ==============================================================================

DailyStockPriceTimeSeries <- R6::R6Class(
  classname = "DailyStockPriceTimeSeries",
  inherit = UniversalTimeSeries,
  public = list(
    
    
    # ==========================================================================
    # ==========================================================================
    # =====================     CLASS CONSTRUCTOR      =========================
    # ==========================================================================
    initialize = function(dtData, cId, cCurrencyTicker,
                          cPriceColname = "price", cQuoteTimeColname = "quote_time",
                          bAllowNegativePrices = FALSE) {
      
      # 1. input validation ----------------------------------------------------
      # 1.2. cId
      if (!bIsScalarOfType(objIn = cId, cTypeName = "character")) {
        stop("Error inside class PriceTimeSeries constructor! The constructor parameter ",
             "cId is not a character scalar! ")
      }
      # 1.3. cCurrencyTicker
      cCurrencyTicker <- match.arg(arg = cCurrencyTicker, choices = cHandledCurrenciesTickers,
                                   several.ok = FALSE)
      # 1.4. cPriceColname
      if (!bIsScalarOfType(objIn = cPriceColname, cTypeName = "character")) {
        stop("Error inside class PriceTimeSeries constructor! The constructor parameter ",
             "cPriceColname is not a character scalar! ")
      }
      # 1.5. cQuoteTimeColname
      if (!bIsScalarOfType(objIn = cQuoteTimeColname, cTypeName = "character")) {
        stop("Error inside class PriceTimeSeries constructor! The constructor parameter ",
             "cQuoteTimeColname is not a character scalar! ")
      }
      # 1.7. bAllowNegativePrices
      if (!bIsScalarOfType(objIn = bAllowNegativePrices, cTypeName = "logical")) {
        stop("Error inside class PriceTimeSeries constructor! The constructor parameter ",
             "bAllowNegativePrices is not a logical scalar! ")
      }
      # 1.8 dtData
      dtData <- TimeSeriesProcessor$dtValidateAndStandardizeDailyData(
        dtData = dtData, bAllowNegative = FALSE, cPriceColname = cPriceColname, 
        cQuoteTimeColname = cQuoteTimeColname)
      
      # 2. save the data -------------------------------------------------------
      private$dtData <- dtData
      private$cId <- cId
      private$cCurrencyTicker <- cCurrencyTicker
    },
    # ==========================================================================
    
    
    
    # ==========================================================================
    # ==========================================================================
    # ==================     CLASS GETTERS AND SETTERS      ====================
    # ==========================================================================
    # A. dtData member
    dtGetData = function(bNamedPriceColumn = FALSE) {
      # data extraction
      dtDataOut <- data.table::copy(x = private$dtData)
      # input validation
      if (!bNamedPriceColumn) {
        data.table::setnames(x = dtDataOut, old = "price", 
                             new = paste0("price_", private$cId))
      }
      return(dtDataOut)
    },
    # B. cCurrencyTicker member
    # C. 
    # ==========================================================================
    
    
    # ==========================================================================
    # ==========================================================================
    # ===============      TIME SERIES PARSING FUNCTIONS     ===================
    # ==========================================================================
    FillInMissingObs = function(cFillMethod = "ffill") {
      
      # 1. parameter validation
      
      # 2. 
      
    },
    
    DropLeadingMissingObs = function() {
      
    }
    # ==========================================================================
    
  ),
  private = list(
    # private class members
    cCurrencyTicker = NULL,
    cId = NULL
    # private class methods
  )
)

