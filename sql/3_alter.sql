DROP TABLE IF EXISTS status;

ALTER TABLE companies
    -- 1: drop unique company_name
    DROP CONSTRAINT companies_company_name_key,
    -- 2: change default city name
    ALTER COLUMN city SET DEFAULT 'Novosibirsk',
    -- 3: rise up text size
    ALTER city SET DATA TYPE varchar(255),
    -- 4.1: add column
    ADD COLUMN country varchar(150);

-- 4.2: set data
UPDATE companies
SET country='Russia'
WHERE city = 'Moscow'
   OR city = 'Saint-Petersburg'
   OR city = 'Perm';

-- 4.3: set not null country
ALTER TABLE companies
    ALTER COLUMN country SET NOT NULL;

-- --------------------------------------

ALTER TABLE orders
    -- 1: rise up count type
    DROP CONSTRAINT orders_count_check,
    ADD CHECK (count > 0 AND count <= 15000),
    -- 2: cost may be null
    ALTER COLUMN cost DROP NOT NULL,
    -- 3: create status variable
    ADD COLUMN status varchar(20),
    ADD CONSTRAINT status_valid CHECK (status in ('Принят', 'В работе', 'Выполнен'));

-- 4: add values into orders
UPDATE orders
SET status='Принят'
WHERE id = '11-A-11';

UPDATE orders
SET status='В работе'
WHERE id = '22-B-22';

UPDATE orders
SET status='Выполнен'
WHERE id = '33-C-33';


-- 5.1: change status structure
CREATE TABLE status
(
    id   INTEGER PRIMARY KEY,
    name varchar(20) NOT NULL UNIQUE
);

-- 5.2: insert into status data
INSERT INTO status
VALUES (1, 'Принят'),
       (2, 'В работе'),
       (3, 'Выполнен');

-- 5.3: clean up
ALTER TABLE orders
    DROP CONSTRAINT status_valid,
    ALTER COLUMN status SET DATA TYPE INTEGER
        USING (CASE
                   WHEN status = 'Принят' THEN 1
                   WHEN status = 'В работе' THEN 2
                   WHEN status = 'Выполнен' THEN 3
        END),
    ADD FOREIGN KEY (status) REFERENCES status (id);