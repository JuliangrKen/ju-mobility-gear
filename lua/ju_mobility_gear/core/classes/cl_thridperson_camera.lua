
local setmetatable = setmetatable

local ply = LocalPlayer()

local CAMERA = {}

--[[

    public:

    Pos
    Angle

]]

CAMERA.__index = CAMERA

function CAMERA:new(minDist, maxDist, height)
    
    self.__index = self

    self.minDist = minDist
    self.maxDist = maxDist

    self.height = height

    return setmetatable({}, self)

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

    -- TODO: Проверить удачность направления и добавления

    local trace = util.TraceLine({
        start = self.eyePos,
        endpos = self.Angle,
    })

    -- TODO: Используя данные о трейсе избегать столкновения с объектами
    
    if trace.Hit then
        origin = trace.HitPos
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
    
    return self

end


ju.mobility_gear.classes.camera = CAMERA
