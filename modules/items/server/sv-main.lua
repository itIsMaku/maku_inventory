Citizen.CreateThread(function()
    local sqlItems = database.server.FetchSqlItems()
    if table.isEmpty(sqlItems) then return end

    log.warn(
        'You have %s items in your MySQL table \'items\'. All items must be defined in \'configs/items.lua\'.',
        table.size(sqlItems)
    )
end)
