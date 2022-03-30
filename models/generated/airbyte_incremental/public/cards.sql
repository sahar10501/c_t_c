{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_ab3') }}
select
    {{ adapter.quote('id') }},
    due,
    pos,
    url,
    {{ adapter.quote('desc') }},
    {{ adapter.quote('name') }},
    cover,
    {{ adapter.quote('start') }},
    badges,
    closed,
    idlist,
    labels,
    idboard,
    idshort,
    descdata,
    idlabels,
    shorturl,
    idmembers,
    shortlink,
    istemplate,
    subscribed,
    duecomplete,
    duereminder,
    idchecklists,
    idmembersvoted,
    checkitemstates,
    customfielditems,
    datelastactivity,
    idattachmentcover,
    manualcoverattachment,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_cards_hashid
from {{ ref('cards_ab3') }}
-- cards from {{ source('public', '_airbyte_raw_cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

