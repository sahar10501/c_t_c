{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_ab3') }}
select
    {{ adapter.quote('id') }},
    pos,
    {{ adapter.quote('name') }},
    closed,
    idboard,
    softlimit,
    subscribed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_lists_hashid
from {{ ref('lists_ab3') }}
-- lists from {{ source('public', '_airbyte_raw_lists') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

