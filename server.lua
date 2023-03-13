Vehicles = {}


RegisterServerEvent('ax-vehiclekeys:server:setVehicleKeys', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)


    Vehicles[xPlayer.identifier] = {}

    local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ?', { xPlayer.identifier })
    if result then
        for _,value in pairs(result) do
            table.insert(Vehicles[xPlayer.identifier], {
                plate = value.plate
            })
        end
    end
end)


RegisterServerEvent('ax-vehiclekeys:server:registerJobKey', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Vehicles[xPlayer.identifier] == nil then Vehicles[xPlayer.identifier] = {} end
    table.insert(Vehicles[xPlayer.identifier], {
        plate = ESX.Math.Trim(plate)
    })
end)
