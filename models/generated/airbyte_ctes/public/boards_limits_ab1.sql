{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards') }}
select
    _airbyte_boards_hashid,
    {{ json_extract('table_alias', 'limits', ['attachments'], ['attachments']) }} as attachments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards') }} as table_alias
-- limits at boards/limits
where 1 = 1
and limits is not null
{{ incremental_clause('_airbyte_emitted_at') }}

