{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards_badges') }}
select
    _airbyte_badges_hashid,
    {{ json_extract('table_alias', 'attachmentsbytype', ['trello'], ['trello']) }} as trello,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_badges') }} as table_alias
-- attachmentsbytype at cards/badges/attachmentsByType
where 1 = 1
and attachmentsbytype is not null
{{ incremental_clause('_airbyte_emitted_at') }}

