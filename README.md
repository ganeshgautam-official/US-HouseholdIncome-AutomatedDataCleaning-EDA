# Automated Data Cleaning and EDA of US Household Income Data
This repository contains the code and datasets for automating data cleaning and performing exploratory data analysis (EDA) on US household income data.

## Datasets
- USHouseholdIncome.csv: Contains US household and geographic information.
- USHouseholdIncome_Statistics.csv: Includes statistical data like mean, median, standard deviation, and sum of wages (salary).
- us_cities_reference.csv: Geographic location reference, used for cleaning purposes.
- us_household_summary_statistics.csv: The final output file, created after joining cleaned household data with statistics for EDA.
## Process Overview
### 1. Data Extraction and Loading
Source: The data was extracted from Kaggle.
The raw data is loaded into a table us_household_income_raw.
### 2. Manual Data Insertion
A stored procedure inserts the raw data into an intermediate staging table named as us_household_income_intermediate.
### 3. Automated Data Cleaning
A trigger (in automatic_data_cleaning.sql) performs the automated data cleaning when data is inserted. Key cleaning steps include:
- Removing duplicate records.
- Proper casing for all values (e.g., city names).
- Correcting misspelled data.
- Standardizing and removing data inconsistencies.
### 4. Final Data Load
After cleaning, another trigger loads the final data into the us_household_income_cleaned table which is optimized for analysis.
### 5. View Creation for EDA
A view is created by joining the clean household data with statistics data, ready for exploratory data analysis (EDA).

## EDA
### 1: Distribution Plot of Household Income
In the first step of my analysis, I explored the overall distribution of household income across the US. I created a distribution plot using binning techniques to capture the spread of income values. Upon analysis, I found that the data is right-skewed. This suggests that while a large proportion of households earn within a lower-to-middle income range, there is a smaller yet significant number of households earning much higher incomes, creating a long tail in the distribution.
