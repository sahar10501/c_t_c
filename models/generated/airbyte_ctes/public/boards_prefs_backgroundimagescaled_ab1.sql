{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards_prefs') }}
{{ unnest_cte(ref('boards_prefs'), 'prefs', 'backgroundimagescaled') }}
select
    _airbyte_prefs_hashid,
    {{ json_extract_scalar(unnested_column_value('backgroundimagescaled'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('backgroundimagescaled'), ['width'], ['width']) }} as width,
    {{ json_extract_scalar(unnested_column_value('backgroundimagescaled'), ['height'], ['height']) }} as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_prefs') }} as table_alias
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
{{ cross_join_unnest('prefs', 'backgroundimagescaled') }}
where 1 = 1
and backgroundimagescaled is not null
{{ incremental_clause('_airbyte_emitted_at') }}

