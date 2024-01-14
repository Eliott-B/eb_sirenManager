fx_version 'cerulean'
game 'gta5'

lua54 "yes"

author 'Eliott-B'
description 'Emergency siren manager'
version '1.0.0'

client_scripts {
    "client/cl_siren.lua",
    "client/cl_gui.lua"
}

server_scripts {
    "server/sv_sync.lua"
}

ui_page "web/build/index.html"

files {
    "web/build/index.html",
    "web/build/**/*"
}