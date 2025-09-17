SELECT 
    C.CalendarDate,
    COUNT(O.OrderID) AS OrdersCount
FROM Calendar C
LEFT JOIN Orders O ON O.OrderDate = C.CalendarDate
GROUP BY C.CalendarDate
ORDER BY C.CalendarDate
OPTION (MAXRECURSION 366);