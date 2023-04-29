
local mg = ju.mobility_gear

local function fly(ply, mv)
    
end

local function flyWithHooks(ply, mv)
    
end

local switchTable = {
    [4] = fly,
    [5] = flyWithHooks,
}

hook.Add('Move', 'ju_mobility_gear_move', function(ply, mv)

    local state = ply:GetMGState() or 0

    if state = 0 then
        return
    end

    switchTable[state](ply, mv)

end)
