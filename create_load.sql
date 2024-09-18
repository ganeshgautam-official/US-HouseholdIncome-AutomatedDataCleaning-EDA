DROP TABLE IF EXISTS us_household_income_raw;
DROP TABLE IF EXISTS us_household_income_intermediate;
DROP TABLE IF EXISTS us_household_income_cleaned;

DELETE FROM us_household_income_raw;
DELETE FROM us_household_income_cleaned;
DELETE FROM us_household_income_intermediate;

CREATE TABLE us_household_income_raw (
    row_id INTEGER,
    id INTEGER,
    State_code INTEGER,
    State_name VARCHAR(100),
    State_ab CHAR(2),
    County VARCHAR(100),
    City VARCHAR(100),
    Place VARCHAR(100),
    Type VARCHAR(50),
    Primary_type VARCHAR(50),
    Zip_code INTEGER,
    Area_code INTEGER,
    Aland BIGINT,
    Awater BIGINT,
    Lat NUMERIC,
    Lon NUMERIC,
    insertion_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (row_id, insertion_timestamp)
);

CREATE TABLE us_household_income_intermediate (
    row_id INTEGER,
    id INTEGER,
    State_code INTEGER,
    State_name VARCHAR(100),
    State_ab CHAR(2),
    County VARCHAR(100),
    City VARCHAR(100),
    Place VARCHAR(100),
    Type VARCHAR(50),
    Primary_type VARCHAR(50),
    Zip_code INTEGER,
    Area_code INTEGER,
    Aland BIGINT,
    Awater BIGINT,
    Lat NUMERIC,
    Lon NUMERIC,
    insertion_timestamp TIMESTAMP,
    last_cleanup TIMESTAMP,
    PRIMARY KEY (row_id, insertion_timestamp)
);


CREATE TABLE us_household_income_cleaned (
    row_id INTEGER,
    id INTEGER,
    State_code INTEGER,
    State_name VARCHAR(100),
    State_ab CHAR(2),
    County VARCHAR(100),
    City VARCHAR(100),
    Place VARCHAR(100),
    Type VARCHAR(50),
    Primary_type VARCHAR(50),
    Zip_code INTEGER,
    Area_code INTEGER,
    Aland BIGINT,
    Awater BIGINT,
    Lat NUMERIC,
    Lon NUMERIC,
    insertion_timestamp TIMESTAMP,
    last_cleanup TIMESTAMP,
    PRIMARY KEY (row_id, insertion_timestamp)
);

CREATE TABLE us_cities_reference(
    City VARCHAR(100),
    City_ascii VARCHAR(100),
    State_id VARCHAR(2),
    State_name VARCHAR(100),
    County_name VARCHAR(100),
    Lat NUMERIC,
    LON NUMERIC
);


COPY us_household_income_raw(row_id, id, State_code, State_name, State_ab, County, City, Place, Type, Primary_type, Zip_code, Area_code, Aland, Awater, Lat, Lon)
FROM 'D:\Anlyst_Builder_Data_Analysis\SQL\Projects\US_HouseHold_Income\USHouseholdIncome.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY us_cities_reference(City, City_ascii, State_id, State_name, County_name, Lat, Lon)
FROM 'D:\Anlyst_Builder_Data_Analysis\SQL\Projects\US_Household_Income\us_cities_reference.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

