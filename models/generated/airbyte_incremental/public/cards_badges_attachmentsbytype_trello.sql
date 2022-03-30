{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_badges_attachmentsbytype_trello_ab3') }}
select
    _airbyte_attachmentsbytype_hashid,
    card,
    board,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_trello_hashid
from {{ ref('cards_badges_attachmentsbytype_trello_ab3') }}
-- trello at cards/badges/attachmentsByType/trello from {{ ref('cards_badges_attachmentsbytype') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

