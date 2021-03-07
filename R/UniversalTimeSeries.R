UniversalTimeSeries <- R6::R6Class(
  classname = "UniversalTimeSeries",
  public = list(
    initialize = function() {},
    AddCalculatedColumn = function(dtNewColumn) {}
  ),
  private = list(
    dtData = NULL,
    cFrequency = NULL
  )
)
