{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards') }}
select
    _airbyte_boards_hashid,
    {{ json_extract_scalar('labelnames', ['red'], ['red']) }} as red,
    {{ json_extract_scalar('labelnames', ['sky'], ['sky']) }} as sky,
    {{ json_extract_scalar('labelnames', ['blue'], ['blue']) }} as blue,
    {{ json_extract_scalar('labelnames', ['lime'], ['lime']) }} as lime,
    {{ json_extract_scalar('labelnames', ['pink'], ['pink']) }} as pink,
    {{ json_extract_scalar('labelnames', ['black'], ['black']) }} as black,
    {{ json_extract_scalar('labelnames', ['green'], ['green']) }} as green,
    {{ json_extract_scalar('labelnames', ['orange'], ['orange']) }} as orange,
    {{ json_extract_scalar('labelnames', ['purple'], ['purple']) }} as purple,
    {{ json_extract_scalar('labelnames', ['yellow'], ['yellow']) }} as yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards') }} as table_alias
-- labelnames at boards/labelNames
where 1 = 1
and labelnames is not null
{{ incremental_clause('_airbyte_emitted_at') }}

