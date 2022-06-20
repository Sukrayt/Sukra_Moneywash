local ESX = nil
local MoneyWashing = {}
if config.UseOldESX then
    TriggerEvent("esx:getSharedObject", function(obj) 
        ESX = obj 
    end)
else
    ESX = exports['es_extended']:getSharedObject()
end

local round = function(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent('sukra_moneywash:depositMoney')
AddEventHandler('sukra_moneywash:depositMoney', function(black_money)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local ply_blackmoney = xPlayer.getAccount('black_money').money
    if ply_blackmoney < 1 then
        TriggerClientEvent('esx:showNotification', xPlayer.source,  Translation[config.Locale]['no_blackmoney'])
    else
        xPlayer.removeAccountMoney('black_money', ply_blackmoney)
        TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[config.Locale]['wash_in_progress'])
        local amount = (ply_blackmoney / 100) * config.Percent
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

ESX.RegisterServerCallback('sukra:moneywash:getmoneyy', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if MoneyWashing and MoneyWashing[xPlayer.identifier] then         
            cb(MoneyWashing[xPlayer.identifier])
    end
end)

ESX.RegisterServerCallback('sukra:moneywash:getmoney1', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ply_blackmoney = xPlayer.getAccount('black_money').money
    cb(ply_blackmoney)
end)

ESX.RegisterServerCallback('sukra:moneywash:gethour', function(source, cb)
    local date_table = os.date("*t")
    local hournow = date_table.hour
    cb(hournow)
end)
