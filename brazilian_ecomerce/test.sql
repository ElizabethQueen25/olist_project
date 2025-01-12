SELECT *
FROM olist_customers_dataset
LIMIT 20

SELECT *
FROM olist_geolocation_dataset
LIMIT 20

SELECT *
FROM olist_order_items_dataset
LIMIT 20

SELECT *
FROM olist_order_payments_dataset
LIMIT 20

SELECT *
FROM olist_order_reviews_dataset
LIMIT 20

SELECT *
FROM olist_orders_dataset
LIMIT 20

SELECT *
FROM olist_products_dataset
LIMIT 20

SELECT *
FROM olist_sellers_dataset
LIMIT 20

SELECT *
FROM product_category_name_translation
LIMIT 20

-- veryfying the uniqueness of each column
--- Table customers
SELECT customer_zip_code_prefix, COUNT(*)
FROM olist_customers_dataset AS customers
GROUP BY customer_zip_code_prefix
HAVING COUNT(*) > 1;
--- Table geolocation
SELECT geolocation_zip_code_prefix, COUNT(*)
FROM olist_geolocation_dataset AS geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;
--- Table order_reviews
SELECT review_id, COUNT(*)
FROM olist_order_reviews_dataset AS order_reviews
GROUP BY review_id
HAVING COUNT(*) >1
---Table order_items
SELECT order_id, COUNT(*)
FROM olist_orders_dataset AS orders_dataset
GROUP BY order_id
HAVING COUNT(*) >1;
---Table products
SELECT product_id, COUNT(*)
FROM olist_products_dataset AS products
GROUP BY product_id
HAVING COUNT(*) >1;
---Table sellers
SELECT seller_id, COUNT(*)
FROM olist_sellers_dataset AS sellers
GROUP BY seller_id
HAVING COUNT(*)>1;

-- Stablishing the primary keys for each table
--- Table customers
ALTER TABLE olist_customers_dataset 
ADD PRIMARY KEY (customer_id)

DESCRIBE olist_customers_dataset;
--- Table geolocation / no se puede
ALTER TABLE olist_geolocation_dataset  
ADD PRIMARY KEY(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng)
--- Table order_items
ALTER TABLE olist_order_items_dataset 
ADD PRIMARY KEY(order_id, order_item_id)
--- Table order_payments
ALTER TABLE olist_order_payments_dataset
ADD PRIMARY KEY(order_id, payment_sequential)
--- Table order_reviews
ALTER TABLE olist_order_reviews_dataset
ADD PRIMARY KEY(review_id, order_id)
--- Table orders
ALTER TABLE olist_orders_dataset
ADD PRIMARY KEY(order_id)
--- Table products
ALTER TABLE olist_products_dataset
ADD PRIMARY KEY(product_id)
--- Table sellers
ALTER TABLE olist_sellers_dataset
ADD PRIMARY KEY(seller_id)
--- Table product_name
ALTER TABLE product_category_name_translation
ADD PRIMARY KEY(product_category_name);

-- Stablishing the foreign keys for each table
--- Table customers/no se puede
ALTER TABLE olist_customers_dataset AS customers 
ADD FOREIGN KEY (customer_zip_code_prefix) REFERENCES olist_geolocation_dataset(geolocation_zip_code_prefix);
--- Table geolocation
--- Table order_items
ALTER TABLE olist_order_items_dataset
ADD FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id),
ADD FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id),
ADD FOREIGN KEY (seller_id) REFERENCES olist_sellers_dataset(seller_id)
--- Table order_payments
ALTER TABLE olist_order_payments_dataset
ADD FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
--- Table order_reviews
ALTER TABLE olist_order_reviews_dataset
ADD FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);
--- Table orders
ALTER TABLE olist_orders_dataset
ADD FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id);
--- Table products
ALTER TABLE olist_products_dataset
ADD FOREIGN KEY (product_category_name) REFERENCES product_category_name_translation(product_category_name);
--- Table sellers
--- Table product_name


-- Updating typos
UPDATE olist_geolocation_dataset
SET geolocation_city = 'sao paulo'
WHERE geolocation_city = 'são paulo';

ALTER TABLE olist_customers_dataset DROP PRIMARY KEY;
ALTER TABLE olist_geolocation_dataset DROP PRIMARY KEY;
ALTER TABLE olist_order_items_dataset DROP PRIMARY KEY;
ALTER TABLE olist_order_payments_dataset DROP PRIMARY KEY;
ALTER TABLE olist_order_reviews_dataset DROP PRIMARY KEY;
ALTER TABLE olist_orders_dataset DROP PRIMARY KEY;
ALTER TABLE olist_products_dataset DROP PRIMARY KEY;
ALTER TABLE olist_sellers_dataset DROP PRIMARY KEY;
ALTER TABLE product_category_name_translation DROP PRIMARY KEY;

-- Hay productos que no estan en el listado de nombres/se agregan los productos
SELECT DISTINCT product_category_name
FROM olist_products_dataset
WHERE product_category_name NOT IN (
    SELECT product_category_name
    FROM product_category_name_translation
);

--Updating the table with the missing values
INSERT INTO product_category_name_translation (product_category_name)
SELECT DISTINCT product_category_name
FROM olist_products_dataset
WHERE product_category_name NOT IN (
    SELECT product_category_name
    FROM product_category_name_translation
);

-- Hay valores NULL en los productos que no dejan armar la fk
SELECT *
FROM olist_products_dataset
WHERE product_category_name IS NULL;


--Deleting the NULL values 
ALTER TABLE olist_order_items_dataset
DROP CONSTRAINT olist_order_items_dataset_product_id_fkey;

ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT olist_order_items_dataset_product_id_fkey
FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id)
ON DELETE SET NULL;
DELETE FROM olist_products_dataset
WHERE product_category_name IS NULL;
/* borramos los NULL values pues son productos que no se actualizaron
se tendría que esperar una proximaq actualziacion, por lo que se continua con 
los productos que se tiene*/