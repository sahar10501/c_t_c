{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('boards_limits_attachments_ab3') }}
select
    _airbyte_limits_hashid,
    perboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_attachments_hashid
from {{ ref('boards_limits_attachments_ab3') }}
-- attachments at boards/limits/attachments from {{ ref('boards_limits') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

