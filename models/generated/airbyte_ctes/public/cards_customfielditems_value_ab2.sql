{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_customfielditems_value_ab1') }}
select
    _airbyte_customfielditems_hashid,
    cast({{ adapter.quote('date') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('date') }},
    cast({{ adapter.quote('text') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('text') }},
    cast({{ adapter.quote('number') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('number') }},
    cast({{ adapter.quote('option') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('option') }},
    cast(checked as {{ dbt_utils.type_string() }}) as checked,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_customfielditems_value_ab1') }}
-- value at cards/customFieldItems/value
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

