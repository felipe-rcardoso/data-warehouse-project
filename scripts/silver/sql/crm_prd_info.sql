INSERT OVERWRITE dev_dw.silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
select 
    prd_id,
	replace(substring(prd_key, 1, 5),'-', '_') AS cat_id, -- get the cat_id
    substring(prd_key, 7, len(prd_key)) AS prd_key, -- get the prd_key
	prd_nm,
	coalesce(prd_cost,0) as prd_cost, -- change null to 0
	CASE UPPER(TRIM(prd_line)) 
         WHEN  'M' THEN 'Mountain'
         WHEN  'R' then 'Road'
         WHEN  'S' then 'Other Sales'
         WHEN  'T' then 'Touring'
         ELSE 'n/a'
    END AS prd_line,
	cast(prd_start_dt AS DATE) as prd_start_dt,
    --> end date = start date of next record -1
    cast(LEAD(prd_start_dt) OVER (PARTITION BY prd_key order by prd_start_dt)-1 as Date) as prd_end_dt
FROM dev_dw.bronze.crm_prd_info;