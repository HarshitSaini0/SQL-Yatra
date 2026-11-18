-- ============================================
-- WEEK 1: CHALLENGE SOLUTIONS
-- Instructor: Use these to verify student work
-- ============================================


-- SOLUTION 1: The Regional Manager
SELECT OrderID, Region, Sales
FROM superstore
WHERE Region = 'South';


-- SOLUTION 2: The Loss Leader
SELECT CustomerName, Category, Profit
FROM superstore
WHERE Profit < 0
ORDER BY Profit ASC;  -- ASC puts most negative first

-- Alternative (same result):
-- SELECT CustomerName, Category, Profit
-- FROM superstore
-- WHERE Profit < 0
-- ORDER BY Profit;  -- ASC is default


-- SOLUTION 3: The Name Search
SELECT CustomerName, Region
FROM superstore
WHERE CustomerName LIKE '%Corp%' 
   OR CustomerName LIKE '%Inc%';

-- Note: We need OR because a customer can't have BOTH "Corp" AND "Inc" in their name


-- SOLUTION 4: The Holiday Shopper
SELECT OrderDate, Sales
FROM superstore
WHERE OrderDate BETWEEN '2023-11-01' AND '2023-12-31';

-- Note: Dates in SQLite are stored as text in 'YYYY-MM-DD' format
-- BETWEEN works with dates just like it works with numbers


-- SOLUTION 5: The High-Value Client (Bonus)
SELECT CustomerName, Category, Sales
FROM superstore
WHERE Sales > 1000
ORDER BY Sales DESC
LIMIT 5;