--- Load a model.
--- @param model string|number The model name or hash.
--- @return number model The model hash.
function lib.CFX.LoadModel(model)
    if type(model) == 'string' then
        model = joaat(model)
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    return model
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
function lib.CFX.CreateBlip(blipData)
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
function lib.CFX.RemoveBlip(blip)
    if not DoesBlipExist(blip) then return false end

    RemoveBlip(blip)

    return true
end

--- Rename a blip on the map.
--- @param blip number The blip handle.
--- @param label string The new blip label.
--- @return boolean success true if the blip was renamed, false otherwise.
function lib.CFX.RenameBlip(blip, label)
    if not DoesBlipExist(blip) then return false end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)

    return true
end
