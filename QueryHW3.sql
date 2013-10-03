-- Paul McCusker
-- Question 1
select
agents.city
from
agents
where
agents.aid in (
select 
orders.aid
from
orders
where
orders.cid in (
select
customers.cid
from
customers
where
customers.cid = 'c002'));


-- Questions 2

SELECT 
  agents.city
FROM 
  public.agents, 
  public.customers, 
  public.orders
WHERE 
  agents.aid = orders.aid AND
  orders.cid = customers.cid AND
  customers.cid = 'c002';

  -- Question 3 

  select distinct pid
from Products
where pid in
	(select pid
	from Orders
	where aid in

	(select aid 
	from Orders
	where aid in

	(select aid
	from Agents
	where cid in

	(select cid
	from Customers
	where city = 'Kyoto')
	)
	)
	)

-- Question 4

select distinct  o2.pid 
from  Orders o1, orders o2, Customers
where o1.cid = customers.cid 
and   o1.aid = o2.aid
and   customers.city = 'Kyoto'

-- Question 5

select distinct 
name 
from 
customers
where 
cid not in
(
	select cid
    from orders
    )

-- Question 6

select distinct c.name
from  orders o right outer join customers c
     on c.cid = o.cid 
     where o.cid is null 