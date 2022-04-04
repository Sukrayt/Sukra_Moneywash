--if config.Locale == nil then
--    print('Error Locale is Invalid, set it to de or en if it still breaks join my Discord')
--end

RegisterServerEvent('sukra_moneywash:washMoney')
AddEventHandler('sukra_moneywash:washMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local accountMoney = 0
    
    accountMoney = xPlayer.getAccount('black_money').money
    
    if accountMoney < 1 then
        TriggerClientEvent('esx:showNotification', _source,  Translation[config.Locale]['no_blackmoney'])
    else
      
            xPlayer.removeAccountMoney('black_money', accountMoney)
            xPlayer.addMoney(accountMoney * 0.8)
            TriggerClientEvent('esx:showNotification', _source, Translation[config.Locale]['wash_succesfull'])
    end
end)