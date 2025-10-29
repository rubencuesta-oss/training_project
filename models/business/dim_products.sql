{{config(materialized='table')}}

with supplier as (
    select *
    from {{ ref('trsf_dbt_project_supplier_location') }}
),

product as (
    select * 
    from {{ ref('trsf_dbt_project_product') }}
)

select s.supplier_id,
        s.supplier_name,
        s.supplier_account_balance,
        s.supplier_nation,
        s.supplier_region,
        s.supplier_tier,
        s.supplier_status,
        p.part_id,
        p.supplier_quantity_available,
        p.supply_cost,
        p.part_manufacturer,
        p.part_brand,
        p.part_type,
        p.part_size,
        p.part_container,
        p.part_retail_price
from supplier s 
join product p 
on s.supplier_id = p.supplier_id