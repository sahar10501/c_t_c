{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards_badges_attachmentsbytype') }}
select
    _airbyte_attachmentsbytype_hashid,
    {{ json_extract_scalar('trello', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('trello', ['board'], ['board']) }} as board,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_badges_attachmentsbytype') }} as table_alias
-- trello at cards/badges/attachmentsByType/trello
where 1 = 1
and trello is not null
{{ incremental_clause('_airbyte_emitted_at') }}

