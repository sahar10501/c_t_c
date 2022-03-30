{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'due',
        'pos',
        'url',
        adapter.quote('desc'),
        adapter.quote('name'),
        'cover',
        adapter.quote('start'),
        'badges',
        boolean_to_string('closed'),
        'idlist',
        array_to_string('labels'),
        'idboard',
        'idshort',
        'descdata',
        array_to_string('idlabels'),
        'shorturl',
        array_to_string('idmembers'),
        'shortlink',
        boolean_to_string('istemplate'),
        boolean_to_string('subscribed'),
        boolean_to_string('duecomplete'),
        'duereminder',
        'idchecklists',
        array_to_string('idmembersvoted'),
        array_to_string('checkitemstates'),
        array_to_string('customfielditems'),
        'datelastactivity',
        'idattachmentcover',
        boolean_to_string('manualcoverattachment'),
    ]) }} as _airbyte_cards_hashid,
    tmp.*
from {{ ref('cards_ab2') }} tmp
-- cards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

