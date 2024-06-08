base.settings.Locale = GetConvar('maku_inventory:locale', 'en')

local success, reason = lib.locales.Load(base.settings.Locale)
if not success then
    lib.log.error('Failed to load locale file: %s, %s', base.settings.Locale, reason)
end

lib.log.debug('Loaded locale file: %s', base.settings.Locale)
