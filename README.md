# 📸 sb-takescreenshot

Take high-quality screenshots from client, preview them with NUI, and upload to FiveMerr API.  

# Preview
![image](https://raw.githubusercontent.com/suryabhaiin/sb-takescreenshot/refs/heads/main/image.png)

## 🚀 Features
- ✅ Take screenshots from any player
- ✅ Show stylish NUI preview with Save/Retake/Cancel options & After confir send to API
- ✅ Upload directly to FiveMerr API
- ✅ Easy exports for use in other scripts

## ⚙️ Installation
1. Download or clone the resource:
```bash
git clone https://github.com/suryabhaiin/sb-takescreenshot.git
```
Add to your server.cfg:
```ini
ensure sb-takescreenshot
set screenshot_fivemerr_api_key "YourRealApiFivemerrKeyHere"
```
📝 Configuration
Edit config.lua (if exists) or ensure your Config.ApiUrl and Config.ApiKey are set properly in the script.

API Key: Reads from screenshot_fivemerr_api_key server variable

🖥️ Usage
➡️ From other scripts
You can call the screenshot export directly:

client:
```Lua
exports['sb-takescreenshot']:takeScreenshot()
```
server:
```Lua
exports['sb-takescreenshot']:takeScreenshot(target_source)
```
| Replace `target_source` with the player server ID.


🔔 Receive screenshot response
Listen to the exported response event in your script:

Client-Side Handling (in your client script)
```Lua
-- Listen for the screenshot response
RegisterNetEvent('sb-takescreenshot:screenshotresponse')
AddEventHandler('sb-takescreenshot:screenshotresponse', function(url)
    -- Your client-side logic here
    print('[CLIENT] Received screenshot URL:', url)
end)
```

Server-Side Handling (in your server script)
```Lua
-- Listen for the screenshot response
RegisterNetEvent('sb-takescreenshot:screenshotresponse')
AddEventHandler('sb-takescreenshot:screenshotresponse', function(source, url)
    -- Your server-side logic here
    print(('[SERVER] Received screenshot URL from player %s: %s'):format(source, url))
end)
```

| Note: This event is triggered on both server and client side with the uploaded image URL.

🛠️ Dependencies: [screenshot-basic](https://github.com/citizenfx/screenshot-basic)

✨ Credits
Developed by: Surya Bhai [GitHub](https://github.com/suryabhaiin)
Powered by: FiveMerr API

📄 License
MIT. Free to use, modify, and contribute.

💡 Future Enhancements
Automatic dimension or compression adjustments

🔗 Contributions
Contributions welcome! Fork, improve, and submit a PR. Let's build efficient FiveM utilities together.
