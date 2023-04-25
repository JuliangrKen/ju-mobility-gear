
local function drawMGDots()
    
end

concommand.Add('ju_mg_draw_dots', function(ply, cmd, args, argStr)

    local state = args[1]

    if state == nil or state == 0 then
        hook.Remove('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots')
        return
    end

    hook.Add('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots', drawMGDots)

end, function () return {0, 1} end)
