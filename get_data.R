library(tidycensus)
library(tidyverse)

# View educational attainment variables if needed
# v <- load_variables(2022, "acs5", cache = TRUE)
# View(v %>% filter(str_detect(name, "B15003")))

edu_data <- get_acs(
  geography = "tract",
  variables = c(total = "B15003_001", bachelor_up = "B15003_022"),
  state = "CA",
  county = "Los Angeles",
  year = 2022,
  geometry = TRUE,
  survey = "acs5"
)

# Reshape and calculate percentage
la_edu_percent <- edu_data %>%
  select(GEOID, variable, estimate, geometry) %>%
  pivot_wider(names_from = variable, values_from = estimate) %>%
  mutate(percent_bachelor_or_higher = 100 * bachelor_up / total)

# View result
#glimpse(la_edu_percent)

write_rds(la_edu_percent, "la_edu_percent.rds")