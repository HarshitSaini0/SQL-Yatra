-- ============================================================
-- WEEK 2: CHALLENGE SOLUTIONS
-- Instructor: only open this AFTER the student has attempted it.
-- Ask: "Walk me through your logic" before comparing code.
-- ============================================================


-- SOLUTION 1: LIMIT warm-up
SELECT CustomerName, Sales, Profit
FROM superstore
ORDER BY Profit DESC
LIMIT 3;
-- Henry Ford 3000/600, Blacksmith Industries 2500/500, Frank Smith 1800/400
-- NOTE: ORDER BY must come before LIMIT, or "top 3" is meaningless.


-- SOLUTION 2: The CEO headline
SELECT COUNT(*)             AS total_orders,
       SUM(Sales)           AS total_revenue,
       SUM(Profit)          AS total_profit,
       ROUND(AVG(Sales), 2) AS avg_order_value
FROM superstore;
-- 15 | 15125 | 2135 | 1008.33
-- NOTE: No GROUP BY = one grand-total row. That's exactly what we want here.


-- SOLUTION 3: The regional Pivot Table
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;
-- West 5200, Central 4275, East 4000, South 1650


-- SOLUTION 4: The margin report
SELECT Category,
       SUM(Sales)  AS total_sales,
       SUM(Profit) AS total_profit,
       ROUND(100.0 * SUM(Profit) / SUM(Sales), 2) AS profit_margin_pct
FROM superstore
GROUP BY Category
ORDER BY profit_margin_pct DESC;
-- Technology      10200 | 1800 | 17.65
-- Office Supplies   775 |  135 | 17.42
-- Furniture        4150 |  200 |  4.82
-- TEACHING POINT: Office Supplies is tiny in revenue but almost as
-- profitable per dollar as Technology. Furniture is the weak spot.


-- SOLUTION 5: HAVING practice
SELECT Region,
       COUNT(*) AS order_count
FROM superstore
GROUP BY Region
HAVING COUNT(*) > 3
ORDER BY order_count DESC;
-- West 5, East 4
-- NOTE: Cannot be done with WHERE — COUNT(*) doesn't exist yet at WHERE time.


-- SOLUTION 6: The full pipeline
SELECT Region,
       COUNT(*)   AS holiday_orders,
       SUM(Sales) AS holiday_sales
FROM superstore
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-12-31'
GROUP BY Region
HAVING SUM(Sales) > 1000
ORDER BY holiday_sales DESC
LIMIT 2;
-- Central 2/4200, West 3/3250
-- South had one holiday order (900) → dropped by HAVING.
-- East had 1400 → passes HAVING but loses the LIMIT 2 race.


-- BONUS SOLUTION: Who came second?
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC
LIMIT 1 OFFSET 1;
-- Central 4275
-- LIMIT 1 = take one row. OFFSET 1 = skip first place.
-- In Week 6 you'll do this more elegantly with RANK().


-- REFLECTION ANSWER:
-- The date is a property of each individual ROW, so it must be filtered
-- before grouping (WHERE). The $1000 threshold is a property of the
-- GROUP's total, which only exists after grouping (HAVING).