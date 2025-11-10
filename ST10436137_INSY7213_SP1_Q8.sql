SELECT 
    b.BIKE_ID,
    b.BIKE_TYPE,
    b.MANUFACTURER,
    d.VALUE,
    CASE
        WHEN d.VALUE <= 1500 THEN '*'
        WHEN d.VALUE > 1500 AND d.VALUE <= 3000 THEN '**'
        WHEN d.VALUE > 3000 THEN '***'
        ELSE 'N/A'
    END AS "STATUS"
FROM BIKE b
JOIN DONATION d ON b.BIKE_ID = d.BIKE_ID
ORDER BY b.BIKE_ID;
