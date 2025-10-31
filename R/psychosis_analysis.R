# COMPARING BIG FOOT SIGHTINGS TO PSYCHOSIS BY STATE
library(readr)
library(dplyr)
library(ggplot2)


# Load Big Foot sightings by state
bigfoot_df = read.csv("data/df_bigfoot.csv")


# Load up psychosis data
# data is from https://mhanational.org/data-in-your-community/mha-state-county-data/
psychosis_df = readxl::read_xlsx("data/Psychosis_State Bar.xlsx")

p_df_short = psychosis_df %>%
  select(State, `Formatted Show # or Percent Positive Age`)

# Merge data together
joined = bigfoot_df %>%
  left_join(p_df_short, join_by("Location" == "State")) %>%
  na.omit() %>%
  mutate(Sightings = as.numeric(Sightings),
         `Formatted Show # or Percent Positive Age` = as.numeric(`Formatted Show # or Percent Positive Age`))

# Create data viz
ggplot(data = joined, aes(x = `Formatted Show # or Percent Positive Age`,
                          y = Sightings)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Risk of Psychosis (per 100,000 population)") +
  ylab("Big Foot Sightings") +
  ggtitle("Big Foot Sightings by State vs Risk of Psychosis") +
  theme(
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 15)

  )

# Visually, it doesn't look like there's any obvious correlation