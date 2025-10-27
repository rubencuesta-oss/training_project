{{ config(materialized='table') }}

with customer as (
    
    select C_CUSTKEY as customer_id,
            C_NAME as name,
	        C_ADDRESS as address,
	        C_NATIONKEY as nation_id,
	        C_PHONE as phone,
	        C_ACCTBAL as acctbal,
	        C_MKTSEGMENT as mktsegment,
	        C_COMMENT as customer_comment

    from PROJECT_DBT.TPCH_SF1.CUSTOMER)

select *
from customer