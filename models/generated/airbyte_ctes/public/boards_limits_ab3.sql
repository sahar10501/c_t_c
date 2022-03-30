{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_limits_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_boards_hashid',
        'attachments',
    ]) }} as _airbyte_limits_hashid,
    tmp.*
from {{ ref('boards_limits_ab2') }} tmp
-- limits at boards/limits
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

