
local math = math
local cos = math.cos
local sin = math.sin
local timeC = TimedCos
local timeS = TimedSin

local minDist = 32
local maxDist = 128
local height = 16

-- TODO: Разместить создание камеры в момент смены MG State
-- local camera = ju.mobility_gear.classes.camera:new(minDist, maxDist, height)

local camera

local function calcView(ply, eyeVector, eyeAngle, fov, znear, zfar)

    camera = ju.mobility_gear.classes.camera
                    :new(minDist, maxDist, height)
                    :SetEyePos(eyeVector)
                    :SetEyeAngle(eyeAngle)
                    :Recalculate()

    local view = {

        -- main settings:
		origin = camera.Pos,
		angles = camera.Angle,
		drawviewer = camera.NeedDrawViewer,

        -- other
        fov = fov,
		znear = znear,
		zfar = zfar,
		-- ortho = {0, 0, 0, 0},

	}

    return view

end

-- TODO: Доработать эффект!

local function canDraw(hands, vm, ply, weapon)
    
    return !camera.NeedDrawViewer

end

-- TODO: Добавлять хук, когда берётся УПМ
-- TODO: Добавить настройку вида от 3 лица (по необходимости)

hook.Add('CalcView', 'ju_mobility_gear_calcview', calcView)
hook.Add('PreDrawPlayerHands', 'ju_mobility_gear_hands', canDraw)

-- TODO: Удалить хуки, что могут повлиять на работу камеры
