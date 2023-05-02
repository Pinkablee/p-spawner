function Distance(one, two)
    local dist = #(one - two)
    return dist
end

function CreateMarker(type, coords, sizex, sizey, sizez, r, g, b, a)
    return DrawMarker(type, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, sizex, sizey, sizez, r, g, b, a, false, false, 2, false, nil, nil, false)
end

function Prompt(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end