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

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local visible = false;
	while true do
        local veh = GetVehiclePedIsIn(ped, false)
        if veh ~= 0 and IsPedInAnyPoliceVehicle(ped) and IsPedInSeat(veh, ped, {-1, 0}) then
            if (not visible) then SendNUIMessage({type = "show"}) end
        else
            if (visible) then SendNUIMessage({type = "show"}) end
        end
        Citizen.Wait(5)
	end
end)

RegisterKeyMapping('siren', 'Toggle siren', 'keyboard', 'j')

RegisterNetEvent('eb:toggleSiren')
AddEventHandler('eb:toggleSiren', function(vehNetId)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    SetVehicleHasMutedSirens(veh, IsVehicleSirenAudioOn(veh))
end)

RegisterNetEvent('eb:hornSiren')
AddEventHandler('eb:hornSiren', function(vehNetId)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    BlipSiren(veh)
end)

RegisterCommand("show-nui", function()
    SendNUIMessage({type = "show"})
end)