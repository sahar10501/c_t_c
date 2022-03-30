{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cards_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ empty_string_to_null('due') }} as {{ type_timestamp_with_timezone() }}) as due,
    cast(pos as {{ dbt_utils.type_float() }}) as pos,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(cover as {{ type_json() }}) as cover,
    cast({{ adapter.quote('start') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('start') }},
    cast(badges as {{ type_json() }}) as badges,
    {{ cast_to_boolean('closed') }} as closed,
    cast(idlist as {{ dbt_utils.type_string() }}) as idlist,
    labels,
    cast(idboard as {{ dbt_utils.type_string() }}) as idboard,
    cast(idshort as {{ dbt_utils.type_bigint() }}) as idshort,
    cast(descdata as {{ type_json() }}) as descdata,
    idlabels,
    cast(shorturl as {{ dbt_utils.type_string() }}) as shorturl,
    idmembers,
    cast(shortlink as {{ dbt_utils.type_string() }}) as shortlink,
    {{ cast_to_boolean('istemplate') }} as istemplate,
    {{ cast_to_boolean('subscribed') }} as subscribed,
    {{ cast_to_boolean('duecomplete') }} as duecomplete,
    cast(duereminder as {{ dbt_utils.type_string() }}) as duereminder,
    idchecklists,
    idmembersvoted,
    checkitemstates,
    customfielditems,
    cast({{ empty_string_to_null('datelastactivity') }} as {{ type_timestamp_with_timezone() }}) as datelastactivity,
    cast(idattachmentcover as {{ dbt_utils.type_string() }}) as idattachmentcover,
    {{ cast_to_boolean('manualcoverattachment') }} as manualcoverattachment,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards_ab1') }}
-- cards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

