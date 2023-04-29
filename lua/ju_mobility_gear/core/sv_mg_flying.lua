
local mg = ju.mobility_gear

local function fly(ply, mv)
    
    print 'fly'

end

local function flyWithHooks(ply, mv)
    
    print 'flyWithHooks'

end

local switchTable = {
    [4] = fly,
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
