--- Load a model.
--- @param model string|number The model name or hash.
--- @return number model The model hash.
function lib.client.LoadModel(model)
    if type(model) == 'string' then
        model = joaat(model)
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    return model
end

--- Load a scaleform movie.
--- @param scaleform string The scaleform name.
function lib.client.LoadScaleformMovie(scaleform)
    RequestScaleformMovie(scaleform)
end

--- @class BlipData
--- @field coords vector3 The blip coordinates.
--- @field color number|nil The blip color.
--- @field sprite number|nil The blip sprite.
--- @field scale number|nil The blip scale.
--- @field display number|nil The blip display.
--- @field isShortRange boolean|nil The blip short range.
--- @field alpha number|nil The blip alpha.
--- @field isBright boolean|nil The blip brightness.
--- @field category number|nil The blip category.
--- @field fade table|nil The blip fade.
--- @field label string The blip label.

--- Create new blip on the map.
--- @param blipData BlipData The blip data.
--- @return number blip The blip handle.
function lib.client.CreateBlip(blipData)
    local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)

    if blipData.sprite ~= nil then
        SetBlipSprite(blip, blipData.sprite)
    else
        SetBlipSprite(blip, 1)
    end

    if blipData.scale ~= nil then
        SetBlipScale(blip, blipData.scale)
    else
        SetBlipScale(blip, 0.8)
    end

    if blipData.color ~= nil then
        SetBlipColour(blip, blipData.color)
    else
        SetBlipColour(blip, 4)
    end

    if blipData.display ~= nil then
        SetBlipDisplay(blip, blipData.display)
    else
        SetBlipDisplay(blip, 4)
    end

    if blipData.isShortRange ~= nil then
        SetBlipAsShortRange(blip, blipData.isShortRange)
    else
        SetBlipAsShortRange(blip, true)
    end

    if blipData.alpha ~= nil then
        SetBlipAlpha(blip, blipData.alpha)
    end

    if blipData.isBright ~= nil then
        SetBlipBright(blip, blipData.isBright)
    end

    if blipData.category ~= nil then
        SetBlipCategory(blip, blipData.category)
    end

    if blipData.fade ~= nil then
        SetBlipFade(blip, blipData.fade.opacity, blipData.fade.duration)
    end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blipData.label)
    EndTextCommandSetBlipName(blip)

    return blip
end

--- Remove a blip from the map.
--- @param blip number The blip handle.
--- @return boolean success true if the blip was removed, false otherwise.
function lib.client.RemoveBlip(blip)
    if not DoesBlipExist(blip) then return false end

    RemoveBlip(blip)

    return true
end

--- Rename a blip on the map.
--- @param blip number The blip handle.
--- @param label string The new blip label.
--- @return boolean success true if the blip was renamed, false otherwise.
function lib.client.RenameBlip(blip, label)
    if not DoesBlipExist(blip) then return false end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)

    return true
end

local commandsCooldowns = {}

--- Register a key mapping.
--- @param options table The key mapping options.
--- @param callback function The key mapping callback.
function lib.client.RegisterKey(options, callback)
    local command = string.format('maku_inventory:%s', options.name)
    RegisterCommand(command, function(client, args, raw)
        if options.cooldown == nil then
            callback(client, args, raw)
            return
        end

        local cooldown = commandsCooldowns[command]
        if cooldown ~= nil then
            lib.shared.debug('Command is on cooldown')
            return
        end

        commandsCooldowns[command] = true
        SetTimeout(options.cooldown, function()
            commandsCooldowns[command] = nil
        end)

        callback(client, args, raw)
    end, false)
    RegisterKeyMapping(command, options.description, options.mapper, options.key)
end

function lib.client.Disarm()
    local playerPed = PlayerPedId()
    ClearPedTasksImmediately(playerPed)
    SetCurrentPedWeapon(playerPed, joaat('WEAPON_UNARMED'), true)
end
