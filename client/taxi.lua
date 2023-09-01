RegisterNUICallback('GetAvailableTaxiDrivers', function(_, cb)
    lib.callback('Renewed-Phone:server:GetAvailableTaxiDrivers', false, function(drivers)
        cb(drivers)
    end)
end)

RegisterNetEvent('Renewed-Phone:OpenAvailableTaxi', function()
    local taxiMenu = {}

    lib.callback('Renewed-Phone:server:GetAvailableTaxiDrivers', false, function(drivers)
        for _, v in pairs(drivers) do
            print(drivers)
            taxiMenu[#taxiMenu + 1] = {
                title = v.name,
                description = v.phone,
                icon = 'fas fa-phone-volume',
                onSelect = function()
                    local calldata = {
                        number = v.Phone,
                        name = v.Phone
                    }
                    exports['Renewed-Phone']:CallContact(calldata, true)
                end,
            }
        end
    end)

    taxiMenu[#taxiMenu + 1] = {
        title = 'No Taxi Available',
        icon = 'fas fa-taxi',
        disabled = true
    }

    lib.registerContext({
        id = 'taxi_call_menu',
        title = 'Available Taxis',
        options = taxiMenu
    })
    lib.showContext('taxi_call_menu')
end)