with 
import_registrations as (

    select * from {{ source('powerflow', 'registrations_raw') }}

),

cleaned_registrations as (
    select
        user_id
        , registration_time :: date as registration_date
        , device_id
        , email 
        , platform
        , country
        
    from import_registrations
    where user_id is not null and device_id is not null
)

select * from cleaned_registrations


/*

note:
- all user_id/ device_id are unique
- 1:1 relation of user_id and device_id

implement tests:
- user_id/ device_id unique/ not_null

*/
