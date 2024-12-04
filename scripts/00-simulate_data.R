#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


# Define the vendors
vendors <- c("Voila", "T&T", "Loblaws", "No Frills", "Metro", "Galleria", "Walmart", "Save-On-Foods")

# Number of rows to simulate
n_rows <- 1000

# Generate simulated data
simulated_data <- data.frame(
  product_id = sample(1000:9999, n_rows, replace = TRUE),
  vendor = sample(vendors, n_rows, replace = TRUE),
  product_name = sample(c("Brown Eggs", "Bacon", "Toast", "Milk", "Orange Juice"), n_rows, replace = TRUE),
  current_price = round(runif(n_rows, 2, 15), 2),
  old_price = round(runif(n_rows, 2, 20), 2),
  price_per_unit = round(runif(n_rows, 0.1, 2), 2),
  units = sample(c("kg", "g", "lb", "ea"), n_rows, replace = TRUE),
  brand = sample(c("Brand A", "Brand B", "Brand C", "Brand D"), n_rows, replace = TRUE),
  nowtime = as.character(seq(ymd_hms("2024-01-01 00:00:00"), by = "hour", length.out = n_rows)),
  concatted = sample(c("category1", "category2", "category3"), n_rows, replace = TRUE)
)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

