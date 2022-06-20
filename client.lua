local ESX = nil
if config.UseOldESX then
    Citizen.CreateThread(function()
        ESX = nil
       
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
local round = function(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
function openMenu()
    local blackwashmoney = 0
    local bb = 0
    local hournow = 0
    ESX.TriggerServerCallback("sukra:moneywash:getmoneyy", function(blackwashmoney) 
        ESX.TriggerServerCallback("sukra:moneywash:getmoney1", function(bb) 
            ESX.TriggerServerCallback("sukra:moneywash:gethour", function(hournow) 
    		mainMenu = NativeUI.CreateMenu(Translation[config.Locale]['menu_title'], "")
    		_menuPool:Add(mainMenu)
    

    		if bb == nil then
        		bb = 0
    		end
    		local get_money = NativeUI.CreateItem(Translation[config.Locale]['get_wash_money_title'], "")
    		mainMenu:AddItem(get_money)
    		local wash_money = NativeUI.CreateItem(Translation[config.Locale]['menu_wash_money_title'], Translation[config.Locale]['menu_wash_money_desc'] .. tostring(bb))
    		mainMenu:AddItem(wash_money)
    		if hournow == config.hour and blackwashmoney ~= 0 then
    			get_money:Enabled(true)
    		else
        		get_money:Enabled(false)
    		end
    		local see_money = NativeUI.CreateItem(Translation[config.Locale]['menu_money_title'], Translation[config.Locale]['menu_money_desc'] .. tostring(blackwashmoney))
    		mainMenu:AddItem(see_money)
    		see_money:Enabled(false)
    		mainMenu.OnItemSelect = function(sender, item, index)
			if item == wash_money then                          --probably not the best method
            			TriggerServerEvent('sukra_moneywash:depositMoney', black_money_percent)
            			TriggerServerEvent("sukra_moneywash:withdrawMoney", source)
            			mainMenu:Visible(false)
        		elseif item == get_money then
            			TriggerServerEvent("sukra_moneywash:withdrawMoney", source)
            			ESX.ShowNotification(Translation[config.Locale]['wash_succesfull'])
            			mainMenu:Visible(false)
    			end
		end
    --the following disables Mouse Control and prevents the Camera from spinning when the Menu is open
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
        	DrawMarker(27, config.MoneywashLocation, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
        	if dist < 1.0 then
            		ESX.ShowHelpNotification(Translation[config.Locale]['wash_money'])
            		if IsControlJustReleased(0, 38) then
                		openMenu()
            		end
        	end
	end
	Citizen.Wait(sleep)
end)

if config.timereminder then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1800000)
            ESX.TriggerServerCallback("sukra:moneywash:gethour", function(hournow) 
                ESX.TriggerServerCallback("sukra:moneywash:getmoneyy", function(blackwashmoney) 
                if hournow == config.hour then
                       for _, playerId in ipairs(GetPlayers()) do
                                if blackwashmoney ~= nil then
                                    if config.customnotify then
                                        notify(Translation[config.Locale]['notification_done'])
                                    else
                                        ESX.ShowNotification(Translation[config.Locale]['notification_done'])
                                    end
                                end
                	end
            	end
        	end)
    	    end)
        end
    end)
end
