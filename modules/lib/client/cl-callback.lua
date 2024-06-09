CALLBACKS_EVENT = lib.settings.CallbacksEvent

lib.client.callbacks = {}

--- Trigger a callback to the server and wait for the response
--- @param callbackName string The name of the callback
--- @vararg any The arguments to pass to the callback
--- @return any The response from the callback
function lib.client.TriggerCallback(callbackName, ...)
    local p = promise.new()

    TriggerServerEvent(CALLBACKS_EVENT, callbackName, ...)

    lib.client.callbacks[callbackName] = {
        promise = p
    }

    return Citizen.Await(p)
end

--- Trigger a callback to the server and run a callback when the response is received
--- @param callbackName string The name of the callback
--- @param callback function The callback to run when the response is received
--- @vararg any The arguments to pass to the callback
function lib.client.TriggerCallbackAsync(callbackName, callback, ...)
    TriggerServerEvent(CALLBACKS_EVENT, callbackName, ...)

    lib.client.callbacks[callbackName] = {
        fun = callback
    }
end

RegisterNetEvent(CALLBACKS_EVENT, function(callbackName, ...)
    local callback = lib.client.callbacks[callbackName]
    if callback == nil then
        lib.shared.error('Callback can not be completed: %s does not exist', callbackName)
        return
    end

    if callback.fun == nil then
        if callback.promise == nil then
            lib.shared.error('Callback can not be completed: Promise %s does not exist', callbackName)
            return
        end

        callback.promise:resolve(...)

        lib.client.callbacks[callbackName] = nil
        return
    end

    callback.fun(...)

    lib.client.callbacks[callbackName] = nil
end)
