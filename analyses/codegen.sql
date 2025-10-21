-- test: yml-file für sources über codegen generieren lassen:

{{ codegen.generate_source(schema_name= 'public', database_name= 'powerflow', include_descriptions=true) }}

-- name: besser ändern zu powerflow (public ist der schema name)
-- database: powerflow
-- schema: public