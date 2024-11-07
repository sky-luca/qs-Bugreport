fx_version 'cerulean'
game 'gta5'

author 'Luca'
description 'Bug Report System with ox_lib and Discord Logging'
version '1.0.0'
lua54 'yes'

dependency 'ox_lib'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
    'config.lua'
}

shared_scripts {
    '@ox_lib/init.lua'
}
