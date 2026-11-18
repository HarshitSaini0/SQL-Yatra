### 🏢 Part 1: The 3 "Rooms" of DB Browser (How to Use It)

When you open the app, look at the tabs at the very top. This is your workflow.

#### 1. The "Database Structure" Tab (The Blueprint)
*   **What it is:** This is the table of contents. It shows you what tables exist in your database (e.g., `superstore`). 
*   **How to use it:** Click on a table name here to see its "schema" (the columns, data types, and rules). *You don't write queries here; you just look at the blueprint.*

#### 2. The "Browse Data" Tab (The Excel View)
*   **What it is:** This is the visual grid. It looks exactly like Excel.
*   **How to use it:** 
    1. Click the **Browse Data** tab.
    2. Use the **"Table:"** dropdown in the middle to select `superstore`.
    3. You can scroll through the data, click on cells, and even manually edit a cell by double-clicking it (like Excel).
    *   *Instructor Tip:* Tell your student, "Whenever you are confused about what your SQL query is doing, come to this tab to look at the raw truth of the data."

#### 3. The "Execute SQL" Tab (The Command Center)
*   **What it is:** This is where the magic happens. This is where you type your `SELECT`, `FROM`, and `WHERE` commands.
*   **How to use it:**
    1. Click the **Execute SQL** tab.
    2. Type your query in the top white box.
    3. Click the **Play button (▶)** (or press `F5`) to run it.
    4. The results will appear in the bottom half of the screen in a grid.

#### 🚨 THE MOST IMPORTANT BUTTON: "Write Changes"
*   **The Trap:** If you manually edit data in the "Browse Data" tab, or if you run an `INSERT` or `UPDATE` command in the "Execute SQL" tab, **it does not save to the hard drive automatically.** It is only saved in the app's temporary memory.
*   **The Fix:** Look at the top toolbar for the **"Write Changes"** button (it looks like a floppy disk with a green checkmark). **You must click this to permanently save your changes to the `.db` file.** If you close the app without clicking this, your edits are lost!

---

### ⌨️ Part 2: Essential Shortcuts (Speed & Efficiency)

Memorize these. They will save you and your student hundreds of hours over the 6-week course.

#### 🏃‍♂️ Execution & Navigation
| Action | Windows / Linux | Mac |
| :--- | :--- | :--- |
| **Run the highlighted/current query** | `F5` or `Ctrl` + `Enter` | `Cmd` + `Return` |
| **Open a new SQL tab** (Great for testing) | `Ctrl` + `T` | `Cmd` + `T` |
| **Close current SQL tab** | `Ctrl` + `W` | `Cmd` + `W` |
| **Switch between SQL tabs** | `Ctrl` + `Tab` | `Cmd` + `Option` + `Arrow` |

#### ✍️ Editing & Formatting (In the SQL Editor)
| Action | Windows / Linux | Mac |
| :--- | :--- | :--- |
| **Auto-complete column/table names** | `Ctrl` + `Space` | `Cmd` + `Space` |
| **Find and Replace text** | `Ctrl` + `F` | `Cmd` + `F` |
| **Duplicate the current line** | `Ctrl` + `D` | `Cmd` + `D` |
| **Move line Up / Down** | `Alt` + `Up/Down Arrow` | `Option` + `Up/Down Arrow` |
| **Comment out a line** (Turns it grey) | `Ctrl` + `/` | `Cmd` + `/` |
| **Undo / Redo** | `Ctrl` + `Z` / `Y` | `Cmd` + `Z` / `Shift+Cmd+Z` |

#### 💾 Saving
| Action | Windows / Linux | Mac |
| :--- | :--- | :--- |
| **Write Changes (Save to disk)** | `Ctrl` + `S` | `Cmd` + `S` |

---

### 💡 Part 3: Golden Rules for Writing SQL (Teach this on Day 1)

Shortcuts are great, but *how* you type SQL matters just as much for readability. Teach your student these 3 formatting rules immediately:

**1. The "Capitalization Rule"**
Always type **SQL KEYWORDS IN ALL CAPS**, and type *table and column names in lowercase*. 
*   **Bad:** `select category, sales from superstore where region = 'West'`
*   **Good:** `SELECT category, sales FROM superstore WHERE region = 'West'`
*   *Why?* It allows the human eye to instantly separate the "instructions" from the "data."

**2. The "Line Break Rule"**
Never write a query on a single line. Put every major clause on a new line.
```sql
SELECT category, sales 
FROM superstore 
WHERE region = 'West' 
  AND profit > 0;
```
*   *Why?* When a query breaks or gives an error, line breaks make it 10x easier to spot the typo.

**3. The "Comment Rule"**
Use `--` to leave notes to yourself (or your student) inside the code. The database ignores anything after `--`.
```sql
-- This query finds high-profit tech sales in the West
SELECT category, sales 
FROM superstore 
WHERE region = 'West' 
  AND category = 'Technology'; -- Filtering for tech only
```

---

### 🎯 Your First 5-Minute "Test Drive"
*If you want to make sure everything is working perfectly right now, do this:*

1. Open DB Browser and load your `MyLearningDB.db` file.
2. Go to **Execute SQL**.
3. Type this: `SELECT * FROM superstore;`
4. Press **F5**. (You should see all 15 rows).
5. Now, change it to: `SELECT * FROM superstore WHERE Region = 'East';`
6. Press **F5**. (You should see only the East rows).
7. Press **Ctrl+S** (or Cmd+S) just to build the muscle memory of saving!
