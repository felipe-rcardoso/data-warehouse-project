"""
===============================================================================
Notebook: etl_utils
===============================================================================
Purpose:
    Shared utility functions for the ETL pipeline (Bronze, Silver, Gold).
    Provides execution control, error handling and logging for each load step.

Functions:
    new_run_id()    -> Generates a unique ID to group all steps of one execution.
    write_log()     -> Appends a log record to the ETL log table.
    run_step()      -> Executes a load step, prints its status, handles errors
                       and records the result (SUCCESS / FAILED).
    run_sql_file()  -> Reads a .sql file, executes it and returns the number
                       of inserted rows.

Log Table:
    dev_dw.silver.etl_log

Usage:
    %run ../utils/etl_utils

    run_id = new_run_id()
    run_step(run_id, "silver", "crm_cust_info",
             lambda: run_sql_file("sql/crm_cust_info.sql"))

Notes:
    - Must run on Serverless or All-Purpose compute (not SQL Warehouse).
    - Each .sql file must contain a single statement.
    - Error messages are truncated to 2000 characters in the log table.
===============================================================================
"""

import uuid
from datetime import datetime
from pyspark.sql import Row

LOG_TABLE = "dev_dw.silver.etl_log"

def new_run_id():
    return str(uuid.uuid4())

def write_log (run_id, layer, table_name, status, rows, start, end, error=None):
    row = Row(
        run_id = run_id,
        layer = layer,
        table_name = table_name,
        status = status,
        rows_inserted = rows,
        start_time = start,
        end_time = end,
        duration_sec = (end - start).total_seconds(),
        error_message=error
    )
    spark.createDataFrame([row], schema = spark.table(LOG_TABLE).schema).write.mode("append").saveAsTable(LOG_TABLE)

def run_step(run_id, layer, table_name, action):
    # action é função que executa a carga e retorna o n de linhas

    start = datetime.now()
    print(f">> [{layer}] {table_name}")
    try:
        rows = action()
        end = datetime.now()
        print(f"   OK | {rows} rows | {(end - start).total_seconds():.1f}s")
        write_log(run_id, layer, table_name, "SUCCESS", rows, start, end)
        return True
    except Exception as e:
        end = datetime.now()
        msg = str(e)[:2000]
        print(f"   FAILED | {msg[:300]}")
        write_log(run_id, layer, table_name, "FAILED", None, start, end, msg)
        return False

def run_sql_file(path):
    query = open(path).read().strip().rstrip(";")
    result = spark.sql(query).first()
    return result["num_inserted_rows"] if result else None

