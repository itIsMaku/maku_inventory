lib = {
    settings = {},

    shared = {},
    client = {},
    server = {},
}

lib.settings.Debug = GetConvarInt('maku_inventory:debug', 0) == 1
