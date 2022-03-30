{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_badges_attachmentsbytype_trello_ab1') }}
select
    _airbyte_attachmentsbytype_hashid,
    cast(card as {{ dbt_utils.type_bigint() }}) as card,
    cast(board as {{ dbt_utils.type_bigint() }}) as board,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_badges_attachmentsbytype_trello_ab1') }}
-- trello at cards/badges/attachmentsByType/trello
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

