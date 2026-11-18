-- ============================================================
-- WEEK 2: HOMEWORK — "Kill the Pivot Table"
-- ------------------------------------------------------------
-- Instructions:
--   1. For each task, FIRST write the Pivot Table spec as a comment:
--         Rows = ?   Values = ?   Filter = ?   Sort = ?
--   2. Then write the SQL and run it in DB Browser.
--   3. Paste your actual result as a comment under each query.
--   4. Ctrl+S / Cmd+S to save, then commit & push to GitHub.
-- Due: before Week 3.
-- ============================================================


-- ------------------------------------------------------------
-- HOMEWORK 1: Pivot Table #1 — Category Summary
-- Rows = Category | Values = count of orders, sum of sales,
--                   average sales (2dp), min sales, max sales
-- Sort = total sales, largest first
-- Expected: Technology 6/10200/1700/500/3000
--           Furniture   5/4150/830/450/1200
--           Office Supp 4/775/193.75/75/300
-- ------------------------------------------------------------

-- Pivot spec (fill in):
-- Rows =
-- Values =
-- Filter =
-- Sort =

-- Your query:




-- ------------------------------------------------------------
-- HOMEWORK 2: Pivot Table #2 — Region × Category Matrix
-- Rows = Region, then Category | Values = sum of sales, sum of profit
-- Sort = Region A→Z, then sales largest first
-- Expected: 12 rows
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- HOMEWORK 3: The Value Filter (HAVING)
-- Task: Show only categories whose TOTAL PROFIT is greater than 150.
--       Display Category and total_profit, best first.
-- Expected: Technology 1800, Furniture 200
--           (Office Supplies = 135, so it is excluded)
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- HOMEWORK 4: The Loss Report (WHERE + GROUP BY + HAVING)
-- Task: Count loss-making orders (Profit < 0) per region.
--       Only show regions with 2 OR MORE loss-making orders.
--       Display Region and loss_orders.
-- Expected: South 2
-- Think: why is "Profit < 0" a WHERE and ">= 2" a HAVING?
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- HOMEWORK 5: The "Top 2" Board Report (ORDER BY + LIMIT)
-- Task: Show the top 2 categories by total sales.
--       Display only Category and total_sales.
-- Expected: Technology 10200, Furniture 4150
-- ------------------------------------------------------------

-- Your query:




-- ============================================================
-- BONUS (optional) — A peek at Week 4
-- Task: Total sales per MONTH.
-- Hint: SQLite has no DATE_TRUNC. Use SUBSTR(OrderDate, 1, 7)
--       to grab 'YYYY-MM' out of '2023-11-05'.
-- Expected: 9 month-rows; 2023-12 = 5600, 2023-11 = 4150
-- ============================================================

-- Your query:




-- ============================================================
-- SELF-CHECK BEFORE SUBMITTING
-- [ ] Every non-aggregated SELECT column appears in GROUP BY
-- [ ] Row filters in WHERE, group filters in HAVING
-- [ ] Every LIMIT has an ORDER BY above it
-- [ ] Aliases on all calculated columns
-- [ ] Keywords in CAPS, one clause per line
-- [ ] Ran every query and pasted the result as a comment
-- ============================================================