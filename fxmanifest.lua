fx_version 'cerulean'
game 'gta5'

author 'FjamZoo#0001 & MannyOnBrazzers#6826'
description 'A No Pixel inspired edit of QBCore\'s Phone. Released By RenewedScripts'
version 'Test'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
    '@qb-garages/config.lua',
}

client_scripts {
    'client/*.lua',
    'modules/targets/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
}

dependencies {
    'oxmysql',
    'ox_lib',
    'Renewed-Lib'
}