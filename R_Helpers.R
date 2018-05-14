


######################################################################################
##### Get dates for file name (best practice YYYYMMDDHHMMSS to avoid collisions) #####
######################################################################################

#----- Get time and date for output -----#

time <- Sys.time()

date_for_file_name <- paste(strsplit(strsplit(as.character(time), " ")[[1]][1], "-")[[1]][1],
                            strsplit(strsplit(as.character(time), " ")[[1]][1], "-")[[1]][2], 
                            strsplit(strsplit(as.character(time), " ")[[1]][1], "-")[[1]][3],
                            sep="")

time_for_file_name <- paste(strsplit(strsplit(as.character(time), " ")[[1]][2], ":")[[1]][1],
                            strsplit(strsplit(as.character(time), " ")[[1]][2], ":")[[1]][2],
                            strsplit(strsplit(as.character(time), " ")[[1]][2], ":")[[1]][3],
                            sep="")




#----- Write output file -----#

write.csv(output_object, paste("Output/", date_for_file_name, "_", time_for_file_name, "_output_from_r.csv", sep=""), row.names=FALSE)








########################################################
##### Email notification to email entered from cmd #####
########################################################


## .bat file (example)
set /p input= enter your email to receive an alert upon completion:
"C:\Users\Documents\R\R-3.4.3\bin\x64\Rscript.exe" "Source Files\test.R" %input% >> Error_log.txt
cmd /k




## Place at start of script
#------  Accept input from command prompt  ------#

email_address <- commandArgs(trailingOnly = TRUE)

if (length(email_address) != 0) {
  email_address <- trimws(email_address[1])
}




## Place at end of script (or at whichever point you want the notification(s) to be sent)
#------ Email notification if valid email was provided  ------#

tryCatch(
  if (length(email_address) != 0) {
    
    OutApp <- COMCreate("Outlook.Application")
    outMail = OutApp$CreateItem(0)
    outMail[["To"]] = email_address
    outMail[["subject"]] = "CMP Bot Complete"
    outMail[["body"]] = " "
    outMail$Send()
    
  }
  , error = function(e) {})





###########################################################################
##### Detach Packages (e.g. for accommodation of both plyr and dplyr) #####
###########################################################################


detach_package <- function(pkg, character.only = FALSE)
{
  if(!character.only)
  { pkg <- deparse(substitute(pkg)) }
  search_item <- paste("package", pkg, sep = ":")
  while(search_item %in% search())
  { detach(search_item, unload = TRUE, character.only = TRUE) }
}
detach_package(broom)
detach_package(recipes)
detach_package(dplyr)






#################################################
##### Install and load a vector of packages #####
#################################################


required_packages <- c(
  "RODBC"
  , "plyr" # ALWAYS load plyr before dplyr # ALWAYS detach packages prior to loading plyr/dplyr
  , "dplyr"
  , "stringr"
  , "reshape2"
  , "foreach"
  , "doParallel"
  , "tidyverse"
  , "lubridate"
  , "xlsx"
  , "data.table"
  , "stringr"
  , "RDCOMClient"
  , "rvest"
  , "httr"
  , "mailR"
  , "curl"
  , "RCurl"
  , "caret"
  , "tm"
  , "SnowballC"
  , "arm"
  , "doParallel"
  , "caTools"
  , "xlsx"
  , "jsonlite"
)


# Install packages
for (i in 1:length(required_packages)) {
  
  if ( any(grepl(required_packages[i], installed.packages())) == TRUE) {  }
  if ( any(grepl(required_packages[i], installed.packages())) == FALSE) { install.packages(required_packages[i], dependencies = TRUE, repos='https://cran.csiro.au/') } #'http://cran.us.r-project.org' is confirmed to work but is slow
  
}


# Load packages i.e. this replaces library function
lapply(required_packages, require, character.only = TRUE)



##################################################################################################################
##### Dynamically change the name of a column (useful if you don't know the format of data you're receiving) #####
##################################################################################################################



# create a simple dataframe:
set.seed(1000)
city <- runif(3,0,10) %>% round(0); metro <- runif(3,2,10) %>% round(0); suburban <- runif(3,3,10) %>% round(0)
pets <- rbind(city, metro, suburban); colnames(pets) <- c("dogs_and_cats", "cats", "dogs")
pets


# Preferred method for replacing an *exact* match (because it's simplest):
colnames(pets)[which(colnames(pets) == "dogs")] <- "canines"


# this also replaces only *exact* column name matches
colnames(pets)[grepl("^dogs$", colnames(pets)) %>% grep(TRUE, .)] <- "canines"
pets


# this changes the name of all columns *containing* the word "dogs" to "canines" (i.e. both "dogs" and "dogs_and_cats" will become "canines")
colnames(pets)[grepl("dogs", colnames(pets)) %>% grep(TRUE, .)] <- "canines"
pets



#############################
##### Make a word cloud #####
#############################



library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


# This imports a one column dataframe (each element is a sentence)
scoping <- read.csv("C:/Users/condys/Desktop/scoping.csv")
colnames(scoping)[1] <- "col"
scoping <- scoping$col


docs <- Corpus(VectorSource(scoping))

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")


# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)


dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))




