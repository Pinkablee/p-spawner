CreateThread(function()
    local url = "https://raw.githubusercontent.com/pinkablee/versions/main/spawner.txt"
    local version = GetResourceMetadata(GetCurrentResourceName(), "version", 0)

    PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
        if resultData and errorCode == 200 then
            resultData = resultData:match("%d%.%d+%.%d+")
            if version < resultData then
                print(("^3[ALERT]^0: A new version is available. (Current Version: ^1%s^0, Latest Version: ^2%s^0)"):format(version, resultData))
            end
        end
    end, "GET")
end)
