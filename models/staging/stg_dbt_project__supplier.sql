{{ config(materialized='table') }}

with supplier as (
    
    select 	S_SUPPKEY as supplier_id,
	            S_NAME as name,
	            S_ADDRESS as address,
	            S_NATIONKEY as nation_id,
	            S_PHONE as phone,
	            S_ACCTBAL as acctbal,
	            S_COMMENT as supplier_comment

    from {{ source('TPCH_SF1', 'SUPPLIER') }})

select *
from supplier