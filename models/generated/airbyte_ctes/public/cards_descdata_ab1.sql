{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards') }}
select
    _airbyte_cards_hashid,
    {{ json_extract('table_alias', 'descdata', ['emoji'], ['emoji']) }} as emoji,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards') }} as table_alias
-- descdata at cards/descData
where 1 = 1
and descdata is not null
{{ incremental_clause('_airbyte_emitted_at') }}

