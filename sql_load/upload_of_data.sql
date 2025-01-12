-- Tabla: customers
CREATE TABLE public.olist_customers_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(255),
    customer_state VARCHAR(2)
);

-- Tabla: geolocation
CREATE TABLE public.olist_geolocation_dataset (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(2)
);

-- Tabla: order_items
CREATE TABLE public.olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT,
    PRIMARY KEY (order_id, order_item_id)
);

-- Tabla: order_payments
CREATE TABLE public.olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value FLOAT
);

-- Tabla: order_reviews
CREATE TABLE public.olist_order_reviews_dataset (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- Tabla: orders
CREATE TABLE public.olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Tabla: products
CREATE TABLE public.olist_products_dataset (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

-- Tabla: product_category_name_translation
CREATE TABLE public.product_category_name_translation (
    product_category_name VARCHAR(255) PRIMARY KEY,
    product_category_name_english VARCHAR(255)
);

-- Tabla: sellers
CREATE TABLE public.olist_sellers_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(255),
    seller_state VARCHAR(2)
);

-- Estableciendo propietario de las tablas a postgres
ALTER TABLE public.olist_customers_dataset OWNER to postgres;
ALTER TABLE public.olist_geolocation_dataset OWNER to postgres;
ALTER TABLE public.olist_order_items_dataset OWNER to postgres;
ALTER TABLE public.olist_order_payments_dataset OWNER to postgres;
ALTER TABLE public.olist_order_reviews_dataset OWNER to postgres;
ALTER TABLE public.olist_orders_dataset OWNER to postgres;
ALTER TABLE public.olist_products_dataset OWNER to postgres;
ALTER TABLE public.product_category_name_translation OWNER to postgres;
ALTER TABLE public.olist_sellers_dataset OWNER to postgres;


-- Comandos COPY para cargar los datos desde los archivos CSV
COPY olist_customers_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_geolocation_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_order_items_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_order_payments_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_order_reviews_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_orders_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_products_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_products_dataset.csv' DELIMITER ',' CSV HEADER;
COPY product_category_name_translation FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\product_category_name_translation.csv' DELIMITER ',' CSV HEADER;
COPY olist_sellers_dataset FROM 'D:\Pycharm\kaggle_course_sql\brazilian_ecomerce\olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;

DROP TABLE
/*public.olist_customers_dataset,
public.olist_geolocation_dataset,
public.olist_order_items_dataset, 
public.olist_order_payments_dataset, 
public.olist_order_reviews_dataset, 
public.olist_orders_dataset, 
public.olist_products_dataset, 
public.product_category_name_translation, 
public.olist_sellers_dataset;
*/

SELECT *
FROM olist_geolocation_dataset