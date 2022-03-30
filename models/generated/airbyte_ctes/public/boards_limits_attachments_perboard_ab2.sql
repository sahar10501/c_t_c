{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_limits_attachments_perboard_ab1') }}
select
    _airbyte_attachments_hashid,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(warnat as {{ dbt_utils.type_bigint() }}) as warnat,
    cast(disableat as {{ dbt_utils.type_bigint() }}) as disableat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_limits_attachments_perboard_ab1') }}
-- perboard at boards/limits/attachments/perBoard
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

