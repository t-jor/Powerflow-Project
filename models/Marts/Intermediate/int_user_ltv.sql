with 
registrations as (
    select 
        distinct user_id
        , date(min(registration_time)) as registration_date
    from {{ ref("stg_registrations_clean") }}
    group by user_id
),

daily_purchases as (
    select
        user_id
        , date(transaction_time) as transaction_date
        , sum(total_value) as daily_revenue
    from {{ ref('stg_transactions') }}
    group by user_id, transaction_date
)

select 
    purch.user_id
    , purch.transaction_date
    , reg.registration_date
    , datediff(day, reg.registration_date, purch.transaction_date) as lifetime
    , purch.daily_revenue
    , sum(daily_revenue) over (partition by purch.user_id order by purch.transaction_date) as cumulative_daily_revenue
from daily_purchases as purch
left join registrations as reg  
on purch.user_id = reg.user_id
order by purch.user_id, purch.transaction_date