--- Send a message to the NUI
---@param action string The action to send
---@param data any The data to send
function lib.client.SendFrontendMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

--- Set the focus of the NUI
---@param value boolean The value to set the focus to
function lib.client.SetFrontendFocus(value)
    SetNuiFocus(value, value)
end

--- Set the visibility of the NUI
---@param visible boolean The visibility to set
function lib.client.SetFrontendVisibility(visible)
    lib.client.SendMessage('setVisible', visible)
    lib.settings.NUIVisible = visible
end
