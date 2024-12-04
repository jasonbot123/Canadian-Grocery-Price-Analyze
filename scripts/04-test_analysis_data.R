#### Preamble ####
# Purpose: Tests the Bacon, Brown Egg, and Bagel Data 
# Author: Jason Yang 
# Date: 03 December 2024 
# Contact: jzc.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? Needs to have the cleaned data saved locally


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

brown_egg <- read_parquet(here::here("data/02-analysis_data/brown_egg.parquet"))
bacon_data <- read_parquet(here::here("data/02-analysis_data/bacon_data.parquet"))
most_common_bagel <- read_parquet(here::here("data/02-analysis_data/bagel.parquet"))

test_that("dataset has required columns", {
  required_columns <- c("current_price", "old_price", "price_per_unit", "product_name", "nowtime", "units")
  expect_true(all(required_columns %in% colnames(brown_egg)))
})
test_that("dataset has required columns", {
  required_columns <- c("current_price", "old_price", "price_per_unit", "product_name", "nowtime", "units")
  expect_true(all(required_columns %in% colnames(bacon_data)))
})
test_that("dataset has required columns", {
  required_columns <- c("current_price", "old_price", "price_per_unit", "product_name", "nowtime", "units")
  expect_true(all(required_columns %in% colnames(most_common_bagel)))
})

test_that("No missing or invalid values in critical columns", {
  # Check for missing values in essential columns
  essential_columns <- c("current_price", "vendor", "old_price")
  for (col in essential_columns) {
    expect_true(all(!is.na(brown_egg[[col]])))
  }
  
  # Check for invalid current_price (e.g., negative values)
  expect_true(all(brown_egg$current_price > 0))
  expect_true(all(brown_egg$old_price > 0))
})

test_that("No missing or invalid values in critical columns", {
  # Check for missing values in essential columns
  essential_columns <- c("current_price", "vendor", "old_price")
  for (col in essential_columns) {
    expect_true(all(!is.na(bacon_data[[col]])))
  }
  
  # Check for invalid current_price (e.g., negative values)
  expect_true(all(bacon_data$current_price > 0))
  expect_true(all(bacon_data$old_price > 0))
})

test_that("No missing or invalid values in critical columns", {
  # Check for missing values in essential columns
  essential_columns <- c("current_price", "vendor", "old_price")
  for (col in essential_columns) {
    expect_true(all(!is.na(most_common_bagel[[col]])))
  }
  
  # Check for invalid current_price (e.g., negative values)
  expect_true(all(most_common_bagel$current_price > 0))
  expect_true(all(most_common_bagel$old_price > 0))
})



