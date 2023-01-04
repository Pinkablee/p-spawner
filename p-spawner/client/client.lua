local function OpenSpawner(vehicleSpawn, heading)	
    local vehicles = {}

    for k, v in pairs(cfg.vehicles) do
        table.insert(vehicles, {
            title = v.label,
            description = "Spawn this vehicle",
            arrow = true,
            event = 'p-spawner:client:spawnVehicle',
            args = {
                model = v.model,
                coords = vehicleSpawn,
                heading = heading
            }
        })
    end

    lib.registerContext({
        id = 'vehicle_menu',
        menu = 'vehicle_spawner',
        title = 'Vehicle Spawner',
        options = vehicles
    })
    lib.showContext('vehicle_menu')
end

CreateThread(function()
    while true do
		local sleep = 500

        local coords = GetEntityCoords(cache.ped)

        for k, v in pairs(cfg.locations) do
            local dist = Distance(coords, v.marker)

            if dist < 5.0 then
				sleep = 0

                CreateMarker(1, v.marker, 1.5, 1.5, 1.0, 255, 255, 255, 255)
				
                if dist < 1.5 then
                    Prompt('Press ~INPUT_CONTEXT~ to spawn a Vehicle')

                    local pressed = IsControlJustPressed(0, 38)
					if pressed then
						OpenSpawner(v.vehicleSpawn, v.heading)
					end
                end
			end
		end

		Wait(sleep)
	end
end)

RegisterNetEvent('p-spawner:client:spawnVehicle', function(data)
    local model = data.model
    local vehicleSpawn = data.coords
    local heading = data.heading

    if model then
        local hash = GetHashKey(model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            RequestModel(hash) 
            Wait(100)
        end

        local createdVehicle = CreateVehicle(hash, vehicleSpawn, heading, true, false)
        SetPedIntoVehicle(cache.ped, createdVehicle, -1)
        SetVehicleEngineOn(createdVehicle, true, true, false)
        SetVehRadioStation(createdVehicle, "OFF")
	end
end)
