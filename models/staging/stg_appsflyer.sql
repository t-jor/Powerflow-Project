with
appsflyer as (
    select * from {{ source('powerflow', 'appsflyer_raw') }}
)

select * from appsflyer