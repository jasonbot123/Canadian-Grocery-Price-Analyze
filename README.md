# Starter folder

## Overview

This repository contains the analysis of grocery prices for breakfast staples—bacon, brown eggs, and bagels—collected from eight major Canadian grocery vendors. The study aims to identify which vendor offers the lowest prices, the most frequent discounts, and how pricing strategies vary across vendors. This analysis was conducted as part of Project Hammer, a broader initiative to foster competition and reduce potential collusion in the Canadian grocery sector.

The originaldata is available here: [Project Hammer](https://jacobfilipp.com/hammer/).
## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

The code in this repository was partially developed with the assistance of ChatGPT-4o. Specifically, the LLM was consulted during the data simulation process, for assistance with visualizations, and for refining some modeling approaches. Detailed transcripts of interactions with ChatGPT-4o are available in other/llm_usage. These records ensure transparency regarding the contributions of AI to this project.

## Instructions 

1. Download the download the Canadian Grocery Data from [Project Hammer](https://jacobfilipp.com/hammer/) before running the scripts for the simulation and cleaning process.
2. Use the cleaned data in `data/02-analysis_data` for statistical analysis and summary statistics. 3
3. To generate the final paper, use the Quarto document (`paper.qmd`) in the `paper/` directory. The document can be rendered to PDF to produce a complete report of the analysis.