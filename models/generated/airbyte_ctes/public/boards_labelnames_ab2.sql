{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_labelnames_ab1') }}
select
    _airbyte_boards_hashid,
    cast(red as {{ dbt_utils.type_string() }}) as red,
    cast(sky as {{ dbt_utils.type_string() }}) as sky,
    cast(blue as {{ dbt_utils.type_string() }}) as blue,
    cast(lime as {{ dbt_utils.type_string() }}) as lime,
    cast(pink as {{ dbt_utils.type_string() }}) as pink,
    cast(black as {{ dbt_utils.type_string() }}) as black,
    cast(green as {{ dbt_utils.type_string() }}) as green,
    cast(orange as {{ dbt_utils.type_string() }}) as orange,
    cast(purple as {{ dbt_utils.type_string() }}) as purple,
    cast(yellow as {{ dbt_utils.type_string() }}) as yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_labelnames_ab1') }}
-- labelnames at boards/labelNames
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

