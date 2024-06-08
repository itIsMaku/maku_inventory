function inventory.shared.CalculateInventoryWeight(inv)
    local weight = 0
    for _, item in ipairs(inv.items) do
        local itemInstance = items.shared.GetItem(item.name)
        weight = weight + (itemInstance and itemInstance.weight or 0)
    end

    return weight
end

function inventory.shared.GetDetailedInventoryItems(inv)
    local retval = {}
    for _, item in ipairs(inv.items) do
        local itemInstance = items.shared.GetItem(item.name)
        item.weight = itemInstance and itemInstance.weight or 0
        item.label = itemInstance and itemInstance.label or item.name

        table.insert(retval, item)
    end

    return retval
end
