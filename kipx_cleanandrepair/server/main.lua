local ESX, QBCore

if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.Framework == 'esx' then
    ESX.RegisterUsableItem(Config.RepairKit, function(source)
        TriggerClientEvent('kipxcleanandrepair:useRepairKit', source, Config.RepairKit)
    end)

    ESX.RegisterUsableItem(Config.CleaningKit, function(source)
        TriggerClientEvent('kipxcleanandrepair:useCleaningKit', source, Config.CleaningKit)
    end)

elseif Config.Framework == 'qbcore' then
    QBCore.Functions.CreateUseableItem(Config.RepairKit, function(source)
        TriggerClientEvent('kipxcleanandrepair:useRepairKit', source, Config.RepairKit)
    end)

    QBCore.Functions.CreateUseableItem(Config.CleaningKit, function(source)
        TriggerClientEvent('kipxcleanandrepair:useCleaningKit', source, Config.CleaningKit)
    end)
end


RegisterNetEvent('kipxcleanandrepair:removeItem', function(item)
    local src = source
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeInventoryItem(item, 1)

    elseif Config.Framework == 'qbcore' then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(item, 1)
    end
end)
