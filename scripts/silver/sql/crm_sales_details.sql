INSERT OVERWRITE dev_dw.silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
     ELSE TRY_TO_DATE(CAST(sls_order_dt AS STRING), 'yyyyMMdd') 
END AS sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
     ELSE TRY_TO_DATE(CAST(sls_ship_dt AS STRING), 'yyyyMMdd') 
END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
     ELSE TRY_TO_DATE(CAST(sls_due_dt AS STRING), 'yyyyMMdd') 
END AS sls_due_dt,

/* Rules, if sales is negative, zero or null, derive using Quantity and price
   if price is zero or null, calculate it using Sales and qauntity
   if price is negative, converto to a positive value.
*/
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
     THEN sls_quantity * abs(sls_price)
     ELSE sls_sales
END AS sls_sales,

sls_quantity,

CASE WHEN sls_price IS NULL OR sls_price <=0 THEN sls_sales / nullif(sls_quantity, 0)
     ELSE sls_price
END as sls_price
from dev_dw.bronze.crm_sales_details;