siren = true;

local function hornSiren(vehicle)
	BlipSiren(vehicle)
end

local function toogleSiren(ped, vehicle)
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
        if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) then
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
            if ((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped)) then
                if (siren == false) then
                    SetVehicleHasMutedSirens(vehicle, true)
                end
                if (IsVehicleSirenOn(vehicle) == 1) then
                    if (siren == false) then
                        SirenOff()
                    else
                        SirenOn()
                    end
                else
                    LightOff()
                end
            end
        end
	end
end)

RegisterKeyMapping('siren', 'Toogle siren', 'keyboard', 'j')

RegisterNetEvent('eb:toggleSiren')
AddEventHandler('eb:toggleSiren', toogleSiren())

RegisterNetEvent('eb:hornSiren')
AddEventHandler('eb:hornSiren', hornSiren())