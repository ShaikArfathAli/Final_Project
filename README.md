# Final_Project

# Replace NULL Values in SQL (T-SQL)

## Problem Statement

You are given a table named `HZL_Table` with three columns: `Date`, `BU` (Business Unit), and `Value`. Some rows have `NULL` in the `Value` column. The goal is to **replace all NULLs** with the **most recent non-NULL value** within the same Business Unit, ordered by date.

## Table Structure

| Date       | BU   | Value |
|------------|------|-------|
| 2024-01-01 | hzl  | 3456  |
| 2024-02-01 | hzl  | NULL  |
| 2024-03-01 | hzl  | NULL  |
| 2024-04-01 | hzl  | NULL  |
| 2024-01-01 | SC   | 32456 |
| 2024-02-01 | SC   | NULL  |
| 2024-03-01 | SC   | NULL  |
| 2024-04-01 | SC   | NULL  |
| 2024-05-01 | SC   | 345   |
| 2024-06-01 | SC   | NULL  |

## Solution Approach

The T-SQL script:
- Creates the table
- Inserts the sample data
- Uses a `WITH` CTE and `OUTER APPLY` to forward-fill NULL values using the latest available non-NULL `Value` in each Business Unit (`BU`), based on the date.

## How to Run

1. Open SQL Server Management Studio (SSMS)
2. Run the script `replace_nulls.tsql`
3. The output will return a list with `NULL`s replaced by the last known value in the same BU.

      ## Output (Expected)
-----------------------------
| Date       | BU   | Value |
|------------|------|-------|
| 2024-01-01 | hzl  | 3456  |
| 2024-02-01 | hzl  | 3456  |
| 2024-03-01 | hzl  | 3456  |
| 2024-04-01 | hzl  | 3456  |
| 2024-01-01 | SC   | 32456 |
| 2024-02-01 | SC   | 32456 |
| 2024-03-01 | SC   | 32456 |
| 2024-04-01 | SC   | 32456 |
| 2024-05-01 | SC   | 345   |
| 2024-06-01 | SC   | 345   |

