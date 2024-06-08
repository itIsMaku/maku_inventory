function inventory.client.UpdateInventory(inv)
    lib.shared.debug('Updating inventory')
    -- lib.shared.debugTable(inv)

    inventory.client.Inventory = inv
end

RegisterNetEvent('maku_inventory:inventory:updateInventory', inventory.client.UpdateInventory)
