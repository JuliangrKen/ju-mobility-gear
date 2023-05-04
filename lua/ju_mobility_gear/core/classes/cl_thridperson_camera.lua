
local setmetatable = setmetatable
local LocalPlayer = LocalPlayer

local CAMERA = {}

--[[

    public:

    Pos
    Angle

    NeedDrawViewer

]]

CAMERA.__index = CAMERA

function CAMERA:new(minDist, maxDist, height)
    
    local heir = setmetatable({}, self)

    heir.__index = self

    heir.minDist = minDist
    heir.maxDist = maxDist

    return heir

end

-- Set/Get Eye Data

function CAMERA:SetEyePos(eyePos)

    self.eyePos = eyePos
    return self
    
end

function CAMERA:GetEyePos()
    
    return self.eyePos

end

function CAMERA:SetEyeAngle(eyeAngle)
    
    self.eyeAngle = eyeAngle
    return self

end

function CAMERA:GetEyeAngle()
    
    return self.eyeAngle

end

function CAMERA:addDynamic()
    -- TODO: Покачивания
    -- TODO: Эффект зума на высокой скорости
    -- TODO: Добавить плавности
end

function CAMERA:considerHits()

    local trace = util.TraceLine({
        start = self.eyePos,
        endpos = self.Pos,
        collisiongroup = COLLISION_GROUP_WORLD,
    })

    if trace.Hit then
        self.Pos = trace.HitPos
    end
    
end

function CAMERA:checkDrawViewer()

    self.NeedDrawViewer = true

    local ply = LocalPlayer()
    
    if IsValid(ply) then

        local matrix = Matrix()
        
        local pPos = ply:GetPos()
        local pCenterPos = Vector(pPos[1], pPos[2], pPos[3] + 32)

        self.NeedDrawViewer = self.minDist * self.minDist < self.Pos:DistToSqr(pCenterPos)

    end

end

--[[
    [ Main method ]

    Заново рассчитывает вектор и угол, исходя из всех ранее установленных значений свойств;
]]
function CAMERA:Recalculate()
    
    self.Pos = self.eyePos - self.eyeAngle:Forward() * self.maxDist
    self.Angle = self.eyeAngle

    self:addDynamic()
    self:considerHits()

    self:checkDrawViewer()

    return self

end


ju.mobility_gear.classes.camera = CAMERA
