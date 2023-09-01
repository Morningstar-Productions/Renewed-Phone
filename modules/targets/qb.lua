return {
    AddHook = function()
        exports['qb-target']:AddTargetModel(Config.BoothModels, {
            options = {{
                icon = "fas fa-phone-volume",
                label = "Make Call",
                action = function()
                    OpenPublicPhone()
                end,
            }, {
                icon = 'fas fa-clipboard',
                label = 'View Taxis',
                type = 'client',
                event = 'Renewed-Phone:OpenAvailableTaxi'
            }},
            distance = 1.0
        })
    end,
    RemoveHook = function()
        exports['qb-target']:RemoveTargetModel(Config.BoothModels, {'View Taxis', 'Make Call'})
    end
}