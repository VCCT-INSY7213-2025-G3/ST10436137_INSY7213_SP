SET SERVEROUTPUT ON;

DECLARE
    v_bike_id BIKE.BIKE_ID%TYPE;
    v_bike_type BIKE.BIKE_TYPE%TYPE;
    v_manufacturer BIKE.MANUFACTURER%TYPE;
    v_value DONATION.VALUE%TYPE;
    v_status VARCHAR2(10);

    CURSOR cur_bike_status IS
        SELECT b.BIKE_ID, b.BIKE_TYPE, b.MANUFACTURER, d.VALUE
        FROM BIKE b
        JOIN DONATION d ON b.BIKE_ID = d.BIKE_ID
        ORDER BY b.BIKE_ID;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BikeRUs Bike Status Report ---');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

    FOR r IN cur_bike_status LOOP
        v_bike_id := r.BIKE_ID;
        v_bike_type := r.BIKE_TYPE;
        v_manufacturer := r.MANUFACTURER;
        v_value := r.VALUE;

        IF v_value <= 1500 THEN
            v_status := '*';
        ELSIF v_value > 1500 AND v_value <= 3000 THEN
            v_status := '**';
        ELSE
            v_status := '***';
        END IF;

        DBMS_OUTPUT.PUT_LINE('BIKE ID:           ' || v_bike_id);
        DBMS_OUTPUT.PUT_LINE('BIKE TYPE:         ' || v_bike_type);
        DBMS_OUTPUT.PUT_LINE('BIKE MANUFACTURER: ' || v_manufacturer);
        DBMS_OUTPUT.PUT_LINE('BIKE VALUE:        ' || v_value);
        DBMS_OUTPUT.PUT_LINE('STATUS:            ' || v_status);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
