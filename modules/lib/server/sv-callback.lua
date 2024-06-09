CALLBACKS_EVENT = lib.settings.CallbacksEvent

lib.server.callbacks = {}

--- Register a callback for the client to call
--- @param name string The name of the callback
--- @param callback function The callback function
function lib.server.RegisterCallback(name, callback)
    lib.server.callbacks[name] = {
        fun = callback
    }
end

RegisterNetEvent(CALLBACKS_EVENT, function(callbackName, ...)
    local client = source
    local callback = lib.server.callbacks[callbackName]
    if callback == nil then
        lib.shared.error('Callback can not be completed: %s does not exist', callbackName)
        return
    end

    if callback.fun == nil then
        lib.shared.error('Callback can not be completed: %s does not have a function', callbackName)
        return
    end

    TriggerClientEvent(CALLBACKS_EVENT, client, callbackName, callback.fun(client, ...))
end)
