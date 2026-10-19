INSERT OVERWRITE dev_dw.silver.crm_cust_info
(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname, -- REMOVE SPACES
TRIM(cst_lastname) AS cst_lastname, -- REMOVE SPACES
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
     WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
     ELSE 'n/a' 
END AS cst_marital_status, --STD VALUES
CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
     WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
     ELSE 'n/a' 
END as cst_gndr, -- STD VALUES
cst_create_date 
from (
    SELECT 
    *,
    ROW_NUMBER() OVER (Partition By CST_ID order by  cst_create_date desc) as flag_last 
    FROM dev_dw.bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) a
where flag_last = 1; -- REMOVE DUPLICATES