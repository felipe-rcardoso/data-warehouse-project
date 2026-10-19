INSERT OVERWRITE dev_dw.silver.erp_cust_az12(
cid,
bdate,
gen
)
SELECT  
CASE WHEN cid like 'NAS%' THEN  SUBSTRING(cid, 4, LEN(cid))
     ELSE cid
end as cid,
CASE WHEN bdate > getdate() THEN null
     ELSE bdate
END AS bdate,
CASE WHEN TRIM(UPPER(gen)) IN ('F', 'FEMALE') THEN 'Female'
     WHEN TRIM(UPPER(gen)) IN ('M', 'MALE') THEN 'Male'
     ELSE 'n/a'
END as gen
FROM dev_dw.bronze.erp_cust_az12;