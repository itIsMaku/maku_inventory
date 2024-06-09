lib = {
    settings = {},

    shared = {},
    client = {},
    server = {},
}

lib.settings.Debug = GetConvarInt('maku_inventory:debug', 0) == 1
lib.settings.CallbacksEvent = 'maku_inventory:callbacks'
