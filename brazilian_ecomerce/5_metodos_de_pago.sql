/*¿Qué métodos de pago son los más utilizados, 
y cuántas transacciones se han realizado con cada uno? */


WITH total_transactions AS(
SELECT
    COUNT(*) AS total
FROM
    olist_order_payments_dataset
WHERE
    payment_type != 'not_defined'
), payment_summary AS(
SELECT
    payment_type,
    COUNT(payment_type) AS transactions
FROM
    olist_order_payments_dataset
WHERE
    payment_type != 'not_defined'
GROUP BY
    payment_type
)

SELECT
    payment_type,
    transactions,
    ROUND(transactions*100/(SELECT total FROM total_transactions)) AS percentage
FROM
    payment_summary
ORDER BY
    percentage DESC;
    






/*
JUSTIFICACION ELIMINACION DE not_defined
Los registros con payment_type como not_defined tienen las siguientes características:

Cantidad de registros: 3.
Detalles de las transacciones:
payment_installments: Todos son 1.
payment_value: Todos tienen un valor de 0.0.
Esto sugiere que estas transacciones podrían ser errores o intentos de pago fallidos, ya que no tienen valor asociado.

Recomendaciones:
Investigar: Si tienes acceso al sistema de origen, verifica por qué se generaron estos registros.
Excluir temporalmente: Puedes eliminarlos del análisis principal, ya que son insignificantes en cantidad y no afectan el valor total.
Documentar: Si decides excluirlos, asegúrate de mencionarlo en el análisis final.*/