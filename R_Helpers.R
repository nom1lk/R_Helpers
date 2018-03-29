


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





#################################################
##### Install and load a vector of packages #####
#################################################


required_packages <- c(
  "RODBC"
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
)


# Install packages
for (i in 1:length(required_packages)) {
  
  if ( any(grepl(required_packages[i], installed.packages())) == TRUE) {  }
  if ( any(grepl(required_packages[i], installed.packages())) == FALSE) { install.packages(required_packages[i], dependencies = TRUE, repos='https://cran.csiro.au/') } #'http://cran.us.r-project.org' is confirmed to work but is slow
  
}


# Load packages i.e. this replaces library function
lapply(required_packages, require, character.only = TRUE)
