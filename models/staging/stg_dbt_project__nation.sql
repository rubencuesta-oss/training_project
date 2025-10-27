{{ config(materialized='table') }}

with nation as (
    
    select N_NATIONKEY as nation_id,
	        N_NAME as name,
	        N_REGIONKEY as region_id,
	        N_COMMENT as nation_comment

    from {{ source('TPCH_SF1', 'NATION') }})

select *
from nation