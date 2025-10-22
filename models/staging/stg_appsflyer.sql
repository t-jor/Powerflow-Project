{{ config(materialized='view') }}

with
import_af_campaigns as (

    select * from {{ source('powerflow', 'appsflyer_raw') }}

),

final_af_campaigns as (

    select
        device_id,
        attribution_time :: date as attribution_date,
        channel,
        campaign_id,
        attribution_cost

    from import_af_campaigns

)

select * from final_af_campaigns
--where attribution_cost is null or attribution_cost = 0


/*

note:
- device_id is unique
- 1:1 relation of device_id and attribution_time

implement tests:
- device_id unique/ not_null

*/



