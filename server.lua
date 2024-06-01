ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx:setPlayerColor')
AddEventHandler('esx:setPlayerColor', function()
    if ESX == nil then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then
        return
    end

    local playerId = source
    local playerGroup = xPlayer.getGroup()

    local color = Config.Colors[playerGroup]
    local emoji = Config.Emojis[playerGroup] or ""

    TriggerClientEvent('esx:setPlayerColor', playerId, playerId, color, emoji)
end)

function RefreshPlayerColors()
    if ESX == nil then
        return
    end

    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
        if xPlayer then
            local playerGroup = xPlayer.getGroup()
            local color = Config.Colors[playerGroup]
            local emoji = Config.Emojis[playerGroup] or ""

            TriggerClientEvent('esx:setPlayerColor', tonumber(playerId), tonumber(playerId), color, emoji)
        end
    end
end

-- Fonction pour recharger la configuration
function ReloadConfig()
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
    if configFile then
        local configFunction = load(configFile)
        if configFunction then
            configFunction()
            RefreshPlayerColors()
        end
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ReloadConfig()
    end
end)

-- Ajout de la commande Staff:Showname
ESX.RegisterCommand('Staff:Showname', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent('esx:showPlayerNames', -1, true)
end, true, {help = "Afficher les noms des joueurs au-dessus de leur tête", validate = true, arguments = {}})

RegisterServerEvent('esx:hidePlayerNames')
AddEventHandler('esx:hidePlayerNames', function()
    TriggerClientEvent('esx:showPlayerNames', -1, false)
end)