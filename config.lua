--You have to Change the Position of the Washing Point in client.lua line 13, to big brain for me to add here sorry

config = {}     --dont touch
Translation = {}       --dont touch

config.Locale = 'en'    --en or de feel free to add more and PR it on GitHub


Translation = {         --Add more under en if you want to Translate the Script
    ['en'] = {
      ['wash_money'] = 'Press ~g~E~s~, to wash your Illegal Money',
      ['wash_succesfull'] = 'You succesfully washed your Illegal Money',
      ['no_blackmoney'] = 'You dont have any Illegal Money',
      ['money_wash_prompt'] = 'Press ~INPUT_CONTEXT~ to wash your ~r~Illegal Money~s~',
    },
    ['de'] = {
      ['wash_money'] = 'Drücke ~g~E~s~, um dein Schwarzgeld zu waschen',
      ['wash_succesfull'] = 'Du hast erfolgreich dein Schwarzgeld gewaschen',
      ['no_blackmoney'] = 'Du hast kein Schwarzgeld',
      ['money_wash_prompt'] = 'Drücke ~INPUT_CONTEXT~ um dein ~r~Schwarzgeld~s~ zu waschen',
    }
}
