local frameworkModule = framework.settings.FrameworkModule
local frameworkResource = framework.settings.FrameworkResource

local frameworkResources = {
    ['es_extended'] = 'esx',
    ['qb-core'] = 'qb-core',
}

local function loadFramework(module, resource)
    local side = 'cl'
    if IsDuplicityVersion() then
        side = 'sv'
    end

    local file = lib.shared.LoadLocalFile(string.format('modules/framework/%s/%s-main.lua', module, side))
    if file == nil then
        lib.shared.error('Failed to load framework: %s-main.lua is not present in %s', side, module)
        return
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    local result = load(file)()
    if result == nil or result.Load == nil then
        lib.shared.error('Failed to load framework: %s/%s-main.lua does not return load value', module, side)
        return
    end

    if IsDuplicityVersion() then
        framework.server = result.Load(resource)
        return
    end

    framework.client = result.Load(resource)
end

local found = false
for resource, module in pairs(frameworkResources) do
    if lib.shared.IsResourcePresent(resource) then
        loadFramework(module, resource)
        found = true
        break
    end
end

if not found then
    if lib.shared.IsResourcePresent(frameworkResource) then
        loadFramework(frameworkModule, frameworkResource)
        return
    end

    lib.shared.error('Failed to load framework: %s is not present on server', frameworkResource)
end
