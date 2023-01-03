fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Pinkable'
version '1.0.0'
description 'Vehicle Spawner'

shared_script '@ox_lib/init.lua'

client_scripts {
    'client/functions.lua',
    'client/client.lua'
}

dependencie 'ox_lib'