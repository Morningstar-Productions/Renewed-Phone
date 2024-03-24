lib.callback.register('qb-phone:server:GetAvailableTaxiDrivers', function(_)
    local TaxiDrivers = {}

    for i = 1, #Config.TaxiJob do
        local job = Config.TaxiJob[i]
        TaxiDrivers[job.Job] = {}
        TaxiDrivers[job.Job].Players = {}
    end

    for _, v in pairs(GetPlayers()) do
        local player = exports.qbx_core:GetPlayer(v)

        if not player then return end

        local job = player.PlayerData.job.name

        if TaxiDrivers[job] and player.PlayerData.job.onduty then
            TaxiDrivers[job].Players[#(TaxiDrivers[job].Players) + 1] = {
                name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
                phone = player.PlayerData.charinfo.phone,
            }
        end
    end
    return TaxiDrivers
end)