{{ config(materialized='table')}}

with
customer_value as (
    select * from {{ ref('int_user_ltv') }}
),

customer_acquisition_cost as (
    select * from {{ ref('int_users_with_attribution') }}
)
   
select 
    ltv.user_id 
    , ltv.transaction_date
    , ltv.lifetime
    , ltv.cumulative_daily_revenue
    , cac.channel 
    , cac.campaign_id 
    , cac.attribution_cost
    , ROUND(DIV0(ltv.cumulative_daily_revenue, cac.attribution_cost), 2) as costumer_roi 
from customer_value as ltv
INNER JOIN customer_acquisition_cost as cac
on ltv.user_id = cac.user_id

-- where campaign_id = 'organic'
-- how to display costumer_roi for organic customers? >>> 0 or 100%?