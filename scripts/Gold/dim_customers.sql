create or replace view dev_dw.gold.dim_customers as 
select row_number() OVER(order by ci.cst_id) AS customer_key,
       ci.cst_id as customer_id,
       ci.cst_key as  customer_number,
       ci.cst_firstname as first_name,
       ci.cst_lastname as last_name,
       ci.cst_marital_status as marital_status,
       ci.cst_create_date as create_date,
       ca.bdate as birthdate,
       CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- crm is the master for gender info
            ELSE coalesce(ca.gen,'n/a')
       END as gender,
       la.cntry as country
    from dev_dw.silver.crm_cust_info ci
    left join  dev_dw.silver.erp_cust_az12 ca on ci.cst_key = ca.cid
    left join dev_dw.silver.erp_loc_a101 la on ci.cst_key = la.cid
