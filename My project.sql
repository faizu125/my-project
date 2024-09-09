create schema detail_shope;
use detail_shope;

use retailshop;

CREATE TABLE OnlineRetail (
    InvoiceNo VARCHAR(10),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(50)
);
select * from online_retail
;
## 2. Beginner Queries
  #  - Distribution of Order Values Across All Customers:
  
   select CustomerID, SUM(UnitPrice * Quantity) AS OrderValue
     FROM OnlineRetail
     GROUP BY CustomerID;
     
     
   # Number of Unique Products Purchased by Each Customer:
   
  SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProducts
     FROM OnlineRetail
     GROUP BY CustomerID;

 # Customers with a Single Purchase:*
 
    SELECT CustomerID
     FROM OnlineRetail
     GROUP BY CustomerID
     HAVING COUNT(DISTINCT InvoiceNo) = 1;
     
	# *Commonly Purchased Products Together

          SELECT p1.StockCode, p2.StockCode, COUNT(*) AS Frequency
     FROM OnlineRetail p1
     JOIN OnlineRetail p2 ON p1.InvoiceNo = p2.InvoiceNo AND p1.StockCode <> p2.StockCode
     GROUP BY p1.StockCode, p2.StockCode
     ORDER BY Frequency DESC;

# 3. Advanced Queries
   # *Customer Segmentation by Purchase Frequency

    SELECT CustomerID, COUNT(*) AS PurchaseFrequency,
     CASE
         WHEN COUNT(*) > 50 THEN 'High'
         WHEN COUNT(*) BETWEEN 20 AND 50 THEN 'Medium'
         ELSE 'Low'
     END AS FrequencySegment
     FROM OnlineRetail
     GROUP BY CustomerID;

   # *Average Order Value by Country:
   
      SELECT Country, AVG(UnitPrice * Quantity) AS AverageOrderValue
     FROM OnlineRetail
     GROUP BY Country;

 # Customer Churn Analysis:
 
      SELECT CustomerID
     FROM OnlineRetail
     GROUP BY CustomerID
     HAVING MAX(InvoiceDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
     
      # Product Affinity Analysis:
      
           SELECT p1.StockCode AS ProductA, p2.StockCode AS ProductB, COUNT(*) AS Frequency
     FROM OnlineRetail p1
     JOIN OnlineRetail p2 ON p1.InvoiceNo = p2.InvoiceNo AND p1.StockCode <> p2.StockCode
     GROUP BY ProductA, ProductB
     HAVING Frequency > 10
     ORDER BY Frequency DESC;

 # Time-based Analysis:
 
  SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(UnitPrice * Quantity) AS TotalSales
     FROM OnlineRetail
     GROUP BY Year, Month
     ORDER BY Year, Month;