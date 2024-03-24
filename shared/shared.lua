QBCore = exports['qb-core']:GetCoreObject() -- Backwards Compat

local phoneProp = 0
local phoneModel = joaat("prop_player_phone_01")

local createPhoneExport = require 'shared.export-function'

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib and PhoneData.AnimationData.anim do
            if not IsEntityPlayingAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                lib.requestAnimDict(PhoneData.AnimationData.lib, 1000)
                TaskPlayAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

local function deletePhone()
	if phoneProp then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end
createPhoneExport('deletePhone', deletePhone)

local function newPhoneProp()
	deletePhone()
	lib.requestModel(phoneModel, 1000)
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, true, true, false)
	local bone = GetPedBoneIndex(cache.ped, 28422)
	if phoneModel == joaat("prop_player_phone_01") then
		AttachEntityToEntity(phoneProp, cache.ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
	else
		AttachEntityToEntity(phoneProp, cache.ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
	end
end
createPhoneExport('newPhoneProp', newPhoneProp)

local function DoPhoneAnimation(anim)
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim
    if cache.vehicle then AnimationLib = 'anim@cellphone@in_car@ps' end
    lib.requestAnimDict(AnimationLib)
    TaskPlayAnim(cache.ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end
createPhoneExport('DoPhoneAnimation', DoPhoneAnimation)