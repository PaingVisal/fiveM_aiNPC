fx_version 'cerulean'
game 'gta5'

author 'sal24k'
description 'NPC AI with ChatGPT and Voice Playback'
version '1.0.0'

client_scripts {
    'client/npc_ai.lua'
}

server_scripts {
    'server/npc_ai_server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}
