# Week 1: Mindset Shift & Fetching Data

## 🎯 Learning Objectives
By the end of this session, you will be able to:
- Understand the difference between Excel (procedural) and SQL (declarative) thinking
- Write basic SELECT queries to retrieve specific data
- Filter data using WHERE, IN, BETWEEN, and LIKE
- Sort and limit results with ORDER BY and LIMIT

## 🧠 The Mindset Shift

### Excel vs SQL
| Excel (Procedural) | SQL (Declarative) |
|---|---|
| "Click cell A1, drag down, apply filter" | "Give me all customers in the West region" |
| Step-by-step, cell-by-cell | Describe WHAT you want, database figures out HOW |
| Like cooking a meal yourself | Like ordering at a restaurant |

## 📝 SQL Syntax Cheat Sheet

### Basic Structure
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column DESC
LIMIT number;
```

### Key Clauses
- **SELECT**: Choose which columns to display (like highlighting columns in Excel)
- **FROM**: Specify which table to query (like choosing which sheet to work on)
- **WHERE**: Filter rows based on conditions (like using filter dropdowns)
- **ORDER BY**: Sort results (like Sort A-Z or Z-A)
- **LIMIT**: Restrict number of rows returned (like only looking at top N rows)

### Filtering Operators
| Operator | Purpose | Example |
|---|---|---|
| `=` | Equals | `WHERE Region = 'West'` |
| `>` / `<` | Greater than / Less than | `WHERE Sales > 500` |
| `IN` | Matches any value in a list | `WHERE Region IN ('East', 'West')` |
| `BETWEEN` | Within a range (inclusive) | `WHERE Sales BETWEEN 100 AND 500` |
| `LIKE` | Pattern matching | `WHERE CustomerName LIKE '%Smith%'` |

### LIKE Wildcards
- `%` = zero, one, or multiple characters
- `_` = exactly one character
- Examples:
  - `LIKE 'A%'` → starts with A (Alice, Acme, Alice Wonderland)
  - `LIKE '%Corp'` → ends with Corp (Acme Corp, David Corp)
  - `LIKE '%Smith%'` → contains Smith anywhere (John Smith, Blacksmith Industries)

## 💡 Pro Tips
1. **Never use SELECT *** in production - it wastes memory and bandwidth
2. **SQL keywords in CAPS**, table/column names in lowercase for readability
3. **Always use LIMIT** when testing queries on large tables
4. **Semicolon (;)** at the end tells the database "I'm done giving instructions"

## 🚨 Common Errors
- **Forgetting quotes around text**: `WHERE Region = West` ❌ → `WHERE Region = 'West'` ✅
- **Case sensitivity**: Data values are often case-sensitive ('West' ≠ 'west')
- **Wrong clause order**: Must be SELECT → FROM → WHERE → ORDER BY → LIMIT
