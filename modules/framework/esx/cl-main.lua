local function load(resource)
    local ESX = exports[resource]:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function()
        TriggerServerEvent('maku_inventory:base:load')
    end)

    return {

    }
end

return {
    Load = load
}
