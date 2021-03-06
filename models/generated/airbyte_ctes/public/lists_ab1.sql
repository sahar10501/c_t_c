{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_lists') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['pos'], ['pos']) }} as pos,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['closed'], ['closed']) }} as closed,
    {{ json_extract_scalar('_airbyte_data', ['idBoard'], ['idBoard']) }} as idboard,
    {{ json_extract_scalar('_airbyte_data', ['softLimit'], ['softLimit']) }} as softlimit,
    {{ json_extract_scalar('_airbyte_data', ['subscribed'], ['subscribed']) }} as subscribed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_lists') }} as table_alias
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

