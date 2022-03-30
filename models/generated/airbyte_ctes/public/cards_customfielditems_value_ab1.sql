{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards_customfielditems') }}
select
    _airbyte_customfielditems_hashid,
    {{ json_extract_scalar(adapter.quote('value'), ['date'], ['date']) }} as {{ adapter.quote('date') }},
    {{ json_extract_scalar(adapter.quote('value'), ['text'], ['text']) }} as {{ adapter.quote('text') }},
    {{ json_extract_scalar(adapter.quote('value'), ['number'], ['number']) }} as {{ adapter.quote('number') }},
    {{ json_extract_scalar(adapter.quote('value'), ['option'], ['option']) }} as {{ adapter.quote('option') }},
    {{ json_extract_scalar(adapter.quote('value'), ['checked'], ['checked']) }} as checked,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_customfielditems') }} as table_alias
-- value at cards/customFieldItems/value
where 1 = 1
and {{ adapter.quote('value') }} is not null
{{ incremental_clause('_airbyte_emitted_at') }}

