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

select li.order_id,
        li.part_id,
        li.supplier_id,
        li.line_number,
        li.quantity,
        li.extended_price,
        li.discount,
        li.tax,
        li.return_flag,
        li.line_status,
        li.ship_date,
        li.shipin_struct,
        li.ship_mode,
        o.order_status,
        o.order_year,
        o.order_month,
        o.order_priority,
        o.customer_id,
        o.customer_market_segment,
        o.customer_account_balance,
        o.customer_nation,
        o.customer_tier,
        o.customer_status,
        p.supplier_account_balance,
        p.supplier_nation,
        p.supplier_region,
        p.supplier_tier,
        p.supplier_status,
        p.supplier_quantity_available,
        p.supply_cost,
        p.part_manufacturer,
        p.part_brand,
        p.part_type,
        p.part_size,
        p.part_container,
        p.part_retail_price

from lineitem li
join orders o 
on li.order_id = o.order_id 
join products p 
on li.part_id = p.part_id and li.supplier_id = p.supplier_id