{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_prefs_ab1') }}
select
    _airbyte_boards_hashid,
    cast(voting as {{ dbt_utils.type_string() }}) as voting,
    {{ cast_to_boolean('canbeorg') }} as canbeorg,
    cast({{ adapter.quote('comments') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('comments') }},
    {{ cast_to_boolean('selfjoin') }} as selfjoin,
    {{ cast_to_boolean('caninvite') }} as caninvite,
    cast(cardaging as {{ dbt_utils.type_string() }}) as cardaging,
    {{ cast_to_boolean('hidevotes') }} as hidevotes,
    cast(background as {{ dbt_utils.type_string() }}) as background,
    {{ cast_to_boolean('cardcovers') }} as cardcovers,
    {{ cast_to_boolean('istemplate') }} as istemplate,
    {{ cast_to_boolean('canbepublic') }} as canbepublic,
    cast(invitations as {{ dbt_utils.type_string() }}) as invitations,
    {{ cast_to_boolean('canbeprivate') }} as canbeprivate,
    {{ cast_to_boolean('backgroundtile') }} as backgroundtile,
    cast(backgroundimage as {{ dbt_utils.type_string() }}) as backgroundimage,
    {{ cast_to_boolean('canbeenterprise') }} as canbeenterprise,
    cast(permissionlevel as {{ dbt_utils.type_string() }}) as permissionlevel,
    cast(backgroundtopcolor as {{ dbt_utils.type_string() }}) as backgroundtopcolor,
    {{ cast_to_boolean('calendarfeedenabled') }} as calendarfeedenabled,
    cast(backgroundbrightness as {{ dbt_utils.type_string() }}) as backgroundbrightness,
    cast(backgroundbottomcolor as {{ dbt_utils.type_string() }}) as backgroundbottomcolor,
    backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_prefs_ab1') }}
-- prefs at boards/prefs
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

