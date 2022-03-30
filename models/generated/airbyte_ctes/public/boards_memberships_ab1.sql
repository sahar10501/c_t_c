{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('boards') }}
{{ unnest_cte(ref('boards'), 'boards', 'memberships') }}
select
    _airbyte_boards_hashid,
    {{ json_extract_scalar(unnested_column_value('memberships'), ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar(unnested_column_value('memberships'), ['idMember'], ['idMember']) }} as idmember,
    {{ json_extract_scalar(unnested_column_value('memberships'), ['memberType'], ['memberType']) }} as membertype,
    {{ json_extract_scalar(unnested_column_value('memberships'), ['deactivated'], ['deactivated']) }} as deactivated,
    {{ json_extract_scalar(unnested_column_value('memberships'), ['unconfirmed'], ['unconfirmed']) }} as unconfirmed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('boards') }} as table_alias
-- memberships at boards/memberships
{{ cross_join_unnest('boards', 'memberships') }}
where 1 = 1
and memberships is not null
{{ incremental_clause('_airbyte_emitted_at') }}

