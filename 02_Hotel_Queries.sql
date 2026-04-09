-- Q1: For every user in the system, get the user_id and last booked room_no

select * from bookings

SELECT user_id, MAX(booking_date)
FROM bookings
GROUP BY user_id;

-----------------------------------------------------
-- Q2: TGet booking_id and total billing amount of every booking created in November, 2021

select * from booking_commercials
select * from items

SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-----------------------------------------------------
-- Q3: Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000

select * from booking_commercials
select * from items 

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-----------------------------------------------------
-- Q4: Determine the most ordered and least ordered item of each month of year 2021
WITH item_orders AS (
    SELECT 
        MONTH(bill_date) AS month,
        item_id,
        SUM(item_quantity) AS total_qty,
        RANK() OVER (PARTITION BY MONTH(bill_date) ORDER BY SUM(item_quantity) DESC) AS rnk_desc,
        RANK() OVER (PARTITION BY MONTH(bill_date) ORDER BY SUM(item_quantity)) AS rnk_asc
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY MONTH(bill_date), item_id
)
SELECT *
FROM item_orders
WHERE rnk_desc = 1 OR rnk_asc = 1;

-----------------------------------------------------
-- Q5: Find the customers with the second highest bill value of each month of year 2021
WITH bill_data AS (
    SELECT 
        bc.booking_id,
        MONTH(bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS total_bill,
        RANK() OVER (PARTITION BY MONTH(bc.bill_date) 
                     ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) AS rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bc.booking_id, MONTH(bc.bill_date)
)
SELECT *
FROM bill_data
WHERE rnk = 2;