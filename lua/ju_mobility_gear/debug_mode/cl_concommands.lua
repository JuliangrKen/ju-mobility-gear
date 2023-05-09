
local math = math
local tSin = TimedSin

local cfg = ju.mobility_gear.cfg
local classes = ju.mobility_gear.classes

concommand.Add('ju_mg_draw_dots', function(ply, cmd, args, argStr)

    local state = tonumber(args[1])

    if state == nil or state == 0 then
        hook.Remove('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots')
        return
    end

    local ply = LocalPlayer()

    local radius = (cfg.maxLength - cfg.minLength) / 2
    local distCenter = cfg.maxLength - cfg.minLength
    local slopeDist = cfg.defaultSlopeDist

    local bomb1 = classes.trace_bomb:new(radius)
    local bomb2 = classes.trace_bomb:new(radius)

    hook.Add('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots', function()
        
        if state == 2 then
            
            local sin = tSin(0.5, 0, 500, 0)
    
            bomb1:SetRadius(radius + sin)
            bomb2:SetRadius(radius + sin)

        end

        bomb1:SetPos(ply:LocalToWorld(Vector(distCenter, slopeDist, 0)))
        bomb2:SetPos(ply:LocalToWorld(Vector(distCenter, -slopeDist, 0)))

        bomb1:DrawTraces()
        bomb2:DrawTraces()

    end)

end, function () return {0, 1} end)

concommand.Add('ju_mg_get_my_mg_state', function()
    
    local ply = LocalPlayer()
    local mgState = ply:GetMGState()

    print(mgState)

end)