{{ config(materialized='table') }}

select * from {{ source('powerflow', 'registrations_raw') }}
where user_id is not null