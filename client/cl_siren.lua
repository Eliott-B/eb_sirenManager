local function IsPedInSeat(veh, ped, seats)
    for _, seat in pairs(seats) do
        if GetPedInVehicleSeat(veh, seat) == ped then
            return true
        end
    end
    return false
end

RegisterCommand("siren", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if veh == 0 then return end
    if not IsPedInAnyPoliceVehicle(ped) or not IsPedInSeat(veh, ped, {-1, 0}) then return end

    local vehNetId = NetworkGetNetworkIdFromEntity(veh)
    if IsVehicleSirenOn(veh) then
        TriggerServerEvent("eb:toggleSiren", vehNetId)
    else
        TriggerServerEvent("eb:hornSiren", vehNetId)
    end
end)

RegisterCommand("passengerLight", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if veh == 0 then return end
    if not IsPedInAnyPoliceVehicle(ped) or not IsPedInSeat(veh, ped, {0}) then return end

    local vehNetId = NetworkGetNetworkIdFromEntity(veh)
    TriggerServerEvent("eb:passengerLight", vehNetId)
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local hasAlreadyVisible = false
    local hasLightsAlreadyOn = false
	while true do
        if IsPedInAnyPoliceVehicle(ped) then
            local veh = GetVehiclePedIsIn(ped, false)
            if (IsVehicleSirenOn(veh) and not hasLightsAlreadyOn) then
                SendNUIMessage({type = "lights", lights = true})
                SendNUIMessage({type = "siren", siren = IsVehicleSirenAudioOn(veh)})
                hasLightsAlreadyOn = true
            elseif (not IsVehicleSirenOn(veh) and hasLightsAlreadyOn) then
                SendNUIMessage({type = "lights", lights = false})
                SendNUIMessage({type = "siren", lights = false})
                hasLightsAlreadyOn = false
            end
            if (not hasAlreadyVisible and IsPedInSeat(veh, ped, {-1, 0})) then
                SendNUIMessage({type = "show"})
                hasAlreadyVisible = true
            end
        elseif (hasAlreadyVisible) then
                SendNUIMessage({type = "show"})
                hasAlreadyVisible = false
        end
        Citizen.Wait(500)
	end
end)

RegisterKeyMapping('siren', 'Toggle siren', 'keyboard', 'j')
RegisterKeyMapping('passengerLight', 'Toggle light for passenger', 'keyboard', 'e')

RegisterNetEvent('eb:toggleSiren')
AddEventHandler('eb:toggleSiren', function(vehNetId)
    local ped = PlayerPedId()
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    SetVehicleHasMutedSirens(veh, IsVehicleSirenAudioOn(veh))
    if (veh == GetVehiclePedIsIn(ped, false) and IsPedInSeat(veh, ped, {-1, 0})) then
        SendNUIMessage({type = "siren", siren = IsVehicleSirenAudioOn(veh)})
    end
end)

RegisterNetEvent('eb:hornSiren')
AddEventHandler('eb:hornSiren', function(vehNetId)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    BlipSiren(veh)
end)


RegisterNetEvent('eb:passengerLight')
AddEventHandler('eb:passengerLight', function(vehNetId)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    SetVehicleSiren(veh, not IsVehicleSirenOn(veh))
    if (veh == GetVehiclePedIsIn(ped, false) and IsPedInSeat(veh, ped, {-1, 0})) then
        SendNUIMessage({type = "lights", lights = IsVehicleSirenOn(veh)})
    end
end)

RegisterCommand("show-nui", function()
    SendNUIMessage({type = "show"})
end)