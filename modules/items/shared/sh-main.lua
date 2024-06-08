local itemsFile = lib.shared.LoadLocalFile('configs/items.lua')

if not itemsFile then
    lib.shared.error('Failed to load items file')
    return
end

---@diagnostic disable-next-line: param-type-mismatch
local items = load(itemsFile)()
if items == nil then
    lib.shared.error('Failed to load items file: items.lua does not return any value')
    return
end

base.items = items
