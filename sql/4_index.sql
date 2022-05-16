-- 1: create basic index
CREATE INDEX companies_city_index
    ON companies (city);

-- 2: create composite index
CREATE INDEX companies_city_country_index
    ON companies (city, country);



-- 3: create basic unique index
CREATE UNIQUE INDEX orders_name_index
    ON orders (order_name);

-- 4: create composite index with desc sorting
CREATE INDEX orders_cost_count_desc_index
    ON orders(count DESC, cost DESC);




-- 5: create composite index with nulls first
CREATE INDEX progress_dates_index
    ON progress(date_done ASC NULLS FIRST, created_date ASC NULLS FIRST);