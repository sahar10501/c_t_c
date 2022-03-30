{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_cover_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        adapter.quote('size'),
        'color',
        'brightness',
        'idattachment',
        boolean_to_string('iduploadedbackground'),
    ]) }} as _airbyte_cover_hashid,
    tmp.*
from {{ ref('cards_cover_ab2') }} tmp
-- cover at cards/cover
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

