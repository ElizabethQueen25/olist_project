--¿Cuál es el tiempo promedio entre
--la fecha de compra y la fecha de entrega 
--por estado del cliente?

WITH delivery_time AS (
SELECT
    customer_id,
    ROUND(AVG(EXTRACT(EPOCH FROM(order_delivered_customer_date - order_purchase_timestamp))/86400)) AS avg_time
FROM
    olist_orders_dataset AS orders
WHERE
    order_delivered_customer_date IS NOT NULL
GROUP BY
    customer_id
)

SELECT
    customer_state,
    ROUND(AVG(delivery_time.avg_time)) AS estimated_delivery_time
FROM
    olist_customers_dataset AS customers
INNER JOIN
    delivery_time
ON
    customers.customer_id = delivery_time.customer_id
GROUP BY
    customer_state
ORDER BY
    estimated_delivery_time DESC;


SELECT
    customer_id,
    customer_city,
    customer_state
FROM 
    olist_customers_dataset

SELECT
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM 
    olist_orders_dataset

