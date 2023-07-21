fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Pinkable'
version '1.0.3'
description 'Vehicle Spawner (p-spawner)'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/functions.lua',
    'client/client.lua'
}

server_script 'server/version.lua'

dependencies {
    'ox_lib'
}
