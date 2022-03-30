{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards') }}
{{ unnest_cte(ref('cards'), 'cards', 'customfielditems') }}
select
    _airbyte_cards_hashid,
    {{ json_extract_scalar(unnested_column_value('customfielditems'), ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract('', unnested_column_value('customfielditems'), ['value'], ['value']) }} as {{ adapter.quote('value') }},
    {{ json_extract_scalar(unnested_column_value('customfielditems'), ['idModel'], ['idModel']) }} as idmodel,
    {{ json_extract_scalar(unnested_column_value('customfielditems'), ['idValue'], ['idValue']) }} as idvalue,
    {{ json_extract_scalar(unnested_column_value('customfielditems'), ['modelType'], ['modelType']) }} as modeltype,
    {{ json_extract_scalar(unnested_column_value('customfielditems'), ['idCustomField'], ['idCustomField']) }} as idcustomfield,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards') }} as table_alias
-- customfielditems at cards/customFieldItems
{{ cross_join_unnest('cards', 'customfielditems') }}
where 1 = 1
and customfielditems is not null
{{ incremental_clause('_airbyte_emitted_at') }}

