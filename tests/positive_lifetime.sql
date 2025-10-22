-- This test checks if we have users with lifetime < 0 (might occur when registration_date > transaction_date)

select
    *
   
from {{ ref("int_user_ltv") }}

where lifetime < 0