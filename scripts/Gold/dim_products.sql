create view dev_dw.gold.dim_products as 
select 
ROW_NUMBER() OVER (ORDER BY p.prd_start_dt, prd_key) as product_key,
prd_id as product_id,
prd_key as product_number,
prd_nm as product_name,
cat_id as category_id,
pc.cat as category,
pc.subcat as subcategory,
prd_cost  as cost,
prd_line as product_line,
prd_start_dt as start_date,
pc.maintenance 
from dev_dw.silver.crm_prd_info p
left join dev_dw.silver.erp_px_cat_g1v2 pc on p.cat_id = pc.id
where prd_end_dt is null -- filter out all historical dat
