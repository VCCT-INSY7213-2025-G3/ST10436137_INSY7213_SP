-- Trigger Creation: Prevent invalid (≤ 0) bike values on update
CREATE OR REPLACE TRIGGER trg_validate_bike_value
BEFORE UPDATE OF VALUE ON DONATION
FOR EACH ROW
BEGIN
    IF :NEW.VALUE <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20020,
            'ERROR: Invalid donation value entered. Bike value must be greater than 0.'
        );
    END IF;
END;
/

-- Testing trigger
UPDATE DONATION
SET VALUE = 0
WHERE DONATION_ID = 1;
