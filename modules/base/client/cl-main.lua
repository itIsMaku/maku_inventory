base.settings.keybinds = {
    inventory = GetConvar('maku_inventory:keybind_inventory', 'F2'),
}

lib.client.RegisterKey(
    {
        name = 'openInventory',
        description = lib.shared.GetLocale('keybinds.openInventory'),
        mapper = 'keyboard',
        key = base.settings.keybinds.inventory,
        cooldown = 1000
    },
    function(_, args, _)
        local success, error = inventory.client.OpenInventory({
            {
                type = 'trunk',
                name = 'ABC123',
                model = 'sultanrs'
            },
            {
                type = 'glovebox',
                name = 'ABC123',
                model = 'sultan2'
            }
        })
        if not success then
            lib.shared.warn('Failed to open inventory: %s', error)
        end
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
