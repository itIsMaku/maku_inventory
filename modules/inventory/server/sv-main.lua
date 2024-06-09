local cachedInventories = {}

local function loadInventory(type, name, data)
    if data == nil then data = {} end

    local response = database.server.LoadInventory({
        type = type,
        name = name
    })

    local inv = {
        type = type,
        name = name,
        items = {},
        maxWeight = data.maxWeight,
        client = data.client
    }

    for _, row in ipairs(response) do
        local item = {
            name = row.item,
            amount = row.amount,
            slot = row.slot,
            data = json.decode(row.data)
        }

        table.insert(inv.items, item)
    end

    -- lib.shared.debugTable(inv)

    return inv
end

function inventory.server.GetInventory(type, name, data)
    if cachedInventories[type] == nil then
        cachedInventories[type] = {}
    end

    if cachedInventories[type][name] == nil then
        cachedInventories[type][name] = loadInventory(type, name, data)
    end

    return cachedInventories[type][name]
end

function inventory.server.UpdateInventory(type, name, inv, client)
    -- TODO: Implement

    cachedInventories[type][name] = inv
    TriggerClientEvent('maku_inventory:inventory:updateInventory', client, inv)
end

lib.server.RegisterCallback('getInventories', function(client, inventoriesTypes)
    local inventories = {}
    for _, inv in ipairs(inventoriesTypes) do
        local invInstance = inventory.server.GetInventory(inv.type, inv.name, {
            maxWeight = inv.maxWeight,
        })

        table.insert(inventories, invInstance)
    end

    return inventories
end)
