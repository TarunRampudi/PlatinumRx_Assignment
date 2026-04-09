-- 1)Find the revenue we got from each sales channel in a given year

select * from clinic_sales
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

--2)Find top 10 the most valuable customers for a given year
SELECT TOP 10
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC;

--3)Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year
WITH revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
expense AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT 
    r.month,
    r.total_revenue,
    ISNULL(e.total_expense, 0) AS total_expense,
    r.total_revenue - ISNULL(e.total_expense, 0) AS profit,
    CASE 
        WHEN r.total_revenue - ISNULL(e.total_expense, 0) > 0 
        THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
LEFT JOIN expense e 
    ON r.month = e.month
ORDER BY r.month;

--4)For each city find the most profitable clinic for a given month
WITH profit_data AS (
    SELECT 
        c.city,
        cs.cid,
        SUM(cs.amount) AS total_revenue,
        ISNULL(SUM(e.amount), 0) AS total_expense,
        SUM(cs.amount) - ISNULL(SUM(e.amount), 0) AS profit,
        RANK() OVER (
            PARTITION BY c.city 
            ORDER BY SUM(cs.amount) - ISNULL(SUM(e.amount), 0) DESC
        ) AS rnk
    FROM clinic_sales cs
    JOIN clinics c 
        ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid
        AND MONTH(cs.datetime) = MONTH(e.datetime)
        AND YEAR(cs.datetime) = YEAR(e.datetime)
    WHERE MONTH(cs.datetime) = 9 
      AND YEAR(cs.datetime) = 2021
    GROUP BY c.city, cs.cid
)
SELECT 
    city,
    cid,
    total_revenue,
    total_expense,
    profit
FROM profit_data
WHERE rnk = 1;

--5)For each state find the second least profitable clinic for a given month
SELECT state, cid, profit
FROM (
    SELECT 
        c.state,
        cs.cid,
        SUM(cs.amount) - ISNULL(SUM(e.amount), 0) AS profit,
        ROW_NUMBER() OVER (
            PARTITION BY c.state 
            ORDER BY SUM(cs.amount) - ISNULL(SUM(e.amount), 0)
        ) AS rn
    FROM clinic_sales cs
    JOIN clinics c 
        ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid
        AND MONTH(cs.datetime) = MONTH(e.datetime)
        AND YEAR(cs.datetime) = YEAR(e.datetime)
    WHERE MONTH(cs.datetime) = 9 
      AND YEAR(cs.datetime) = 2021
    GROUP BY c.state, cs.cid
) t
WHERE rn = 2;