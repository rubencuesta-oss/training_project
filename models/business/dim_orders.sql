{{config(materialized='table')}}

with orders as (
    select *
    from {{ ref('trsf_dbt_project_orders') }}
),

customer as (
    select * 
    from {{ ref('trsf_dbt_project_customer_location') }}
)

select  o.order_id,
        o.order_status,
        o.total_price,
        o.order_date,
        o.order_year,
        o.order_month,
        o.order_priority,
        o.clerk,
        o.ship_priority,
        c.customer_id,
        c.customer_name,
        c.customer_market_segment,
        c.customer_account_balance,
        c.customer_nation,
        c.customer_region,
        c.customer_tier,
        c.customer_status
from orders o
join customer c
on o.customer_id = c.customer_id