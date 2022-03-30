{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'pos',
        adapter.quote('name'),
        boolean_to_string('closed'),
        'idboard',
        'softlimit',
        boolean_to_string('subscribed'),
    ]) }} as _airbyte_lists_hashid,
    tmp.*
from {{ ref('lists_ab2') }} tmp
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

