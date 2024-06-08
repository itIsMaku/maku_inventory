local intervals = {}

--- Set an interval to run a callback every `delay` milliseconds.
--- @param callback function The callback to run.
--- @param delay number|nil The delay in milliseconds.
--- @return number intervalId The interval ID.
function lib.shared.SetInterval(callback, delay)
    delay = delay or 0

    local intervalId = table.size(intervals) + 1
    intervals[intervalId] = delay

    Citizen.CreateThread(function()
        local interval = intervals[intervalId]
        while interval ~= nil do
            interval = intervals[intervalId]

            Citizen.Wait(delay)
            callback()
        end
    end)

    return intervalId
end

--- Clear an interval by its ID.
--- @param intervalId number The interval ID.
--- @return boolean success Whether the interval was cleared.
function lib.shared.ClearInterval(intervalId)
    if intervals[intervalId] == nil then
        return false
    end

    intervals[intervalId] = nil

    return true
end
