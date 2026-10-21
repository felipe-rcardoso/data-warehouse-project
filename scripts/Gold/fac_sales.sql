create or replace view dev_dw.gold.fac_sales as
select 
    sls_ord_num as  order_numbers,
    p.product_key,
    c.customer_key,
    sls_order_dt as order_date,
    sls_ship_dt as ship_date,
    sls_due_dt as due_date,
    sls_sales as sales_amount, 
    sls_quantity as quantity,
    sls_price as price
from dev_dw.silver.crm_sales_details s
left join dev_dw.gold.dim_products p on s.sls_prd_key = p.product_number
left join dev_dw.gold.dim_customers c on s.sls_cust_id = c.customer_id
