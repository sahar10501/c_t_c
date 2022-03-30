{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards') }}
select
    _airbyte_cards_hashid,
    {{ json_extract_scalar('badges', ['due'], ['due']) }} as due,
    {{ json_extract_scalar('badges', ['votes'], ['votes']) }} as votes,
    {{ json_extract_scalar('badges', ['fogbugz'], ['fogbugz']) }} as fogbugz,
    {{ json_extract_scalar('badges', ['comments'], ['comments']) }} as {{ adapter.quote('comments') }},
    {{ json_extract_scalar('badges', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar('badges', ['checkItems'], ['checkItems']) }} as checkitems,
    {{ json_extract_scalar('badges', ['subscribed'], ['subscribed']) }} as subscribed,
    {{ json_extract_scalar('badges', ['attachments'], ['attachments']) }} as attachments,
    {{ json_extract_scalar('badges', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('badges', ['dueComplete'], ['dueComplete']) }} as duecomplete,
    {{ json_extract('table_alias', 'badges', ['attachmentsByType'], ['attachmentsByType']) }} as attachmentsbytype,
    {{ json_extract_scalar('badges', ['checkItemsChecked'], ['checkItemsChecked']) }} as checkitemschecked,
    {{ json_extract_scalar('badges', ['viewingMemberVoted'], ['viewingMemberVoted']) }} as viewingmembervoted,
    {{ json_extract_scalar('badges', ['checkItemsEarliestDue'], ['checkItemsEarliestDue']) }} as checkitemsearliestdue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards') }} as table_alias
-- badges at cards/badges
where 1 = 1
and badges is not null
{{ incremental_clause('_airbyte_emitted_at') }}

