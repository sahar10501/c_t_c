{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards') }}
{{ unnest_cte(ref('cards'), 'cards', 'labels') }}
select
    _airbyte_cards_hashid,
    {{ json_extract_scalar(unnested_column_value('labels'), ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar(unnested_column_value('labels'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('labels'), ['color'], ['color']) }} as color,
    {{ json_extract_scalar(unnested_column_value('labels'), ['idBoard'], ['idBoard']) }} as idboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards') }} as table_alias
-- labels at cards/labels
{{ cross_join_unnest('cards', 'labels') }}
where 1 = 1
and labels is not null
{{ incremental_clause('_airbyte_emitted_at') }}

