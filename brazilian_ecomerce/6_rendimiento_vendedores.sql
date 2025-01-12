/*o	¿Qué vendedor tiene el mayor número de 
productos vendidos y cuál es su ingreso total generado?*/


SELECT
    seller_id,
    COUNT(product_id) AS total_products,
    ROUND(SUM(price)) AS total_income

FROM
    olist_order_items_dataset
GROUP BY
    seller_id
ORDER BY
    total_products DESC