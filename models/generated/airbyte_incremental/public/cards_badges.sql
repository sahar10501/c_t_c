{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_badges_ab3') }}
select
    _airbyte_cards_hashid,
    due,
    votes,
    fogbugz,
    {{ adapter.quote('comments') }},
    {{ adapter.quote('location') }},
    checkitems,
    subscribed,
    attachments,
    description,
    duecomplete,
    attachmentsbytype,
    checkitemschecked,
    viewingmembervoted,
    checkitemsearliestdue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_badges_hashid
from {{ ref('cards_badges_ab3') }}
-- badges at cards/badges from {{ ref('cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

