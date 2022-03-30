{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_cards') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['due'], ['due']) }} as due,
    {{ json_extract_scalar('_airbyte_data', ['pos'], ['pos']) }} as pos,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', '_airbyte_data', ['cover'], ['cover']) }} as cover,
    {{ json_extract_scalar('_airbyte_data', ['start'], ['start']) }} as {{ adapter.quote('start') }},
    {{ json_extract('table_alias', '_airbyte_data', ['badges'], ['badges']) }} as badges,
    {{ json_extract_scalar('_airbyte_data', ['closed'], ['closed']) }} as closed,
    {{ json_extract_scalar('_airbyte_data', ['idList'], ['idList']) }} as idlist,
    {{ json_extract_array('_airbyte_data', ['labels'], ['labels']) }} as labels,
    {{ json_extract_scalar('_airbyte_data', ['idBoard'], ['idBoard']) }} as idboard,
    {{ json_extract_scalar('_airbyte_data', ['idShort'], ['idShort']) }} as idshort,
    {{ json_extract('table_alias', '_airbyte_data', ['descData'], ['descData']) }} as descdata,
    {{ json_extract_array('_airbyte_data', ['idLabels'], ['idLabels']) }} as idlabels,
    {{ json_extract_scalar('_airbyte_data', ['shortUrl'], ['shortUrl']) }} as shorturl,
    {{ json_extract_array('_airbyte_data', ['idMembers'], ['idMembers']) }} as idmembers,
    {{ json_extract_scalar('_airbyte_data', ['shortLink'], ['shortLink']) }} as shortlink,
    {{ json_extract_scalar('_airbyte_data', ['isTemplate'], ['isTemplate']) }} as istemplate,
    {{ json_extract_scalar('_airbyte_data', ['subscribed'], ['subscribed']) }} as subscribed,
    {{ json_extract_scalar('_airbyte_data', ['dueComplete'], ['dueComplete']) }} as duecomplete,
    {{ json_extract_scalar('_airbyte_data', ['dueReminder'], ['dueReminder']) }} as duereminder,
    {{ json_extract('table_alias', '_airbyte_data', ['idChecklists']) }} as idchecklists,
    {{ json_extract_array('_airbyte_data', ['idMembersVoted'], ['idMembersVoted']) }} as idmembersvoted,
    {{ json_extract_array('_airbyte_data', ['checkItemStates'], ['checkItemStates']) }} as checkitemstates,
    {{ json_extract_array('_airbyte_data', ['customFieldItems'], ['customFieldItems']) }} as customfielditems,
    {{ json_extract_scalar('_airbyte_data', ['dateLastActivity'], ['dateLastActivity']) }} as datelastactivity,
    {{ json_extract_scalar('_airbyte_data', ['idAttachmentCover'], ['idAttachmentCover']) }} as idattachmentcover,
    {{ json_extract_scalar('_airbyte_data', ['manualCoverAttachment'], ['manualCoverAttachment']) }} as manualcoverattachment,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_cards') }} as table_alias
-- cards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

