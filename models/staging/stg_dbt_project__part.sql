{{ config(materialized='table') }}

with part as (
    
    select 	P_PARTKEY as part_id,
	        P_NAME as name,
	        P_MFGR as mfgr,
	        P_BRAND as brand,
	        P_TYPE as type,
	        P_SIZE as size,
	        P_CONTAINER as container,
	        P_RETAILPRICE as retail_price,
	        P_COMMENT as part_comment

    from PROJECT_DBT.TPCH_SF1.PART)

select *
from part