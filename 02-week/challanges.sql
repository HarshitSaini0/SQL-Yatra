-- ============================================================
-- WEEK 2: HANDS-ON CHALLENGES  ("You Do" phase — 45 mins)
-- Rules:
--   1. Before writing SQL, say the Excel version out loud:
--      "Rows = ___, Values = ___, Filter = ___"
--   2. Stuck for 3+ minutes? Ask for a HINT, not the answer.
--   3. Error message? Paste it into your AI assistant first.
-- ============================================================


-- ------------------------------------------------------------
-- CHALLENGE 1: LIMIT warm-up  (Week 1 carry-over)
-- Task: Show the 3 most profitable individual transactions.
--       Display CustomerName, Sales, Profit.
-- Expected: Henry Ford (600), Blacksmith Industries (500), Frank Smith (400)
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- CHALLENGE 2: The CEO headline
-- Task: In ONE row, show total orders, total revenue, total profit,
--       and average order value rounded to 2 decimals.
--       Use aliases so the headers look professional.
-- Expected: 15 | 15125 | 2135 | 1008.33
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- CHALLENGE 3: The regional Pivot Table
-- Task: Show total sales per region, highest first.
--       Alias the sum as total_sales.
-- Expected: West 5200, Central 4275, East 4000, South 1650
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- CHALLENGE 4: The margin report
-- Task: For each category show total_sales, total_profit,
--       and profit_margin_pct = 100 * profit / sales, rounded to 2.
--       Sort by margin, best first.
-- Expected: Technology 17.65 | Office Supplies 17.42 | Furniture 4.82
-- Hint: use 100.0 (with the decimal!)
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- CHALLENGE 5: HAVING practice
-- Task: Show only regions with MORE THAN 3 orders.
--       Display Region and order_count, busiest first.
-- Expected: West 5, East 4
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- CHALLENGE 6: The full pipeline (WHERE + GROUP BY + HAVING + LIMIT)
-- Task: During the holiday season (2023-11-01 to 2023-12-31),
--       show the TOP 2 regions by sales, but only if that region
--       made more than $1000 in the period.
--       Display Region, holiday_orders, holiday_sales.
-- Expected: Central (2 orders, 4200), West (3 orders, 3250)
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- BONUS CHALLENGE: Who came second?
-- Task: Find the region with the SECOND highest total sales.
--       Do it with ORDER BY + LIMIT + OFFSET (no subqueries yet!)
-- Expected: Central 4275
-- ------------------------------------------------------------

-- Your query:




-- ------------------------------------------------------------
-- REFLECTION (write as a comment, no code needed)
-- Q: In Challenge 6, why must the date filter be in WHERE
--    and the $1000 filter be in HAVING?
-- A:
-- ------------------------------------------------------------