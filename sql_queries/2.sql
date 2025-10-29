SELECT COUNT(DISTINCT rd.rider_id) AS Active_Riders
FROM rides rd
JOIN riders rdr
ON rd.rider_id = rdr.rider_id
WHERE request_time BETWEEN '2024-01-01 00:00' AND '2024-12-31 23:59'
AND rdr.signup_date BETWEEN '2021-01-01 00:00' AND '2021-12-31 23:59'