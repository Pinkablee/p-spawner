fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Pinkable'
version '1.0.1'
description '(p-spawner) A modern, well-rounded FiveM vehicle spawner.'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_script 'server/version.lua'

dependencies {
    'ox_lib'
}
