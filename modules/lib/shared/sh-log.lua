local function getImmediateModule(filePath)
    local startIndex, endIndex = string.find(filePath, 'modules/')
    if startIndex then
        local remainingPath = string.sub(filePath, endIndex + 1)
        local nextSlashIndex = string.find(remainingPath, '/')
        if nextSlashIndex then
            return string.sub(remainingPath, 1, nextSlashIndex - 1)
        end

        return remainingPath
    end

    return 'main'
end

local prefixes = {
    ['error'] = '^1[module: %s | error] ^7',
    ['warn'] = '^3[module: %s | warn] ^7',
    ['info'] = '^2[module: %s | info] ^7',
    ['load'] = '^3[module: %s | load] ^7',
    ['debug'] = '^5[module: %s | debug] ^7',
}

log = {}

for name, prefix in pairs(prefixes) do
    if name == 'debug' and not lib.settings.Debug then
        log.debug = function(content, ...)
        end
    else
        log[name] = function(content, ...)
            local source = debug.getinfo(2, 'S').source
            print(prefix:format(getImmediateModule(source)) .. content:format(...))
        end
    end
end

function log.table(_table, debug)
    if debug and not lib.settings.Debug then return end

    if type(_table) ~= 'table' then return end

    print(json.encode(_table, { indent = true }))
end

lib.log.origin = log

function lib.log.error(value, ...)
    return error(value:format(...))
end

function lib.log.warn(value, ...)
    return warn(value:format(...))
end

function lib.log.debug(value, ...)
    return log.debug(value, ...)
end

function lib.log.info(value, ...)
    return log.info(value, ...)
end
