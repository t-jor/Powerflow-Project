with
import_ga_campaigns as (

    select * from {{ source('powerflow', 'google_ads') }}

),

import_costs as (

    select * from {{ ref('campaign_cost') }} 

),

ga_campaign_costs as (   
    select
        ga.device_id
        , ga.attribution_time :: date as attribution_date
        , 'google_ads' as channel
        , ga.campaign as campaign_id
        , c.cost as attribution_cost

    from import_ga_campaigns as ga 
    left join import_costs as c
    on ga.campaign = c.campaign_id
)

select * from ga_campaign_costs


/*

note:
- device_id is unique
- 1:1 relation of device_id and attribution

implement tests:
- device_id unique/ not_null

*/
