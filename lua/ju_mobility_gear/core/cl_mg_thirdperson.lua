
local math = math
local cos = math.cos
local sin = math.sin
local timeC = TimedCos
local timeS = TimedSin

local camDist = 128
local camAddition = 16

local function getBasePos(origin, angle)
    return origin - angle:Forward() * camDist
end

local function addDynamicEffect(ply, origin, angle)
    
    -- TODO: Покачивания
    -- TODO: Эффект зума на высокой скорости
    -- TODO: Добавить плавности
    
    return origin, angle

end

local function considerTraceRestrictions(origin, angle)

    -- TODO: Проверить удачность направления и добавления

    local startPos = origin + angle:Forward() * camAddition
    local endPos = origin - angle:Forward() * camAddition

    local trace = util.TraceLine({
        start = startPos,
        endpos = endPos,
    })

    -- TODO: Используя данные о трейсе избегать столкновения с объектами
    
    if trace.Hit then
        origin = startPos
    end
    
    return origin

end

local function checkPosCorrectness(ply, origin, angle)

    local bottomPos = ply:GetPos()

    origin = considerTraceRestrictions(origin, angle)

    return origin

end

local function getCamPosAndAngles(ply, origin, angle)

    origin = getBasePos(origin, angle)
    origin, angle = addDynamicEffect(ply, origin, angle)
    origin = checkPosCorrectness(ply, origin, angle)

    return origin, angle

end

local function calcView(ply, origin, angle, fov, znear, zfar)

    local origin, angles = getCamPosAndAngles(ply, origin, angle)

    local view = {

        -- main settings:
		origin = origin,
		angles = angles,
		drawviewer = true,

        -- other
        fov = fov,
		znear = znear,
		zfar = zfar,
		-- ortho = {0, 0, 0, 0},

	}

    return view

end

-- TODO: Добавлять хук, когда берётся УПМ
-- TODO: Добавить настройку вида от 3 лица (по необходимости)

hook.Add('CalcView', 'ju_mobility_gear_calcview', calcView)

-- TODO: Удалить хуки, что могут повлиять на работу камеры
