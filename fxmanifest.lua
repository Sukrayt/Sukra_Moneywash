fx_version 'cerulean'

game 'gta5'

author 'Sukra'

description 'Simple Moneywash System for ESX'

version '1.0'

shared_script '@es_extended/imports.lua'

server_scripts {
	'server.lua',
	'config.lua'
}

client_script {
	'client.lua',
	'config.lua'
}