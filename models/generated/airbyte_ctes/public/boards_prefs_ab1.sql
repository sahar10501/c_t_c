{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards') }}
select
    _airbyte_boards_hashid,
    {{ json_extract_scalar('prefs', ['voting'], ['voting']) }} as voting,
    {{ json_extract_scalar('prefs', ['canBeOrg'], ['canBeOrg']) }} as canbeorg,
    {{ json_extract_scalar('prefs', ['comments'], ['comments']) }} as {{ adapter.quote('comments') }},
    {{ json_extract_scalar('prefs', ['selfJoin'], ['selfJoin']) }} as selfjoin,
    {{ json_extract_scalar('prefs', ['canInvite'], ['canInvite']) }} as caninvite,
    {{ json_extract_scalar('prefs', ['cardAging'], ['cardAging']) }} as cardaging,
    {{ json_extract_scalar('prefs', ['hideVotes'], ['hideVotes']) }} as hidevotes,
    {{ json_extract_scalar('prefs', ['background'], ['background']) }} as background,
    {{ json_extract_scalar('prefs', ['cardCovers'], ['cardCovers']) }} as cardcovers,
    {{ json_extract_scalar('prefs', ['isTemplate'], ['isTemplate']) }} as istemplate,
    {{ json_extract_scalar('prefs', ['canBePublic'], ['canBePublic']) }} as canbepublic,
    {{ json_extract_scalar('prefs', ['invitations'], ['invitations']) }} as invitations,
    {{ json_extract_scalar('prefs', ['canBePrivate'], ['canBePrivate']) }} as canbeprivate,
    {{ json_extract_scalar('prefs', ['backgroundTile'], ['backgroundTile']) }} as backgroundtile,
    {{ json_extract_scalar('prefs', ['backgroundImage'], ['backgroundImage']) }} as backgroundimage,
    {{ json_extract_scalar('prefs', ['canBeEnterprise'], ['canBeEnterprise']) }} as canbeenterprise,
    {{ json_extract_scalar('prefs', ['permissionLevel'], ['permissionLevel']) }} as permissionlevel,
    {{ json_extract_scalar('prefs', ['backgroundTopColor'], ['backgroundTopColor']) }} as backgroundtopcolor,
    {{ json_extract_scalar('prefs', ['calendarFeedEnabled'], ['calendarFeedEnabled']) }} as calendarfeedenabled,
    {{ json_extract_scalar('prefs', ['backgroundBrightness'], ['backgroundBrightness']) }} as backgroundbrightness,
    {{ json_extract_scalar('prefs', ['backgroundBottomColor'], ['backgroundBottomColor']) }} as backgroundbottomcolor,
    {{ json_extract_array('prefs', ['backgroundImageScaled'], ['backgroundImageScaled']) }} as backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards') }} as table_alias
-- prefs at boards/prefs
where 1 = 1
and prefs is not null
{{ incremental_clause('_airbyte_emitted_at') }}

