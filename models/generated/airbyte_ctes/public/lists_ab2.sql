{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(pos as {{ dbt_utils.type_float() }}) as pos,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    {{ cast_to_boolean('closed') }} as closed,
    cast(idboard as {{ dbt_utils.type_string() }}) as idboard,
    cast(softlimit as {{ dbt_utils.type_bigint() }}) as softlimit,
    {{ cast_to_boolean('subscribed') }} as subscribed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_ab1') }}
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

