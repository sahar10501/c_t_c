{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_badges_ab1') }}
select
    _airbyte_cards_hashid,
    cast({{ empty_string_to_null('due') }} as {{ type_timestamp_with_timezone() }}) as due,
    cast(votes as {{ dbt_utils.type_bigint() }}) as votes,
    cast(fogbugz as {{ dbt_utils.type_string() }}) as fogbugz,
    cast({{ adapter.quote('comments') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('comments') }},
    {{ cast_to_boolean(adapter.quote('location')) }} as {{ adapter.quote('location') }},
    cast(checkitems as {{ dbt_utils.type_bigint() }}) as checkitems,
    {{ cast_to_boolean('subscribed') }} as subscribed,
    cast(attachments as {{ dbt_utils.type_bigint() }}) as attachments,
    {{ cast_to_boolean('description') }} as description,
    {{ cast_to_boolean('duecomplete') }} as duecomplete,
    cast(attachmentsbytype as {{ type_json() }}) as attachmentsbytype,
    cast(checkitemschecked as {{ dbt_utils.type_bigint() }}) as checkitemschecked,
    {{ cast_to_boolean('viewingmembervoted') }} as viewingmembervoted,
    cast({{ empty_string_to_null('checkitemsearliestdue') }} as {{ type_timestamp_with_timezone() }}) as checkitemsearliestdue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_badges_ab1') }}
-- badges at cards/badges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

