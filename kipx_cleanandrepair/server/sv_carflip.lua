local ESX, QBCore

if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.Framework == 'esx' then
    ESX.RegisterUsableItem(Config.CarLift, function(source)
        TriggerClientEvent('kipxcleanandrepair:useRepairKit', source, Config.CarLift)
    end)

elseif Config.Framework == 'qbcore' then
    QBCore.Functions.CreateUseableItem(Config.RepairKit, function(source)
        TriggerClientEvent('kipxcleanandrepair:useRepairKit', source, Config.CarLift)
    end)
end