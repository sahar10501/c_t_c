{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_badges_attachmentsbytype_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_badges_hashid',
        'trello',
    ]) }} as _airbyte_attachmentsbytype_hashid,
    tmp.*
from {{ ref('cards_badges_attachmentsbytype_ab2') }} tmp
-- attachmentsbytype at cards/badges/attachmentsByType
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

