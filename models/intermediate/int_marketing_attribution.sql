with
campaign_cost_af as (

    select * from {{ ref('stg_appsflyer') }}

),

campaign_cost_ga as (

    select * from {{ ref('stg_google_ads') }}

),

marketing_attribution as (
    select * from campaign_cost_af
    union
    select * from campaign_cost_ga
)

select * from marketing_attribution