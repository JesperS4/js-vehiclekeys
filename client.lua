local currentVehicle = nil

Citizen.CreateThread(function()
    while ESX.PlayerData.job == nil do
        Wait(100)
    end
    TriggerServerEvent('prisma-vehiclekeys:server:setVehicleKeys')
end)

RegisterKeyMapping('voertuigslot', 'Om je voertuig opslot te doen', 'keyboard', 'U')

RegisterCommand('voertuigslot', function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local vehCoords = GetEntityCoords(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local distance = #(vehCoords - pos)

    if distance < 4 then
        currentVehicle = vehicle
        ESX.TriggerServerCallback('prisma-vehiclekeys:server:isVehicleOwned', function(owned)
            if owned then
                SendNUIMessage({
                    action = 'open'
                })
                SetNuiFocus(true, true)
            end
        end, plate)
    end
end)


RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

function inDistance()
    local vehCoords = GetEntityCoords(currentVehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local distance = #(vehCoords - pos)
    return distance < 4
end

RegisterNUICallback('closevehicle', function()
    if inDistance() then
        SetVehicleDoorsLocked(currentVehicle, 2)
        PlayVehicleDoorOpenSound(currentVehicle, 1)
        StartVehicleHorn(currentVehicle, 200, 0, false)
        Config.Notify("Voertuig opslot gezet..", 'success')
        doAnim()
    end
end)


RegisterNUICallback('openvehicle', function()
    if inDistance() then
        SetVehicleDoorsLocked(currentVehicle, 1)
        PlayVehicleDoorOpenSound(currentVehicle, 0)
        StartVehicleHorn(currentVehicle, 100, 0, false)
        Config.Notify("Voertuig open gemaakt..", 'success')
        doAnim()
    end
end)


RegisterNUICallback('opentrunk', function()
    if inDistance() then
        if GetVehicleDoorAngleRatio(currentVehicle,5) ~= 0 or GetVehicleDoorAngleRatio(currentVehicle,5) ~= 0.0  then
            SetVehicleDoorShut(currentVehicle, 5, false)
        else
            SetVehicleDoorOpen(currentVehicle, 5, false, false)
        end
        doAnim()
    end
end)

function doAnim()
    local dict <const> = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
    local co = GetEntityCoords(PlayerPedId())
    local he = GetEntityHeading(PlayerPedId())

    TaskPlayAnimAdvanced(PlayerPedId(), dict, "fob_click_fp", co.x, co.y, co.z, 0, 0, he, 0.8, 1.0, -1, 50, 0.0, 0, 0)
    Citizen.SetTimeout(1000, function()
        ClearPedTasks(PlayerPedId())
    end)
end


