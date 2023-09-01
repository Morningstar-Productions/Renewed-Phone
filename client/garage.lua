-- Functions

local function findVehFromPlateAndLocate(plate)
    local gameVehicles = QBCore.Functions.GetVehicles()
    for i = 1, #gameVehicles do
        local vehicle = gameVehicles[i]
        if DoesEntityExist(vehicle) then
            if QBCore.Functions.GetPlate(vehicle) == plate then
                local vehCoords = GetEntityCoords(vehicle)
                SetNewWaypoint(vehCoords.x, vehCoords.y)
                return true
            end
        end
    end
end

-- NUI Callback

RegisterNUICallback('SetupGarageVehicles', function(_, cb)
    lib.callback('Renewed-Phone:server:GetGarageVehicles', false, function(vehicles)
        cb(vehicles)
    end)
end)

RegisterNUICallback('gps-vehicle-garage', function(data, cb)
    local veh = data.veh
    if Config.Garage == 'jdev' then
        exports['qb-garages']:TrackVehicleByPlate(veh.plate)
        TriggerEvent('Renewed-Phone:client:CustomNotification',
            "GARAGE",
            "GPS Marker Set!",
            "fas fa-car",
            "#e84118",
            5000
        )
        cb("ok")
    elseif Config.Garage == 'qbcore' then
        --Deprecated
        if veh.state == 'In' then
            if veh.parkingspot then
                SetNewWaypoint(veh.parkingspot.x, veh.parkingspot.y)
                lib.notify({ title = 'Valet', description = "Your vehicle has been marked", type = "success" })
            end
        elseif veh.state == 'Out' and findVehFromPlateAndLocate(veh.plate) then
            lib.notify({ title = 'Valet', description = "Your vehicle has been marked", type = "success" })
        else
            lib.notify({ title = 'Valet', description = "This vehicle cannot be located", type = "error" })
        end
    elseif veh.state == 'Out' and findVehFromPlateAndLocate(veh.plate) then
        lib.notify({ title = 'Valet', description = "Your vehicle has been marked", type = "success" })
    else
        lib.notify({ title = 'Valet', description = "This vehicle cannot be located", type = "error" })
    end
    cb("ok")
end)

RegisterNUICallback('sellVehicle', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:sendVehicleRequest', data)
    cb("ok")
end)

-- Events

RegisterNetEvent('Renewed-Phone:client:sendVehicleRequest', function(data, seller)
    local success = exports['Renewed-Phone']:PhoneNotification("VEHICLE SALE", 'Purchase '..data.plate..' for $'..data.price, 'fas fa-map-pin', '#b3e0f2', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
    if success then
        TriggerServerEvent("Renewed-Phone:server:sellVehicle", data, seller, 'accepted')
    else
        TriggerServerEvent("Renewed-Phone:server:sellVehicle", data, seller, 'denied')
    end
end)

RegisterNetEvent('Renewed-Phone:client:updateGarages', function()
    SendNUIMessage({
        action = "UpdateGarages",
    })
end)
