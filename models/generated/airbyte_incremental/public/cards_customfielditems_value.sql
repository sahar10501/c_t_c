{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_customfielditems_value_ab3') }}
select
    _airbyte_customfielditems_hashid,
    {{ adapter.quote('date') }},
    {{ adapter.quote('text') }},
    {{ adapter.quote('number') }},
    {{ adapter.quote('option') }},
    checked,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_value_hashid
from {{ ref('cards_customfielditems_value_ab3') }}
-- value at cards/customFieldItems/value from {{ ref('cards_customfielditems') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

