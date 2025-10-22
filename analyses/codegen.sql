-- test1: yml-file für sources über codegen generieren lassen:

{{ codegen.generate_source(schema_name= 'public', database_name= 'powerflow', include_descriptions=true) }}

-- name: besser ändern zu powerflow (public ist der schema name)
-- database: powerflow
-- schema: public


--test2: staging-modelle generieren lassen:

{{ codegen.generate_base_model(
    source_name='powerflow',
    table_name='appsflyer_raw',
    materialized='view'
) }}

{{ codegen.generate_base_model(
    source_name='powerflow',
    table_name='google_ads',
    materialized='view'
) }}

{{ codegen.generate_base_model(
    source_name='powerflow',
    table_name='transactions',
    materialized='view'
) }}

{{ codegen.generate_base_model(
    source_name='powerflow',
    table_name='registrations_raw',
    materialized='table'
) }}


--test3: schema.yml mit Beschreibungen und Tests für staging-Modelle generieren lassen:

{{ codegen.generate_model_yaml(
    model_names=['stg_registrations_clean']
) }}

{{ codegen.generate_model_yaml(
    model_names=['stg_appsflyer']
) }}

{{ codegen.generate_model_yaml(
    model_names=['stg_google_ads']
) }}

{{ codegen.generate_model_yaml(
    model_names=['stg_transactions']
) }}


--test4: schema.yml mit Beschreibungen und Tests für int-Modelle generieren lassen:

{{ codegen.generate_model_yaml(
    model_names=['int_marketing_attribution']
) }}

{{ codegen.generate_model_yaml(
    model_names=['int_users_with_attribution']
) }}

{{ codegen.generate_model_yaml(
    model_names=['int_user_ltv']
) }}


--test5: schema.yml mit Beschreibungen und Tests für roi-Modell generieren lassen:

{{ codegen.generate_model_yaml(
    model_names=['user_roi']
) }}






