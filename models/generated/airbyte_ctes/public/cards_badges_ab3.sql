{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_badges_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        'due',
        'votes',
        'fogbugz',
        adapter.quote('comments'),
        boolean_to_string(adapter.quote('location')),
        'checkitems',
        boolean_to_string('subscribed'),
        'attachments',
        boolean_to_string('description'),
        boolean_to_string('duecomplete'),
        'attachmentsbytype',
        'checkitemschecked',
        boolean_to_string('viewingmembervoted'),
        'checkitemsearliestdue',
    ]) }} as _airbyte_badges_hashid,
    tmp.*
from {{ ref('cards_badges_ab2') }} tmp
-- badges at cards/badges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

