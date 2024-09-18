-- Validating the table creation

-- Raw table
SELECT *
FROM 
    us_household_income_raw
LIMIT 20;

-- Staging table
SELECT
    *
FROM
    us_household_income_intermediate
LIMIT 10;


-- Datawarehouse table
SELECT
    *
FROM
    us_household_income_cleaned
LIMIT 10;

-- Salary table
SELECT
    *
FROM 
    us_household_income_statistics
LIMIT 10;


-- Checking for duplication and other inconsistencies
SELECT COUNT(*)
FROM 
    us_household_income_intermediate;


-- Checking for duplicates values
SELECT
    id, 
    COUNT(id)
FROM
    us_household_income_intermediate
GROUP BY
    id
HAVING 
    COUNT(id) > 1;


-- Checking naming inconsistency in state_name
SELECT
    DISTINCT state_name
FROM
    us_household_income_intermediate
ORDER BY
    state_name ASC;

-- Checking naming inconsistencies in type column
SELECT
    DISTINCT type
FROM
    us_household_income_intermediate
ORDER BY
    type ASC;




-- To check if the trigger is created or not
SELECT trigger_name, event_manipulation, event_object_table
FROM information_schema.triggers
WHERE event_object_table = 'us_household_income_intermediate';


-- Final table validation

SELECT
    id, 
    COUNT(id)
FROM
    us_household_income_cleaned
GROUP BY
    id
HAVING 
    COUNT(id) > 1;


-- Checking naming inconsistency in state_name column
SELECT
    DISTINCT state_name
FROM
    us_household_income_cleaned
ORDER BY
    state_name ASC;

-- Checking naming inconsistencies in type column
SELECT
    DISTINCT type
FROM
    us_household_income_cleaned
ORDER BY
    type ASC;

