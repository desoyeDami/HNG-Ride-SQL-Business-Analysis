%%sql
WITH DriverRideStats AS (
    SELECT
        driver_id,
        COUNT(ride_id) AS total_rides_attempted,
        SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS total_cancelled
    FROM
        rides
    WHERE
        request_time BETWEEN '2021-06-01 00:00:00' AND '2024-12-31 23:59:59'
    GROUP BY
        driver_id
),
DriverCompletedStats AS (
    SELECT
        rd.driver_id,
        COUNT(rd.ride_id) AS total_completed_rides
    FROM
        rides rd
    JOIN
        payments p ON rd.ride_id = p.ride_id
    WHERE
        p.amount > 0
        AND rd.request_time BETWEEN '2021-06-01 00:00:00' AND '2024-12-31 23:59:59'
    GROUP BY
        rd.driver_id
)
SELECT
    dr.name,
    dr.rating AS average_rating,
    cs.total_completed_rides,
    (CAST(rs.total_cancelled AS REAL) * 100.0 / rs.total_rides_attempted) AS cancellation_rate_percent
FROM
    drivers dr
JOIN
    DriverRideStats rs ON dr.driver_id = rs.driver_id
JOIN
    DriverCompletedStats cs ON dr.driver_id = cs.driver_id
WHERE
    cs.total_completed_rides >= 30
    AND dr.rating >= 4.5
    AND (CAST(rs.total_cancelled AS REAL) * 100.0 / rs.total_rides_attempted) < 5.0
ORDER BY
    cs.total_completed_rides DESC
LIMIT 10; 