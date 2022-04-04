  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
      PlayerData = xPlayer
  end)
  
  function hintToDisplay(text)
      SetTextComponentFormat("STRING")
      AddTextComponentString(text)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
  
  local place = {
      --{x = 2434.7, y = 4968.66, z = 42.35},
      {x = 2434.7, y = 4968.66, z = 42.35}
  }
  
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          for k in pairs(place) do
              DrawMarker(27, place[k].x, place[k].y, place[k].z -1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
          end
      end
  end)
  
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
  
          for k in pairs(place) do
  
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, place[k].x, place[k].y, place[k].z)
  
              if dist <= 0.5 then
                  hintToDisplay(Translation[config.Locale]['money_wash_prompt'])
                  
                  if IsControlJustPressed(0, 38) then
                      TriggerServerEvent('sukra_moneywash:washMoney')
                  end            
              end
          end
      end
  end)