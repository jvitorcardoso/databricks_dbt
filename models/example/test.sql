{{ config(materialized='view') }}

with source_data as (

    select 1 as id, 'alice'  as user_name, 'alice@example.com'   as user_email, date('1995-04-12') as user_birth
    union all
    select 2 as id, 'bob'    as user_name, 'bob@example.com'     as user_email, date('1989-07-23') as user_birth
    union all
    select 3 as id, 'carol'  as user_name, 'carol@example.com'   as user_email, null               as user_birth -- intentionally NULL
    union all
    select 4 as id, 'david'  as user_name, 'david@example.com'   as user_email, date('1992-01-15') as user_birth
    union all
    select 5 as id, 'eve'    as user_name, 'eve@example.com'     as user_email, date('2000-11-05') as user_birth

)

select *
from source_data
