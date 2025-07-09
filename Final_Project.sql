-- Problem: Replace NULL values in a column using previous non-NULL values within the same BU.

-- Step 1: Create the table
CREATE TABLE HZL_Table (
    [Date] DATE,
    BU VARCHAR(10),
    Value INT
);

-- Step 2: Insert sample data into the table
INSERT INTO HZL_Table ([Date], BU, Value) VALUES 
('2024-01-01', 'hzl', 3456),
('2024-02-01', 'hzl', NULL),
('2024-03-01', 'hzl', NULL),
('2024-04-01', 'hzl', NULL),
('2024-01-01', 'SC', 32456),
('2024-02-01', 'SC', NULL),
('2024-03-01', 'SC', NULL),
('2024-04-01', 'SC', NULL),
('2024-05-01', 'SC', 345),
('2024-06-01', 'SC', NULL);

-- Step 3: Query to replace NULLs with the last known non-NULL value per BU
WITH OrderedData AS (
    SELECT 
        Date,
        BU,
        Value
    FROM HZL_Table
)
SELECT 
    t.Date,
    t.BU,
    ISNULL(t.Value, prev.Value) AS Value
FROM OrderedData t
OUTER APPLY (
    SELECT TOP 1 Value
    FROM HZL_Table h
    WHERE h.BU = t.BU
      AND h.Date <= t.Date
      AND h.Value IS NOT NULL
    ORDER BY h.Date DESC
) prev
ORDER BY t.BU, t.Date;

-- Final Note:
-- This script fills in missing [Value] entries by carrying forward the last available
-- non-NULL value from the same business unit, ordered by date.
