{{ config(materialized='table') }}

with region as (
    
    select R_REGIONKEY as region_id,
	        R_NAME as name,
	        R_COMMENT as region_comment

    from {{ source('TPCH_SF1', 'REGION') }})

select *
from region