{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_memberships_ab1') }}
select
    _airbyte_boards_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(idmember as {{ dbt_utils.type_string() }}) as idmember,
    cast(membertype as {{ dbt_utils.type_string() }}) as membertype,
    {{ cast_to_boolean('deactivated') }} as deactivated,
    {{ cast_to_boolean('unconfirmed') }} as unconfirmed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_memberships_ab1') }}
-- memberships at boards/memberships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

