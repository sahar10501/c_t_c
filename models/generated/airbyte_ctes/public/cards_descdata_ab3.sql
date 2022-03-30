{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_descdata_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        'emoji',
    ]) }} as _airbyte_descdata_hashid,
    tmp.*
from {{ ref('cards_descdata_ab2') }} tmp
-- descdata at cards/descData
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

