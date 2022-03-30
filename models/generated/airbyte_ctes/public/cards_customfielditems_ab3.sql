{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_customfielditems_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        adapter.quote('id'),
        adapter.quote('value'),
        'idmodel',
        'idvalue',
        'modeltype',
        'idcustomfield',
    ]) }} as _airbyte_customfielditems_hashid,
    tmp.*
from {{ ref('cards_customfielditems_ab2') }} tmp
-- customfielditems at cards/customFieldItems
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

