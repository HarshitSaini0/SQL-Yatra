

# 🚀 The 15-Minute Local SQL Setup Guide
**Tool:** DB Browser for SQLite (Free, Open Source, Works on all OS)

### Step 1: Download & Install (5 Minutes)
Go to the official website: **[sqlitebrowser.org](https://sqlitebrowser.org/)** and download the version for your operating system.

*   **🪟 Windows:** Download the "Standard installer for 64-bit Windows". Run the `.exe` file and just click "Next" through the prompts.
*   **🍎 Mac:** Download the "macOS Universal" `.dmg` file. Open it and drag the app to your Applications folder. *(Note: If Mac gives a security warning, go to System Settings > Privacy & Security and click "Open Anyway").*
*   **🐧 Linux:** 
    *   *Ubuntu/Debian:* Open terminal and run `sudo apt install sqlitebrowser`
    *   *Fedora:* `sudo dnf install sqlitebrowser`
    *   *Flatpak:* Available on Flathub.

### Step 2: Create Your Local Database File (2 Minutes)
Unlike a cloud database, your database is just a single file sitting on your computer.

1. Open **DB Browser for SQLite**.
2. Click the **"New Database"** button in the top left corner.
3. A file explorer will open. Navigate to your **Desktop** (or a dedicated "SQL_Course" folder).
4. Name the file `MyLearningDB` and click **Save**.
5. A "Create Table" window will pop up. **Just click "Cancel"** (we are going to use a script to do this automatically).

### Step 3: Load the "Superstore" Data (3 Minutes) (Now this is opetional but recomended)
Now we will build the table and insert the data using the exact script from our Week 1 lesson.

1. At the top of the app, click the **"Execute SQL"** tab.
2. In the large blank white space (SQL 1), **copy and paste the entire code block below**:

```sql
-- 1. Create the table structure
CREATE TABLE superstore (
    OrderID TEXT,
    OrderDate DATE,
    Region TEXT,
    Category TEXT,
    Sales REAL,
    Profit REAL,
    CustomerName TEXT
);

-- 2. Insert 15 rows of realistic dummy data
INSERT INTO superstore (OrderID, OrderDate, Region, Category, Sales, Profit, CustomerName) VALUES
('ORD-001', '2023-01-15', 'West', 'Technology', 1500.00, 300.00, 'John Smith'),
('ORD-002', '2023-02-20', 'East', 'Furniture', 800.00, -50.00, 'Sarah Jenkins'),
('ORD-003', '2023-03-10', 'South', 'Office Supplies', 150.00, 45.00, 'Acme Corp'),
('ORD-004', '2023-11-05', 'West', 'Technology', 2500.00, 500.00, 'Blacksmith Industries'),
('ORD-005', '2023-12-20', 'Central', 'Furniture', 1200.00, 100.00, 'Alice Wonderland'),
('ORD-006', '2023-11-15', 'East', 'Office Supplies', 300.00, 10.00, 'Bob Smithers'),
('ORD-007', '2023-05-22', 'West', 'Furniture', 450.00, 20.00, 'Charlie Brown'),
('ORD-008', '2023-12-01', 'South', 'Technology', 900.00, -100.00, 'David Corp'),
('ORD-009', '2023-08-14', 'Central', 'Office Supplies', 75.00, 30.00, 'Eve Inc'),
('ORD-010', '2023-10-30', 'East', 'Technology', 1800.00, 400.00, 'Frank Smith'),
('ORD-011', '2023-11-25', 'West', 'Office Supplies', 250.00, 50.00, 'Grace Hopper'),
('ORD-012', '2023-12-15', 'Central', 'Technology', 3000.00, 600.00, 'Henry Ford'),
('ORD-013', '2023-09-10', 'South', 'Furniture', 600.00, -20.00, 'Ivy Corp'),
('ORD-014', '2023-11-10', 'East', 'Furniture', 1100.00, 150.00, 'Jack Smithson'),
('ORD-015', '2023-12-28', 'West', 'Technology', 500.00, 100.00, 'Karen Smith');
```

3. **CRITICAL STEP:** Click the **Play button (▶)** in the top right of the Execute SQL window (or press `F5` / `Ctrl+Enter` / `Cmd+Enter`). 
4. Look at the bottom panel ("Execution results"). It should say: *"Query executed successfully"*.

### Step 4: Verify Your Data (2 Minutes)
Let's make sure it worked!

1. Click on the **"Browse Data"** tab at the top.
2. In the "Table:" dropdown menu, select **`superstore`**.
3. You should now see a beautiful, Excel-like grid with all 15 rows of data! 🎉
4. **Save your work:** Press `Ctrl + S` (or `Cmd + S` on Mac) to save the database file. 

