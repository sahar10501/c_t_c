{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_badges_attachmentsbytype_trello_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_attachmentsbytype_hashid',
        'card',
        'board',
    ]) }} as _airbyte_trello_hashid,
    tmp.*
from {{ ref('cards_badges_attachmentsbytype_trello_ab2') }} tmp
-- trello at cards/badges/attachmentsByType/trello
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

