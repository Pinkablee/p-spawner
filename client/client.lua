local notified = false

local function OpenContext(coords, heading)
    local options = {}

    for i, vehicle in pairs(cfg?.vehicles) do
        table.insert(options, {
            title = vehicle.label,
            description = 'Spawn this vehicle!',
            arrow = true,
            event = 'spawnVehicle',
            args = {
                model = vehicle.model,
                coords = coords,
                heading = heading
            }
        })
    end

    lib.registerContext({
        id = 'vehicle_menu',
        menu = 'vehicle_spawner',
        title = 'Vehicle Spawner',
        options = options
    })
    lib.showContext('vehicle_menu')
end

CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(cache.ped)

        for i, location in pairs(cfg?.locations) do
            local dist = #(coords - location.marker)

            if dist < 5.0 then
                sleep = 0
                DrawMarker(2, location.marker.x, location.marker.y, location.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 150, false, false, 2, true, nil, nil, false)

                if dist < 1.5 then
                    if not notified then
                        notified = true
                        lib.showTextUI('[E] - Spawn a Vehicle')
                    end

                    local pressed = IsControlJustPressed(0, 38)

                    if pressed then
                        OpenContext(location.coords, location.heading)
                    end
                elseif notified then
                    notified = false
                    lib.hideTextUI()
                end
            end
        end

        Wait(sleep)
    end
end)

RegisterNetEvent('spawnVehicle', function(data)
    if not data.model then return end

    local hash = GetHashKey(data.model)
    RequestModel(hash)

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(100)
    end

    local vehicle = CreateVehicle(hash, data.coords, data.heading, true, false)
    SetPedIntoVehicle(cache.ped, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehRadioStation(vehicle, 'OFF')
end)
