# COMPARING BIG FOOT SIGHTINGS TO HEIGHT BY STATE
library(readr)
library(dplyr)
library(ggplot2)
library(maps)
library(stringr)

# Load Big Foot sightings by state
bigfoot_df = read.csv("data/df_bigfoot.csv")

# Load height by state data
height_df = read.csv("data/Average Male Height 2023.csv") %>%
  select(-Ranking) %>%
  mutate(feet = as.numeric(str_extract(Average.Male.Height.2023 ,pattern = "^.")),
         inches = as.numeric(str_match(Average.Male.Height.2023, pattern = "^.(\\d+)\\.")[,2]),
         partial_inches = as.numeric(str_match(Average.Male.Height.2023, pattern = "\\.(\\d+)")[,2]),
         height_in_inches = (12*feet) + inches + (0.1 * partial_inches))

glimpse(bigfoot_df)
glimpse(height_df)

joined = height_df %>%
  left_join(bigfoot_df, join_by("Region" == "Location")) %>%
  na.omit()

ggplot(data = joined, aes(x = height_in_inches, y = Sightings)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Big Foot Sightings vs. Height by State") +
  xlab("Height") +
  theme(
    axis.text = element_text(size = 15),
    axis.title = element_text(size = 15)
  )
