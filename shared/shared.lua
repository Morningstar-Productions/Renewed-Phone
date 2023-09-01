Shared = Shared or {}

PlayerPed = cache.ped

QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()

---@todo ESX Compatible Work
-- ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

local phoneProp = 0
local phoneModel = joaat("prop_npc_phone_02")

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib and PhoneData.AnimationData.anim do
            local ped = PlayerPed
            if not IsEntityPlayingAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                lib.requestAnimDict(PhoneData.AnimationData.lib)
                TaskPlayAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

function newPhoneProp()
	deletePhone()
	lib.requestModel(phoneModel)
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, true, true, false)
    local ped = PlayerPed
	local bone = GetPedBoneIndex(ped, 28422)
	if phoneModel == joaat("prop_cs_phone_01") then
		AttachEntityToEntity(phoneProp, ped, bone, 0.0, 0.0, 0.0, 50.0, 320.0, 50.0, true, true, false, false, 2, true)
	else
		AttachEntityToEntity(phoneProp, PlayerPed, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
	end
end

function deletePhone()
	if phoneProp then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

function DoPhoneAnimation(anim)
    local ped = PlayerPed
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim
    if IsPedInAnyVehicle(ped, false) then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end
    lib.requestAnimDict(AnimationLib)
    TaskPlayAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end