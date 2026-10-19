INSERT OVERWRITE dev_dw.silver.erp_loc_a101(
cid,
cntry
)
select 
replace(cid, '-','') as cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry is null THEN 'n/a'
     ELSE trim(cntry)
END as  cntry
from dev_dw.bronze.erp_loc_a101;