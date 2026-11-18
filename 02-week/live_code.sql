-- ============================================================
-- WEEK 2: LIVE CODING DEMO  ("I Do" phase — type this live!)
-- Dataset: superstore (15 rows)
-- Run one block at a time: highlight it, then press F5
-- ============================================================


-- ============================================================
-- BLOCK 0: LIMIT CATCH-UP (10 mins — we skipped this in Week 1)
-- ============================================================

-- 0a. LIMIT without ORDER BY: "give me any 3 rows"
SELECT CustomerName, Sales
FROM superstore
LIMIT 3;
-- WHY: Useful only for peeking at the shape of the data.
-- The 3 rows are arbitrary — never use this for a "Top 3" report.


-- 0b. LIMIT WITH ORDER BY: the real "Top 3"
SELECT CustomerName, Sales
FROM superstore
ORDER BY Sales DESC
LIMIT 3;
-- EXPECTED: Henry Ford 3000, Blacksmith Industries 2500, Frank Smith 1800
-- WHY: Sort first, THEN chop. Order matters.


-- 0c. Bottom 3 (flip the sort)
SELECT CustomerName, Sales
FROM superstore
ORDER BY Sales ASC
LIMIT 3;
-- EXPECTED: Eve Inc 75, Acme Corp 150, Grace Hopper 250


-- 0d. OFFSET = skip rows. "Who came 2nd?"
SELECT CustomerName, Sales
FROM superstore
ORDER BY Sales DESC
LIMIT 1 OFFSET 1;
-- EXPECTED: Blacksmith Industries 2500
-- WHY: OFFSET 1 skips 1st place, LIMIT 1 takes the next one.


-- ============================================================
-- BLOCK 1: AGGREGATES WITHOUT GROUP BY (grand totals)
-- ============================================================

-- 1a. The whole-company headline number
SELECT SUM(Sales) AS total_revenue
FROM superstore;
-- EXPECTED: 15125
-- Excel equivalent: =SUM(F:F) in a cell at the bottom


-- 1b. Many aggregates at once — the "dashboard header"
SELECT COUNT(*)        AS total_orders,
       SUM(Sales)      AS total_revenue,
       SUM(Profit)     AS total_profit,
       ROUND(AVG(Sales), 2) AS avg_order_value,
       MIN(Sales)      AS smallest_order,
       MAX(Sales)      AS largest_order
FROM superstore;
-- EXPECTED: 15 | 15125 | 2135 | 1008.33 | 75 | 3000
-- WHY: Many rows go IN, ONE row comes OUT. Detail is gone.


-- 1c. COUNT(*) vs COUNT(DISTINCT ...)
SELECT COUNT(*)                     AS total_rows,
       COUNT(DISTINCT Region)       AS regions_we_sell_in,
       COUNT(DISTINCT Category)     AS categories_we_sell,
       COUNT(DISTINCT CustomerName) AS unique_customers
FROM superstore;
-- EXPECTED: 15 | 4 | 3 | 15
-- WHY: 15 orders but only 4 regions. "How many?" needs precision:
--      how many ROWS vs how many UNIQUE things.


-- ============================================================
-- BLOCK 2: GROUP BY — the Pivot Table replacement
-- ============================================================

-- 2a. Revenue per region (Rows = Region, Values = Sum of Sales)
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region;
-- EXPECTED (unordered): Central 4275, East 4000, South 1650, West 5200
-- WHY: One output row per unique Region. This IS a Pivot Table.


-- 2b. Add sorting so it reads like a report
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;
-- EXPECTED: West 5200, Central 4275, East 4000, South 1650


-- 2c. The full regional scorecard
SELECT Region,
       COUNT(*)             AS order_count,
       SUM(Sales)           AS total_sales,
       SUM(Profit)          AS total_profit,
       ROUND(AVG(Sales), 2) AS avg_order_value
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;
-- EXPECTED:
-- West    | 5 | 5200 | 970 | 1040
-- Central | 3 | 4275 | 730 | 1425
-- East    | 4 | 4000 | 510 | 1000
-- South   | 3 | 1650 | -75 |  550
-- TEACHING POINT: South has decent sales but NEGATIVE profit.
--                 This is the insight a spreadsheet scroll would hide.


-- 2d. Profit margin per category (calculated column)
SELECT Category,
       SUM(Sales)  AS total_sales,
       SUM(Profit) AS total_profit,
       ROUND(100.0 * SUM(Profit) / SUM(Sales), 2) AS profit_margin_pct
FROM superstore
GROUP BY Category
ORDER BY profit_margin_pct DESC;
-- EXPECTED: Technology 10200/1800/17.65,
--           Office Supplies 775/135/17.42,
--           Furniture 4150/200/4.82
-- WHY 100.0 and not 100? The ".0" forces decimal math.
--      Integer division would silently round down to 0.
-- WHY SUM(Profit)/SUM(Sales) and not AVG(Profit/Sales)?
--      Weighted vs unweighted average — big orders should count more.


-- 2e. GROUP BY two columns = nested Pivot Table
SELECT Region,
       Category,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region, Category
ORDER BY Region, total_sales DESC;
-- EXPECTED: 12 rows (one per Region+Category combination)
-- WHY: GROUP BY Region, Category means "one bucket per PAIR".


-- ============================================================
-- BLOCK 3: HAVING — filtering the buckets
-- ============================================================

-- 3a. Only show regions doing more than $4000
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
HAVING SUM(Sales) > 4000
ORDER BY total_sales DESC;
-- EXPECTED: West 5200, Central 4275
-- WATCH OUT: East is EXACTLY 4000, so ">" excludes it.
--            Change to >= and East appears. Great precision lesson.


-- 3b. Only regions with more than 3 orders
SELECT Region,
       COUNT(*) AS order_count
FROM superstore
GROUP BY Region
HAVING COUNT(*) > 3
ORDER BY order_count DESC;
-- EXPECTED: West 5, East 4


-- 3c. Which regions are losing money overall?
SELECT Region,
       SUM(Profit) AS total_profit
FROM superstore
GROUP BY Region
HAVING SUM(Profit) < 0;
-- EXPECTED: South -75


-- ============================================================
-- BLOCK 4: WHERE + HAVING TOGETHER (the key distinction)
-- ============================================================

-- Business question:
-- "During the holiday season (Nov 1 – Dec 31), which regions
--  brought in more than $1000?"
SELECT Region,
       COUNT(*)   AS holiday_orders,
       SUM(Sales) AS holiday_sales
FROM superstore
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-12-31'  -- filter ROWS
GROUP BY Region
HAVING SUM(Sales) > 1000                              -- filter GROUPS
ORDER BY holiday_sales DESC;
-- EXPECTED: Central 2 orders/4200, West 3 orders/3250, East 2 orders/1400
-- (South's only holiday order was 900, so HAVING drops it)
-- WHY: WHERE shrinks the data BEFORE bucketing.
--      HAVING judges the buckets AFTER they're built.


-- ============================================================
-- BLOCK 5: PUTTING IT ALL TOGETHER — "Top N" report
-- ============================================================

-- "Top 2 regions by holiday revenue"
SELECT Region,
       SUM(Sales) AS holiday_sales
FROM superstore
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-12-31'
GROUP BY Region
HAVING SUM(Sales) > 1000
ORDER BY holiday_sales DESC
LIMIT 2;
-- EXPECTED: Central 4200, West 3250
-- Full pipeline: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT


-- ============================================================
-- BLOCK 6: "BREAK IT" MOMENTS (run these ON PURPOSE)
-- ============================================================

-- 6a. Aggregate in WHERE → ERROR: misuse of aggregate function
-- SELECT Region, SUM(Sales)
-- FROM superstore
-- WHERE SUM(Sales) > 4000
-- GROUP BY Region;
-- FIX: move it to HAVING. WHERE runs before sums exist.


-- 6b. Missing GROUP BY → NO error in SQLite, but WRONG answer!
-- SELECT Region, SUM(Sales)
-- FROM superstore;
-- Returns ONE row: a random Region next to the grand total 15125.
-- LESSON: "It ran" is not the same as "it's right".


-- 6c. Selecting a column you didn't group by
-- SELECT Region, CustomerName, SUM(Sales)
-- FROM superstore
-- GROUP BY Region;
-- SQLite picks an arbitrary CustomerName. Other databases error out.
-- FIX: either add CustomerName to GROUP BY, or drop it from SELECT.


-- 6d. Integer division trap
SELECT Category,
       SUM(Profit) / SUM(Sales) * 100 AS wrong_way
FROM superstore
GROUP BY Category;
-- Compare with 100.0 * SUM(Profit) / SUM(Sales) in block 2d.
-- On integer columns the "wrong_way" truncates to 0. Always use decimals.