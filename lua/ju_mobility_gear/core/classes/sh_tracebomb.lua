
local math = math
local pi = math.pi
local cos = math.cos
local sin = math.sin
local deg = math.deg

local defaultColor = Color(10, 95, 215)
local defaultNumVertexesCircle = 10

local TRACE_BOMB = {}

--[[
    
    public:

    Pos
    Radius
    NumVertexesCircle

]]

TRACE_BOMB.__index = TRACE_BOMB

function TRACE_BOMB:new(pos, radius, numVertexesCircle)
    
    local heir = setmetatable({}, self)

    heir.__index = self

    heir.Pos = pos
    heir.Radius = radius
    heir.NumVertexesCircle = numVertexesCircle or defaultNumVertexesCircle

    return heir

end

function TRACE_BOMB:SetSphereAxis(sphereAxis)
    
    self.sphereAxis = sphereAxis
    return self

end

function TRACE_BOMB:GetSphereAxis()
    
    return self.sphereAxis or Vector(0, 0, 0)

end

function TRACE_BOMB:SetHorizontal(isX)
    
    self:SetSphereAxis(isX and Vector(1, 0, 0) or Vector(0, 1, 0))
    return self

end

function TRACE_BOMB:SetVertical()
    
    self:SetSphereAxis(Vector(0, 0, 1))
    return self

end

function TRACE_BOMB:SetTraceFilter(filter)

    self.filter = filter
    return filter
    
end

function TRACE_BOMB:GetTraceFilter()
    
    return filter

end

--[[
    function samplingConditionsFunc(trace, pos)

    trace - table (Structures/TraceResult)
    pos - TRACE_BOMB.Pos
]]

function TRACE_BOMB:SetSamplingConditionsFunc(samplingConditionsFunc)
    
    self.samplingConditionsFunc = samplingConditionsFunc
    return self

end

function TRACE_BOMB:GetSamplingConditionsFunc()
    
    return self.samplingConditionsFunc

end

function TRACE_BOMB:SetTakeEverything()
    
    self.takeEverything = true
    return self

end

function TRACE_BOMB:SetTakeFirstOne()

    self.takeEverything = false
    return self

end

local function createCircle(numVertexesCircle)
    
    local circleVertexes = {}

    local piStep = 2 * pi / numVertexesCircle
    local currentPi = pi / 2

    for i = 1, numVertexesCircle, 1 do

        circleVertexes[i] = Vector(cos(currentPi), sin(currentPi), 0)

        currentPi = currentPi + piStep

    end

    return circleVertexes

end

local function createShereByCircle(circleVertexes)

    local shereVertexes = {}
    
    local numVertexesCircle = #circleVertexes
    local rotateAngle = Angle(360 / numVertexesCircle, 0, 0)

    local matrix = Matrix()
    
    for i = 1, numVertexesCircle, 1 do
        
        for k, v in ipairs(circleVertexes) do
            
            shereVertexes[#shereVertexes + 1] = matrix * v

        end

        matrix:Rotate(rotateAngle)

    end

    return shereVertexes
    
end

function TRACE_BOMB:createCircle()

    self.circleVertexes = createCircle(self.NumVertexesCircle)

end

function TRACE_BOMB:createShereByCircle()
    
    self.shereVertexes = createShereByCircle(self.circleVertexes)

end

function TRACE_BOMB:shereSetup()
    
    local matrix = Matrix()

    matrix:Translate(self.Pos)
    matrix:Scale(Vector(self.Radius, self.Radius, self.Radius))
    matrix:Rotate(self:GetSphereAxis():Angle())

    self.vertexes = {}

    for k, v in ipairs(self.shereVertexes) do
        
        self.vertexes[k] = matrix * v

    end

end

function TRACE_BOMB:createShere()
    
    local shereVertexes = {}

    self:createCircle()
    self:createShereByCircle()

    self:shereSetup()
    
    return self.vertexes

end

function TRACE_BOMB:UpdateVertexes()
    
    self.vertexes = self:createShere()
    return self

end

function TRACE_BOMB:Boom()
    
    if !self.vertexes then
        self:UpdateVertexes()
    end

    local resultTable = self.takeEverything and {}

    for _, v in ipairs(self.vertexes) do
        
        local trace = util.TraceLine({
            
            start = self.Pos,
            endpos = v,

            filter = self.filter,
        
        })

        if !(trace and trace.Hit) then continue end

        if self.samplingConditionsFunc and !self.samplingConditionsFunc(trace, self.Pos) then continue end

        if !resultTable then return trace end

        resultTable[#resultTable + 1] = trace 

    end

    return resultTable

end


if CLIENT then

    function TRACE_BOMB:DrawShere(color)
        
        if !self.vertexes then return end

        local last
        for k, v in ipairs(self.vertexes) do
            
            if last then
                render.DrawLine(last, v, color or defaultColor, true)
            end

            last = v

        end


    end
    
    function TRACE_BOMB:DrawPaintedShere(color)
        
        render.SetColorMaterial()
        render.DrawSphere(self.Pos, self.Radius, self.NumVertexesCircle, self.NumVertexesCircle, color or defaultColor)

    end

    function TRACE_BOMB:DrawTraces(color)
    
        if !self.vertexes then return end

        for _, v in ipairs(self.vertexes) do
            
            render.SetColorMaterial()
            render.DrawLine(self.Pos, v, color or defaultColor, true)

        end

    end

end


ju.mobility_gear.classes.trace_bomb = TRACE_BOMB
