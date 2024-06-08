local function load(resource)
    local ESX = exports[resource]:getSharedObject()

    local function getIdentifier(client)
        local player = ESX.GetPlayerFromId(client)
        if player == nil then return nil end

        return player.identifier
    end

    return {
        GetIdentifier = getIdentifier
    }
end

return {
    Load = load
}
