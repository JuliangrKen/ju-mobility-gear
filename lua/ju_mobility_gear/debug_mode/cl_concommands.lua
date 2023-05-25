
local math = math
local tSin = TimedSin

local mg = ju.mobility_gear
local cfg = mg.cfg
local classes = mg.classes

local function updatePos(ply, bomb1, bomb2, distCenter, slopeDist)
    
    bomb1:SetPos(ply:LocalToWorld(Vector(distCenter, slopeDist, 0)))
    bomb2:SetPos(ply:LocalToWorld(Vector(distCenter, -slopeDist, 0)))

end

local function drawLines(bomb1, bomb2)

    bomb1:DrawTraces()
    bomb2:DrawTraces()

end

local bomb1C = Color(255, 157, 0)
local bomb2C = Color(170, 0, 255)

local function drawDots(bomb1, bomb2)
    
    render.SetColorMaterial()

    for k, v in ipairs(bomb1:Boom()) do

        render.DrawSphere(v.HitPos, 32, 10, 10,bomb1C )

    end

    for k, v in ipairs(bomb2:Boom()) do

        render.DrawSphere(v.HitPos, 32, 10, 10, bomb2C)

    end

end

local switchFunc = {
    
    -- 1. отрисовка только точек

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        drawDots(bomb1, bomb2)
        
    end,

    -- 2. отрисовка точек и линий

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        drawDots(bomb1, bomb2)
        drawLines(bomb1, bomb2)

    end,

    -- 3. отрисовка только линий

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        drawLines(bomb1, bomb2)
        
    end,

    -- 4. отрисовка только линий в движении

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        local sin = tSin(0.5, 0, 500, 0)
    
        bomb1:SetRadius(radius + sin)
        bomb2:SetRadius(radius + sin)

    end,

    -- 5. отрисовка фигуры

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        bomb1:DrawShere()
        bomb2:DrawShere()

    end,

    -- 6. отрисовка закрашенной фигуры

    function(bomb1, bomb2, distCenter, slopeDist, radius)
        
        bomb1:DrawPaintedShere()
        bomb2:DrawPaintedShere()

    end,

}

concommand.Add('ju_mg_draw_dots', function(ply, cmd, args, argStr)

    local state = tonumber(args[1])

    if state == nil or state == 0 then
        hook.Remove('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots')
        return
    end

    local ply = LocalPlayer()

    local distCenter = cfg.defaultMaxLength - cfg.defaultMinLength
    local slopeDist = cfg.defaultSlopeDist
    local radius = (cfg.defaultMaxLength - cfg.defaultMinLength) / 2

    local bomb1 = classes.trace_bomb:new(radius)
    local bomb2 = classes.trace_bomb:new(radius)
    
    bomb1:SetTakeEverything()
    bomb2:SetTakeEverything()

    local params = mg.addDefaultTraceParams({})
    
    for k, v in pairs(params) do
        bomb1[k] = v
        bomb2[k] = v
    end
    
    local drawFunc = switchFunc[state] or function() end

    hook.Add('PostDrawOpaqueRenderables', 'ju_mobility_gear_draw_dots', function()
        
        updatePos(ply, bomb1, bomb2, distCenter, slopeDist)
        drawFunc(bomb1, bomb2, distCenter, slopeDist, radius)

    end)

end)

concommand.Add('ju_mg_get_my_mg_state', function()
    
    local ply = LocalPlayer()
    local mgState = ply:GetMGState()

    print('MG state: ' .. mgState)

end)