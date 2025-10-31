library(rvest)
library(dplyr)

# Web scraping big foot sightings
bigfoot_page = read_html("https://www.bfro.net/gdb/")

info = bigfoot_page %>% html_elements(".cs") %>%
  html_text()

locations = info[seq(1, length(info), by = 4)]
num_sightings = info[seq(2, length(info), by = 4)]

bigfoot_df = data.frame("Location" = locations,
                        "Sightings" = num_sightings)

write.csv(bigfoot_df, "data/df_bigfoot.csv", row.names = FALSE)