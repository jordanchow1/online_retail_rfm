-- Recency, Frequency, Monetary
SELECT CustomerID,
       datediff(CURDATE(), MAX(InvoiceDate)) AS Recency,
       COUNT(DISTINCT(InvoiceNo)) AS Frequency,
       SUM(UnitPrice*Quantity) AS Monetary
FROM online_retail_2
WHERE CustomerID != ''
GROUP BY CustomerID
ORDER BY 1, 2, 3 DESC, 4 DESC;


-- Cumulative Monetary Value
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