{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('boards_prefs_backgroundimagescaled_ab3') }}
select
    _airbyte_prefs_hashid,
    url,
    width,
    height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_backgroundimagescaled_hashid
from {{ ref('boards_prefs_backgroundimagescaled_ab3') }}
-- backgroundimagescaled at boards/prefs/backgroundImageScaled from {{ ref('boards_prefs') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

