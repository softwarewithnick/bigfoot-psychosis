# COMPARING BIG FOOT SIGHTINGS TO DRUNK BY STATE
library(readr)
library(dplyr)
library(ggplot2)
library(maps)

# Load Big Foot sightings by state
bigfoot_df = read.csv("data/df_bigfoot.csv")

# Load drunk states data
drunk_df = read.csv("data/df_drunk.csv")

glimpse(bigfoot_df)
glimpse(drunk_df)

joined = drunk_df %>%
  left_join(bigfoot_df, join_by("State" == "Location"))

ggplot(data = joined, aes(x = Drunk_Rank, y = Sightings)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE)


state_maps = map_data("state")

bigfoot_df$region = tolower(bigfoot_df$Location)
map_data = state_maps %>%
  left_join(bigfoot_df, by = "region")

ggplot(map_data, aes(long, lat, group = group, fill = Sightings)) +
  geom_polygon(color = "white") +
  coord_fixed(1.3) +
  scale_fill_gradient(low = "lightyellow", high = "red", na.value = "gray90") +
  labs(title = "Sightings by State (USA)",
       fill = "Sightings") +
  theme_void() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
  )
