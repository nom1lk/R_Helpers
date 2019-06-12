

my_packages <- c(
  "RODBC"
  , "dplyr"
  , "stringr"
  , "reshape2"
  , "foreach"
  , "doParallel"
  , "tidyverse"
  , "lubridate"
  , "data.table"
  , "stringr"
  , "RDCOMClient"
  , "rvest"
  , "httr"
  , "curl"
  , "RCurl"
  , "caret"
  , "tm"
  , "SnowballC"
  , "arm"
  , "doParallel"
  , "caTools"
  , "jsonlite"
)






install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p, dependencies = TRUE)
  }
}

invisible(sapply(my_packages, install_if_missing))


lapply(my_packages, library, character.only=TRUE)



