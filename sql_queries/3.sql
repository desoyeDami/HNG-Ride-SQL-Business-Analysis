WITH QuarterlyRevenue AS (
    SELECT
        strftime('%Y', paid_date) AS SalesYear,
        (strftime('%m', paid_date) - 1) / 3 + 1 AS SalesQuarter,
        SUM(amount) AS QuarterRevenue
    FROM
        payments
    WHERE 
        amount > 0
        AND paid_date BETWEEN '2021-01-01 00:00' AND '2024-12-31 23:59'
    GROUP BY
        SalesYear,
        SalesQuarter
),
YOYGrowth AS (
    SELECT 
        SalesYear,
        SalesQuarter,
        QuarterRevenue,
        LAG(QuarterRevenue, 1, 0) OVER(
            PARTITION BY SalesQuarter
            ORDER BY SalesYear
        ) as PrevYearRevenue
    FROM
        QuarterlyRevenue
)
SELECT
    SalesYear,
    SalesQuarter,
    QuarterRevenue,
    PrevYearRevenue,
    (QuarterRevenue - PrevYearRevenue) * 100 / NULLIF(PrevYearRevenue, 0) AS YOYGrowthPercentage
FROM
    YOYGrowth
WHERE 
    PrevYearRevenue > 0
ORDER BY
    YOYGrowthPercentage DESC