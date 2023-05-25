
local math = math
local tSin = TimedSin

local mg = ju.mobility_gear
local cfg = mg.cfg
local classes = mg.classes

concommand.Add('ju_mg_draw_dots', function(ply, cmd, args, argStr)

    local state = tonumber(args[1])

    if state == nil or state == 0 then
        hook.Remove('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots')
        return
    end

    local ply = LocalPlayer()

    local radius = (cfg.defaultMaxLength - cfg.defaultMinLength) / 2
    local distCenter = cfg.defaultMaxLength - cfg.defaultMinLength
    local slopeDist = cfg.defaultSlopeDist

    local bomb1 = classes.trace_bomb:new(radius)
    local bomb2 = classes.trace_bomb:new(radius)
    
    bomb1:SetTakeEverything()
    bomb2:SetTakeEverything()

    local params = mg.addDefaultTraceParams({})
    
    for k, v in pairs(params) do
        bomb1[k] = v
        bomb2[k] = v
    end
    
    hook.Add('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots', function()
        
        if state == 2 then
            
            local sin = tSin(0.5, 0, 500, 0)
    
            bomb1:SetRadius(radius + sin)
            bomb2:SetRadius(radius + sin)

        end

        if state == 3 then

            render.SetColorMaterial()

            for k, v in ipairs(bomb1:Boom()) do

                render.DrawSphere(v.HitPos, 32, 10, 10, Color(255, 157, 0))

            end

            for k, v in ipairs(bomb2:Boom()) do

                render.DrawSphere(v.HitPos, 32, 10, 10, Color(170, 0, 255))

            end

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