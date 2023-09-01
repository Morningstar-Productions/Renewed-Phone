-- NUI Callback

RegisterNUICallback('AcceptMailButton', function(data, cb)
    if data.buttonEvent or data.buttonData then
        if data.isServer then
            TriggerServerEvent(data.buttonEvent, data.buttonData)
        else
            TriggerEvent(data.buttonEvent, data.buttonData)
        end
    end

    TriggerServerEvent('Renewed-Phone:server:ClearButtonData', data.mailId)
    cb('ok')
end)

RegisterNUICallback('GetMails', function(_, cb)
    cb(PhoneData.Mails)
end)

RegisterNUICallback('RemoveMail', function(data, cb)
    local MailId = data.mailId
    TriggerServerEvent('Renewed-Phone:server:RemoveMail', MailId)
    cb('ok')
end)

-- Events

RegisterNetEvent('Renewed-Phone:client:NewMailNotify', function(MailData)
    TriggerEvent('Renewed-Phone:client:CustomNotification',
        "Mail",
        "New E-Mail from: "..MailData.sender,
        "fas fa-envelope",
        "ff002f",
        1500
    )

    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
end)

RegisterNetEvent('Renewed-Phone:client:UpdateMails', function(NewMails)

    PhoneData.Mails = {}

    for _, v in pairs(NewMails) do
        PhoneData.Mails[#PhoneData.Mails+1] = {
            citizenid = v.citizenid,
            sender = v.sender,
            subject = v.subject,
            message = v.message,
            read = v.read,
            mailid = v.mailId,
            date = v.date,
            button = type(v.button) == "string" and json.decode(v.button) or v.button
        }
    end

    PhoneData.Mails = NewMails

    SendNUIMessage({
        action = "UpdateMails",
        Mails = NewMails
    })
end)

RegisterCommand('dumbmail', function()
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Booya",
        subject = "I love Zoo",
        message = "This is an interesting email from yours truly, booya. I'm so mad you took my phone and made it better. Maybe I just take it all and upload it soon!",
        button = {
            buttonEvent = "Renewed-Debt:server:AcceptShit",
            buttonData = 10,
            isServer = false
        }
    })
end)