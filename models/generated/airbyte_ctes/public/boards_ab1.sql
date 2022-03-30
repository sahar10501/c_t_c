{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_boards') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', '_airbyte_data', ['prefs'], ['prefs']) }} as prefs,
    {{ json_extract_scalar('_airbyte_data', ['closed'], ['closed']) }} as closed,
    {{ json_extract_array('_airbyte_data', ['idTags'], ['idTags']) }} as idtags,
    {{ json_extract('table_alias', '_airbyte_data', ['limits'], ['limits']) }} as limits,
    {{ json_extract_scalar('_airbyte_data', ['pinned'], ['pinned']) }} as pinned,
    {{ json_extract_scalar('_airbyte_data', ['starred'], ['starred']) }} as starred,
    {{ json_extract_scalar('_airbyte_data', ['descData'], ['descData']) }} as descdata,
    {{ json_extract_scalar('_airbyte_data', ['ixUpdate'], ['ixUpdate']) }} as ixupdate,
    {{ json_extract_array('_airbyte_data', ['powerUps'], ['powerUps']) }} as powerups,
    {{ json_extract_scalar('_airbyte_data', ['shortUrl'], ['shortUrl']) }} as shorturl,
    {{ json_extract_scalar('_airbyte_data', ['shortLink'], ['shortLink']) }} as shortlink,
    {{ json_extract('table_alias', '_airbyte_data', ['labelNames'], ['labelNames']) }} as labelnames,
    {{ json_extract_scalar('_airbyte_data', ['subscribed'], ['subscribed']) }} as subscribed,
    {{ json_extract_array('_airbyte_data', ['memberships'], ['memberships']) }} as memberships,
    {{ json_extract_scalar('_airbyte_data', ['dateLastView'], ['dateLastView']) }} as datelastview,
    {{ json_extract_scalar('_airbyte_data', ['idEnterprise'], ['idEnterprise']) }} as identerprise,
    {{ json_extract_scalar('_airbyte_data', ['idBoardSource'], ['idBoardSource']) }} as idboardsource,
    {{ json_extract_scalar('_airbyte_data', ['creationMethod'], ['creationMethod']) }} as creationmethod,
    {{ json_extract_scalar('_airbyte_data', ['idOrganization'], ['idOrganization']) }} as idorganization,
    {{ json_extract_scalar('_airbyte_data', ['enterpriseOwned'], ['enterpriseOwned']) }} as enterpriseowned,
    {{ json_extract_array('_airbyte_data', ['premiumFeatures'], ['premiumFeatures']) }} as premiumfeatures,
    {{ json_extract_scalar('_airbyte_data', ['templateGallery'], ['templateGallery']) }} as templategallery,
    {{ json_extract_scalar('_airbyte_data', ['dateLastActivity'], ['dateLastActivity']) }} as datelastactivity,
    {{ json_extract_scalar('_airbyte_data', ['datePluginDisable'], ['datePluginDisable']) }} as dateplugindisable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_boards') }} as table_alias
-- boards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

