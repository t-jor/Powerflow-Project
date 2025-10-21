{{ config(materialized='table') }}

with 
registrations as (
    select * from {{ source('powerflow', 'registrations_raw') }}
),

cleaned as (
    select * from registrations
    where user_id is not null
)

select * from cleaned


