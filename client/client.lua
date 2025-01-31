local isNotified = false

local function spawnVehicle(model, coords, heading)
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(100) end
    
    local vehicle = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, true, false)
    SetPedIntoVehicle(cache.ped, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehRadioStation(vehicle, 'OFF')
end

local function openVehicleMenu(coords, heading)
    local options = {}
    for _, vehicle in ipairs(Config.Vehicles) do
        table.insert(options, {
            title = vehicle.Label,
            description = 'Spawn this vehicle!',
            arrow = true,
            event = 'spawnVehicle',
            args = { model = vehicle.Model, coords = coords, heading = heading }
        })
    end

    lib.registerContext({
        id = 'vehicle_menu',
        title = 'Vehicle Spawner',
        options = options
    })
    lib.showContext('vehicle_menu')
end

CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(cache.ped)

        for _, location in ipairs(Config.Locations) do
            local dist = #(coords - location.Marker)
                
            if dist < 5.0 then
                sleep = 0
                DrawMarker(2, location.Marker.x, location.Marker.y, location.Marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 150, false, false, 2, true, nil, nil, false)
                
                if dist < 1.5 then
                    if not isNotified then
                        isNotified = true
                        lib.showTextUI('[E] - Spawn a Vehicle')
                    end
                        
                    if IsControlJustPressed(0, 38) then
                        openVehicleMenu(location.SpawnCoords, location.Heading)
                    end
                elseif isNotified then
                    isNotified = false
                    lib.hideTextUI()
                end
            end
        end
            
        Wait(sleep)
    end
end)

RegisterNetEvent('spawnVehicle', function(data)
    if data and data.model then
        spawnVehicle(data.model, data.coords, data.heading)
    end
end)
