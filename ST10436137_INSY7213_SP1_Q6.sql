-- The function will determine the total contribution to donations a specific donor has made.
-- It will take the Donor's ID as an input.
-- Calculations for VAT are included, as well as a sum of donations.
-- The function will return a number for the total sum.

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fnDonorContribution(p_donor_id IN DONOR.DONOR_ID%TYPE) RETURN NUMBER IS  -- input parameter
    -- Declaring variables to store fetched data and calculations
    v_donor_name VARCHAR2(100);
    v_contact_no DONOR.CONTACT_NO%TYPE;
    v_total_donations NUMBER;
    c_vat_rate CONSTANT NUMBER := 0.15;
    
BEGIN
    -- Selecting Donor's details for given donor
    SELECT (dr.DONOR_FNAME || ' ' || dr.DONOR_LNAME), dr.CONTACT_NO
    INTO v_donor_name, v_contact_no
    FROM DONOR dr
    WHERE dr.DONOR_ID = p_donor_id;

    -- Selecting and totalling all donations made by donor
    SELECT SUM(dn.VALUE)
        INTO v_total_donations
        FROM DONATION dn
        WHERE dn.DONOR_ID = p_donor_id;

    -- Informs the user if the donor exists but has no donations
    IF v_total_donations IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No donations for Donor ID: ' || p_donor_id);
    END IF;

    -- Output results to user
    DBMS_OUTPUT.PUT_LINE('--- Donor Contribution Summary ---');
    DBMS_OUTPUT.PUT_LINE('Donor:            ' || v_donor_name);
    DBMS_OUTPUT.PUT_LINE('Contact:          ' || v_contact_no);
    DBMS_OUTPUT.PUT_LINE('Total (ex VAT):   R ' || v_total_donations);
    DBMS_OUTPUT.PUT_LINE('VAT @ 15%:        R ' || v_total_donations*c_vat_rate);
    DBMS_OUTPUT.PUT_LINE('Total (incl VAT): R ' || v_total_donations*(1+c_vat_rate));
    DBMS_OUTPUT.PUT_LINE('----------------------------------');

    -- Return total donations inclusive of VAT
    RETURN v_total_donations*(1 + c_vat_rate);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Triggered if the donor id does not exist
            DBMS_OUTPUT.PUT_LINE('Error: Donor ID ' || p_donor_id || ' not found.');
        RETURN NULL;

        WHEN OTHERS THEN
            -- If any other errors occur
            DBMS_OUTPUT.PUT_LINE('Unexpected error in fnDonorContribution: ' || SQLERRM);
        RETURN NULL;
        
END fnDonorContribution;
/

-- Executing the function
DECLARE
    -- Declaring the variable to fetch and store value
    v_total_incl_vat NUMBER;
BEGIN
    -- Running function and storing return value
    v_total_incl_vat := fnDonorContribution('DID12');

    -- Checks if donor has donations
    IF v_total_incl_vat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Function return value (incl VAT): R ' || v_total_incl_vat);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Catching any error
        DBMS_OUTPUT.PUT_LINE('Error caught: ' || SQLERRM);
END;
/
