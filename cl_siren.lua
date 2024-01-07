siren = true;

RegisterCommand("hornSiren", function()
	local ped = PlayerPedId()
    if(IsPedSittingInAnyVehicle(ped)) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) and IsPedInAnyPoliceVehicle(ped)) then
            BlipSiren(vehicle)
        end
	end
end)

RegisterCommand("siren", function()
	local ped = PlayerPedId()
    if(IsPedSittingInAnyVehicle(ped)) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) and IsPedInAnyPoliceVehicle(ped) and siren == false) then
            SetVehicleHasMutedSirens(vehicle, false)
            siren = true;
        elseif((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) and IsPedInAnyPoliceVehicle(ped) and siren == true) then
            siren = false;
        end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
        local ped = PlayerPedId()
        if(IsPedSittingInAnyVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) and IsPedInAnyPoliceVehicle(ped) and siren == false) then
                SetVehicleHasMutedSirens(vehicle, true)
            end
        end
	end
end)

RegisterKeyMapping('hornSiren', 'Toogle horn siren', 'keyboard', 'j')
RegisterKeyMapping('siren', 'Toggle siren', 'keyboard', 'k')