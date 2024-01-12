fx_version 'cerulean'
game 'gta5'

author 'Eliott-B'
description 'Emergency siren manager'
version '1.0.0'

client_script {
    "client/cl_siren.lua",
    "client/cl_gui.lua"
}

server_script {
    "server/sv_sync.lua"
}