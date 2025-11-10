SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE spDonorDetails (p_bike_id IN BIKE.BIKE_ID%TYPE) IS -- takes BIKE_ID as input parameter
    -- Declaring variables to store fetched data
    v_donor_name        VARCHAR2(100);
    v_contact_no        DONOR.CONTACT_NO%TYPE;
    v_vol_first_name    VOLUNTEER.VOL_FNAME%TYPE;
    v_donation_date     DONATION.DONATION_DATE%TYPE;
    v_bike_description  BIKE.DESCRIPTION%TYPE;

BEGIN
    -- Selecting and storing data into variables for given BIKE_ID
    SELECT (d.DONOR_FNAME || ' ' || d.DONOR_LNAME), d.CONTACT_NO, v.VOL_FNAME, dn.DONATION_DATE, b.DESCRIPTION
    INTO v_donor_name, v_contact_no, v_vol_first_name, v_donation_date, v_bike_description
    FROM DONATION dn
    JOIN DONOR d ON d.DONOR_ID = dn.DONOR_ID
    JOIN VOLUNTEER v ON v.VOL_ID   = dn.VOLUNTEER_ID
    JOIN BIKE b ON b.BIKE_ID  = dn.BIKE_ID
    WHERE dn.BIKE_ID = p_bike_id;

    DBMS_OUTPUT.PUT_LINE('ATTENTION: ' || v_donor_name || ' assisted by:  ' || v_vol_first_name ||
        ' ,donated the  ' || v_bike_description || ' on the ' || v_donation_date);

    EXCEPTION
        -- Occurs if there is no matching record for given ID.
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No donation found for Bike ID: ' || p_bike_id);
        
        -- Occurs when select query returns more than one record.
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Multiple donations found for Bike ID: ' || p_bike_id);

        -- Occurs for any other unexpected errors
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Unexpected error for Bike ID ' || p_bike_id || ' -> ' || SQLCODE || ': ' || SQLERRM);
END;
/

-- Running procedure for B004
BEGIN
  spDonorDetails('B004');
END;
/
