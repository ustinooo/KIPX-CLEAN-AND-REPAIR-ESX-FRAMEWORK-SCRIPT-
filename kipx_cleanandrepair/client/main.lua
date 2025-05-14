local lastRepairUse = 0
local lastCleanUse = 0
local cooldownTime = Config.Cooldown

RegisterNetEvent('kipxcleanandrepair:useRepairKit')
AddEventHandler('kipxcleanandrepair:useRepairKit', function(item)
    local currentTime = GetGameTimer()
    if currentTime - lastRepairUse < cooldownTime then
        local secondsLeft = math.ceil((cooldownTime - (currentTime - lastRepairUse)) / 1000)
        TriggerEvent('kipxcleanandrepair:notif', 'Cooldown', 'You must wait ' .. secondsLeft .. 's before repairing again.', 5000, 'error')
        return
    end
    lastRepairUse = currentTime

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
        
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle
        if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
        else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
            SetVehicleDoorOpen(vehicle, 4, false, false)
            lib.progressBar({
                duration = 10000,
                label = 'Repairing Vehicle...',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_ped',
                    flags = 8,
                },
            })
            SetVehicleDeformationFixed(vehicle)
            SetVehicleFixed(vehicle)
            SetVehicleDoorShut(vehicle, 4, false, true)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 750.0)
            SetVehicleUndriveable(vehicle, false)
            ClearPedTasksImmediately(playerPed)
            TriggerEvent('kipxcleanandrepair:notif', 'Car Repair', 'Vehicle repaired successfully!', 5000, 'success')
            TriggerServerEvent('kipxcleanandrepair:removeItem', item)
        else
            TriggerEvent('kipxcleanandrepair:notif', 'Car Repair', 'You must be in or near a vehicle to use this.', 5000, 'error')
        end
    end
end)


RegisterNetEvent('kipxcleanandrepair:useCleaningKit')
AddEventHandler('kipxcleanandrepair:useCleaningKit', function(item)
    local currentTime = GetGameTimer()
    if currentTime - lastCleanUse < cooldownTime then
        local secondsLeft = math.ceil((cooldownTime - (currentTime - lastCleanUse)) / 1000)
        TriggerEvent('kipxcleanandrepair:notif', 'Cooldown', 'You must wait ' .. secondsLeft .. 's before cleaning again.', 5000, 'error')
        return
    end
    lastCleanUse = currentTime

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

    if vehicle then
        lib.progressBar({
            duration = 10000,
            label = 'Cleaning Vehicle...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
            anim = {
                dict = 'amb@world_human_maid_clean@',
                clip = 'base',
                flags = 8,
            },
        })
        local id = NetworkGetNetworkIdFromEntity(vehicle)
        WashDecalsFromVehicle(vehicle, playerPed, 1.0)
        SetVehicleDirtLevel(vehicle, 0.1)
        ClearPedTasksImmediately(playerPed)
        NetworkFadeInEntity(vehicle, true, true)
        SetNetworkIdCanMigrate(id, true)
        SetNetworkIdExistsOnAllMachines(id, true)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetEntityAsMissionEntity(vehicle, true, true)
        TriggerEvent('kipxcleanandrepair:notif', 'Car Cleaning', 'Vehicle cleaned successfully!', 5000, 'success')
        TriggerServerEvent('kipxcleanandrepair:removeItem', item)
    else
        TriggerEvent('kipxcleanandrepair:notif', 'Car Cleaning', 'You must be in or near a vehicle to use this.', 5000, 'error')
    end
end)


RegisterNetEvent('kipxcleanandrepair:notif')
AddEventHandler('kipxcleanandrepair:notif', function(title, description, time, type)
      lib.notify({
        title = title,
        description = description,
        duration = time,
        type = type
      })
end)