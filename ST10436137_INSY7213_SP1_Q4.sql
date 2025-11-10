-- Creating view
CREATE OR REPLACE VIEW vwBikeRUs AS
SELECT 
    (dn.DONOR_FNAME || ' ' || dn.DONOR_LNAME) AS DONOR_NAME,
    dn.CONTACT_NO,
    b.BIKE_TYPE,
    d.DONATION_DATE
FROM DONATION d
JOIN DONOR dn ON d.DONOR_ID = dn.DONOR_ID
JOIN BIKE b ON d.BIKE_ID = b.BIKE_ID
JOIN VOLUNTEER v ON d.VOLUNTEER_ID = v.VOL_ID
WHERE v.VOL_ID = 'vol105';

SELECT * FROM vwBikeRUs; -- Displaying view

-- Benefits of using a View
/*
1. Simplify complex queries
   - Complex joins and conditions are all encapsulated into a single object (GeeksforGeeks, 2025).
   - This means that a user can queery the view just like a table.
   - This ensures that data is consistent and reusable in a logical capacity.
   - This is very beneficial for reports, which BikeRUs will find themselves doing often.

2. Allows data to be presented flexibly
   - Views can provide different users with different tailored views (GeeksforGeeks, 2025).
   - This can be beneficial as different employees of BikesRUs may be tasked with handling different entities.
   - Therefore, each user can have to access to their relevant views and all necessary data.
*/
