{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_cover_ab1') }}
select
    _airbyte_cards_hashid,
    cast({{ adapter.quote('size') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('size') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast(brightness as {{ dbt_utils.type_string() }}) as brightness,
    cast(idattachment as {{ dbt_utils.type_string() }}) as idattachment,
    {{ cast_to_boolean('iduploadedbackground') }} as iduploadedbackground,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_cover_ab1') }}
-- cover at cards/cover
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

