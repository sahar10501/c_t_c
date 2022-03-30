{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_labels_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        adapter.quote('id'),
        adapter.quote('name'),
        'color',
        'idboard',
    ]) }} as _airbyte_labels_hashid,
    tmp.*
from {{ ref('cards_labels_ab2') }} tmp
-- labels at cards/labels
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

