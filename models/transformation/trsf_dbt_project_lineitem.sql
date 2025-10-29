{{config(materialized='table')}}

with lineitem as (
    select *
    from {{ ref('stg_dbt_project__lineitem') }}
)

select order_id,
        part_id,
        supplier_id,
        line_number,
        quantity,
        extended_price,
        discount,
        tax,

        case
            when return_flag = 'N' then 'Not Returned'
            when return_flag = 'R' then 'Returned'
            when return_flag = 'A' then 'Accepted'
            else 'Unknown'
        end as return_flag,

        case 
            when line_status = 'O' then 'Open'
            when line_status = 'F' then 'Fulfilled'
            else 'Unknown'
        end as line_status,

        ship_date,
        commit_date,
        receipt_date,
        shipin_struct,
        ship_mode

from lineitem