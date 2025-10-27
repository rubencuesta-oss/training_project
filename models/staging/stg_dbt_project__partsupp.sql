{{ config(materialized='table') }}

with partsupp as (
    
    select PS_PARTKEY as part_id,
	        PS_SUPPKEY as supplier_id,
	        PS_AVAILQTY as availqty,
	        PS_SUPPLYCOST as supply_cost,
	        PS_COMMENT as part_supllier_comment

    from {{ source('TPCH_SF1', 'PARTSUPP') }})

select *
from partsupp