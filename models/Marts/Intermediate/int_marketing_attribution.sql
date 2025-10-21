-- {{ config(materialized='table') }}

with
appsflyer as (
    select * from {{ source('powerflow', 'appsflyer_raw') }}
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