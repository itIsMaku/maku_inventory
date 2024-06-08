base.settings.Locale = GetConvar('maku_inventory:locale', 'en')

local success, reason = lib.shared.LoadLocales(base.settings.Locale)
if not success then
    lib.shared.error('Failed to load locale file: %s, %s', base.settings.Locale, reason)
end

lib.shared.debug('Loaded locale file: %s', base.settings.Locale)
