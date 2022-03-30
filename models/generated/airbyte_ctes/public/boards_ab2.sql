{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('boards_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(prefs as {{ type_json() }}) as prefs,
    {{ cast_to_boolean('closed') }} as closed,
    idtags,
    cast(limits as {{ type_json() }}) as limits,
    {{ cast_to_boolean('pinned') }} as pinned,
    {{ cast_to_boolean('starred') }} as starred,
    cast(descdata as {{ dbt_utils.type_string() }}) as descdata,
    cast(ixupdate as {{ dbt_utils.type_bigint() }}) as ixupdate,
    powerups,
    cast(shorturl as {{ dbt_utils.type_string() }}) as shorturl,
    cast(shortlink as {{ dbt_utils.type_string() }}) as shortlink,
    cast(labelnames as {{ type_json() }}) as labelnames,
    {{ cast_to_boolean('subscribed') }} as subscribed,
    memberships,
    cast({{ empty_string_to_null('datelastview') }} as {{ type_timestamp_with_timezone() }}) as datelastview,
    cast(identerprise as {{ dbt_utils.type_string() }}) as identerprise,
    cast(idboardsource as {{ dbt_utils.type_string() }}) as idboardsource,
    cast(creationmethod as {{ dbt_utils.type_string() }}) as creationmethod,
    cast(idorganization as {{ dbt_utils.type_string() }}) as idorganization,
    {{ cast_to_boolean('enterpriseowned') }} as enterpriseowned,
    premiumfeatures,
    cast(templategallery as {{ dbt_utils.type_string() }}) as templategallery,
    cast({{ empty_string_to_null('datelastactivity') }} as {{ type_timestamp_with_timezone() }}) as datelastactivity,
    cast({{ empty_string_to_null('dateplugindisable') }} as {{ type_timestamp_with_timezone() }}) as dateplugindisable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards_ab1') }}
-- boards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

