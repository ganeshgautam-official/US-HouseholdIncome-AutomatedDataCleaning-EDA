# Automated Data Cleaning and EDA of US Household Income Data
This repository contains the code and datasets for automating data cleaning and performing exploratory data analysis (EDA) on US household income data.

## Datasets
- [USHouseholdIncome.csv](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/data/USHouseholdIncome.csv): Contains US household and geographic information.
- [USHouseholdIncome_Statistics.csv](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/data/USHouseholdIncome_Statistics.csv): Includes statistical data like mean, median, standard deviation, and sum of wages (salary).
- [us_cities_reference.csv](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/data/us_cities_reference.csv): Geographic location reference, used for cleaning purposes.
- [us_household_summary_statistics.csv](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/data/us_household_summary_statistics.csv): The final output file, created after joining cleaned household data with statistics for EDA.
## Process Overview
### [1. Data Extraction and Loading](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/create_load.sql)
- Source: The raw data is sourced from Kaggle.
- The raw datasets are loaded into a table called us_household_income_raw.
### [2. Manual Data Insertion](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/manual_insertion.sql)
- A stored procedure is used to manually insert the raw data into a staging table named us_household_income_intermediate.
### [3. Automated Data Cleaning](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/automatic_data_cleaning.sql)
- An automated data cleaning process is triggered upon data insertion. This process, defined in automatic_data_cleaning.sql, includes the following key steps:
- Removing duplicates: Any duplicate records are removed.
- Standardizing case: Proper casing is applied to all values (e.g., city names).
- Correcting spelling errors: Common misspellings are corrected.
- Standardizing data: Inconsistencies in the data are addressed and standardized.

### [4. Final Data Load](https://github.com/iamganeshg18/US-HouseholdIncome-AutomatedDataCleaning-EDA/blob/main/automatic_data_cleaning.sql)
- After the data cleaning is completed, a second trigger loads the cleaned data into the us_household_income_cleaned table, which is optimized for analysis.
## EDA
### 1: Distribution Plot of Household Income
In the first step of my analysis, I explored the overall distribution of household income across the US. I created a distribution plot using binning techniques to capture the spread of income values. Upon analysis, I found that the data is right-skewed. This suggests that while a large proportion of households earn within a lower-to-middle income range, there is a smaller yet significant number of households earning much higher incomes, creating a long tail in the distribution.

![Salary Distribution](./plots/salary_distribution.png)

### 2: Average Mean Salary by State
In the next step of my analysis, I visualized the average household salary across different states using a treemap. This allowed me to quickly see how salaries vary geographically. States with higher average salaries occupy larger sections of the treemap, making it easier to identify salary concentration across regions.

- States like the District of Columbia and Connecticut  are prominently featured due to their high average household incomes.
- On the other end, states like Puerto Rico and Mississippi have smaller blocks, representing lower average salaries.

![State-wise Treemap](./plots/state_wise_treemap.png)

### 3: Average Mean Salary by Type 
In this step, I analyzed household incomes based on different types of regions, such as city, borough, county, village, and municipality. I created a treemap to visualize the contribution of each type to overall salary levels. The size of each block represents the average salary in that type of region.
- Municipalities tend to lead with the highest average salaries.
- Communities or smaller regions show weaker salary levels, as seen by their smaller representation in the treemap.

![Type-wise Treemap](./plots/type_treemap.png)

### Relationship between Mean Salary and Variability
In this step, I examined the relationship between salary variability and average salary using a scatter plot. This visualization helps to understand how the spread (or variability) in salaries correlates with the overall average salary across different regions.

- There is a positive relationship between salary variability and average salary, with an overall R-squared value of 0.7093, suggesting a strong correlation.
- Regions with higher average salaries tend to show greater variability, meaning there is a wider spread in income levels.

![Scatter Plot](./plots/scatter_plot.png)

I created a scatter plot specifically for salaries greater than $140K to explore high-income households in more detail. This plot aims to examine whether salary variability still shows a strong correlation with the average salary in the upper-income bracket.

- The relationship between salary variability and average salary in this segment is much weaker, with an R-squared value of only 0.025.
- This indicates that for households earning over $140K, the spread of salaries does not significantly vary with the average income in the region.

![Scatter Plot for High Salaries](./plots/scatter_plot_high_sal.png)
  


### Top 10 and Bottom 10 Cities by Mean Household Salary
Top 10 cities by average mean Salary
![Bottom 10 Cities](./plots/Bottom_10_citiies.png)

Bottom 10 Cities by average mean Salary
![Bottom 10 Cities](./plots/Bottom_10_citiies.png)









