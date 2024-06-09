Citizen.CreateThread(function()
    while not base.settings.NUIReady do
        Citizen.Wait(100)
    end

    TriggerServerEvent('maku_inventory:base:load')
end)
