CREATE VIEW us_household_income_summary AS
    SELECT
        cleaned.row_id,
        cleaned.id,
        cleaned.State_name,
        cleaned.City,
        cleaned.County,
        cleaned.Place,
        cleaned.Type,
        stats.Mean_Salary,
        stats.Median_Salary,
        stats.St_dev,
        stats.Sum_w,
        cleaned.Lat,
        cleaned.Lon
    FROM
        us_household_income_cleaned AS cleaned
    JOIN
        us_household_income_statistics AS stats
        ON cleaned.id = stats.id
    WHERE
        stats.Mean_Salary > 0 
        AND stats.Median_Salary > 0; 


SELECT
    *
FROM
    us_household_income_summary
LIMIT 100;


-- Finding avg mean salary and median salary across each state
SELECT
    State_name,
    ROUND(AVG(Mean_Salary), 2) AS avg_mean_sal,
    ROUND(AVG(Median_Salary), 2) AS avg_median_sal
FROM
     us_household_income_summary
GROUP BY
    State_name
ORDER BY
    avg_mean_sal DESC;


