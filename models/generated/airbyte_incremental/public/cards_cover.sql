{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_cover_ab3') }}
select
    _airbyte_cards_hashid,
    {{ adapter.quote('size') }},
    color,
    brightness,
    idattachment,
    iduploadedbackground,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_cover_hashid
from {{ ref('cards_cover_ab3') }}
-- cover at cards/cover from {{ ref('cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

