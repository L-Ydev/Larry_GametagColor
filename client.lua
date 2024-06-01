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

-- Gestion de l'affichage des noms des joueurs
local showPlayerNames = false

RegisterNetEvent('esx:showPlayerNames')
AddEventHandler('esx:showPlayerNames', function(show)
    showPlayerNames = show
    if not show then
        for _, playerId in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(playerId)
            if ped then
                RemoveMpGamerTag(ped)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if showPlayerNames then
            for _, playerId in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(playerId)
                local playerName = GetPlayerName(playerId)

                if ped then
                    local playerTag = CreateMpGamerTag(ped, playerName, false, false, "", 0)
                    SetMpGamerTagVisibility(playerTag, 0, true)
                end
            end
        else
            Wait(1000)
        end
    end
end)
