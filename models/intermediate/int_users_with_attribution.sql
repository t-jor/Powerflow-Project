with
registrations_clean as (
    select * from {{ ref('stg_registrations_clean') }}
),

marketing_attribution as (
    select * from {{ ref('int_marketing_attribution') }}
),

users_with_attribution as (
    select 
       reg.user_id
       , reg.registration_time
       , reg.device_id
       , ma.attribution_time
       , coalesce(ma.channel, 'organic') as channel
       , coalesce(ma.campaign_id, 'organic') as campaign_id
       , coalesce(ma.attribution_cost, 0) as attribution_cost
    from registrations_clean as reg 
    left join marketing_attribution as ma
    on reg.device_id = ma.device_id
)

select * from users_with_attribution