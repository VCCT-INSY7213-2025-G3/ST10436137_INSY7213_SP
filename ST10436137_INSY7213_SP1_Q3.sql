SET SERVEROUTPUT ON;

DECLARE
    c_vat_rate CONSTANT NUMBER := 0.15;
    v_vat_amount NUMBER;
    v_total_amount NUMBER;
    CURSOR curs_roadbikes IS
        SELECT 
            b.DESCRIPTION AS description,
            b.MANUFACTURER AS manufacturer,
            b.BIKE_TYPE AS type,
            d.VALUE AS value
        FROM DONATION d
        JOIN BIKE b ON b.BIKE_ID = d.BIKE_ID
        WHERE b.BIKE_TYPE = 'Road Bike';

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Road Bike VAT Report ---');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

    FOR r IN curs_roadbikes LOOP
        BEGIN
            v_vat_amount := r.value * c_vat_rate;
            v_total_amount := r.value + v_vat_amount;

            -- Display formatted output
            DBMS_OUTPUT.PUT_LINE('BIKE DESCRIPTION:   ' || r.description);
            DBMS_OUTPUT.PUT_LINE('BIKE MANUFACTURER:  ' || r.manufacturer);
            DBMS_OUTPUT.PUT_LINE('BIKE TYPE:          ' || r.type);
            DBMS_OUTPUT.PUT_LINE('VALUE:              R ' || r.value);
            DBMS_OUTPUT.PUT_LINE('VAT:                R ' || v_vat_amount);
            DBMS_OUTPUT.PUT_LINE('TOTAL AMNT:         R ' || v_total_amount);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
        END;
    END LOOP;
END;
/
