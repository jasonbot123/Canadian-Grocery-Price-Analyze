#### Preamble ####
# Purpose: Cleans the Groceries' data into analysis dataset 
# Author: Jason Yang
# Date: 26 November 2024 
# Contact: jzc.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Ensure the 'tidyverse' package is installed for data manipulation.
# - Data should be downloaded and saved in the local project directory in a 'data/01-raw_data' folder.
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)

grocery_product <- read_parquet('data/01-raw_data/grocery_product.parquet')
grocery_raw <- read_parquet('data/01-raw_data/grocery_raw.parquet')


# Join the two datasets on "id" and "product_id" columns 
grocery <- grocery_raw %>% left_join(grocery_product, by = c("product_id" = "id"))

grocery$vendor <- as.factor(grocery$vendor)
grocery$product_name <- as.factor(grocery$product_name)
grocery$brand <- as.factor(grocery$brand)  

# Filter the Grocery Data to only contain Brown Eggs
brown_egg <- grocery %>%
  filter(grepl("brown eggs", product_name, ignore.case = TRUE))

# Filter the Grocery Data to only contain Bacons 
bacon_data <- grocery %>%
  filter(
    grepl("bacon", product_name, ignore.case = TRUE) & # Must contain "bacon"
      !grepl("dressing|seasoning|flavor|snack|caesar|ml|salad|cream|breakfast|cheddar|soup|veggie|chips|chunks|bits|cheese|sauce|beans|potato|crumble|frozen|pizza|sandwich|peppers|wrapped|spread|pasta|stuffed|sausage|mac|burger|ketchup|mustard|butter|egg|hash|ham|maple|hickory|applewood|flavoured|bean|&|garlic|spam|ranch|chichicken|pie|crackers|cookies|pieces|and|beef|twisters", 
             product_name, ignore.case = TRUE) # Exclude unwanted terms
  )

# Filter the Grocery to only contain the Everything Bagels
bagel_data <- grocery %>%
  filter(grepl("bagel", product_name, ignore.case = TRUE))

# Count the occurrences of bagel types
bagel_type_counts <- bagel_data %>%
  mutate(bagel_type = case_when(
    grepl("everything", product_name, ignore.case = TRUE) ~ "Everything Bagel",
    grepl("plain", product_name, ignore.case = TRUE) ~ "Plain Bagel",
    grepl("cinnamon", product_name, ignore.case = TRUE) ~ "Cinnamon Raisin Bagel",
    grepl("blueberry", product_name, ignore.case = TRUE) ~ "Blueberry Bagel",
    grepl("sesame", product_name, ignore.case = TRUE) ~ "Sesame Bagel",
    grepl("whole wheat", product_name, ignore.case = TRUE) ~ "Whole Wheat Bagel",
    TRUE ~ "Other"
  )) %>%
  group_by(bagel_type) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

most_common_bagel <- grocery %>%
  filter(grepl("everything bagel", product_name, ignore.case = TRUE))

most_common_bagel <- most_common_bagel %>% 
  filter(current_price != "" & !is.na(current_price))

bacon_data <- bacon_data %>% 
  filter(current_price != "" & !is.na(current_price))

brown_egg <- brown_egg %>%
  filter(current_price != "" & !is.na(current_price))

most_common_bagel$old_price <- gsub("was", "", most_common_bagel$old_price, ignore.case = TRUE)

most_common_bagel <- most_common_bagel %>%
  mutate(
    old_price = ifelse(old_price == "" | is.na(old_price), current_price, as.numeric(old_price))
  )

bacon_data$old_price <- gsub("[^0-9.]", "", bacon_data$old_price)
bacon_data$old_price <- gsub("\\.$", "", bacon_data$old_price)
bacon_data <- bacon_data %>%
  filter(!grepl("/100g", current_price))

bacon_data <- bacon_data %>%
  mutate(
    current_price = ifelse(
      grepl("^\\d+/\\$", current_price), # Identify multi-item prices
      as.numeric(str_extract(current_price, "\\d+\\.\\d+$")) / # Extract total price
        as.numeric(str_extract(current_price, "^\\d+")),      # Extract quantity
      current_price
    )
  )

bacon_data$current_price <- gsub("[^0-9.]", "", bacon_data$current_price)
bacon_data$current_price <- gsub("\\.$", "", bacon_data$current_price)
bacon_data <- bacon_data %>%
  mutate(
    old_price = ifelse(old_price == "" | is.na(old_price), current_price, as.numeric(old_price))
  )

bacon_data <- bacon_data %>%
  filter(!grepl("^\\d+/\\$", current_price))


brown_egg <- brown_egg %>%
  mutate(
    old_price = ifelse(old_price == "" | is.na(old_price), current_price, as.numeric(old_price))
  )


most_common_bagel <- most_common_bagel %>%
  filter(!grepl("^\\d+/\\$", current_price))



brown_egg$current_price <- as.numeric(brown_egg$current_price)
most_common_bagel$current_price <- as.numeric(most_common_bagel$current_price)
bacon_data$current_price <- as.numeric(bacon_data$current_price)

brown_egg$nowtime <- as.POSIXct(brown_egg$nowtime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC") 
most_common_bagel$nowtime <- as.POSIXct(most_common_bagel$nowtime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
bacon_data$nowtime <- as.POSIXct(bacon_data$nowtime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC") 


brown_egg$old_price <- as.numeric(brown_egg$old_price)
most_common_bagel$old_price <- as.numeric(most_common_bagel$old_price)
bacon_data$old_price <- as.numeric(bacon_data$old_price)

brown_egg$units <- as.factor(brown_egg$units)
bacon_data$units <- as.factor(bacon_data$units)
most_common_bagel$units <- as.factor(most_common_bagel$units)


#### Save data ####
write_parquet(brown_egg, "data/02-analysis_data/brown_egg.parquet")
write_parquet(bacon_data, "data/02-analysis_data/bacon_data.parquet")
write_parquet(most_common_bagel, "data/02-analysis_data/bagel.parquet")

