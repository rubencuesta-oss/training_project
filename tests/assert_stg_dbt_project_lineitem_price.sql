select 
    order_id,
    sum(extended_price) as total_extended_price
from {{ ref('stg_dbt_project__lineitem') }}
group by 1
having sum(extended_price) < 0