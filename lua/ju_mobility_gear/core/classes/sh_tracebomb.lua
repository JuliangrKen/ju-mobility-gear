
local math = math
local pi = math.pi
local cos = math.cos
local sin = math.sin
local deg = math.deg

local defaultColor = Color(10, 95, 215)
local defaultNumVertexesCircle = 10

local TRACE_BOMB = {}

TRACE_BOMB.__index = TRACE_BOMB

--[[
    TODO:
    1. фикс - увеличение/уменьшение сферы.
    2. добавить - полусфера и прочие об плоскость.
]]

--[[
    radius : Num
    pos : Vector
    numVertexesCircle : Num

    return new TRACE_BOMB table
]]
function TRACE_BOMB:new(radius, pos, numVertexesCircle)
    
    local heir = setmetatable({}, self)

    heir.__index = self

    heir.radius = radius
    heir.pos = pos
    heir.numVertexesCircle = numVertexesCircle or defaultNumVertexesCircle

    return heir

end


-- Position methods

--[[
    pos : Vector

    return this table
]]
function TRACE_BOMB:SetPos(pos)
    
    if self.pos != pos then

        local lastPos = self:GetPos()
        
        self.pos = pos

        if self.vertexes then
        
            self:updatePos(lastPos)

        else
    
            self:updateVertexes()

        end

    end

    return self

end

--[[
    return pos : Vector
]]
function TRACE_BOMB:GetPos()

    return self.pos or Vector(0, 0, 0)
    
end


-- Scale methods

--[[
    radius : Num

    return this table
]]
function TRACE_BOMB:SetRadius(radius)

    if self.radius != radius then

        local lastRadius = self:GetRadius()

        self.radius = radius
        
        if self.vertexes then
        
            self:updateScale(lastRadius)

        else
    
            self:updateVertexes()

        end
    
    end

    return self

end

--[[
    return radius : Num
]]
function TRACE_BOMB:GetRadius()

    return self.radius or 1

end

-- TODO: update Rotation methods

-- Rotation methods

--[[
    sphereAxis : Vector

    return this table
]]
function TRACE_BOMB:SetSphereAxis(sphereAxis)
    
    self.sphereAxis = sphereAxis
    return self

end

--[[
    return sphereAxis : Vector
]]
function TRACE_BOMB:GetSphereAxis()
    
    return self.sphereAxis or Vector(0, 0, 0)

end

--[[
    isX : bool

    return this table
]]
function TRACE_BOMB:SetHorizontal(isX)
    
    self:SetSphereAxis(isX and Vector(1, 0, 0) or Vector(0, 1, 0))
    return self

end

--[[
    return this table
]]
function TRACE_BOMB:SetVertical()
    
    self:SetSphereAxis(Vector(0, 0, 1))
    return self

end

--[[
    Trace methods

    Wiki Page:
    https://wiki.facepunch.com/gmod/Structures/Trace
]]

--[[
    filter : Entity or table {Entity} or function(Entity)
    
    return this table
]]
function TRACE_BOMB:SetTraceFilter(filter)

    self.filter = filter
    return self
    
end

--[[
    return filter : Entity or table {Entity} or function(Entity)
]]
function TRACE_BOMB:GetTraceFilter()
    
    return self.filter

end


--[[
    samplingConditionsFunc : function(trace : Table, pos : Vector)

    Table:
        https://wiki.facepunch.com/gmod/Structures/TraceResult

    return this table
]]
function TRACE_BOMB:SetSamplingConditionsFunc(samplingConditionsFunc)
    
    self.samplingConditionsFunc = samplingConditionsFunc
    return self

end

--[[
    return samplingConditionsFunc : function(trace : Table, pos : Vector)
]]
function TRACE_BOMB:GetSamplingConditionsFunc()
    
    return self.samplingConditionsFunc

end

--[[
    return this table
]]
function TRACE_BOMB:SetTakeEverything()
    
    self.takeEverything = true
    return self

end

--[[
    return this table
]]
function TRACE_BOMB:SetTakeFirstOne()

    self.takeEverything = false
    return self

end

--[[
    return Trace or Table { Trace }
]]
function TRACE_BOMB:Boom()
    
    if !self.vertexes then
        self:updateVertexes()
    end

    local resultTable = self.takeEverything and {}

    for _, v in ipairs(self.vertexes) do
        
        local trace = util.TraceLine({
            
            start = self:GetPos(),
            endpos = v,

            filter = self.filter,
        
        })

        if !(trace and trace.Hit) then continue end

        if self.samplingConditionsFunc and !self.samplingConditionsFunc(trace, self:GetPos()) then continue end

        if !resultTable then return trace end

        resultTable[#resultTable + 1] = trace 

    end

    return resultTable

end


if CLIENT then

    --[[
        color : Color
    ]]
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

    --[[
        color : Color
    ]]
    function TRACE_BOMB:DrawPaintedShere(color)
        
        render.SetColorMaterial()
        render.DrawSphere(self:GetPos(), self.radius, self.numVertexesCircle, self.numVertexesCircle, color or defaultColor)

    end

    --[[
        color : Color
    ]]
    function TRACE_BOMB:DrawTraces(color)
    
        if !self.vertexes then return end

        for _, v in ipairs(self.vertexes) do
            
            render.SetColorMaterial()
            render.DrawLine(self:GetPos(), v, color or defaultColor, true)

        end

    end

end


-- local functions for crating vertexes

--[[
    numVertexesCircle : Num

    return table { [index] = Vector }
]]
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

--[[
    circleVertexes : Table { [index] = Vector }

    return Table { [index] = Vector }
]]
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


-- private function

function TRACE_BOMB:createCircle()

    self.circleVertexes = createCircle(self.numVertexesCircle)

end

function TRACE_BOMB:createShereByCircle()
    
    self.shereVertexes = createShereByCircle(self.circleVertexes)

end

function TRACE_BOMB:shereSetup()
    
    local matrix = Matrix()

    matrix:Translate(self:GetPos())
    matrix:Scale(Vector(self.radius, self.radius, self.radius))
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

--[[
    return this table
]]
function TRACE_BOMB:updateVertexes()
    
    self.vertexes = self:createShere()
    return self

end

--[[
    lastPos : Num
]]
function TRACE_BOMB:updatePos(lastPos)
   
    local matrix = Matrix()
    matrix:Translate(self:GetPos() - lastPos)

    self:multiplyByMatrix(matrix)

end

--[[
    lastRadius : Num
]]
function TRACE_BOMB:updateScale(lastRadius)

    local newRadius = self:GetRadius()

    if newRadius > lastRadius then
        
        self:increaseSize(newRadius / lastRadius)
        return

    end

    self:reduceSize(newRadius / lastRadius)
    
end

--[[
    num : Num
]]
function TRACE_BOMB:increaseSize(num)

    local curPos = self:GetPos()

    -- temp set Vector(0,0,0) pos for correct scaling
    self:SetPos(Vector(0, 0, 0))

    local matrix = Matrix()
    matrix:Scale(Vector(num, num, num))

    self:multiplyByMatrix(matrix)

    -- return to current pos
    self:SetPos(curPos)

end

--[[
    num : Num
]]
function TRACE_BOMB:reduceSize(num)

    self:increaseSize(num > 1 and 1 / num or num)

end

--[[
    matrix : Matrix
]]
function TRACE_BOMB:multiplyByMatrix(matrix)
    
    for k, v in ipairs(self.vertexes) do
        
        self.vertexes[k] = matrix * v

    end

end
 

ju.mobility_gear.classes.trace_bomb = TRACE_BOMB
