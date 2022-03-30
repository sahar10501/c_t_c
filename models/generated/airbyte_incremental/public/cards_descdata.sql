{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_descdata_ab3') }}
select
    _airbyte_cards_hashid,
    emoji,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_descdata_hashid
from {{ ref('cards_descdata_ab3') }}
-- descdata at cards/descData from {{ ref('cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

