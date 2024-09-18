CREATE OR REPLACE PROCEDURE insert_into_intermediate()
LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO us_household_income_intermediate (
        row_id, id, State_code, State_name, State_ab, County, City, Place, Type, Primary_type, Zip_code, Area_code, Aland, Awater, Lat, Lon, insertion_timestamp
    )
    SELECT
        row_id, id, State_code, State_name, State_ab, County, City, Place, Type, Primary_type, Zip_code, Area_code, Aland, Awater, Lat, Lon, insertion_timestamp
    FROM
        us_household_income_raw;

    DELETE FROM us_household_income_raw;

END;
$$;


CALL insert_into_intermediate();

