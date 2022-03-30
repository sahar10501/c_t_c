{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_limits_ab1') }}
select
    _airbyte_boards_hashid,
    cast(attachments as {{ type_json() }}) as attachments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_limits_ab1') }}
-- limits at boards/limits
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

