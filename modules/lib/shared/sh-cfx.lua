--- Check if a resource is present on server.
--- @param resourceName string The name of the resource to check.
--- @return boolean result true if the resource is present, false otherwise.
function lib.shared.IsResourcePresent(resourceName)
    local state = GetResourceState(resourceName)
    return state == 'started' or state == 'starting'
end

--- Load a local file from the current resource.
--- @param path string The path to the file.
--- @param options table|nil Options to apply to the file content.
--- @return string|table|nil content file content or nil if the file does not exist.
function lib.shared.LoadLocalFile(path, options)
    local localFile = LoadResourceFile(GetCurrentResourceName(), path)

    if localFile == nil then return nil end

    if options == nil then return localFile end

    if options.json then return json.decode(localFile) end

    return localFile
end
