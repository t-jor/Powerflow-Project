-- {{ config(materialized='table') }}

with
appsflyer as (
    select * from {{ ref('stg_appsflyer') }}
),

google_ads_prep as (
    select * from {{ ref('stg_google_ads') }}
),

marketing_attribution as (
    select * from appsflyer
    union
    select * from google_ads_prep
)

select * from marketing_attribution