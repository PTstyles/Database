-- Paul McCusker

-- Question 1

SELECT agents.city
FROM agents
WHERE agents.aid IN
    (SELECT orders.aid
     FROM orders
     WHERE orders.cid IN
         (SELECT customers.cid
          FROM customers
          WHERE customers.cid = 'c002'));

 -- Questions 2

SELECT agents.city
FROM public.agents,
     public.customers,
     public.orders
WHERE agents.aid = orders.aid
  AND orders.cid = customers.cid
  AND customers.cid = 'c002';

 -- Question 3

SELECT DISTINCT pid
FROM Products
WHERE pid IN
    (SELECT pid
     FROM Orders
     WHERE aid IN
         (SELECT aid
          FROM Orders
          WHERE aid IN
              (SELECT aid
               FROM Agents
               WHERE cid IN
                   (SELECT cid
                    FROM Customers
                    WHERE city = 'Kyoto'))));

 -- Question 4

SELECT DISTINCT o2.pid
FROM Orders o1,
     orders o2,
     Customers
WHERE o1.cid = customers.cid
  AND o1.aid = o2.aid
  AND customers.city = 'Kyoto';

 -- Question 5

SELECT DISTINCT name
FROM customers
WHERE cid NOT IN
    (SELECT cid
     FROM orders);

 -- Question 6

SELECT DISTINCT c.name
FROM orders o
RIGHT OUTER JOIN customers c ON c.cid = o.cid
WHERE o.cid IS NULL -- Question 7

  SELECT DISTINCT c.name ,
                  a.name
  FROM orders o ,
       agents a,
       customers c WHERE o.aid = a.aid
  AND o.cid = c.cid
  AND a.city = c.city;

 -- Question 8

SELECT DISTINCT c.name ,
                a.name ,
                c.city
FROM customers c,
     agents a
WHERE c.city = a.city;

 -- Question 9

SELECT DISTINCT c.name,
                c.city
FROM customers c
WHERE city IN
    (SELECT city
     FROM products
     GROUP BY city
     ORDER BY count(city) ASC LIMIT 1);

 -- Question 10

SELECT DISTINCT c.name,
                c.city
FROM customers c
WHERE city IN
    (SELECT city
     FROM products
     GROUP BY city
     ORDER BY count(city) DESC LIMIT 1); -- takes a single city 

 -- Question 11

SELECT c.name,
       c.city
FROM customers c
WHERE city IN
    (SELECT city
     FROM products
     GROUP BY city HAVING count(city) IN
       (SELECT count(city)
        FROM products
        GROUP BY city
        ORDER BY count(city) DESC LIMIT 1)) 

 -- Question 12

  SELECT p.name
  FROM products p
GROUP BY name HAVING AVG (priceUSD) >
  (SELECT AVG(priceUSD)
   FROM products) 

  -- Question 13

SELECT c.name,
       o.pid,
       o.dollars
FROM customers c
INNER JOIN orders o ON c.cid = o.cid
INNER JOIN products p ON p.pid = o.pid
ORDER BY o.dollars DESC 

-- Question 14

SELECT c.name,
       coalesce (SUM (o.dollars), 0)
FROM customers c
LEFT OUTER JOIN orders o ON c.cid = o.cid
GROUP BY c.cid
ORDER BY c.name ASC 

-- Question 15

SELECT c.name,
       a.name,
       p.pid
FROM customers c,
     agents a ,
     products p,
     orders o
WHERE o.cid = c.cid
  AND o.aid = a.aid
  AND p.pid = o.pid
  AND a.city = 'New York' 

  -- Question 16

  SELECT o.ordno, o.dollars, (p.priceUSD * o.qty) - ((p.priceUSD * o.qty) * (c.discount/ 100))
  FROM orders o,
       products p,
       customers c WHERE c.cid = o.cid
  AND p.pid = o.pid
  AND o.dollars <> (p.priceUSD * o.qty) - ((p.priceUSD * o.qty) * (c.discount/ 100)) 

  -- Question17

  UPDATE orders
  SET dollars = 10 WHERE dollars = 500;

