SELECT 
    d.DONOR_ID AS "Donor ID", 
    b.BIKE_TYPE AS "Bike Type", 
    b.DESCRIPTION AS "Bike Description", 
    'R ' || d.VALUE AS "Bike Value"
FROM DONATION d
JOIN BIKE b ON b.BIKE_ID = d.BIKE_ID
WHERE d.VALUE > 1500