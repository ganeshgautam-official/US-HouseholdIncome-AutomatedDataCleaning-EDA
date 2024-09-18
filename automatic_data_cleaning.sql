DROP FUNCTION IF EXISTS clean_batch_data() CASCADE;
CREATE OR REPLACE FUNCTION clean_batch_data()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Automated data cleaning is succefully executed!';
    -- Data cleaning steps
    -- Removing duplicates
    DELETE FROM us_household_income_intermediate
    WHERE row_id IN(
        SELECT
            row_id
        FROM(
                SELECT
                row_id,
                id,
                ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
        FROM    
            us_household_income_intermediate
            ) AS subquery
        WHERE
        row_num > 1

    );

    -- Making sure all column's values are in proper case and adjusting some mispell values
    UPDATE us_household_income_intermediate
        SET state_name = CASE
                    WHEN INITCAP(state_name) = 'Georia' THEN 'Georgia'
                    ELSE INITCAP(state_name)
                 END,
            county = INITCAP(county),
            city = INITCAP(city),
            place = INITCAP(place),
            type = CASE
                     WHEN type = 'Boroughs' THEN 'Borough'
                     WHEN UPPER(type) = 'CPD' OR UPPER(type) = 'CDP' THEN 'CDP'
                     ELSE INITCAP(type)
                   END,
            last_cleanup = CURRENT_TIMESTAMP;

    RETURN NULL;

END;
$$;

DROP TRIGGER IF EXISTS Clean_Data ON us_household_income_intermediate;
CREATE TRIGGER Clean_Data
AFTER INSERT ON us_household_income_intermediate
FOR EACH STATEMENT
EXECUTE FUNCTION clean_batch_data();


DROP FUNCTION IF EXISTS insert_into_cleaned() CASCADE;
CREATE OR REPLACE FUNCTION insert_into_cleaned()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Insertion on final table is successful!';
    INSERT INTO us_household_income_cleaned (
        row_id, id, State_code, State_name, State_ab, County, City, Place, Type, Primary_type, Zip_code, Area_code, Aland, Awater, Lat, Lon, insertion_timestamp, last_cleanup
    )
    SELECT
        row_id, id, State_code, State_name, State_ab, County, City, Place, Type, Primary_type, Zip_code, Area_code, Aland, Awater, Lat, Lon, insertion_timestamp, last_cleanup
    FROM
        us_household_income_intermediate;

    -- DELETE FROM us_household_income_intermediate;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS cleaned_batch_insertion ON us_household_income_intermediate;
CREATE TRIGGER cleaned_batch_insertion
AFTER UPDATE ON us_household_income_intermediate
FOR EACH STATEMENT
EXECUTE FUNCTION insert_into_cleaned();









