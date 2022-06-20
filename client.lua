local ESX = nil
if Config.OldESX then
    Citizen.CreateThread(function()
        while ESX == nil do
           TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
          Citizen.Wait(0)
        end
    end)
else
	ESX = exports['es_extended']:getSharedObject()
end


--UI
_menuPool = NativeUI.CreatePool()
local mainMenu
local notify = function(txt)
	-- CUSTOM NOTIFICATION
end

local openMenu = function()
    ESX.TriggerServerCallback("sukra:moneywash:getCurrentWashMoney", function(currentWashMoney) 
        ESX.TriggerServerCallback("sukra:moneywash:getPlayerBlackMoney", function(ply_money) 
            ESX.TriggerServerCallback("sukra:moneywash:gethour", function(hournow) 
    		mainMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_title'], "")
    		_menuPool:Add(mainMenu)
    		local get_money = NativeUI.CreateItem(Translation[Config.Locale]['get_wash_money_title'], "")
    		mainMenu:AddItem(get_money)
    		local wash_money = NativeUI.CreateItem(Translation[Config.Locale]['menu_wash_money_title'], Translation[Config.Locale]['menu_wash_money_desc'] .. tostring(ply_money))
    		mainMenu:AddItem(wash_money)
    		if hournow == Config.Hour and currentWashMoney ~= 0 then
    			get_money:Enabled(true)
    		else
        		get_money:Enabled(false)
    		end
    		local see_money = NativeUI.CreateItem(Translation[Config.Locale]['menu_money_title'], Translation[Config.Locale]['menu_money_desc'] .. tostring(ply_money))
    		mainMenu:AddItem(see_money)
    		see_money:Enabled(false)
    		mainMenu.OnItemSelect = function(sender, item, index)
			if item == wash_money then                          --probably not the best method
            			TriggerServerEvent('sukra_moneywash:depositMoney')
            			mainMenu:Visible(false)
        		elseif item == get_money then
            			TriggerServerEvent("sukra_moneywash:withdrawMoney")
            			ESX.ShowNotification(Translation[Config.Locale]['wash_succesfull'])
            			mainMenu:Visible(false)
    			end
		end
    		mainMenu:Visible(true)
    		_menuPool:RefreshIndex()
    		_menuPool:MouseControlsEnabled (false)
    		_menuPool:MouseEdgeEnabled (false)
		_menuPool:ControlDisablingEnabled(false)
		end)
	end)
end)
end	

Citizen.CreateThread(function()
    while true do
	local pedCoord = GetEntityCoords(PlayerPedId())
	local dist = #(pedCoord - config.MoneywashLocation)
        local sleep = 3000
	if dist < 10.0 then
		sleep = 0
		_menuPool:ProcessMenus()
        	DrawMarker(27, Config.MoneywashLocation, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        	if dist < 1.0 then
            		ESX.ShowHelpNotification(Translation[Config.Locale]['wash_money'])
            		if IsControlJustReleased(0, 38) then
                		openMenu()
            		end
        	end
	end
	Citizen.Wait(sleep)
end)

if Config.Reminder then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1800000)
            ESX.TriggerServerCallback("sukra:moneywash:gethour", function(currentHour) 
                ESX.TriggerServerCallback("sukra:moneywash:getCurrentWashMoney", function(currentWashMoney) 
                	if currentHour == Config.hour then
				if currentWashMoney ~= nil then
					if Config.ESXNotify then
						ESX.ShowNotification(Translation[Config.Locale]['notification_done'])
					else
						notify(Translation[Config.Locale]['notification_done'])
					end
				end
            		end
        	end)
    	    end)
        end
    end)
end
