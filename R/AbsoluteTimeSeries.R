AbsoluteTimeSeries <- R6::R6Class(
  classname = "AbsoluteTimeSeries",
  inherit = "UniversalTimeSeries",
  public = list(
    initialize = function(dtData, cFreq, cId) {
      
    }
  ),
  private = list(
    cUnit = NULL,
    cFreq = NULL,
    cId = NULL
  )
)
