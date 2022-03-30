{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_customfielditems_ab1') }}
select
    _airbyte_cards_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('value') }} as {{ type_json() }}) as {{ adapter.quote('value') }},
    cast(idmodel as {{ dbt_utils.type_string() }}) as idmodel,
    cast(idvalue as {{ dbt_utils.type_string() }}) as idvalue,
    cast(modeltype as {{ dbt_utils.type_string() }}) as modeltype,
    cast(idcustomfield as {{ dbt_utils.type_string() }}) as idcustomfield,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_customfielditems_ab1') }}
-- customfielditems at cards/customFieldItems
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

