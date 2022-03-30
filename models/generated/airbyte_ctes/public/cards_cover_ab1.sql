{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cards') }}
select
    _airbyte_cards_hashid,
    {{ json_extract_scalar('cover', ['size'], ['size']) }} as {{ adapter.quote('size') }},
    {{ json_extract_scalar('cover', ['color'], ['color']) }} as color,
    {{ json_extract_scalar('cover', ['brightness'], ['brightness']) }} as brightness,
    {{ json_extract_scalar('cover', ['idAttachment'], ['idAttachment']) }} as idattachment,
    {{ json_extract_scalar('cover', ['idUploadedBackground'], ['idUploadedBackground']) }} as iduploadedbackground,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cards') }} as table_alias
-- cover at cards/cover
where 1 = 1
and cover is not null
{{ incremental_clause('_airbyte_emitted_at') }}

