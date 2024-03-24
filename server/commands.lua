lib.addCommand("p#", { help = "Provide Phone Number" }, function(source)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local number = player.PlayerData.charinfo.phone
	local PlayerCoords = GetEntityCoords(PlayerPed)
	for _, v in pairs(GetPlayers()) do
		local TargetPed = GetPlayerPed(v)
		local dist = #(PlayerCoords - GetEntityCoords(TargetPed))

		if dist < 3.0 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 255, 0, 0 },
                multiline = true,
                args = {"Phone #", number}
            })
		end
	end
end)
