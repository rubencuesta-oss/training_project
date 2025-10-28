{{config(materialized='view')}}

with part as (
    select *
    from {{ ref('stg_dbt_project__part') }}
),

partsupp as (
    select *
    from {{ ref('stg_dbt_project__partsupp') }}
)

select ps.part_id,
        ps.supplier_id,
        ps.availqty as supplier_quantity_available,
        ps.supply_cost,
        cast(regexp_replace(p.mfgr, '[^0-9]', '') as int) as part_manufacturer,
        cast(regexp_replace(p.brand, '[^0-9]', '') as int) as part_brand,
        p.type as part_type,
        p.size as part_size,
        p.container as part_container,
        p.retail_price as part_retail_price

from partsupp ps 
join part p
on ps.part_id = p.part_id 
