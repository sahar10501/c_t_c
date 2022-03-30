{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_prefs_backgroundimagescaled_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_prefs_hashid',
        'url',
        'width',
        'height',
    ]) }} as _airbyte_backgroundimagescaled_hashid,
    tmp.*
from {{ ref('boards_prefs_backgroundimagescaled_ab2') }} tmp
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

