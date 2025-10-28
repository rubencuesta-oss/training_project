{{config(materialized='view')}}

with supplier as (
    select *
    from {{ ref('stg_dbt_project__supplier') }}
),

nation as (
    select *
    from {{ ref('stg_dbt_project__nation') }}
),

region as (
    select *
    from {{ ref('stg_dbt_project__region') }}
)

select s.supplier_id,
        cast(regexp_replace(s.name, '[^0-9]', '') as int) as supplier_name,
        s.acctbal as supplier_account_balance,
        n.name as supplier_nation,
        r.name as supplier_region,

        case 
            when s.acctbal >= 8000 then 'Premium'
            when s.acctbal >= 5000 then 'Gold'
            when s.acctbal >= 2000 then 'Silver'
            else 'Standard'
        end as supplier_tier,

        case
            when s.acctbal >= 0 then 'Good Standing'
            else 'At Risk'
        end as supplier_status

from supplier s
join nation n
on s.nation_id = n.nation_id
join region r
on r.region_id = n.region_id