RegisterServerEvent('eb:toggleSiren')
AddEventHandler('eb:toggleSiren', function()
    local players = GetPlayers()
    for _,player in pairs(players) do
        TriggerClientEvent('eb:toggleSiren', player)
    end
end)

RegisterServerEvent('eb:hornSiren')
AddEventHandler('eb:hornSiren', function()
    local players = GetPlayers()
    for _,player in pairs(players) do
        TriggerClientEvent('eb:hornSiren', player)
    end
end)