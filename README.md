# Veloland — Sales Report

**Author:** Luka Gelashvili  
**Purpose:** Power BI portfolio project built on the AdventureWorks2019 SQL database. Created a fictional company "Veloland" and built a sales performance report from scratch — from SQL data extraction to Power BI dashboard.

---

## Repository contents

- **`Sales_report_veloland.sql`**  
  Full SQL query script with JOINs across multiple AdventureWorks2019 tables. Uses a single SELECT with function overview, commented for readability.

- **`Sales_report_Veloland_adventureWorks_2019.pbix`**  
  Power BI report (2 pages). Data sourced from the SQL query output.

---

## What each report page shows

- **Executive** — company-level sales KPIs, trends, revenue breakdowns, and interactive filters.
- **HR** — employee performance metrics and headcount overview.

Both pages include interactive filters (CTRL+click to activate). INFO buttons navigate to visual explanations.

---

## How to open

1. Install Power BI Desktop.
2. Open the `.pbix` file — data is embedded, no database connection needed.
3. To review the SQL logic, open `Sales_report_veloland.sql` in any text editor or SSMS.
