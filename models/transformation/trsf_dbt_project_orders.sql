{{config(materialized='view')}}

with orders as (
    select *
    from {{ ref('stg_dbt_project__orders') }}
)

select order_id,
        customer_id,
        case
            when order_status = 'F' then 'Filled'
            when order_status = 'O' then 'Open'
            when order_status = 'P' then 'Pending Payment'
            else 'Unknown'
        end as order_status,
        total_price,
        order_date,
        extract(year from order_date) as order_year,
        extract (month from order_date) as order_month,
        cast(regexp_substr(order_priority, '^[0-9]+') as int) as order_priority,
        cast(regexp_replace(clerk, '[^0-9]', '') as int) as clerk,
        ship_priority

from orders