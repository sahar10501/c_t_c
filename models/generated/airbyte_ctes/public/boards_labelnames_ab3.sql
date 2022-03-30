{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_labelnames_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_boards_hashid',
        'red',
        'sky',
        'blue',
        'lime',
        'pink',
        'black',
        'green',
        'orange',
        'purple',
        'yellow',
    ]) }} as _airbyte_labelnames_hashid,
    tmp.*
from {{ ref('boards_labelnames_ab2') }} tmp
-- labelnames at boards/labelNames
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

