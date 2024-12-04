#### Preamble ####
# Purpose: Downloads and saves the data from Jacbo Filipp Project Hammer 
# Author: Jason Yang
# Date: 26 November 2024 
# Contact: jzc.yang@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Need to have the data downloaded from https://jacobfilipp.com/hammer/ and saved locally. 
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Save data ####
grocery_product <- read.csv('data/01-raw_data/hammer-4-product.csv')
grocery_raw <- read.csv('data/01-raw_data/hammer-4-raw.csv')
                        


write_parquet(grocery_product, "data/01-raw_data/grocery_product.parquet")
write_parquet(grocery_raw, "data/01-raw_data/grocery_raw.parquet")

         
