library(raster)
library(leaflet)
library(tidyverse)

# Get UK polygon data
UK <- getData("GADM", country = "GB", level = 2)

### Create dummy data
set.seed(111)
mydf <- data.frame(place = unique(UK$NAME_2),
                   value = sample.int(n = 1000000, size = n_distinct(UK$NAME_2), replace = TRUE))

### Create five colors for fill
mypal <- colorQuantile(palette = "RdYlBu", domain = mydf$value, n = 5, reverse = TRUE)

leaflet() %>% 
addProviderTiles("OpenStreetMap.Mapnik") %>%
setView(lat = 55, lng = -3, zoom = 6) %>%
addPolygons(data = UK,
            stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.3,
            fillColor = ~mypal(mydf$value),
            popup = paste("Region: ", UK$NAME_2, "<br>",
                          "Value: ", mydf$value, "<br>")) %>%
addLegend(position = "bottomright", pal = mypal, values = mydf$value,
          title = "UK value",
          opacity = 1)



# Get polygons
library(jsonlite)
library(geojsonio)

geojson <- fromJSON("https://data.gov.au/geoserver/vic-suburb-locality-boundaries-psma-administrative-boundaries/wfs?request=GetFeature&typeName=ckan_af33dd8c_0534_4e18_9245_fc64440f742e&outputFormat=json")

geojsonjson <- geojson %>% toJSON


# Convert to spatial class https://cran.r-project.org/web/packages/geojsonio/geojsonio.pdf
polygons <- geojson_sp(geojsonjson, disambiguateFIDs = FALSE, stringsAsFactors = FALSE)
polygons <- geojson_list(geojson, disambiguateFIDs = FALSE, stringsAsFactors = FALSE)

geojson$features$geometry$coordinates %>% .[1] %>% geojson_list(., disambiguateFIDs = FALSE, stringsAsFactors = FALSE)

revenue_by_suburb_na_rm %>% head(3)
geo <- revenue_by_suburb_na_rm[, c("ddsuburbname", "revenue")]

# Colours
mypal <- colorQuantile(palette = "RdYlBu", domain = mydf$value, n = 5, reverse = TRUE)



leaflet() %>% 
addProviderTiles("OpenStreetMap.Mapnik") %>%
setView(lat = 55, lng = -3, zoom = 6) %>%
addPolygons(data = geo,
            stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.3,
            fillColor = ~mypal(mydf$value),
            popup = paste("Region: ", UK$NAME_2, "<br>",
                          "Value: ", mydf$value, "<br>")) %>%
addLegend(position = "bottomright", pal = mypal, values = mydf$value,
          title = "UK value",
          opacity = 1)




