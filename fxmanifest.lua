fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Pinkable'
version '1.0.8'
description 'p-spawner: A comprehensive and feature-rich vehicle spawner for FiveM, designed with modern functionality and versatility.'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client/client.lua'
server_script 'server/version.lua'

dependencies {
    'ox_lib'
}
