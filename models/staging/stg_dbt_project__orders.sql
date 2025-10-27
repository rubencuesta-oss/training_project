{{ config(materialized='table') }}

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

    from PROJECT_DBT.TPCH_SF1.ORDERS)

select *
from orders