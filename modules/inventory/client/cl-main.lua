function inventory.client.UpdateInventory(inv)
    lib.shared.debug('Updating inventory')
    -- lib.shared.debugTable(inv)

    Player.inventory = inv
end

RegisterNetEvent('maku_inventory:inventory:updateInventory', inventory.client.UpdateInventory)

function inventory.client.CanOpenInventory()
    if IsPauseMenuActive() then return false, 'pausemenu_active' end

    if not base.settings.NUIReady then return false, 'nui_not_ready' end

    if Player.inventoryOpened then return false, 'already_opened' end

    return true
end

function inventory.client.OpenInventory(inventories)
    local success, error = inventory.client.CanOpenInventory()
    if not success then return false, error end

    if inventories == nil then inventories = {} end

    local playerInventory = Player.inventory
    if playerInventory == nil then
        lib.shared.warn('Player inventory is not loaded yet')
        return false, 'inventory_not_loaded'
    end

    playerInventory.title = lib.shared.GetLocale(string.format('inventory.%s.title', playerInventory.type))
    playerInventory.weight = inventory.shared.CalculateInventoryWeight(playerInventory)
    playerInventory.items = inventory.shared.GetDetailedInventoryItems(playerInventory)

    if not table.isEmpty(inventories) then
        local request = {}
        for _, inv in ipairs(inventories) do
            table.insert(request, {
                type = inv.type,
                name = inv.name,
                maxWeight = inventory.client.GetInventoryMaxWeight(inv.type, inv.data)
            })
        end

        inventories = lib.client.TriggerCallback('getInventories', request)
    end

    local otherInventories = {}
    for _, inv in ipairs(inventories) do
        inv.title = lib.shared.GetLocale(string.format('inventory.%s.title', inv.type), inv.name)
        inv.weight = inventory.shared.CalculateInventoryWeight(inv)
        inv.items = inventory.shared.GetDetailedInventoryItems(inv)

        table.insert(otherInventories, inv)
    end

    lib.client.SendFrontendMessage('openInventory', {
        playerInventory = playerInventory,
        otherInventories = otherInventories
    })

    base.client.SetPedIntoMenu(true)

    lib.client.SetFrontendVisibility(true)
    lib.client.SetFrontendFocus(true)

    Player.inventoryOpened = true

    return true
end

function inventory.client.CloseInventory()
    if not Player.inventoryOpened then return false, 'inventory_not_opened' end

    base.client.SetPedIntoMenu(false)

    lib.client.SetFrontendVisibility(false)
    lib.client.SetFrontendFocus(false)

    Player.inventoryOpened = false

    return true
end

function inventory.client.GetInventoryMaxWeight(type, data)
    data = data or {}
    if type == 'player' then return inventory.settings.PlayerMaxWeight end

    if type == 'trunk' or type == 'glovebox' then
        local vehicleSettings = inventory.shared.VehicleSettings[type]
        if vehicleSettings == nil then
            lib.shared.warn('Vehicle settings for type %s not found', type)
            return 0
        end

        local base = vehicleSettings.base.maxWeight
        local model = data.model
        if model == nil then
            lib.shared.debug('Vehicle model not found in data, using base')
            return base
        end

        local vehicleClass = GetVehicleClassFromName(model)
        if vehicleClass == nil then
            lib.shared.warn('Vehicle class not found for model %s', model)
            return base
        end

        local classData = vehicleSettings.classes[vehicleClass]
        local modelData = vehicleSettings.models[model]
        if modelData == nil or modelData.maxWeight == nil then
            return classData and classData.maxWeight or base
        end

        return modelData.maxWeight
    end

    return 0
end
