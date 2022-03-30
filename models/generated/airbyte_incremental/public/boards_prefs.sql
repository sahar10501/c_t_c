{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('boards_prefs_ab3') }}
select
    _airbyte_boards_hashid,
    voting,
    canbeorg,
    {{ adapter.quote('comments') }},
    selfjoin,
    caninvite,
    cardaging,
    hidevotes,
    background,
    cardcovers,
    istemplate,
    canbepublic,
    invitations,
    canbeprivate,
    backgroundtile,
    backgroundimage,
    canbeenterprise,
    permissionlevel,
    backgroundtopcolor,
    calendarfeedenabled,
    backgroundbrightness,
    backgroundbottomcolor,
    backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_prefs_hashid
from {{ ref('boards_prefs_ab3') }}
-- prefs at boards/prefs from {{ ref('boards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

