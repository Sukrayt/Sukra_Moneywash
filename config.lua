config = {}     --dont touch
Translation = {}       --dont touch

config.Locale = 'en'    --en or de feel free to add more and PR it on GitHub
config.hour = 15
config.MoneywashLocation = vector3(2434.7, 4968.66, 41.35)    --this is the position where the Marker will draw
config.timereminder = true -- reminds people who washed money that they cant get their money if config.hour matches the hour (every 30 min once)
config.customnnotification = false -- if false then esx.shownotification will be used ;)
function notify(txt) -- use your notify here, and input everything except the text, input txt where your text should be.
end 
config.UseOldESX = false  --enable this if you are using Esx V1 Final or 1.2 Anything below 1.2 will not work you should not use these old versions anyways remember to change your fxmanifest.lua if enabled
config.MYSQL = 'oxmysql'  --either oxmysql or mysql-async, if you use mysql-async you have to change the path in fxmanifest.lua


config.Percent = 50

--config.MoneyTime = 15 0 0  --this determines when the Black Money will be washed

Translation = {         --Add more under en if you want to Translate the Script
    ['en'] = {
      ['wash_money'] = 'Press ~g~E~s~, to wash your Illegal Money',
      ['wash_succesfull'] = 'You succesfully washed your Illegal Money',
      ['wash_in_progress'] = 'Your Money is being washed',
      ['no_blackmoney'] = 'You dont have any Illegal Money',
      ['money_wash_prompt'] = 'Press ~INPUT_CONTEXT~ to wash your ~r~Illegal Money~s~',
      ['menu_title'] = 'Money Laundring',
      ['menu_wash_money_title'] = 'Wash your Illegal Money',
      ['menu_wash_money_desc'] = 'How much Black Money you have on yourself:',
      ['menu_money_title'] = 'Money Status',
      ['menu_money_desc'] = 'Money in the Laundring Machine:',
      ['notify_header'] = 'Money Wash is done',                       --only relevant if you use qs-smartphone
      ['notify_text'] = 'Your Money Wash is done, come pick it up',
      ['outoftime'] = 'You didn\'t pick your Money up in time, come back tomorrow',
      ['get_wash_money_title'] = 'Get  your Clean Money',
      ['get_wash_money_desc'] = 'The Amount of Money you will receive:',
      ['No_Time1'] = 'I dont have time yet! come back at:',
      ['No_Time2'] = 'pm!'
    },
    ['de'] = {
      ['wash_money'] = 'Dr??cke ~g~E~s~, um dein Schwarzgeld zu waschen',
      ['wash_succesfull'] = 'Du hast erfolgreich dein Schwarzgeld gewaschen',
      ['wash_in_progress'] = 'Dein Geld wird gewaschen',
      ['no_blackmoney'] = 'Du hast kein Schwarzgeld',
      ['money_wash_prompt'] = 'Dr??cke ~INPUT_CONTEXT~ um dein ~r~Schwarzgeld~s~ zu waschen',
      ['menu_title'] = 'Geldw??scherei',
      ['menu_wash_money_title'] = 'Wasche dein Schwarzgeld',
      ['menu_wash_money_desc'] = 'Soviel Schwarzgeld hast du gerade bei dir:',
      ['menu_money_title'] = 'Geld Status',
      ['menu_money_desc'] = 'Soviel geld hast du gerade in der Waschanlage:',
      ['notify_header'] = 'Geldw??sche abgeschlossen',                 --nur relevant wenn du qs-smartphone benutzt
      ['notify_text'] = 'Dein Geld wurde gewaschen, hole es ab',
      ['outoftime'] = 'Du hast dein Geld nicht rechtzeitig abgeholt, versuche es morgen nochmal',
      ['come_back_later'] = 'Dein Schwarzgeld ist noch nicht bereit, komm sp??ter wieder',
      ['get_wash_money_title'] = ' Gereinigtes Schwarzgeld holen',
      ['get_wash_money_desc'] = 'Die Anzahl des Geldes das du erhalten wirst:',
      ['No_Time1'] = 'Ich habe jetzt keine zeit daf??r komm bitte um:',
      ['No_Time2'] = 'Uhr!'
    }
}
