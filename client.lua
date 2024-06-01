local Config = Config or {}

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('esx:setPlayerColor')
end)

RegisterNetEvent('esx:setPlayerColor')
AddEventHandler('esx:setPlayerColor', function(playerId, color, emoji)
    if color then
        local r, g, b = table.unpack(color)
        SetPlayerColor(playerId, r, g, b, emoji)
    end
end)

function SetPlayerColor(playerId, r, g, b, emoji)
    local ped = GetPlayerPed(GetPlayerFromServerId(playerId))
    local playerName = GetPlayerName(GetPlayerFromServerId(playerId))

    if ped then
        local playerTag = CreateMpGamerTag(ped, emoji .. " " .. playerId .. " | " .. playerName, false, false, "", 0)
        SetMpGamerTagColour(playerTag, 0, r, g, b) 
    end
end
