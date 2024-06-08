--- Load the current locale file.
--- @param locale string The locale to load.
--- @return boolean success true if the file was loaded successfully, false otherwise.
--- @return string|nil error The error message if the file was not loaded successfully.
function lib.locales.Load(locale)
    if locale == nil then return false, 'locale_not_provided' end

    local localeFile = lib.CFX.LoadLocalFile(string.format('locales/%s.json', locale), { json = true })
    if localeFile == nil then return false, 'file_not_found' end

    lib.locales.Current = localeFile

    return true, nil
end

--- Get a locale string.
--- @param key string The key of the locale string.
--- @param ... any The arguments to format the locale string.
--- @return string locale The locale string.
function lib.locales.Get(key, ...)
    local locales = lib.locales.Current
    if locales == nil then return key end

    return string.format(locales[key] or key, ...)
end
