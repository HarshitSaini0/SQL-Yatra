# Week 2: Aggregations & Grouping (+ LIMIT Catch-Up)

## 🎯 Learning Objectives
By the end of this session, you will be able to:
- Use `LIMIT` and `OFFSET` to control how many rows come back *(carried over from Week 1)*
- Replace any Excel Pivot Table with a `GROUP BY` query
- Use `SUM`, `COUNT`, `AVG`, `MIN`, `MAX`
- Filter grouped results with `HAVING` (and know why `WHERE` can't do it)
- Build "Top N" business reports using `ORDER BY` + `LIMIT`

---

## ⏪ Part 0: LIMIT Catch-Up (from Week 1)

### What it does
`LIMIT` caps the number of rows returned. It is always the **last** clause.

```sql
SELECT CustomerName, Sales
FROM superstore
ORDER BY Sales DESC
LIMIT 3;
```

**Excel equivalent:** Sort Z→A, then only look at the top 3 rows.

### Why it matters
| Reason | Explanation |
|---|---|
| Safety | On a 10-million-row table, `LIMIT 10` lets you test logic without freezing your machine |
| Business reports | "Top 5 products", "Bottom 3 regions" = `ORDER BY` + `LIMIT` |
| Speed | You see a sample instantly instead of waiting for everything |

### ⚠️ The Golden Rule
**`LIMIT` without `ORDER BY` is meaningless.** The database returns *any* 3 rows in whatever order it feels like. Always sort first, then limit.

### OFFSET (skip rows)
```sql
SELECT Region, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC
LIMIT 1 OFFSET 1;   -- skip 1st place, show 2nd place
```
`OFFSET 1` = "skip the first row". Great for finding 2nd/3rd place.

---

## 🧠 Part 1: The Mindset Shift — Pivot Table → SQL

Every Pivot Table you have ever built maps to exactly 4 SQL clauses:

| Pivot Table Zone | SQL Clause | Example |
|---|---|---|
| **Rows** (e.g. Region) | `GROUP BY` | `GROUP BY Region` |
| **Values** (e.g. Sum of Sales) | Aggregate function | `SUM(Sales)` |
| **Filters** (e.g. Year = 2023) | `WHERE` | `WHERE OrderDate >= '2023-01-01'` |
| **Value Filters** (e.g. Sum > 5000) | `HAVING` | `HAVING SUM(Sales) > 5000` |
| **Sort Largest→Smallest** | `ORDER BY ... DESC` | `ORDER BY total_sales DESC` |
| **Top 10 Filter** | `LIMIT` | `LIMIT 10` |

> 💡 **Say this out loud:** "A Pivot Table is a `GROUP BY` with a mouse. SQL is a Pivot Table with a keyboard."

---

## 🔢 Part 2: Aggregate Functions

| Function | What it does | Excel equivalent |
|---|---|---|
| `COUNT(*)` | Counts rows | `COUNTA` / row count |
| `COUNT(column)` | Counts non-NULL values in that column | `COUNTA` ignoring blanks |
| `COUNT(DISTINCT col)` | Counts unique values | "Remove Duplicates" then count |
| `SUM(col)` | Adds up values | `SUM` |
| `AVG(col)` | Average | `AVERAGE` |
| `MIN(col)` / `MAX(col)` | Smallest / largest | `MIN` / `MAX` |

**Key idea:** Aggregates take **many rows in → one number out**. The detail disappears; the summary remains.

```sql
SELECT COUNT(*) AS total_orders,
       SUM(Sales) AS total_revenue
FROM superstore;
```

---

## 🧩 Part 3: GROUP BY

Without `GROUP BY`, you get **one grand total**.
With `GROUP BY`, you get **one total per group**.

```sql
SELECT Region,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region;
```

### 🚨 The #1 Beginner Rule
> **Every column in your `SELECT` must either be inside an aggregate function, or listed in `GROUP BY`.**

✅ `SELECT Region, SUM(Sales) ... GROUP BY Region`
❌ `SELECT Region, CustomerName, SUM(Sales) ... GROUP BY Region`
*(Which customer would it show? The question makes no sense — that's why it's illegal.)*

### Grouping by 2 columns
```sql
GROUP BY Region, Category
```
= A Pivot Table with Region in Rows and Category nested underneath. One row per **combination**.

---

## 🔍 Part 4: WHERE vs HAVING (the interview question!)

| | `WHERE` | `HAVING` |
|---|---|---|
| Runs | **Before** grouping | **After** grouping |
| Filters | Individual raw rows | Group summaries |
| Can use aggregates? | ❌ No | ✅ Yes |
| Example | `WHERE Region = 'West'` | `HAVING SUM(Sales) > 4000` |

**Real-life analogy:**
- `WHERE` = "Only let people over 18 into the room."
- `HAVING` = "Now that they're grouped into teams, only show me teams with more than 5 people."

```sql
SELECT Region, SUM(Sales) AS total_sales
FROM superstore
WHERE OrderDate >= '2023-11-01'   -- filter ROWS first
GROUP BY Region
HAVING SUM(Sales) > 1000;         -- filter GROUPS second
```

---

## 📐 Part 5: The Logical Order of a Query

You **write** it in this order:
```
SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
```

The database **thinks** in this order:
```
1. FROM      → get the table
2. WHERE     → throw out unwanted rows
3. GROUP BY  → bucket the survivors
4. HAVING    → throw out unwanted buckets
5. SELECT    → calculate the summaries
6. ORDER BY  → sort them
7. LIMIT     → chop off the top N
```

**This explains everything:**
- Why `WHERE` can't use `SUM()` → step 2 happens before step 5.
- Why `LIMIT` goes last → you can only chop the list after it's sorted.

---

## 🏷️ Part 6: Aliases (AS)

```sql
SELECT Region,
       SUM(Sales) AS total_sales,
       ROUND(100.0 * SUM(Profit) / SUM(Sales), 2) AS profit_margin_pct
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;
```

**Why:** `SUM(Sales)` is an ugly column header. `total_sales` is self-documenting, and you can sort by it.

**Note:** SQLite lets you use aliases in `ORDER BY` and `HAVING`. Some other databases (SQL Server, Oracle) do **not** allow aliases in `HAVING` — there you must repeat `HAVING SUM(Sales) > 4000`.

---

## 🚨 Common Errors & Fixes

| Error | Cause | Fix |
|---|---|---|
| `misuse of aggregate function SUM()` | You put `SUM()` in `WHERE` | Move it to `HAVING` |
| Only 1 row returned with a random Region | You used `SUM()` with no `GROUP BY` | Add `GROUP BY Region` |
| `HAVING` seems to ignore rows oddly | You filtered rows that should've been filtered by `WHERE` | Row filter → `WHERE`; group filter → `HAVING` |
| Margin shows `0` | Integer division | Multiply by `100.0` (with a decimal) not `100` |
| `LIMIT` gives different rows each run | No `ORDER BY` | Always sort before limiting |

### ⚠️ SQLite-Specific Gotcha
In PostgreSQL, `SELECT Region, SUM(Sales) FROM superstore;` **throws an error**.
In SQLite it **silently returns one row with a random Region**. No error ≠ correct! Always double-check you added `GROUP BY`.

---

## 📋 One-Page Cheat Sheet

```sql
SELECT   Region,                              -- the grouping column
         COUNT(*)          AS order_count,    -- how many rows
         SUM(Sales)        AS total_sales,    -- revenue
         ROUND(AVG(Sales), 2) AS avg_order,   -- average
         MIN(Sales)        AS smallest,
         MAX(Sales)        AS largest
FROM     superstore
WHERE    Category = 'Technology'              -- filter ROWS
GROUP BY Region                               -- make buckets
HAVING   SUM(Sales) > 1000                    -- filter BUCKETS
ORDER BY total_sales DESC                     -- sort
LIMIT    3;                                   -- top 3
```