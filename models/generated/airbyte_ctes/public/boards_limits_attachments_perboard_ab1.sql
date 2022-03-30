{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards_limits_attachments') }}
select
    _airbyte_attachments_hashid,
    {{ json_extract_scalar('perboard', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('perboard', ['warnAt'], ['warnAt']) }} as warnat,
    {{ json_extract_scalar('perboard', ['disableAt'], ['disableAt']) }} as disableat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_limits_attachments') }} as table_alias
-- perboard at boards/limits/attachments/perBoard
where 1 = 1
and perboard is not null
{{ incremental_clause('_airbyte_emitted_at') }}

