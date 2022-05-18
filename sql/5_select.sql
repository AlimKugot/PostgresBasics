-- 1.1: where
SELECT company_name, city, order_name
FROM companies c,
     orders o,
     progress p
WHERE c.id = p.companies_id
  AND o.id = p.orders_id
ORDER BY city;


-- 1.1: join
SELECT company_name, city, order_name
FROM progress p
         INNER JOIN companies c ON c.id = p.companies_id
         INNER JOIN orders o on o.id = p.orders_id
ORDER BY city;


-- 2: count orders by status
SELECT s.name, COUNT(o.status)
FROM orders o
         INNER JOIN status s on s.id = o.status
GROUP BY (s.name);


-- 3: count order in every city
SELECT city, COUNT(*)
FROM companies
         INNER JOIN progress p on companies.id = p.companies_id
WHERE p.is_done = false
GROUP BY city;


-- 4: not planned company_names
SELECT company_name
FROM companies
WHERE id NOT IN
      (SELECT p.companies_id
       FROM progress p);

-- 5: cities contains >1 company
INSERT INTO companies(id, company_name, address, city, country)
VALUES ('99M99', 'demo', 'msc', 'Moscow', 'Russia');


SELECT DISTINCT c.city
FROM (
         SELECT city, COUNT(*)
         FROM companies
         GROUP BY city
         HAVING count(*) > 1) inner_request
         JOIN companies c ON c.city = inner_request.city;

DELETE FROM companies
WHERE id='99M99';



-- 6: company statistics: done or not_done
SELECT company_name,
       (
           SELECT count(*)
           FROM progress p1
           WHERE c.id = p1.companies_id
             AND is_done = true
       ) as done,
       (
           SELECT count(*)
           FROM progress p2
           WHERE c.id = p2.companies_id
             AND is_done = false
       ) as not_done
FROM companies c;