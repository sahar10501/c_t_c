{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'url',
        adapter.quote('desc'),
        adapter.quote('name'),
        'prefs',
        boolean_to_string('closed'),
        array_to_string('idtags'),
        'limits',
        boolean_to_string('pinned'),
        boolean_to_string('starred'),
        'descdata',
        'ixupdate',
        array_to_string('powerups'),
        'shorturl',
        'shortlink',
        'labelnames',
        boolean_to_string('subscribed'),
        array_to_string('memberships'),
        'datelastview',
        'identerprise',
        'idboardsource',
        'creationmethod',
        'idorganization',
        boolean_to_string('enterpriseowned'),
        array_to_string('premiumfeatures'),
        'templategallery',
        'datelastactivity',
        'dateplugindisable',
    ]) }} as _airbyte_boards_hashid,
    tmp.*
from {{ ref('boards_ab2') }} tmp
-- boards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

