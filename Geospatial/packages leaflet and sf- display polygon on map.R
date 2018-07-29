
# From question here: https://stackoverflow.com/questions/51580551/convert-xy-to-lat-long-in-r


WestCoastIndiax <- structure(list(X_leaflet_id = 629L, feature_type = "polygon", 
               geometry = structure(list(structure(list(structure(c(-298.1964, 
                                                                    -298.4601, -298.3722, -297.6855, -293.9062, -293.4009, -292.8296, 
                                                                    -292.1265, -291.7529, -289.3359, -288.1934, -289.248, -289.0723, 
                                                                    -287.7539, -284.8535, -286.04, -283.0957, -282.3157, -282.4255, 
                                                                    -282.9529, -283.4253, -284.0295, -284.9634, -285.8643, -286.7651, 
                                                                    -286.7432, -286.875, -286.9519, -288.2922, -288.6328, -290.05, 
                                                                    -291.8958, -292.8955, -293.4009, -294.6863, -298.1964, 25.6861, 
                                                                    24.8565, 24.682, 24.8765, 25.1453, 24.5671, 23.8256, 23.5237, 
                                                                    22.6343, 19.6012, 20.0559, 12.5975, 7.1881, -1.1425, -0.791, 
                                                                    8.4941, 8.0484, 7.8416, 8.2441, 9.2973, 10.4338, 11.62, 14.094, 
                                                                    16.1197, 19.3215, 20.0456, 21.8411, 22.6748, 23.433, 24.4572, 
                                                                    24.7768, 25.0657, 25.3043, 25.8592, 26.116, 25.6861), .Dim = c(36L, 
                                                                                                                                   2L))), class = c("XY", "POLYGON", "sfg"))), class = c("sfc_POLYGON", 
                                                                                                                                                                                         "sfc"), precision = 0, bbox = structure(c(xmin = -298.4601, 
                                                                                                                                                                                                                                   ymin = -1.1425, xmax = -282.3157, ymax = 26.116), class = "bbox"), crs = structure(list(
                                                                                                                                                                                                                                     epsg = 4326L, proj4string = "+proj=longlat +datum=WGS84 +no_defs"), class = "crs"), n_empty = 0L)), row.names = 1L, sf_column = "geometry", agr = structure(c(X_leaflet_id = NA_integer_, 
                                                                                                                                                                                                                                                                                                                                                                                                   feature_type = NA_integer_), class = "factor", .Label = c("constant", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                             "aggregate", "identity")), class = c("sf", "data.frame"))

library(leaflet)
library(sf)

leaflet() %>% addTiles() %>% addPolygons(data=WestCoastIndiax)






