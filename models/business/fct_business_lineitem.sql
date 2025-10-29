{{config(materialized='table')}}

with lineitem as (
    select *
    from {{ ref('trsf_dbt_project_lineitem') }}
),

orders as (
    select *
    from {{ ref('dim_orders') }}
),

products as (
    select * 
    from {{ ref('dim_products') }}
)

select *
from lineitem li
join orders o 
on li.order_id = o.order_id 
join products p 
on li.part_id = p.part_id and li.supplier_id = p.supplier_id