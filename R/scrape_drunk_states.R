library(rvest)
library(dplyr)

page = read_html("https://www.thedrinksbusiness.com/2021/08/these-are-the-drunkest-states-in-america-ranked/")

drunkest_states = page %>%
  html_elements("ol li") %>%
  html_text()

df = data.frame(Drunk_Rank = 1:50,
           State = drunkest_states)

write.csv(df,"data/df_drunk.csv", row.names = FALSE)
