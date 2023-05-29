use supply_chain;

# 1.Company sells the product at different discounted rates. Refer actual product price in product table and selling price in the order item table. 
# Write a query to find out total amount saved in each order then display the orders from highest to lowest amount saved. 

SELECT 
    oi.OrderId,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    SUM((p.UnitPrice - oi.UnitPrice) * oi.Quantity) AS TotalAmountSaved
FROM
    OrderItem oi
        JOIN
    Orders o ON oi.OrderId = o.Id
        JOIN
    Customer c ON o.CustomerId = c.Id
        JOIN
    Product p ON oi.ProductId = p.Id
GROUP BY oi.OrderId , o.OrderDate , c.FirstName , c.LastName
ORDER BY TotalAmountSaved DESC;

#2	Mr. Kavin want to become a supplier. He got the database of "Richard's Supply" for reference. Help him to pick: 
#a. List few products that he should choose based on demand.
#b. Who will be the competitors for him for the products suggested in above question.

#a. 
SELECT 
    p.ProductName, SUM(oi.Quantity) AS Totalorders
FROM
    OrderItem oi
        JOIN
    Product p ON oi.ProductId = p.Id
GROUP BY p.ProductName
ORDER BY Totalorders DESC
LIMIT 10;


#b.
WITH top_products AS (
    SELECT ProductName, SUM(Quantity) AS Totalorders
    FROM OrderItem oi
    JOIN Product p ON oi.ProductId = p.Id
    GROUP BY ProductName
    ORDER BY Totalorders DESC
    LIMIT 10
), supplier_products AS (
    SELECT s.CompanyName, p.ProductName
    FROM Supplier s
    JOIN Product p ON s.Id = p.SupplierId
    WHERE p.ProductName IN (SELECT ProductName FROM top_products)
)
SELECT *
FROM supplier_products;


#3.	Create a combined list to display customers and suppliers details considering the following criteria 
#Both customer and supplier belong to the same country
#Customer who does not have supplier in their country
#Supplier who does not have customer in their country

SELECT c.FirstName, c.LastName, c.Country,
s.Country , s.CompanyName
FROM Customer c
LEFT JOIN Supplier s
ON c.Country = s.Country
UNION
SELECT c.FirstName, c.LastName, c.Country,
s.Country , s.CompanyName
FROM Customer c
RIGHT JOIN Supplier s
ON c.Country = s.Country;

#4. Every supplier supplies specific products to the customers. Create a view of suppliers and total sales made by their products.
CREATE VIEW supplier_sales AS
    SELECT 
        s.Country,
        s.contactname AS SupplierName,
        p.ProductName,
        SUM(oi.Quantity) AS TotalSales
    FROM
        Supplier s
            JOIN
        Product p ON s.Id = p.SupplierId
            JOIN
        OrderItem oi ON p.Id = oi.ProductId
    GROUP BY s.Country , s.contactname , p.ProductName;

SELECT * FROM supplier_sales;

SELECT Country, SupplierName, TotalSales
FROM (
    SELECT Country, SupplierName, TotalSales, 
           ROW_NUMBER() OVER (PARTITION BY Country ORDER BY TotalSales DESC) AS SalesRank
    FROM supplier_sales
) AS sales_ranked
WHERE SalesRank <= 2;


#5. Find out for which products, UK is dependent on other countries for the supply. List the countries which are supplying these products in the same list.

SELECT 
    p.ProductName, c.Country AS SupplyingCountry
FROM
    Product p
        JOIN
    OrderItem oi ON oi.ProductId = p.Id
        JOIN
    Orders o ON oi.OrderId = o.Id
        JOIN
    Customer c ON o.CustomerId = c.Id
WHERE
    c.Country NOT LIKE 'UK'
        AND p.Id IN (SELECT 
            oi1.ProductId
        FROM
            OrderItem oi1
                JOIN
            Orders o1 ON oi1.OrderId = o1.Id
                JOIN
            Customer c1 ON o1.CustomerId = c1.Id
        WHERE
            c1.Country = 'UK'
        GROUP BY oi1.ProductId
        HAVING SUM(oi1.Quantity) < SUM(oi.Quantity) / 2)
ORDER BY p.ProductName, c.Country;

#6.	Create two tables as ‘customer’ and ‘customer_backup’ as follow - 
#‘customer’ table attributes - Id, FirstName,LastName,Phone
#‘customer_backup’ table attributes - Id, FirstName,LastName,Phone

#Create a trigger in such a way that It should insert the details into the  ‘customer_backup’ table when you delete the record from the ‘customer’ table automatically.


CREATE TABLE customer1 (
  Id INT NOT NULL PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Phone VARCHAR(20) NOT NULL
);

CREATE TABLE customer_backup (
  Id INT NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  BackupTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$
CREATE TRIGGER customer_backup_trigger 
AFTER DELETE ON customer1
FOR EACH ROW
BEGIN
    INSERT INTO customer_backup (Id, FirstName, LastName, Phone) 
    VALUES (OLD.Id, OLD.FirstName, OLD.LastName, OLD.Phone);
END$$
DELIMITER ;

-- Growth Strategy
-- Implement a more effective discount strategy: We found that the discount strategy needs improvement. Company can work on optimizing the discounts to increase overall revenue while keeping the customers happy.
-- Encourage local supplier-customer collaborations: We can see there is a gap in local supplier-customer collaborations. stakeholders can work on promoting collaborations between local suppliers and customers to reduce transportation costs, increase delivery speed, and create a mutually beneficial relationship.
-- Focus on the top products and suppliers : We can see the top-performing suppliers and products. We can focus on these suppliers and products to maintain their popularity and ensure a continuous supply.
-- Improve inventory management: We can see that there are instances of overstocking and stockouts. Company can work on optimizing inventory management to avoid stockouts and reduce overstocking, which can lead to waste and unnecessary storage costs.
-- Explore new markets: We can see that some products are being imported from other countries. Company can explore new markets to identify new suppliers and customers for these products, which can help reduce the dependency on other countries.
-- Encourage supplier-customer collaborations across borders: We can see that there are products that the UK is dependent on other countries for products Now company can work on promoting collaborations between international suppliers and UK-based customers to reduce dependency on other countries and ensure a steady supply.


 