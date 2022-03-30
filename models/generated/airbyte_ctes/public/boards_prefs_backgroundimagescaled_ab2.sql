{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_prefs_backgroundimagescaled_ab1') }}
select
    _airbyte_prefs_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(width as {{ dbt_utils.type_bigint() }}) as width,
    cast(height as {{ dbt_utils.type_bigint() }}) as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_prefs_backgroundimagescaled_ab1') }}
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

