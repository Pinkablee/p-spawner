local function OpenContext(coords, heading)	
    local options = {}

    for k, v in pairs(cfg?.vehicles) do
        table.insert(options, {
            title = v.label,
            description = "Spawn this vehicle!",
            arrow = true,
            event = "spawnVehicle",
            args = {
                model = v.model,
                coords = coords,
                heading = heading
            }
        })
    end

    lib.registerContext({id = "vehicle_menu", menu = "vehicle_spawner", title = "Vehicle Spawner", options = options})
    lib.showContext("vehicle_menu")
end

CreateThread(function()
    while true do
		local sleep = 500

        local coords = GetEntityCoords(cache.ped)

        for k, v in pairs(cfg?.locations) do
            local dist = Distance(coords, v.marker)

            if dist < 5.0 then
				sleep = 0

                CreateMarker(1, v.marker, 1.5, 1.5, 1.0, 255, 255, 255, 255)
				
                if dist < 1.5 then
                    Prompt("Press ~INPUT_CONTEXT~ to spawn a Vehicle")

                    local pressed = IsControlJustPressed(0, 38)
					if pressed then
						OpenContext(v.coords, v.heading)
					end
                end
			end
		end

		Wait(sleep)
	end
end)

RegisterNetEvent("spawnVehicle", function(data)
    if data.model then return end

    local hash = GetHashKey(data.model)
    RequestModel(hash)

    while not HasModelLoaded(hash) do
    	RequestModel(hash) 
        Wait(100)
    end

    local vehicle = CreateVehicle(hash, data.coords, data.heading, true, false)
    SetPedIntoVehicle(cache.ped, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehRadioStation(vehicle, "OFF")
end)
