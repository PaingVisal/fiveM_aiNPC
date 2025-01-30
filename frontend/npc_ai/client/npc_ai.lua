local QBCore = exports['qb-core']:GetCoreObject()
local NPCs = {}

Citizen.CreateThread(function()
    -- Load NPCs from the config.lua
    local config = LoadResourceFile(GetCurrentResourceName(), "config.lua")
    assert(load(config))()

    -- Spawn NPCs
    for _, npcData in ipairs(NPCs) do
        local modelHash = GetHashKey(npcData.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end

        local npc = CreatePed(4, modelHash, npcData.coords.x, npcData.coords.y, npcData.coords.z, 0.0, false, true)
        SetEntityAsMissionEntity(npc, true, true)
        TaskStartScenarioInPlace(npc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

        npcData.entity = npc
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        -- Loop through NPCs for proximity checks
        for _, npcData in ipairs(NPCs) do
            local npcCoords = GetEntityCoords(npcData.entity)

            -- Proximity check (if player is near NPC)
            if #(playerCoords - npcCoords) < 2.5 then
                -- Draw text prompt ("Press E to talk to NPC")
                QBCore.Functions.DrawText3D(npcCoords.x, npcCoords.y, npcCoords.z + 1.0, "[E] Talk to " .. npcData.name)

                if IsControlJustReleased(0, 38) then -- 'E' Key pressed
                    -- Display input box to the player for chat
                    DisplayOnscreenKeyboard(1, "NPC_CHAT", "", "", "", "", "", 250)
                    while UpdateOnscreenKeyboard() == 0 do
                        Wait(0)
                    end

                    local message = GetOnscreenKeyboardResult()
                    if message then
                        -- Send the prompt to the server to get AI response
                        TriggerServerEvent('npc_ai:askAI', npcData.name, message)
                    end
                end
            end
        end
    end
end)

-- Function to play the voice URL (from NUI)
RegisterNetEvent('npc_ai:playVoice')
AddEventHandler('npc_ai:playVoice', function(voiceUrl)
    -- Send voice URL to NUI to play
    SendNUIMessage({ action = "playVoice", url = voiceUrl })
end)

-- Draw 3D text helper function (QBCore)
QBCore.Functions.DrawText3D = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
