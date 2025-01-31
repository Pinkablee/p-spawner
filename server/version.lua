CreateThread(function()
    local url = "https://raw.githubusercontent.com/pinkablee/versions/main/spawner.txt"
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)

    PerformHttpRequest(url, function(statusCode, responseBody)
        if statusCode == 200 and responseBody then
            local latestVersion = responseBody:match("%d+%.%d+%.%d+")
            if latestVersion and currentVersion < latestVersion then
                print((
                    "^3[ALERT]^0: A new version is available. " ..
                    "(Current Version: ^1%s^0, Latest Version: ^2%s^0)"
                ):format(currentVersion, latestVersion))
            end
        end
    end, "GET")
end)
