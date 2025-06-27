# 📸 sb-takescreenshot

Take high-quality screenshots from client, preview them with NUI, and upload to FiveMerr API.  

## 🚀 Features
- ✅ Take screenshots from any player
- ✅ Show stylish NUI preview with Save/Retake/Cancel options
- ✅ Upload directly to FiveMerr API
- ✅ Easy exports for use in other scripts

## ⚙️ Installation
1. Download or clone the resource:
```bash
git clone https://github.com/YourUsername/sb-takescreenshot.git
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

server:
```Lua
exports['sb-takescreenshot']:takeScreenshot(target_source)
```
client:
```Lua
exports['sb-takescreenshot']:takeScreenshot()
```
