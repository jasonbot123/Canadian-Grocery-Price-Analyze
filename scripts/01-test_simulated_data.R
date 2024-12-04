#### Preamble ####
# Purpose: Test the simulated data for Canadian Grocery Price 
# Authors: Jason Yang
# Date: 03 December 2024 
# License: None
# Pre-requisites:
# - Ensure that 'tidyverse' is installed for data manipulation.
# - This script will validate the integrity and consistency of the simulated data.


library(testthat)
library(tidyverse)

# Load the simulated data
test_data <- read_csv("data/00-simulated_data/simulated_data.csv")

test_that("Dataset structure is correct", {
  # Check that simulated_data is a data frame
  expect_s3_class(simulated_data, "data.frame")
  
  # Check that simulated_data has the expected number of rows and columns
  expect_equal(ncol(simulated_data), 10)
  expect_gte(nrow(simulated_data), 1000)  # Ensure at least 1000 rows
})

test_that("Column types are correct", {
  # Check data types of each column
  expect_type(simulated_data$product_id, "double")       # Numeric product IDs
  expect_type(simulated_data$vendor, "character")        # Vendor names as strings
  expect_type(simulated_data$product_name, "character")  # Product names as strings
  expect_type(simulated_data$current_price, "double")    # Prices as numeric
  expect_type(simulated_data$old_price, "double")        # Old prices as numeric
  expect_type(simulated_data$price_per_unit, "double")   # Price per unit as numeric
  expect_type(simulated_data$units, "character")         # Units as strings
  expect_type(simulated_data$brand, "character")         # Brands as strings
  expect_type(simulated_data$nowtime, "double")       # Timestamps as strings
  expect_type(simulated_data$concatted, "character")     # Concatted categories as strings
})

test_that("Column constraints are met", {
  # Check product_id range
  expect_true(all(simulated_data$product_id >= 1000 & simulated_data$product_id <= 9999))
  
  # Check that vendors are from the predefined list
  predefined_vendors <- c("Voila", "T&T", "Loblaws", "No Frills", "Metro", "Galleria", "Walmart", "Save-On-Foods")
  expect_true(all(simulated_data$vendor %in% predefined_vendors))
  
  # Check current_price is within the defined range
  expect_true(all(simulated_data$current_price >= 2 & simulated_data$current_price <= 15))
  
  # Check old_price is within the defined range
  expect_true(all(simulated_data$old_price >= 2 & simulated_data$old_price <= 20))
  
  # Check price_per_unit is within the defined range
  expect_true(all(simulated_data$price_per_unit >= 0.1 & simulated_data$price_per_unit <= 2))
  
  # Check valid units
  valid_units <- c("kg", "g", "lb", "ea")
  expect_true(all(simulated_data$units %in% valid_units))
  
  # Check valid product names
  valid_products <- c("Brown Eggs", "Bacon", "Toast", "Milk", "Orange Juice")
  expect_true(all(simulated_data$product_name %in% valid_products))
  
  # Check valid categories
  valid_categories <- c("category1", "category2", "category3")
  expect_true(all(simulated_data$concatted %in% valid_categories))
})

test_that("No missing or invalid values in critical columns", {
  # Check for missing values in essential columns
  essential_columns <- c("product_id", "vendor", "product_name", "current_price", "old_price", "brand")
  for (col in essential_columns) {
    expect_true(all(!is.na(simulated_data[[col]])))
  }
  
  # Check for invalid current_price (e.g., negative values)
  expect_true(all(simulated_data$current_price > 0))
  expect_true(all(simulated_data$old_price > 0))
})

test_that("Timestamps are valid and sequential", {
  # Ensure timestamps are valid and can be converted to POSIXct
  parsed_times <- as.POSIXct(simulated_data$nowtime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
  expect_true(all(!is.na(parsed_times)))
  
  # Check that timestamps are sequential
  expect_true(all(diff(parsed_times) >= 0))
})

