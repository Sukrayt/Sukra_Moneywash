local ESX = nil
local MoneyWashing = {}
if Config.OldESX then
    TriggerEvent("esx:getSharedObject", function(obj) 
        ESX = obj 
    end)
else
    ESX = exports['es_extended']:getSharedObject()
end

RegisterServerEvent('sukra_moneywash:depositMoney')
AddEventHandler('sukra_moneywash:depositMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source) 
    local ply_blackmoney = xPlayer.getAccount('black_money').money or 0
    if ply_blackmoney < 1 then
        TriggerClientEvent('esx:showNotification', xPlayer.source,  Translation[Config.Locale]['no_blackmoney'])
    else
        xPlayer.removeAccountMoney('black_money', ply_blackmoney)
        TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['wash_in_progress'])
        local amount = (ply_blackmoney / 100) * Config.Percent
        MoneyWashing[xPlayer.identifier] = amount
    end
end)



RegisterServerEvent('sukra_moneywash:withdrawMoney')
AddEventHandler('sukra_moneywash:withdrawMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source) 
    if MoneyWashing and MoneyWashing[xPlayer.identifier] then
        xPlayer.addMoney(MoneyWashing[xPlayer.identifier])
        MoneyWashing[xPlayer.identifier] = nil
    end
end)

ESX.RegisterServerCallback('sukra:moneywash:getCurrentWashMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if MoneyWashing and MoneyWashing[xPlayer.identifier] then         
            cb(MoneyWashing[xPlayer.identifier])
    else
            cb(0)
    end
end)

ESX.RegisterServerCallback('sukra:moneywash:getPlayerBlackMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ply_blackmoney = xPlayer.getAccount('black_money').money or 0
    cb(ply_blackmoney)
end)

ESX.RegisterServerCallback('sukra:moneywash:gethour', function(source, cb)
    local date_table = os.date("*t")
    local currentHour = date_table.hour
    cb(currentHour)
end)
