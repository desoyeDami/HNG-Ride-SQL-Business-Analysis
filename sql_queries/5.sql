SELECT 
    pickup_city,
    COUNT(rider_id) as total_rides,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) as cancelled_rides,
    CAST(SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS REAL) / COUNT(rider_id) AS cancellation_rate
FROM
    rides
WHERE
    request_time BETWEEN '2021-06-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY
    pickup_city
ORDER BY
    cancellation_rate DESC
LIMIT 1