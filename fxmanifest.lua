shared_script '@ax-draadlozeoplader/ai_module_fg-obfuscated.lua'
shared_script '@ax-draadlozeoplader/ai_module_fg-obfuscated.js'
fx_version 'cerulean'
game 'gta5'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
    'config.lua',
    'client.lua'
}

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/*'
}
