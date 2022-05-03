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
    count      int                    NOT NULL CHECK (count > 0),
    CONSTRAINT orders_valid_id CHECK (id SIMILAR TO '\d{2}\-[A-Z]\-\d{2}')
);

CREATE TABLE progress
(
    companies_id varchar(5),
    orders_id    varchar(8),
    created_date         date DEFAULT CURRENT_DATE,
    is_done      bool DEFAULT FALSE,
    date_done    date,
    CONSTRAINT progress_valid_date CHECK (date_done > created_date),
    PRIMARY KEY (companies_id, orders_id),
    FOREIGN KEY (companies_id) REFERENCES companies (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,    FOREIGN KEY (orders_id) REFERENCES orders (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO companies(id, company_name, telephone)
VALUES ('11A11', 'vk.com', '+7-952-228-11-52');

INSERT INTO companies(id, company_name, address, telephone)
VALUES('11Z11', '');

INSERT INTO orders(id, order_name, cost, count)
VALUES ('11-A-11', 'vk-videos', 100, 2);

INSERT INTO progress(companies_id, orders_id, date_done)
VALUES ('11A11', '11-A-11', '2025-08-04');

SELECT *
FROM companies;

SELECT *
FROM orders;

SELECT *
FROM progress;