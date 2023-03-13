Config = {}


Config.Notify = function(text, type)
    TriggerEvent('ox_lib:notify', { type = type, description = text })
end