fx_version 'cerulean'
game 'gta5'
version '0.0.0'

author 'itIsMaku - maku#5434 (itismaku)'
description 'inventory system'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
    -- Lib module
    'modules/lib/lib.lua',

    'modules/lib/shared/sh-log.lua',
    'modules/lib/shared/sh-table.lua',
    'modules/lib/shared/sh-cfx.lua',
    'modules/lib/shared/sh-locales.lua',

    -- Base module
    'modules/base/base.lua',

    'modules/base/shared/sh-main.lua',
}

client_scripts {
    -- Lib module
    'modules/lib/client/cl-cfx.lua',

    -- Base module
    'modules/base/client/cl-main.lua',
}

files {
    'locales/*.json',
}

dependencies {
    '/onesync',
    'oxmysql',
}
