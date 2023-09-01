-- NUI Callback


-- WORK IN PROGRESS
--[[
RegisterNUICallback('SetupHousingDocuments', function(_, cb)
    lib.callback('Renewed-Phone:server:GetHousingLocations', false, function(houses)
        cb(houses)
    end)
end)
]]

RegisterNUICallback('documents_Save_Note_As', function(data, cb)
    TriggerServerEvent('Renewed-Phone:server:documents_Save_Note_As', data)
    cb("ok")
end)

RegisterNUICallback('document_Send_Note', function(data, cb)
    if data.Type == 'LocalSend' then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if not isPlayerTooFar(player, distance) then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("Renewed-Phone:server:sendDocumentLocal", data, playerId)
        else
            TriggerEvent("DoShortHudText", "No one around!", 2)
        end
    elseif data.Type == 'PermSend' then
        TriggerServerEvent('Renewed-Phone:server:sendDocument', data)
    end
    cb("ok")
end)

RegisterNetEvent("Renewed-Phone:client:sendingDocumentRequest", function(data, Receiver, Ply, SenderName)
    local success = exports['Renewed-Phone']:PhoneNotification("DOCUMENTS", SenderName..' Incoming Document', 'fas fa-folder', '#b3e0f2', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
    if success then
        if data.Type == 'PermSend' then
            TriggerServerEvent("Renewed-Phone:server:documents_Save_Note_As", data, Receiver, Ply, SenderName)
        elseif data.Type == 'LocalSend' then
            TriggerEvent('Renewed-Phone:client:CustomNotification',
                'DOCUMENTS',
                'New Document',
                'fas fa-folder',
                '#d9d9d9',
                5000
            )

            SendNUIMessage({
                action = "DocumentSent",
                DocumentSend = {
                    title = data.Title,
                    text = data.Text,
                },
            })
        end
    end
end)

RegisterNUICallback('GetNote_for_Documents_app', function(_, cb)
    cb(PhoneData.Documents)
end)

RegisterNetEvent('Renewed-Phone:RefReshNotes_Free_Documents', function(notes)
    PhoneData.Documents = notes
    SendNUIMessage({
        action = "DocumentRefresh",
    })
end)