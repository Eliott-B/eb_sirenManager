fx_version 'cerulean'
game 'gta5'

lua54 "yes"

author 'Eliott-B'
description 'Emergency siren manager'
version '1.0.0'

client_scripts {
    "client/cl_siren.lua"
}

server_scripts {
    "server/sv_sync.lua"
}

ui_page "web/dist/index.html"

files {
    "web/dist/index.html",
    "web/dist/**/*"
}