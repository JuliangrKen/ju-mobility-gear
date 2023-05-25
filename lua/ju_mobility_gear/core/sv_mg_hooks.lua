local mg = ju.mobility_gear
local cfg = mg.cfg

local function makeSetupSteel(ply, point)

    local steel = ents.Create 'ju_modity_gear_steel_wire'

    steel:SetPlayer(ply)
    steel:SetHookPoint(ply)
    
end

-- TODO: учесть условие одного троса

local function isCorrectTraces(tr1, tr2)
    
    return isvector(tr1) and isvector(tr2)

end

local function updateOrCreateSteels(ply)

    local tr1, tr2 = ply:GetHookDots()
    
    print(tr1 or 'TR1 NONE', tr2 or 'TR2 NONE')

    if !isCorrectTraces(tr1, tr2) then
        return false
    end

    if ply.steel1 then
        
        ply.steel1:SetHookPoint(tr1)
    
    else

        ply.steel1 = makeSetupSteel(ply, tr1)

    end

    if ply.steel2 then
        
        ply.steel2:SetHookPoint(tr2)
    
    else

        ply.steel2 = makeSetupSteel(ply, tr2)

    end

    return true

end

local function startAllSteels(...)
    
    for _, steel in pairs(...) do
    
        steel:Start()

    end

end

--[[
    ply : Player

    return bool

    true - OK
    false - player or traces isn't correct
]]
function mg.runHooks(ply)

    if !(ply and IsValid(ply)) then return false end

    return updateOrCreateSteels(ply)
    
end

--[[
    ply : Player
]]
function mg.stopHooks(ply)
    
    if ply.steel1 then
        
        ply.steel1:Stop()
        ply.steel1 = nil

    end

    if ply.steel2 then
        
        ply.steel2:Stop()
        ply.steel2 = nil

    end

end