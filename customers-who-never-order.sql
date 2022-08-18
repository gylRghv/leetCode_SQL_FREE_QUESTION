# Write your MySQL query statement below

#M1
select c.name as Customers
from Customers c
where c.id not in (select distinct customerId from orders);

#M2
SELECT Name AS 'Customers'
FROM Customers c
LEFT JOIN Orders o
ON c.Id = o.CustomerId
WHERE o.CustomerId IS NULL;
