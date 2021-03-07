


bIsScalarOfClass <- function(objIn, cClassName) {
  return(methods::is(object = objIn, class2 = cClassName) & length(objIn) == 1L)
}



bIsScalarOfType <- function(objIn, cTypeName) {
  return(typeof(x = objIn) == cTypeName & length(objIn) == 1L)
}



bCheckCurrency <- function(cTicker) {
  
  # 1. check if cCurr is character scalar
  if (!bIsScalarOfClass(objIn = cTicker, cClassName = "character")) {
    return(FALSE)
  }
  # 2. check if cTicker is in-scope
  if (!(toupper(x = cTicker) %in% cHandledCurrenciesTickers)) {
    return(FALSE)
  }
  return(TRUE)
}


cMyStooqTickers <- c("PKO", "PEO", "KGH", "JSW", "ATT", "CDR", "PGE")
dateStartDate <- as.Date("2016-01-01")
dateEndDate <- as.Date("2020-12-31")

lData <- okeanos.stooq::lGetDailyDataForTickersFromStooq(
  cTickers = cMyStooqTickers, dateStartDate = dateStartDate, 
  dateEndDate = dateEndDate)

lData <- lapply(X = lData, FUN = function(dtIn) {
  
  return(dtIn)
})

dtJoinMultipleDataTablesByUniqueKey <- function(lData, cKeyColumn = "quote_date") {

  dtJoined <- Reduce(f = function() { 
  }, x = lData)
  
  
}

