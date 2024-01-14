RegisterServerEvent('eb:toggleSiren')
AddEventHandler('eb:toggleSiren', function(vehNetId)
    TriggerClientEvent("eb:toggleSiren", -1, vehNetId)
end)

RegisterServerEvent('eb:hornSiren')
AddEventHandler('eb:hornSiren', function(vehNetId)
    TriggerClientEvent("eb:hornSiren", -1, vehNetId)
end)