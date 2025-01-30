local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('npc_ai:playVoice')
AddEventHandler('npc_ai:playVoice', function(voiceUrl)
    -- Trigger the voice playback for all players
    TriggerClientEvent('npc_ai:playVoice', -1, voiceUrl)
end)

-- Example of handling AI response (simulated here, you can replace it with real API calls)
function getAIResponse(npcName, prompt)
    -- Call to AI service (replace with actual API request)
    -- Example response (you'd get real response here from API)
    local response = {
        reply = "Hello, I'm " .. npcName .. ". How can I help you today?",
        voiceUrl = "https://example.com/voice.mp3" -- URL to the generated voice file
    }
    return response
end

-- Trigger AI response when player interacts with NPC
RegisterNetEvent('npc_ai:askAI')
AddEventHandler('npc_ai:askAI', function(npcName, prompt)
    local response = getAIResponse(npcName, prompt)
    TriggerClientEvent('npc_ai:showResponse', source, response.reply, response.voiceUrl)
end)
