{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_memberships_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_boards_hashid',
        adapter.quote('id'),
        'idmember',
        'membertype',
        boolean_to_string('deactivated'),
        boolean_to_string('unconfirmed'),
    ]) }} as _airbyte_memberships_hashid,
    tmp.*
from {{ ref('boards_memberships_ab2') }} tmp
-- memberships at boards/memberships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

