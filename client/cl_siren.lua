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
    local text
	while true do
        local veh = GetVehiclePedIsIn(ped, false)
        if veh ~= 0 and IsPedInAnyPoliceVehicle(ped) and IsPedInSeat(veh, ped, {-1, 0}) then
            if IsVehicleSirenOn(veh) then
                if IsVehicleSirenAudioOn(veh) then
                    text = "Siren : ~g~On"
                else
                    text = "Siren : ~r~Off"
                end
            else
                text = "Light : ~r~Off"
            end
            Draw2DText(0.95, 0.94, text, 0.45)
        end
        Citizen.Wait(5)
	end
end)

RegisterKeyMapping('siren', 'Toggle siren', 'keyboard', 'j')
RegisterKeyMapping('passengerLight', 'Toggle light for passenger', 'keyboard', 'e')

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

RegisterNetEvent('eb:passengerLight')
AddEventHandler('eb:passengerLight', function(vehNetId)
    local veh = NetworkGetEntityFromNetworkId(vehNetId)
    SetVehicleSiren(veh, not IsVehicleSirenOn(veh))
end)