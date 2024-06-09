local function loadPlayerInventory(client)
    local identifier = framework.server.GetIdentifier(client)
    local inventory = inventory.server.GetInventory('player', identifier, {
        maxWeight = inventory.settings.PlayerMaxWeight,
        client = client
    })

    TriggerClientEvent('maku_inventory:inventory:updateInventory', client, inventory)
end

RegisterNetEvent('maku_inventory:base:load', function()
    local client = source

    local identifier = framework.server.GetIdentifier(client)
    if identifier == nil then
        lib.shared.debug('Skipping identifier for client %d', client)
        return
    end

    loadPlayerInventory(client)

    TriggerClientEvent('maku_inventory:base:load', client)
end)

RegisterCommand('givetest', function(client)
    local identifier = framework.server.GetIdentifier(client)
    MySQL.insert(
        'INSERT INTO maku_inventory_inventories (inventory_type, inventory_name, item, amount, slot, data) VALUES (?, ?, ?, ?, ?, ?)',
        {
            'player',
            identifier,
            'weapon_heavypistol',
            1,
            1,
            '{}'
        })
end, false)
