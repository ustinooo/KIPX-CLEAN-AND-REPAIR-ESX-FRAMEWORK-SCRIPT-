local ESX, QBCore

if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('flipVehicle', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    local vehicle
    if Config.Framework == 'esx' then
        vehicle = ESX.Game.GetClosestVehicle()
    elseif Config.Framework == 'qbcore' then
        local result = QBCore.Functions.GetClosestVehicle()
        vehicle = result and result.vehicle or nil
    end

    if vehicle and DoesEntityExist(vehicle) then
        local dist = #(pedCoords - GetEntityCoords(vehicle))

        if dist <= 3.0 and not IsVehicleOnAllWheels(vehicle) then
            RequestAnimDict('missfinale_c2ig_11')
            while not HasAnimDictLoaded("missfinale_c2ig_11") do
                Wait(10)
            end

            TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, false, false, false)
            Wait(Config.TimetoFlip * 1000)

            local rot = GetEntityRotation(vehicle, 2)
            SetEntityRotation(vehicle, rot.x, 0.0, rot.z, 2, true)
            SetVehicleOnGroundProperly(vehicle)

            lib.notify({
                title = 'Vehicle Flip',
                description = 'The vehicle has been flipped back to normal!',
                type = 'success'
            })
            ClearPedTasks(ped)
        else
            lib.notify({
                title = 'Vehicle Flip',
                description = 'The vehicle is either too far or already upright.',
                type = 'error'
            })
        end
    else
        lib.notify({
            title = 'Vehicle Flip',
            description = 'No nearby vehicle found.',
            type = 'error'
        })
    end
end)
