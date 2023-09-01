return {
    AddHook = function()
        local targetOpts = {{
            name = 'renewed_phone_publicphone',
            icon = "fas fa-phone-volume",
            label = "Make Call",
            onSelect = function()
                OpenPublicPhone()
            end,
            canInteract = function(_, distance)
                return distance <= 1.0
            end,
        },
        {
            name = 'renewed_phone_viewtaxis',
            icon = 'fas fa-clipboard',
            label = 'View Taxis',
            onSelect = function()
                TriggerEvent('Renewed-Phone:OpenAvailableTaxi')
            end,
            canInteract = function(_, distance)
                return distance <= 1.0
            end,
        }}
        exports.ox_target:addModel(Config.BoothModels, targetOpts)
    end,
    RemoveHook = function()
        exports.ox_target:removeModel(Config.BoothModels, {'renewed_phone_publicphone', 'renewed_phone_viewtaxis'})
    end
}