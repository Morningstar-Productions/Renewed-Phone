<<<<<<< Updated upstream
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-phone:server:addImageToGallery', function(image)
=======
RegisterNetEvent('Renewed-Phone:server:addImageToGallery', function(image)
>>>>>>> Stashed changes
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)',{Player.PlayerData.citizenid,image})
end)
<<<<<<< Updated upstream
RegisterNetEvent('qb-phone:server:getImageFromGallery', function()
=======

RegisterNetEvent('Renewed-Phone:server:getImageFromGallery', function()
>>>>>>> Stashed changes
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local images = exports.oxmysql:executeSync('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC',{Player.PlayerData.citizenid})
    TriggerClientEvent('Renewed-Phone:refreshImages', src, images)
end)

RegisterNetEvent('Renewed-Phone:server:RemoveImageFromGallery', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local image = data.image
    exports.oxmysql:execute('DELETE FROM phone_gallery WHERE citizenid = ? AND image = ?',{Player.PlayerData.citizenid,image})
end)