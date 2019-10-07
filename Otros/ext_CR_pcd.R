library(geojson)
library(tidyverse)
library(data.table)
library(rgdal)

url_path = "http://daticos-geotec.opendata.arcgis.com/datasets/741bdd9fa2ca4d8fbf1c7fe945f8c916_0.geojson"
downloader::download(url = url_path, destfile = "gas.GeoJSON")
gas <- readOGR(dsn = "gas.GeoJSON")

plot(gas)

saveRDS(gas, file="CR_pcd.Rds")
