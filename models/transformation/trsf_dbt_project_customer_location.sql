{{config(materialized='view')}}

with customer as (
    select *
    from {{ ref('stg_dbt_project__customer') }}
),

nation as (
    select *
    from {{ ref('stg_dbt_project__nation') }}
),

region as (
    select *
    from {{ ref('stg_dbt_project__region') }}
)

select c.customer_id,
        cast(regexp_replace(c.name, '[^0-9]', '') as int) as customer_name,
        c.mktsegment as customer_market_segment,
        c.acctbal as customer_account_balance,
        n.name as customer_nation,
        r.name as customer_region,

        case 
            when c.acctbal >= 8000 then 'Premium'
            when c.acctbal >= 5000 then 'Gold'
            when c.acctbal >= 2000 then 'Silver'
            else 'Standard'
        end as customer_tier,

        case
            when c.acctbal >= 0 then 'Good Standing'
            else 'At Risk'
        end as customer_status

from customer c
join nation n 
on c.nation_id = n.nation_id
join region r 
on r.region_id = n.region_id