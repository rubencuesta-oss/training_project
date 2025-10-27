{{
    config(
        materialized='incremental',
        unique_key='order_id || \'-\' || line_number'
    )
}}

with lineitem as (
    
    select L_ORDERKEY as order_id,
	        L_PARTKEY as part_id,
	        L_SUPPKEY as supplier_id,
	        L_LINENUMBER as line_number,
	        L_QUANTITY as quantity,
	        L_EXTENDEDPRICE as extended_price,
	        L_DISCOUNT as discount,
	        L_TAX as tax,
	        L_RETURNFLAG as return_flag,
	        L_LINESTATUS as line_status,
	        L_SHIPDATE as ship_date,
	        L_COMMITDATE as commit_date,
	        L_RECEIPTDATE as receipt_date,
	        L_SHIPINSTRUCT as shipin_struct,
	        L_SHIPMODE as ship_mode,
	        L_COMMENT as line_item_comment

    from {{ source('TPCH_SF1', 'LINEITEM') }})

select *
from lineitem
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where ship_date >= (select max(ship_date) from {{ this }}) 
{% endif %}
order by ship_date desc