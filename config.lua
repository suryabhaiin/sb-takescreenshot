Config = {}

-- Get API key from server.cfg. add next code to server.cfg:  set screenshot_fivemerr_api_key "YourRealApiFivemerrKeyHere"
-- use export like exports['sb-takescreenshot']:takeScreenshot(target_source) -- playerid
-- sb-takescreenshot:screenshotresponse this is response callback event that send url of image (cl/srv both side cl side response to source)

Config.ApiKey = GetConvar('screenshot_fivemerr_api_key', false)
Config.ApiUrl = "https://api.fivemerr.com/v1/media/images"
Config.debug = false