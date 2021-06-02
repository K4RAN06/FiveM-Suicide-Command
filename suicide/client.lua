local function onSuicide()
    
    Citizen.CreateThread(function()
        RequestAnimDict('mp_suicide')
        while not HasAnimDictLoaded('mp_suicide') do
            Citizen.Wait(0)
        end
        
        local ped = PlayerPedId()
        
        animationWeapon = ''
        weaponType = ''
        --Suicide By Weapon--
        if HasPedGotWeapon(ped, GetHashKey('weapon_pistol'), false) then
            weaponType = 'weapon_pistol'
            animationWeapon = 'pistol'
        elseif HasPedGotWeapon(ped, GetHashKey('weapon_combatpistol'), false) then
            weaponType = 'weapon_combatpistol'
            animationWeapon = 'pistol'
        else -- Suicide By Pill -- 
            weaponType = 'weapon_pill'
            animationWeapon = 'pill'
        end -- if
        
        SetCurrentPedWeapon(ped, GetHashKey(weaponType), true)
        TaskPlayAnim(ped, "mp_suicide", animationWeapon, 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        
        ClearPedTasks(ped)
        while true do 
            local animationTime = GetEntityAnimCurrentTime(ped, 'MP_SUICIDE', animationWeapon)
                Citizen.Wait(1)
            if animationTime > 0.536 then 
                ClearPedTasks(ped)
                ClearEntityLastDamageEntity(ped)
                SetEntityHealth(ped, 0)
            end -- if
            
            if animationTime > 0.3 then 
                SetPedShootRate(ped, 1000)
                SetPedShootsAtCoord(ped, 0.0, 0.0, 0.0, 0)
                    Notify("~g~Successfully Committed Suicide") --Notifes Player That Suicide Has Successfully Executed
            end
            
        end
        
    end)
    
end
RegisterCommand('suicide', onSuicide)

--Function

function Notify(string) SetNotificationTextEntry("STRING") AddTextComponentString(string) DrawNotification(false, true) end