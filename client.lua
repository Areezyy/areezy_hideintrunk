		local player = PlayerPedId()
		local ibaklucka = false

	Citizen.CreateThread(function()
	  	while true do
		    Citizen.Wait(5)

		    	player = PlayerPedId()
			local plyCoords = GetEntityCoords(player, false)
			local vehicle = FordonFram()


		    if IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 54) and GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
			 	SetVehicleDoorOpen(vehicle, 5, false, false)    	
		    	if not ibaklucka then
		        	AttachEntityToEntity(player, vehicle, -1, 0.0, -2.0, 0.335, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
		       		RaiseConvertibleRoof(vehicle, false)
		       		if IsEntityAttached(player) then
						ClearPedTasksImmediately(player)
						Citizen.Wait(100)	       			
						TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
		            	if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
		          			Streaming('timetable@floyd@cryingonbed@base', function()
					  		TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
		               	end)
		            end    
		           	
		    		ibaklucka = true					         		
		    		else
		    		ibaklucka = false
		    		end   			
		    	elseif ibaklucka and IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 54) then
		    		DetachEntity(player, true, true)
		    		SetEntityVisible(player, true, true)
		   			ClearPedTasks(player)   
		    		ibaklucka = false
					ClearAllHelpMessages()		    	

		    	end
		    	Citizen.Wait(2000)
		    	SetVehicleDoorShut(vehicle, 5, false)    	
		    end
	    	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not ibaklucka and GetVehiclePedIsIn(player, false) == 0 then
			elseif DoesEntityExist(vehicle) and ibaklucka then
		    		car = GetEntityAttachedTo(player)
		    		carxyz = GetEntityCoords(car, 0)
		   			local visible = true
		   			DisableAllControlActions(0)
		   			DisableAllControlActions(1)
		   			DisableAllControlActions(2)
		   			EnableControlAction(0, 0, true)
		   			EnableControlAction(0, 249, true) 
		   			EnableControlAction(2, 1, true)
		   			EnableControlAction(2, 2, true)	
		   			EnableControlAction(0, 177, true) 
		   			EnableControlAction(0, 200, true) 				
		     			if IsDisabledControlJustPressed(1, 22) then
		     				if visible then
		    					SetEntityVisible(player, false, false)
		    					visible = false			
		    				end   	
		    			end 					
			elseif not DoesEntityExist(vehicle) and ibaklucka then
		    		DetachEntity(player, true, true)
		    		SetEntityVisible(player, true, true)
		   			ClearPedTasks(player)  	  
		    		ibaklucka = false		
		   			ClearAllHelpMessages()	 		    			
			end  	
	  	end
	end)

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function loadAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  RequestAnimDict( dict )
  Citizen.Wait(5)
 end
end

function FordonFram()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end
