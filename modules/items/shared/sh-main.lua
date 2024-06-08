local itemsFile = lib.shared.LoadLocalFile('configs/items.lua')

if not itemsFile then
    lib.shared.error('Failed to load items file')
    return
end

---@diagnostic disable-next-line: param-type-mismatch
local itemsList = load(itemsFile)()
if itemsList == nil then
    lib.shared.error('Failed to load items file: items.lua does not return any value')
    return
end

items.list = itemsList
base.items = items.list

function items.shared.GetItem(itemName)
    return items.list[itemName]
end
