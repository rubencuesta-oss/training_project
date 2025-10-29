{{config(
        materialized='incremental',
        unique_key='order_id')}}

with orders as (
    
    select O_ORDERKEY as order_id,
	        O_CUSTKEY as customer_id,
	        O_ORDERSTATUS as order_status,
	        O_TOTALPRICE as total_price,
	        O_ORDERDATE as order_date,
	        O_ORDERPRIORITY as order_priority,
	        O_CLERK as clerk,
	        O_SHIPPRIORITY as ship_priority,
	        O_COMMENT as order_comment

    from {{ source('TPCH_SF1', 'ORDERS') }})

select *
from orders
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date >= (select max(order_date) from {{ this }}) 
{% endif %}
order by order_date desc