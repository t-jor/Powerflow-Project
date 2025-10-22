with
import_transactions as (

    select * from {{ source('powerflow', 'transactions') }}

),

final_transactions as (
    select
        user_id,
        transaction_time :: date as transaction_date,
        transaction_id,
        total_value

    from import_transactions
)

select * from final_transactions


/*

note:
- transaction_id is unique
- several transaction per user_id

implement tests:
- transaction_id unique/ not_null
- user_id not_null

*/