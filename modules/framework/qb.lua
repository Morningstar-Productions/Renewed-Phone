---@todo Rework for Multiframework
return {
    initFramework = function()
        AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
            Wait(250)
        end)
    end,
}