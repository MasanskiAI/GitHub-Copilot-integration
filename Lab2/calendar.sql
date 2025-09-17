CREATE TABLE Calendar (
    CalendarDate DATE PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT,
    DayOfWeek INT,
    MonthName NVARCHAR(20),
    DayName NVARCHAR(20)
);

-- Populate Calendar table for 2024
DECLARE @d DATE = '2024-01-01';
WHILE @d <= '2024-12-31'
BEGIN
    INSERT INTO Calendar (CalendarDate, Year, Month, Day, DayOfWeek, MonthName, DayName)
    VALUES (
        @d,
        YEAR(@d),
        MONTH(@d),
        DAY(@d),
        DATEPART(WEEKDAY, @d),
        DATENAME(MONTH, @d),
        DATENAME(WEEKDAY, @d)
    );
    SET @d = DATEADD(DAY, 1, @d);
END