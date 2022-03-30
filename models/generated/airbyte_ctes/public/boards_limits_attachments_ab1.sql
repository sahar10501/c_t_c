{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards_limits') }}
select
    _airbyte_limits_hashid,
    {{ json_extract('table_alias', 'attachments', ['perBoard'], ['perBoard']) }} as perboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_limits') }} as table_alias
-- attachments at boards/limits/attachments
where 1 = 1
and attachments is not null
{{ incremental_clause('_airbyte_emitted_at') }}

