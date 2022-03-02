-- Cumulative Monetary Value --
WITH C AS (
SELECT *, UnitPrice*Quantity AS Amount
FROM online_retail_2
WHERE CustomerID != ''
ORDER BY InvoiceDate)

SELECT CustomerID AS Customer, Country, InvoiceDate, Quantity, UnitPrice, Amount, SUM(Amount)
OVER (
	PARTITION BY CustomerID
    ORDER BY InvoiceDate
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS CumulativeAmount
FROM C
ORDER BY InvoiceDate;