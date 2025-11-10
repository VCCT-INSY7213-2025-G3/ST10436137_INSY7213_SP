-- Trigger Creation: Prevent deletion from DONATION table
CREATE OR REPLACE TRIGGER trg_prevent_donation_delete
BEFORE DELETE ON DONATION
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(
        -20010,
        'ERROR: Deletion from the DONATION table is not permitted by BikeRUs policy.'
    );
END;
/

-- Testing trigger
DELETE FROM DONATION WHERE DONATION_ID = 1;

