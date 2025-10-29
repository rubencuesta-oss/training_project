{{config(materialized='table')}}

with orders as (
    select *
    from {{ ref('trsf_dbt_project_orders') }}
),

customer as (
    select * 
    from {{ ref('trsf_dbt_project_customer_location') }}
)

select *
from orders o
join customer c
on o.customer_id = c.customer_id