# ==============================================================================
# This script contains code that has been used to prepare the data 
# that has been used when developing the package.
# Please keep in mind stooq.com 's terms of service: https://stooq.com/terms.html !!!
# ==============================================================================


cMyStooqTickers <- c(
  "PKO",
  "PEO",
  "KGH",
  "JSW",
  "ATT",
  "CDR",
  "PGE"
)

dateStartDate <- as.Date("2016-01-01")
dateEndDate <- as.Date("2020-12-31")

lData <- okeanos.stooq::lGetDailyDataForTickersFromStooq(
  cTickers = cMyStooqTickers, dateStartDate = dateStartDate, 
  dateEndDate = dateEndDate)

dtPekaoData <- lData$PEO
usethis::use_data(dtPekaoData, internal = FALSE, overwrite = TRUE)
