base.settings.keybinds = {
    inventory = GetConvar('maku_inventory:keybind_inventory', 'F2'),
}

function base.client.CanOpenInventory()
    if IsPauseMenuActive() then return false end

    if not base.settings.NUIReady then return false end

    return true
end

function base.client.OpenInventory(inventoryType)
    if not base.client.CanOpenInventory() then return false, 'can_not_open' end

    if inventoryType == nil then return false, 'invalid_type' end

    local playerInventory = inventory.client.Inventory
    if playerInventory == nil then
        lib.shared.warn('Player inventory is not loaded yet')
        return false, 'inventory_not_loaded'
    end

    playerInventory.title = lib.shared.GetLocale(string.format('inventory.%s.title', inventoryType))
    playerInventory.weight = inventory.shared.CalculateInventoryWeight(playerInventory)
    playerInventory.items = inventory.shared.GetDetailedInventoryItems(playerInventory)

    lib.client.SendFrontendMessage('openInventory', {
        playerInventory = playerInventory,
        otherInventories = {}
    })

    lib.client.SetFrontendVisibility(true)
    lib.client.SetFrontendFocus(true)

    base.client.SetPedIntoMenu(true)
end

lib.client.RegisterKey(
    {
        name = 'openInventory',
        description = lib.shared.GetLocale('keybinds.openInventory'),
        mapper = 'keyboard',
        key = base.settings.keybinds.inventory,
        cooldown = 1000
    },
    function(_, args, _)
        base.client.OpenInventory('player')
    end
)

RegisterNetEvent('maku_inventory:load', function()
    lib.client.Disarm()

    SetWeaponsNoAutoswap(false)
    SetWeaponsNoAutoreload(false)

    lib.shared.SetInterval(function()
        -- Weapon Wheel
        HudWeaponWheelIgnoreSelection()
        DisableControlAction(0, 37, true)
    end)
end)
