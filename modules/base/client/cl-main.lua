base.settings.keybinds = {
    inventory = GetConvar('maku_inventory:keybind_inventory', 'F2'),
}

function base.client.OpenInventory(inventoryType)
    if inventoryType == nil then return false, 'invalid_type' end

    local playerInventory = inventory.client.Inventory
    if playerInventory == nil then
        lib.shared.warn('Player inventory is not loaded yet')
        return false, 'inventory_not_loaded'
    end
end

lib.client.RegisterKey(
    {
        name = 'openInventory',
        description = lib.shared.GetLocale('keybinds.openInventory'),
        mapper = 'keyboard',
        key = base.settings.keybinds.inventory
    },
    function(_, args, _)
        base.client.OpenInventory('player')
    end
)

Citizen.CreateThread(function()
    TriggerServerEvent('maku_inventory:load')
end)
