base.settings.keybinds = {
    Inventory = GetConvar('maku_inventory:keybind_inventory', 'F2'),
    Hotbar = GetConvar('maku_inventory:keybind_hotbar', 'TAB')
}

lib.client.RegisterKey(
    {
        name = 'openInventory',
        description = lib.shared.GetLocale('keybinds.openInventory'),
        mapper = 'keyboard',
        key = base.settings.keybinds.Inventory,
        cooldown = 1000
    },
    function(_, args, _)
        local success, error = inventory.client.OpenInventory({
            {
                type = 'trunk',
                name = 'ABC123',
                data = {
                    model = 'sultanrs'
                }
            },
            {
                type = 'glovebox',
                name = 'ABC123',
                data = {
                    model = 'sultan2'
                }
            }
        })
        if not success then
            lib.shared.warn('Failed to open inventory: %s', error)
        end
    end
)

lib.client.RegisterKey(
    {
        name = 'showHotbar',
        description = lib.shared.GetLocale('keybinds.showHotbar'),
        mapper = 'keyboard',
        key = base.settings.keybinds.Hotbar,
    },
    function(_, args, _)
        if IsNuiFocused() then return end

        lib.client.SendFrontendMessage('showHotbar', true)
    end
)

RegisterNetEvent('maku_inventory:base:load', function()
    base.client.LoadNui()

    lib.client.Disarm()

    SetWeaponsNoAutoswap(false)
    SetWeaponsNoAutoreload(false)

    lib.shared.SetInterval(function()
        -- Weapon Wheel
        HudWeaponWheelIgnoreSelection()
        DisableControlAction(0, 37, true)
    end)
end)
