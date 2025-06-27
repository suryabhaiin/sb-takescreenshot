RegisterNetEvent("sb-takescreenshot:takePreview", function()
    exports['screenshot-basic']:requestScreenshot(function(data)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showScreenshot",
            image = data
        })
    end)
end)

RegisterNUICallback("screenshotResponse", function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent("sb-takescreenshot:userChoice", data.choice)
    cb("ok")
end)

function takeScreenshot()
    TriggerServerEvent("sb-takescreenshot:requestScreenshot")
end

exports("takeScreenshot", takeScreenshot)

RegisterNetEvent("sb-takescreenshot:notify")
AddEventHandler("sb-takescreenshot:notify", function(message)
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        multiline = true,
        args = {"Screenshot", message}
    })
end)

