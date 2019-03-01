library(rvest)
library(dplyr)







#----- Top Level Domains -----# 


top_level_domains <- fromJSON("https://raw.githubusercontent.com/umpirsky/tld-list/master/data/en/tld.json")
top_level_domains <- top_level_domains %>% unlist %>% unname
top_level_domains

# Ends in R
top_level_domains %>% .[substr(., nchar(.), nchar(.)) == "r"]




#----- Programming languages and their colours -----# 


languages <- c("R", "Python", "Ruby", "C", "SQL", "Scala", "Hadoop", "Julia", "Tableau", "Java", "SAS", "Matlab", "Stata", 
               "F#", "Haskell", "Lisp", "Clojure", "Minitab", "SPSS", "Knime", "Golang", "D3") 

language_colours <- fromJSON("https://raw.githubusercontent.com/ozh/github-colors/master/colors.json")
# which((language_colours %>% names %>% tolower) %in% (languages %>% tolower))

get_colour <- function(language) {
  tryCatch({
    ind <- which((language_colours %>% names %>% tolower) %in% (language %>% tolower))
    colour <- language_colours[[ind]]$color
  }
  , error = function(e) {colour <<- "#FFEFD5"} ) # This sets the colour for the language if it's not found in the list
  return(colour)
}

colours <- languages %>% sapply(get_colour) %>% unlist




