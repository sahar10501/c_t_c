{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cards_customfielditems_ab3') }}
select
    _airbyte_cards_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('value') }},
    idmodel,
    idvalue,
    modeltype,
    idcustomfield,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customfielditems_hashid
from {{ ref('cards_customfielditems_ab3') }}
-- customfielditems at cards/customFieldItems from {{ ref('cards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

