-- 1: simple select view
CREATE VIEW order_members AS
SELECT company_name, city, order_name
FROM companies c,
     orders o,
     progress p
WHERE p.companies_id = c.id
  and p.orders_id = o.id;


-- 2: check first view
SELECT *
FROM order_members;


-- 3: insert into progress and check first view
INSERT INTO companies(id, company_name, city, address, country)
VALUES ('89A89', 'demo', 'new-york', 'lenina 2', 'Poland');

INSERT INTO progress(companies_id, orders_id, is_done)
VALUES ('89A89', '22-B-22', FALSE);

SELECT *
FROM order_members;

DELETE
FROM progress
WHERE companies_id = '89A89';
DELETE
FROM companies
WHERE id = '89A89';


-- 4: use view with another select
SELECT order_name
FROM order_members
WHERE city = 'Saint-Petersburg';


-- 5: save view and all data
CREATE MATERIALIZED VIEW order_members_MV
AS
SELECT *
FROM order_members;


-- 6: check view_mv
SELECT *
FROM order_members_MV;


-- 7: check view_mv with insert
INSERT INTO progress(companies_id, orders_id)
VALUES ('89A89', '33-C-33');

SELECT *
FROM order_members_MV;

-- 8: check view_mv with insert and refresh
REFRESH MATERIALIZED VIEW order_members_mv;

SELECT *
FROM order_members_mv;