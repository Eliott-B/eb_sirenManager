siren = true;

function hornSiren(vehicle)
	BlipSiren(vehicle)
end

function toogleSiren(ped, vehicle)
	if (siren == false) then
        SetVehicleHasMutedSirens(vehicle, false)
        siren = true;
    elseif (siren == true) then
        siren = false;
    end
end

RegisterCommand("siren", function()
    local ped = PlayerPedId()
    if (IsPedInAnyPoliceVehicle(ped)) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) then
            if (IsVehicleSirenOn(vehicle) == 1) then
                toogleSiren(ped, vehicle)
            else
                hornSiren(vehicle)
            end
        end
    end
end)

CreateThread(function()
	while true do
		Wait(0)
        local ped = PlayerPedId()
        if (IsPedInAnyPoliceVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if ((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 1) == ped) and siren == false) then
                SetVehicleHasMutedSirens(vehicle, true)
            end
        end
	end
end)

RegisterKeyMapping('siren', 'Toogle siren', 'keyboard', 'j')