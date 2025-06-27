fx_version 'cerulean'
game 'gta5'

author 'Surya Bhai'
description 'Secure Screenshot Capture with Preview, Save, Retake, Cancel'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
}
server_exports {
    'takeScreenshotFlow'
}

client_exports {
    'takeScreenshotFlow'
}
