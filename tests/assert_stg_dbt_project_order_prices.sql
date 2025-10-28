select
    order_id,
    sum(total_price) as total_price
 from {{ ref('stg_dbt_project__orders') }}
 group by 1
 having sum(total_price) < 0