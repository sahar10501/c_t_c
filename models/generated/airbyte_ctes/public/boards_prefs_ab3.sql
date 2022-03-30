{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('boards_prefs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_boards_hashid',
        'voting',
        boolean_to_string('canbeorg'),
        adapter.quote('comments'),
        boolean_to_string('selfjoin'),
        boolean_to_string('caninvite'),
        'cardaging',
        boolean_to_string('hidevotes'),
        'background',
        boolean_to_string('cardcovers'),
        boolean_to_string('istemplate'),
        boolean_to_string('canbepublic'),
        'invitations',
        boolean_to_string('canbeprivate'),
        boolean_to_string('backgroundtile'),
        'backgroundimage',
        boolean_to_string('canbeenterprise'),
        'permissionlevel',
        'backgroundtopcolor',
        boolean_to_string('calendarfeedenabled'),
        'backgroundbrightness',
        'backgroundbottomcolor',
        array_to_string('backgroundimagescaled'),
    ]) }} as _airbyte_prefs_hashid,
    tmp.*
from {{ ref('boards_prefs_ab2') }} tmp
-- prefs at boards/prefs
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

