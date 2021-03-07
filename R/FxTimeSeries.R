

FxTimeSeries <- R6::R6Class(
  classname = "FxTimeSeries",
  inherit = RelativeTimeSeries,
  public = list(

    # class constructor ========================================================
    initialize = function(cQuotedTicker, cBaseTicker, cIdPrefix = NULL,
                          dtData, cQuoteTimeColname = "quote_date",
                          cFxRateColname = "fx_rate") {

      # ----- 1. cIdPrefix -----
      if (!is.null(x = cIdPrefix)) {
        if (!VariousUtils::BasicUtils$bIsScalarOfClass(objIn = cIdPrefix,
                                                       cClassName = "character")) {
          stop("Error inside class FxTimeSeries constructor - parameter ",
               "cIdPrefix is not a character scalar! ")
        }
      }
      # ----- 2. cQuotedTicker -----
      if (!bCheckCurrency(cTicker = cQuotedTicker)) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cQuotedTicker is not a handled currency! ")
      }
      private$cQuotedTicker <- cQuotedTicker
      # ----- 3. cBaseTicker -----
      if (!bCheckCurrency(cTicker = cBaseTicker)) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cBaseTicker is not a handled currency! ")
      }
      private$cBaseTicker <- cBaseTicker
      # ----- 4. dtData -----
      if (!data.table::is.data.table(x = dtData)) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "dtData is not a data.table! ")
      }
      if (nrow(dtData) == 0L) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "dtData has no rows! ")
      }
      # ----- 5. cQuoteTimeColname -----
      # 5.1. check if cQuoteTimeColname is char scalar
      if (!VariousUtils::BasicUtils$bIsScalarOfClass(objIn = cQuoteTimeColname,
                                                     cClassName = "character")) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cQuoteTimeColname is not a character scalar! ")
      }
      # 5.2. check if cQuoteTimeColname is a column in dtData at all
      if (!(cQuoteTimeColname %in% colnames(dtData))) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cQuoteTimeColname value is not a column inside dtData! ")
      }
      # 5.3. check if cQuoteTimeColname is a Date class column
      if (!lubridate::is.Date(x = dtData[[cQuoteTimeColname]])) {
        stop("Error inside class FxTimeSeries constructor - colname indicated by ",
             "cQuoteTimeColname is not of class Date! ")
      }
      # ----- 6. cFxRateColname -----
      # 6.1. check if cFxRateColname is char scalar
      if (!VariousUtils::BasicUtils$bIsScalarOfClass(objIn = cFxRateColname,
                                                     cClassName = "character")) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cQuoteTimeColname is not a character scalar! ")
      }
      # 6.2. check if cFxRateColname is a column in dtData at all
      if (!(cFxRateColname %in% colnames(dtData))) {
        stop("Error inside class FxTimeSeries constructor - parameter ",
             "cFxRateColname is not a column inside dtData! ")
      }
      # 6.3. check if cFxRateColname column is of double type
      if (!is.double(x = dtData[[cFxRateColname]])) {
        stop("Error inside class FxTimeSeries constructor - colname indicated by ",
             "cQuoteTimeColname is not of class Date! ")
      }
      # ----- 7. make ID of the time series -----
      if (!is.null(x = cIdPrefix)) {
        cId <- paste0(cIdPrefix, "_", cBaseTicker, cQuotedTicker)
      } else {
        cId <- paste0(cBaseTicker, cQuotedTicker)
      }
      # ----- 8. save the data -----
      # 8.1. rename colnames
      data.table::setnames(x = dtData, old = cQuoteTimeColname, new = "quote_date")
      data.table::setnames(x = dtData, old = cFxRateColname, new = cId)
      # 8.2. prepare only the columns to save
      cColsToKeep <- c("quote_date", cId)
      dtData <- dtData[, ..cColsToKeep]
      # 8.3. set the index on quote_date
      data.table::setkey(x = dtData, "quote_date")
      # 8.4. save the data into the private member
      private$dtData <- dtData
    },


    # getter methods ===========================================================

    cGetQuotedTicker = function() {
      return(private$cQuotedTicker)
    },

    cGetBaseTicker = function() {
      return(private$cBaseTicker)
    },

    cGetId = function() {
      return(private$cId)
    },

    dtGetRate = function(dateQuoteDate) {
      # check if dateQuoteDate
      if (dateQuoteDate %in% private$dtData[["quote_date"]]) {

        dtOut <- private$dtData[]
      } else {
        return(NULL)
      }
    },

    dtGetData = function() {
      return(private$dtData)
    }

  ),
  private = list(

    # member fields
    cQuotedTicker = NULL,
    cBaseTicker = NULL,
    cId = NULL,
    dtData = NULL


  )
)
