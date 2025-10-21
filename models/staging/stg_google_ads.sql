with
google_ads as (
    select * from {{ source('powerflow', 'google_ads') }}
),

costs as (
    select * from {{ ref('campaign_cost') }} 
),

ads_costs_joined as (   
    select
        ga.device_id
        , ga.attribution_time
        , 'google_ads' as channel
        , ga.campaign as campaign_id
        , c.cost as attribution_cost
    from google_ads as ga 
    left join costs as c
    on ga.campaign = c.campaign_id
)

select * from ads_costs_joined