
local mg = ju.mobility_gear
local cfg = mg.cfg


local function onSetPassive(ply, oldState, newState)

    -- TODO: Убрать все эффекты

end

-- TODO: Убрать, если не нужно
local function onSetActive(ply, oldState, newState)

end

local function onSetHookPulls(ply, oldState, newState)
    
    -- TODO: Первый выпуск крюков
    
end

local function onSetFlight(ply, oldState, newState)
    
    -- TODO: Приостановка выпуска крюков

end

local function onSetFlightAndHookPulls(ply, oldState, newState)
    
    -- TODO: Дальнейшие выпуски крюков

end

local switchTable = {
    -- PASSIVE
    [1] = onSetPassive,

    -- ACTIVE
    [2] = onSetActive,

    -- HOOK_PULLS
    [3] = onSetHookPulls,

    -- FLIGHT
    [4] = onSetFlight,

    -- FLIGHT_AND_HOOK_PULLS
    [5] = onSetFlightAndHookPulls,
}

local function handleMGStateWasChanged(ply, oldState, newState)
    
    local switchFunc = switchTable[newState] 
    if switchFunc then
        switchFunc(ply, oldState, newState)
    end

end

if cfg.debug then

    hook.Add('Ju_MGState_WasChanged', 'Ju_MGState_WasChanged_Main', function(ply, oldState, newState)
        
        handleMGStateWasChanged(ply, oldState, newState)

        mg.log(ply:Nick() .. ' was changed MGState: '
            .. mg.getMGStateName(oldState) .. ' -> '.. mg.getMGStateName(newState))
        
    end)
   
else

    hook.Add('Ju_MGState_WasChanged', 'Ju_MGState_WasChanged_Main', handleMGStateWasChanged)
    
end
