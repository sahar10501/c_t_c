{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('boards_labelnames_ab3') }}
select
    _airbyte_boards_hashid,
    red,
    sky,
    blue,
    lime,
    pink,
    black,
    green,
    orange,
    purple,
    yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_labelnames_hashid
from {{ ref('boards_labelnames_ab3') }}
-- labelnames at boards/labelNames from {{ ref('boards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

