

# options(osrm.server = "nameofserver") e.g. options(osrm.server = "router.project-osrm.org/")
# Apparently setting up a local server is a good idea (the demo server is apparently flakey)
# From here https://cran.r-project.org/web/packages/osrm/README.html
# https://stackoverflow.com/questions/51569400/create-drive-time-isochrones-in-r#51569596

# Great info on osrm here: http://project-osrm.org/docs/v5.5.1/api/#general-options
read_html('http://router.project-osrm.org/route/v1/driving/13.388860,52.517037;13.397634,52.529407;13.428555,52.523219?overview=false')


# Simple example
library(osrm)
pt <- c(-1.566771, 53.829245) # the order is LON LAT 
osrm::osrmIsochrone(loc = pt, breaks = 30)


getOption("osrm.server")[1] # router.project-osrm.org is the demo server. Set one up locally to get consistent data




# Possible better way:
# From here: 


library(RJSONIO)
distHoras <- function(origin, destinations){
  
  origin <- gsub(",", "", origin)
  origin <- gsub(" ", "+", origin)
  origin <- paste("origins=", origin, sep = "")
  
  destinations <- gsub(",", "", destinations)
  destinations <- gsub(" ", "+", destinations)
  destinations <- paste("destinations=", paste(destinations, 
                                               collapse = "|"), sep = "")
  
  
  mode4url <- paste("mode=", 'bicycling', sep = "")
  lang4url <- paste("language=", 'en-EN', sep = "")
  sensor4url <- paste("sensor=", tolower(as.character(FALSE)), 
                      sep = "")
  posturl <- paste(origin, destinations, mode4url, sensor4url, 
                   sep = "&")
  url_string <- paste("http://maps.googleapis.com/maps/api/distancematrix/json?", 
                      posturl, sep = "")
  url_string <- URLencode(url_string)
  connect <- url(url_string)
  tree <- fromJSON(paste(readLines(connect), collapse = ""))
  close(connect)
  rapply(tree$rows,I)
}

distHoras('Paris','London')










