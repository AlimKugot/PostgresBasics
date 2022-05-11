DROP TABLE IF EXISTS progress;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS orders;

CREATE TABLE companies
(
    id           varchar(5) PRIMARY KEY NOT NULL,
    company_name varchar(100)           NOT NULL UNIQUE,
    city         varchar(100)           NOT NULL DEFAULT 'Moscow',
    address      varchar(350),
    telephone    varchar(20) CHECK (telephone SIMILAR TO '\+\d\-\d{3}\-\d{3}-\d{2}\-\d{2}'),
    CONSTRAINT companies_valid_id CHECK (id SIMILAR TO '\d{2}[A-Z]\d{2}')
);

CREATE TABLE orders
(
    id         varchar(8) PRIMARY KEY NOT NULL,
    order_name varchar(100)           NOT NULL,
    cost       numeric                NOT NULL CHECK (cost > 0),
    count      int                    NOT NULL CHECK (count > 0 AND count < 9999),
    CONSTRAINT orders_valid_id CHECK (id SIMILAR TO '\d{2}\-[A-Z]\-\d{2}')
);

CREATE TABLE progress
(
    companies_id varchar(5),
    orders_id    varchar(8),
    created_date date NOT NULL DEFAULT CURRENT_DATE,
    is_done      bool          DEFAULT FALSE,
    date_done    date,
    CONSTRAINT progress_valid_date CHECK (date_done > created_date),
    PRIMARY KEY (companies_id, orders_id),
    FOREIGN KEY (companies_id) REFERENCES companies (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (orders_id) REFERENCES orders (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);



-- 1: insert into companies
INSERT INTO companies(id, company_name, city, address, telephone)
VALUES ('11A11', 'vk', 'Saint-Petersburg', '28 Nevskiy Ave., 5th Floor', '+7-921-111-11-11');
INSERT INTO companies(id, company_name, address, telephone)
VALUES ('22B22', 'yandex', '16 Lva Tolstogo Street', '+7-800-250-96-39');
INSERT INTO companies(id, company_name, city, address, telephone)
VALUES ('33C33', 'miro', 'Perm', 'Решетниковский спуск, 1Щ', '+1-111-111-11-11');

-- 2: insert into orders
INSERT INTO orders(id, order_name, cost, count)
VALUES ('11-A-11', 'vk-videos', 10000000, 1);
INSERT INTO orders(id, order_name, cost, count)
VALUES ('22-B-22', 'yandex-drive', 888888, 100);
INSERT INTO orders(id, order_name, cost, count)
VALUES ('33-C-33', 'miro-desks', 99999, 5);

-- 3: change company phone number
UPDATE companies
SET telephone='+7-888-888-88-88'
WHERE company_name = 'vk';

-- 4: change cost and count for order
UPDATE orders
SET cost=cost * 2,
    count=count / 2
WHERE order_name = 'miro-desks';

-- 5: insert into progress
INSERT INTO progress(companies_id, orders_id, created_date)
VALUES ('11A11', '11-A-11', '2020-01-12');
INSERT INTO progress(companies_id, orders_id, created_date)
VALUES ('22B22', '22-B-22', '2021-05-27');
INSERT INTO progress(companies_id, orders_id, created_date)
VALUES ('33C33', '33-C-33', '2018-06-26');

-- 6: set done_date progress
UPDATE progress
    SET date_done='2021-05-10',
            is_done=true
    WHERE companies_id='11A11';

-- 7: delete
DELETE FROM progress
    WHERE companies_id='33C33';


-- 8: update company_id and check progress UPDATE CASCADE
UPDATE companies
    SET id='99Z99'
    WHERE id='11A11';

-- 9: delete company_id and check progress DELETE CASCADE
DELETE FROM companies
    WHERE id='22B22';

SELECT *
FROM companies;
SELECT *
FROM orders;
SELECT *
FROM progress;