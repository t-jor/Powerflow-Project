with
transactions as (
    select * from {{ source('powerflow', 'transactions') }}
)

select * from transactions