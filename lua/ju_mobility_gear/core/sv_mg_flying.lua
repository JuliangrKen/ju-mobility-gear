
local mg = ju.mobility_gear

local function moveWithMG(ply, mv)

    print 'moveWithMG'
    
end

local function moveWithMGMode(ply, mv)
    
    print 'moveWithMGMode'

end

local function pushWithHooks(ply, mv)
    
    print 'pushWithHooks'

end

local function fly(ply, mv)
    
    print 'fly'

end

local function flyWithHooks(ply, mv)
    
    print 'flyWithHooks'

end

local switchTable = {
    -- PASSIVE
    [1] = moveWithMG,

    -- ACTIVE
    [2] = moveWithMGMode,

    -- HOOK_PULLS
    [3] = pushWithHooks,

    -- FLIGHT
    [4] = fly,

    -- FLIGHT_AND_HOOK_PULLS
    [5] = flyWithHooks,
}

hook.Add('Move', 'ju_mobility_gear_move', function(ply, mv)

    local state = ply:GetMGState() or 0

    if state == 0 then
        return
    end

    local switchFunc = switchTable[state]

    if !switchFunc then
        return
    end

    switchFunc(ply, mv)

end)
