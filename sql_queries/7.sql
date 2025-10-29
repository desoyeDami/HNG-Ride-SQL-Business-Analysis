WITH DriverRevenueByCity AS (
    SELECT
        rd.pickup_city,
        dr.name AS driver_name,
        SUM(p.amount) AS total_revenue
    FROM
        rides rd
    JOIN payments p 
    ON rd.ride_id = p.ride_id
    JOIN drivers dr 
    ON rd.driver_id = dr.driver_id
    WHERE
        p.amount > 0
        AND rd.request_time BETWEEN '2021-06-01 00:00:00' AND '2024-12-31 23:59:59'
    GROUP BY
        rd.pickup_city, dr.name
),
RankedDrivers AS (
    SELECT
        pickup_city,
        driver_name,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY pickup_city
            ORDER BY total_revenue DESC
        ) AS rank
    FROM
        DriverRevenueByCity
)
SELECT
    pickup_city,
    driver_name,
    total_revenue,
    rank
FROM
    RankedDrivers
WHERE
    rank <= 3
ORDER BY
    pickup_city, rank;
