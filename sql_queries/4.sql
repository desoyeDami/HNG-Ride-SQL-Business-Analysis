WITH DriverActiveMonth AS (
    SELECT
        driver_id,
        name,
        (strftime('%Y', '2024-12-31') - strftime('%Y', signup_date)) * 12 +
        (strftime('%m', '2024-12-31') - strftime('%m', signup_date)) + 1 AS total_months_active
    FROM
        drivers
),
DriverTotalRides AS (
    SELECT 
        rd.driver_id,
        COUNT(rd.ride_id) AS total_rides_completed
    FROM rides rd
    JOIN payments pym
    ON rd.ride_id = pym.ride_id
    WHERE pym.amount > 0
    AND rd.request_time BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY rd.driver_id
)
SELECT 
    d.name,
    dt.total_rides_completed,
    d.total_months_active,
    (CAST(dt.total_rides_completed AS REAL) / d.total_months_active) AS rides_per_active_month
FROM DriverActiveMonth d
JOIN DriverTotalRides dt
ON dt.driver_id = d.driver_id
ORDER BY rides_per_active_month DESC
LIMIT 5