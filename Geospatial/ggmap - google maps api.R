
# mode options:  "bicycling", "walking", "transit" or "driving"

# Find out how many free requests you have remaining
distQueryCheck()


# Distinace from place to place
library(ggmap)
from <- 'Paris'
to <- 'London'
mapdist(from,to,mode='driving') 


# Distance from place to place based on coordinates
library(ggmap) # Note it accepts coordingates in lon / lat format
from <- c(144.985531,-37.810043) # 162 Albert Street, East Meloburne
to <- c(145.009286,-37.814144) # 56 Burnley Street, Richmond
mapdist(from,to,mode='transit')


# 
library(ggmap) # Note it accepts coordingates in lon / lat format
from <- c(144.987731,-37.820043)
to <- c(145.049286,-37.817144)
mapdist(from,to,mode='walking')



# Getting lon / lat from place
(wh <- as.numeric(geocode("the white house, dc")))
(lm <- as.numeric(geocode("lincoln memorial washington dc")))
mapdist(wh, lm, mode = "walking")




# Note: mapdist will automatically search for a location (i.e. an address) from any to/from lon/lats it receives
# This means it will error if it can't convert the coordinates to an address it knows
# i.e.
location <- c(145.009286,-37.814144)
revgeocode(location)

location <- c(144.987731,-37.820043)
revgeocode(location)











