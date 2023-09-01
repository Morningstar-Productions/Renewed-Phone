-- NUI Callback

RegisterNUICallback('GetGalleryData', function(_, cb)
    local data = PhoneData.Images
    cb(data)
end)

RegisterNUICallback('DeleteImage', function(image,cb)
    TriggerServerEvent('Renewed-Phone:server:RemoveImageFromGallery',image)
    Wait(400)
    TriggerServerEvent('Renewed-Phone:server:getImageFromGallery')
    cb(true)
end)

-- Events

RegisterNetEvent('Renewed-Phone:refreshImages', function(images)
    PhoneData.Images = images
end)