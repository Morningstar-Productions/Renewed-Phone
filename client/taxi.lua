RegisterNUICallback('GetAvailableTaxiDrivers', function(_, cb)
    local drivers = lib.callback.await('qb-phone:server:GetAvailableTaxiDrivers', false)
    cb(drivers)
end)

RegisterNetEvent('qb-phone:OpenAvailableTaxi', function()
    local taxiMenu = {}

    local drivers = lib.waitFor(function()
        return lib.callback.await('qb-phone:server:GetAvailableTaxiDrivers', false)
    end)

    if drivers then
        for i = 1, #drivers do
            print(drivers)
            taxiMenu[#taxiMenu + 1] = {
                title = drivers[i].name,
                description = drivers[i].Phone,
                icon = 'fas fa-phone-volume',
                onSelect = function()
                    local calldata = {
                        name = v.name,
                        number = v.phone,
                    }
                    exports['qb-phone']:CallContact(calldata, true)
                end,
            }
        end
    end

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