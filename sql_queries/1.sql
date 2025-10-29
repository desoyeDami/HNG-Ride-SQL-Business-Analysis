SELECT  rd.distance_km, 
        dr.name as driver_name, 
        rdr.name as rider_name,
        rd.pickup_city,
        rd.dropoff_city,
        pym.amount
FROM rides rd
JOIN drivers dr
ON rd.driver_id = dr.driver_id
JOIN riders rdr
ON rd.rider_id = rdr.rider_id
JOIN payments pym
ON rd.ride_id = pym.ride_id
WHERE 
    pym.amount > 0
    AND rd.request_time BETWEEN '2022-06-01 00:00' AND '2024-12-31 23:59'
ORDER BY rd.distance_km DESC
LIMIT 10