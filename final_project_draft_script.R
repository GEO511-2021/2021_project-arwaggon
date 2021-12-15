# Load in packages for the Yelp Fusion API
install.packages("devtools")
devtools::install_github("OmaymaS/yelpr")

# Load yelpr package
library(yelpr)

# Assign App Key
key <- "ovIH-U3kauQ5ikHV5951RqsOq81q4MycWiu5xIsFCzd_c2zKxAwUdhb-SDvOeJ9Wrp_3rSVS3z5PuQDqfbl9grNOI3SFeHsOViv2eXZMnus6NlYyWs3gURZP_m-UYXYx"

# Search businesses with keyword 'black' in 'Brooklyn, New York'
business_bk <- business_search(api_key = key,
                               location = 'Brooklyn, NY',
                               term = "African American",
                               categories = 'venues, bars, African',
                               limit = 10)

print(business_bk)

print(business_bk$businesses$coordinates)

# Mapping the data extracted from the Yelp Fusion API

# Load in ggplot2, ggmpap
# Install maps and mapdata
# Load in maps and mapdata
library(ggplot2)
library(ggmap)
#install.packages(c("maps", "mapdata"))
library(maps)
library(mapdata)
library(dplyr)
library(tidyverse)

# Highlight New York State
states <- map_data("state")
#View(states)
ny_df <- subset(states, region == "new york")
#View(ny_df)

brooklyn_df <- data.frame(
  long = c(-73.949997),
  lat = c(40.650002),
  names = c("Brooklyn"),
  stringsAsFactors = FALSE)

# Create the map of where Brooklyn is located
brooklyn_in_ny <- ggplot() +
  geom_polygon(data = ny_df, aes(x = long, y = lat, group = group)) +
  geom_point(data = brooklyn_df, aes(x = long, y = lat), color = "purple", size = 6) + theme_nothing() 
 

# Save map of Brooklyn in New York
ggsave("Brooklyn_in_NY.png", width = 15, height = 5)

# Create a map of African-American businesses in Brooklyn, NY from the Yelp API

# Install Leaflet
install.packages("leaflet")
# Load Leaflet
library(leaflet)

# Load in htmltools
library(htmltools)

brooklyn_businesses <- read.csv("brooklyn_black_businesses.csv")

# Select different basemaps
brooklyn_businesses %>%
  leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>%
  addProviderTiles(providers$Esri.WorldStreetMap, group = "World Street Map") %>%
  addLayersControl(baseGroups = c("World Imagery","World Street Map")) %>%
  # Add the businesses as Markers
  addCircleMarkers(lng = -73.99455, lat = 40.73879, popup = "Raines Law Room", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.92663, lat = 40.70241, popup = "Mad Tropical", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.82939, lat = 40.76613, popup = "Lewis Latimer House Museum", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.94009, lat = 40.69244, popup = "The Brooklyn Bank", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = 73.98994, lat = 40.69053, popup = "New York Transit Museum",  fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.93257, lat = 40.61828, popup = "Hills Place", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.96653, lat = 40.69359, popup = "Pipsqueak Shoppe & Salon", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.97769, lat = 40.68705, popup = "33 Lafayette", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.91975, lat = 40.83102, popup = "Bronx Museum of the Arts", fillOpacity = 0.5)%>%
  addCircleMarkers(lng = -73.95726, lat = 40.78543, popup = "The Jewish Museum", fillOpacity = 0.5)%>%
  setView(lat = 40.650002, lng =-73.949997, zoom = 9.5)




