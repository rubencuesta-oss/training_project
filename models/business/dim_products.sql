{{config(materialized='table')}}

with supplier as (
    select *
    from {{ ref('trsf_dbt_project_supplier_location') }}
),

product as (
    select * 
    from {{ ref('trsf_dbt_project_product') }}
)

select *
from supplier s 
join product p 
on s.supplier_id = p.supplier_id