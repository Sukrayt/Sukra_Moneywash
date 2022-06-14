fx_version 'cerulean'

game 'gta5'

author 'Sukra, Ludaro'

description 'Simple Moneywash System for ESX'

version '2.0'

shared_script '@es_extended/imports.lua'	--remove this line if you dont use esx legacy remember to change the config option

server_scripts {
	'@oxmysql/lib/MySQL.lua',				--replace this line with 	'@mysql-async/lib/MySQL.lua',	if you use mysql-async remember to change the config option
	'server.lua'
}


shared_scripts{
	'config.lua'

}
client_script {
	'@NativeUI/NativeUI.lua',
	'client.lua'
}