{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_limits_attachments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_limits_hashid',
        'perboard',
    ]) }} as _airbyte_attachments_hashid,
    tmp.*
from {{ ref('boards_limits_attachments_ab2') }} tmp
-- attachments at boards/limits/attachments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

