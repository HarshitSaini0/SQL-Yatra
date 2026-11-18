
-- ============================================
-- WEEK 1: LIVE CODING DEMO
-- Instructor: Type these live during the "I Do" phase
-- ============================================

-- 1. THE FOUNDATION: SELECT and FROM
-- Excel equivalent: Highlighting specific columns and copying them
SELECT CustomerName, Category, Sales 
FROM superstore;

-- Why not SELECT *? 
-- SELECT * FROM superstore;  -- Don't do this! It wastes memory and bandwidth


-- 2. FILTERING ROWS: WHERE
-- Excel equivalent: Clicking the filter dropdown on a column header
SELECT CustomerName, Region, Sales 
FROM superstore
WHERE Region = 'West';


-- 3. POWERFUL FILTERING OPERATORS

-- IN Operator
-- Excel equivalent: Checking multiple specific boxes in a filter dropdown
SELECT Category, Sales 
FROM superstore
WHERE Region IN ('West', 'East');

-- Why use IN? Cleaner than: WHERE Region = 'West' OR Region = 'East'


-- BETWEEN Operator
-- Excel equivalent: Number Filters > "Between..."
SELECT OrderID, Sales, Profit 
FROM superstore
WHERE Sales BETWEEN 1000 AND 2000;

-- Note: BETWEEN is INCLUSIVE (includes 1000 and 2000)


-- LIKE Operator (Pattern Matching)
-- Excel equivalent: Text Filters > "Contains..."
SELECT CustomerName, Region 
FROM superstore
WHERE CustomerName LIKE '%Smith%';

-- % is a wildcard that matches zero, one, or multiple characters
-- This finds: John Smith, Bob Smithers, Blacksmith Industries, Frank Smith, etc.


-- 4. SORTING AND RESTRICTING: ORDER BY and LIMIT
-- Excel equivalent: Sorting Z-A and then only looking at the top rows
SELECT Category, Sales, CustomerName
FROM superstore
WHERE Region = 'West'
ORDER BY Sales DESC 
LIMIT 3;

-- DESC = descending (highest first)
-- ASC = ascending (lowest first) - this is the default
-- LIMIT prevents your browser from crashing on large tables


-- 5. COMBINING EVERYTHING: The Complete Query
-- Business Request: "Top 5 highest sales for Furniture or Technology 
-- in West or East regions, between $200 and $1000"
SELECT Category, Region, Sales, CustomerName
FROM superstore
WHERE Category IN ('Furniture', 'Technology')
  AND Region IN ('West', 'East')
  AND Sales BETWEEN 200 AND 1000
ORDER BY Sales DESC
LIMIT 5;

-- Notice the logical order:
-- 1. SELECT what columns you want
-- 2. FROM which table
-- 3. WHERE to filter rows
-- 4. ORDER BY to sort
-- 5. LIMIT to restrict results


-- 6. BONUS: Multiple Conditions with AND/OR
SELECT CustomerName, Sales, Profit
FROM superstore
WHERE Region = 'East'
  AND Category = 'Technology'
  AND Profit > 0;

-- AND = both conditions must be true
-- OR = at least one condition must be true
