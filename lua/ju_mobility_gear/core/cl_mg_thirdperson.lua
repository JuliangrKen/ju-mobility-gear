
local math = math
local cos = math.cos
local sin = math.sin
local timeC = TimedCos
local timeS = TimedSin

local minDist = 16
local maxDist = 128
local height = 16

local camera = ju.mobility_gear.classes.camera:new(minDist, maxDist, height)

local function calcView(ply, eyeVector, eyeAngle, fov, znear, zfar)

    local c = camera:SetEyePos(eyeVector)
                    :SetEyeAngle(eyeAngle)
                    :Recalculate()

    local view = {

        -- main settings:
		origin = c.Pos,
		angles = c.Angle,
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
