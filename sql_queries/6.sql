SELECT 
    rd.rider_id,
    rdr.name,
    COUNT(rd.ride_id) total_ride
FROM rides rd
JOIN payments pym
ON rd.ride_id = pym.ride_id
JOIN riders rdr
ON rd.rider_id = rdr.rider_id
WHERE
    pym.amount > 0
    AND rd.request_time BETWEEN '2021-06-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY
    rd.rider_id 
HAVING
    COUNT(rd.ride_id) > 10
    AND SUM(CASE WHEN pym.method = 'cash' THEN 1 ELSE 0 END) = 0;