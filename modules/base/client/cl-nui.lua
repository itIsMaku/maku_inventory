FRONTEND_PED_MENU_HASH = `FE_MENU_VERSION_EMPTY_NO_BACKGROUND`
BLUR_EFFECT = 'MenuMGIn'
SCALEFORM_MOVIE = 'PAUSE_MP_MENU_PLAYER_MODEL'
HUD_COLORS = {
    INACTIVE = { index = 117, r = 0, g = 0, b = 0, a = 150 },
    ACTIVE = { index = 117, r = 0, g = 0, b = 0, a = 0 }
}

base.settings.DrawPed = false


function base.client.LoadNui()
    lib.client.SendFrontendMessage('load', {
        imagePath = GetConvar('maku_inventory:imagePath', 'items')
    })
end

function base.client.SetPedIntoMenu(value)
    base.settings.DrawPed = value

    ActivateFrontendMenu(FRONTEND_PED_MENU_HASH, false, -1)
    local color = HUD_COLORS.INACTIVE
    if value then
        base.settings.NUICanClose = false

        base.settings.HideCursorInterval = lib.shared.SetInterval(function()
            SetMouseCursorVisibleInMenus(false)
        end)

        AnimpostfxPlay(BLUR_EFFECT, 1, true)
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        if DoesEntityExist(base.settings.ClonedPed) then
            lib.shared.warn('Cloned ped already exists, deleting it')
            DeleteEntity(base.settings.ClonedPed)
        end

        base.settings.ClonedPed = ClonePed(playerPed, false, false, false)
        local coords = GetEntityCoords(playerPed)
        SetEntityCoords(base.settings.ClonedPed, coords.x, coords.y, coords.z, false, false, false, false)
        FreezeEntityPosition(base.settings.ClonedPed, true)
        FinalizeHeadBlend(base.settings.ClonedPed)
        GivePedToPauseMenu(base.settings.ClonedPed, 2)

        SetPauseMenuPedLighting(true)
        SetPauseMenuPedSleepState(true)

        lib.client.LoadScaleformMovie(SCALEFORM_MOVIE)

        color = HUD_COLORS.ACTIVE
        ReplaceHudColourWithRgba(color.index, color.r, color.g, color.b, color.a)

        base.settings.NUICanClose = true
        return
    end

    local success = lib.shared.ClearInterval(base.settings.HideCursorInterval)
    if not success then
        lib.shared.warn('Failed to clear interval for hiding cursor')
    end

    DeleteEntity(base.settings.ClonedPed)

    AnimpostfxStop(BLUR_EFFECT)
    ReplaceHudColourWithRgba(color.index, color.r, color.g, color.b, color.a)
end

RegisterNUICallback('loaded', function(_, callback)
    base.settings.NUIReady = true

    lib.shared.info('UI is ready')

    callback(nil)
end)

RegisterNUICallback('close', function(_, callback)
    if not base.settings.NUICanClose then
        lib.shared.debug('UI can not be closed so fast')
        return
    end

    base.client.CloseInventory()

    callback(nil)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    if base.settings.DrawPed then
        base.client.SetPedIntoMenu(false)
    end
end)
