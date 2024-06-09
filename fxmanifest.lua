fx_version 'cerulean'
game 'gta5'
version '0.1.0-alpha'

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
    'modules/lib/shared/sh-interval.lua',

    -- Base module
    'modules/base/base.lua',
    'modules/base/shared/sh-main.lua',

    -- Inventory module
    'modules/inventory/inventory.lua',
    'modules/inventory/shared/sh-main.lua',

    -- Items module
    'modules/items/items.lua',
    'modules/items/shared/sh-main.lua',

    -- Framework module
    'modules/framework/framework.lua',
    'modules/framework/shared/sh-main.lua',
}

client_scripts {
    -- Lib module
    'modules/lib/client/cl-cfx.lua',
    'modules/lib/client/cl-nui.lua',
    'modules/lib/client/cl-callback.lua',

    -- Base module
    'modules/base/client/cl-init.lua',
    'modules/base/client/cl-main.lua',
    'modules/base/client/cl-nui.lua',

    -- Inventory module
    'modules/inventory/client/cl-main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    -- Lib module
    'modules/lib/server/sv-callback.lua',

    -- Base module
    'modules/base/server/sv-main.lua',

    -- Database module
    'modules/database/database.lua',
    'modules/database/server/sv-main.lua',

    -- Inventory module
    'modules/inventory/server/sv-main.lua',

    -- Items module
    'modules/items/server/sv-main.lua',
}

ui_page 'web/build/index.html'

files {
    'locales/*.json',

    'modules/framework/**/cl-main.lua',
    'configs/items.lua',
    'configs/vehicles.lua',

    'web/build/**/*'
}

dependencies {
    '/onesync',
    'oxmysql',
}
