ESX = nil
QBCore = nil

if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
end

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('qbox-core') == 'started' then
    QBCore = exports['qbox-core']:GetCoreObject()
end

local pendingScreenshots = {}

RegisterCommand("takescreen", function(source)
    local src = source
    takeScreenshot(src)
end)

RegisterNetEvent("sb-takescreenshot:userChoice")
AddEventHandler("sb-takescreenshot:userChoice", function(choice)
    local src = source
    
    if choice == "save" then
        local screenshot = pendingScreenshots[src]
        if screenshot then
            local body = "file=" .. urlencode(screenshot)

            PerformHttpRequest(Config.ApiUrl, function(err, text, headers)
                    if err == 200 or err == 201 then
                        local data = json.decode(text)
                        if data and data.url then
                            if Config.debug then print("✅ Image uploaded: " .. data.url) end
                            TriggerClientEvent("sb-takescreenshot:screenshotresponse", src, data.url)
                            TriggerEvent("sb-takescreenshot:screenshotresponse", data.url)
                            TriggerClientEvent("sb-takescreenshot:notify", src, "✅ Image uploaded: " .. data.url)
                        else
                            if Config.debug then print("❌ API returned no URL") end
                            TriggerClientEvent("sb-takescreenshot:notify", src, "❌ Upload failed: No URL returned.")
                        end
                    else
                        if Config.debug then print("❌ API Error: " .. tostring(err) .. " " .. tostring(text)) end
                        
                        TriggerClientEvent("sb-takescreenshot:notify", src, "Upload failed.")
                    end
                end, "POST", body, {
                    ["Content-Type"] = "application/x-www-form-urlencoded",
                    ["Authorization"] = Config.ApiKey
                })
        end
        pendingScreenshots[src] = nil
    elseif choice == "retake" then
        takeScreenshot(src)

    elseif choice == "cancel" then
        pendingScreenshots[src] = nil
        TriggerClientEvent("sb-takescreenshot:notify", src, "Screenshot task cancelled.")
    end
end)

function takeScreenshot(src)
    if Config.ApiKey then
        exports['screenshot-basic']:requestClientScreenshot(src, {
                fileName = ''
        }, function(err, data)
            if not err then
                pendingScreenshots[src] = data
                TriggerClientEvent("sb-takescreenshot:takePreview", src)
                if Config.debug then print("✅ Screenshot saved in temp data") end
            else
                if Config.debug then print("❌ Screenshot failed:", err) end
            end
        end)
    else
        if Config.debug then print("❌ Screenshot failed:", "No API key set in server.cfg. Check config for details") end
    end
end
exports("takeScreenshot", takeScreenshot)

local lastScreenshotRequest = {}
local cooldownSeconds = 10 -- adjust as needed

RegisterNetEvent("sb-takescreenshot:requestScreenshot")
AddEventHandler("sb-takescreenshot:requestScreenshot", function()
    local src = source
    local now = os.time()
    if lastScreenshotRequest[src] and (now - lastScreenshotRequest[src]) < cooldownSeconds then
        if Config.debug then print("⚠️ Player", src, "is on screenshot cooldown.") end
        TriggerClientEvent("sb-takescreenshot:notify", src, "⚠️ Please wait before taking another screenshot.")
        return
    end
    lastScreenshotRequest[src] = now

    takeScreenshot(src)
end)



AddEventHandler("playerDropped", function()
    local src = source
    pendingScreenshots[src] = nil
    lastScreenshotRequest[src] = nil
end)

function urlencode(str)
    if str then
        str = str:gsub("\n", "\r\n")
        str = str:gsub("([^%w %-%_%.%~])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
        str = str:gsub(" ", "+")
    end
    return str
end

function base64Encode(data)
    return data:gsub('.', function(x)
        return string.format('%02x', x:byte())
    end)
end
