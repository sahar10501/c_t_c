{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_customfielditems_value_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customfielditems_hashid',
        adapter.quote('date'),
        adapter.quote('text'),
        adapter.quote('number'),
        adapter.quote('option'),
        'checked',
    ]) }} as _airbyte_value_hashid,
    tmp.*
from {{ ref('cards_customfielditems_value_ab2') }} tmp
-- value at cards/customFieldItems/value
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

