if config.UseOldESX then
    local ESX = nil

    TriggerEvent("esx:getSharedObject", function(obj) 
        ESX = obj 
    end)
end   

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

RegisterServerEvent('sukra_moneywash:washMoney')
AddEventHandler('sukra_moneywash:washMoney', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local black_money = 0
   
    
    local black_money_player = xPlayer.getAccount('black_money').money

    
    if black_money_player < 1 then
        TriggerClientEvent('esx:showNotification', _source,  Translation[config.Locale]['no_blackmoney'])
    else
        local black_money_percent = black_money_player / 100 * config.Percent
        local result_black_money = round(black_money_percent)
        xPlayer.removeAccountMoney('black_money', black_money_player)
        TriggerClientEvent('esx:showNotification', _source, Translation[config.Locale]['wash_in_progress'])
    end
end)



RegisterServerEvent('sukra_moneywash:getMoney')
AddEventHandler('sukra_moneywash:getMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.addMoney(black_money_player)
TriggerClientEvent('esx:showNotification', _source, Translation[config.Locale]['wash_succesfull'])
end)

RegisterServerEvent('sukra_moneywash:depositMoney')
AddEventHandler('sukra_moneywash:depositMoney', function(black_money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    print(source)
    print(xPlayer.identifier)
    local black_money_player = xPlayer.getAccount('black_money').money
    if black_money_player < 1 then
        TriggerClientEvent('esx:showNotification', _source,  Translation[config.Locale]['no_blackmoney'])
    else
        xPlayer.removeAccountMoney('black_money', black_money_player)
        TriggerClientEvent('esx:showNotification', _source, Translation[config.Locale]['wash_in_progress'])
    local percentage = black_money_player / 100
    local resultt = percentage * config.Percent
   -- print(black_moneyy)
   MySQL.Async.execute('UPDATE users SET black_money_washing = @black_money_washing WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@black_money_washing'] = resultt,
          },function(result)
            if result then
                print("yay")
            else
                print("no ;(")
            end
        end)
    end
end)



RegisterServerEvent('sukra_moneywash:withdrawMoney')
AddEventHandler('sukra_moneywash:withdrawMoney', function()
    print("lol")
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source) 
    MySQL.Async.fetchAll('SELECT * from users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
    },function(result)
      if result then
        for _, v in pairs(result) do
            -- --print(v.truckerexp)
            print(v.black_money_washing)
        xPlayer.addMoney(v.black_money_washing)
           --addexp(v.truckerexp, difficulty)
        end
    end
end)
end)

--[[
RegisterServerEvent('sukra_moneywash:cock_and_ball_torture')
AddEventHandler('sukra_moneywash:cock_and_ball_torture', function()
--    local timer = os.difftime(0 0 0 config.MoneyTime)
--    if timer <= 1 then
--       TriggerServerEvent('sukra_moneywash:moneyNotify')
--    end
end)
]]







ESX.RegisterServerCallback('sukra:moneywash:getmoneyy', function(source, cb)
    local ssource = source
        local xPlayer = ESX.GetPlayerFromId(ssource)
        --print(hour)
        local black_money_player = 0
        if black_money_player ~= nil then
         black_money_playerr = xPlayer.getAccount('black_money').money
         --print(black_money_playerr)
        end
        bb = black_money_player / 100 * config.Percent
        ---- --print(playerId)
        MySQL.Async.fetchAll('SELECT * from users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
        },function(result)
          if result then
            for _, v in pairs(result) do
                -- --print(v.truckerexp)
                cb(v.black_money_washing)
               --addexp(v.truckerexp, difficulty)
            end
        else
            --print("NO EXP TABLE FOUND MONEYWASH PLEASE ADD IT IN YOUR MYSQL!!")
          end
        end)
      end)

      ESX.RegisterServerCallback('sukra:moneywash:getmoney1', function(source, cb)
        local ssource = source
    local black_money_playerr = nil
        local xPlayer = ESX.GetPlayerFromId(ssource)

        local black_money_player = 0
        if black_money_player ~= nil then
         black_money_playerr = xPlayer.getAccount('black_money').money
         cb(black_money_playerr)
         --print(black_money_playerr)
        else
            cb(0)
        end
        bb = black_money_player / 100 * config.Percent

      end)

      ESX.RegisterServerCallback('sukra:moneywash:gethour', function(source, cb)
        local date_table = os.date("*t")
        local hournow = date_table.hour
        cb(hournow)
      end)
