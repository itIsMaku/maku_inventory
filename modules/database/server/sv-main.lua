MySQL.ready(function()
    MySQL.execute([[
        CREATE TABLE IF NOT EXISTS `maku_inventory_inventories` (
	        `id` INT(10) NOT NULL AUTO_INCREMENT,
	        `inventory_type` VARCHAR(50) NOT NULL,
	        `inventory_name` TEXT NOT NULL,
	        `item` TEXT NOT NULL,
	        `amount` INT(10) NOT NULL,
	        `slot` INT(10) NOT NULL,
	        `data` TEXT NOT NULL,
	        PRIMARY KEY (`id`) USING BTREE
        );
    ]])
end)

function database.server.LoadInventory(data)
    local response = MySQL.rawExecute.await(
        'SELECT * FROM maku_inventory_inventories WHERE inventory_type = ? AND inventory_name = ?',
        {
            data.type,
            data.name
        }
    )

    return response
end

function database.server.FetchSqlItems()
    local success, response = pcall(function()
        return MySQL.rawExecute.await('SELECT * FROM items')
    end)
    if not success then return {} end

    local sqlItems = {}
    for _, item in ipairs(response) do
        sqlItems[item.name] = item
    end

    return sqlItems
end
