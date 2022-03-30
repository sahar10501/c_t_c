{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_labels_ab3') }}
select
    _airbyte_cards_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    color,
    idboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_labels_hashid
from {{ ref('cards_labels_ab3') }}
-- labels at cards/labels from {{ ref('cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

